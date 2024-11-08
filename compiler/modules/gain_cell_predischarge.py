# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California and The Board
# of Regents for the Oklahoma Agricultural and Mechanical College
# (acting for and on behalf of Oklahoma State University)
# All rights reserved.
#
from openram import debug
from openram.base import design
from openram.base import vector
from openram.sram_factory import factory
from openram.tech import parameter, drc
from openram.tech import cell_properties as cell_props
from openram import OPTS
from .pgate import *


class gain_cell_predischarge(design):
    """
    Creates a single precharge cell
    This module implements the precharge bitline cell used in the design.
    """
    def __init__(self, name, size=1, gain_cell_rbl="rbl"):

        debug.info(2, "creating precharge cell {0}".format(name))
        super().__init__(name)

        self.gain_cell = factory.create(module_type=OPTS.gain_cell)
        self.beta = parameter["beta"]
        self.ptx_width = self.beta * parameter["min_tx_size"]
        self.ptx_mults = 1
        if(cell_props.use_strap == True and OPTS.num_ports == 1):
            strap = factory.create(module_type=cell_props.strap_module, version=cell_props.strap_version)
            self.width = self.gain_cell.width + strap.width
        else:
            self.width = self.gain_cell.width
        self.gain_cell_rbl = gain_cell_rbl
        # self.gain_cell_br = gain_cell_br
        self.gain_cell_rbl_pin =self.gain_cell.get_pin(self.gain_cell_rbl)
        # self.gain_cell_br_pin =self.gain_cell.get_pin(self.gain_cell_br)

        if self.gain_cell_rbl_pin.layer == "m1":
            self.bitline_layer = "m1"
            self.en_layer = "m2"
        else:
            self.bitline_layer = "m2"
            self.en_layer = "m1"

        # Creates the netlist and layout
        # Since it has variable height, it is not a pgate.
        self.create_netlist()
        if not OPTS.netlist_only:
            self.create_layout()
            self.DRC_LVS()

    def get_rbl_names(self):
        return self.gain_cell_rbl

    def get_wbl_names(self):
        return self.gain_cell_rbl

    def create_netlist(self):
        self.add_pins()
        self.add_ptx()
        self.create_ptx()

    def create_layout(self):

        self.place_ptx()
        self.connect_poly()
        self.route_en()
        self.place_pwell_and_contact()
        self.route_supplies()
        self.route_bitlines()
        self.connect_to_bitlines()
        self.add_boundary()

    def add_pins(self):
        self.add_pin_list([self.gain_cell_rbl, "en", "gnd"],
                          ["OUTPUT", "INPUT", "POWER"])

    def add_ptx(self):
        """
        Initializes the upper and lower nmos
        """
        if cell_props.ptx.bin_spice_models:
            self.ptx_width = pgate.nearest_bin("nmos", self.ptx_width)
        self.nmos = factory.create(module_type="ptx",
                                   width=self.ptx_width,
                                   mults=self.ptx_mults,
                                   tx_type="nmos")

    def route_supplies(self):
        """
        Adds a gnd rail at the top of the cell
        """

        nmos_pin = self.upper_nmos1_inst.get_pin("S")
        nmos_pos = nmos_pin.center()
        self.add_path(nmos_pin.layer, [nmos_pos, self.well_contact_pos])
        nmos_pos_lower = self.lower_nmos_inst.get_pin("S").center()
        self.add_path(nmos_pin.layer, [nmos_pos, nmos_pos_lower])
        self.add_layout_pin_rect_center(text="gnd",
                                        layer=nmos_pin.layer,
                                        offset=self.well_contact_pos)

    def create_ptx(self):
        """
        Create both the upper_nmos and lower_nmos to the module
        """

        self.lower_nmos_inst = self.add_inst(name="lower_nmos",
                                             mod=self.nmos)
        self.connect_inst([self.gain_cell_rbl, "en", "gnd", "gnd"])

        self.upper_nmos1_inst = self.add_inst(name="upper_nmos1",
                                              mod=self.nmos)
        self.connect_inst([self.gain_cell_rbl, "en", "gnd", "gnd"])

        # self.upper_nmos2_inst = self.add_inst(name="upper_nmos2",
        #                                       mod=self.nmos)
        # self.connect_inst(["br", "en", "gnd", "gnd"])

    def place_ptx(self):
        """
        Place both the upper_nmos and lower_nmos to the module
        """

        # reserve some offset to jog the bitlines
        self.initial_yoffset = self.nmos.active_offset.y + self.m2_pitch
        # Compute the other nmos2 location,
        # but determining offset to overlap the source and drain pins
        overlap_offset = self.nmos.get_pin("S").ll() - self.nmos.get_pin("D").ll()

        # adds the lower nmos to layout
        self.lower_nmos_position = vector(self.well_enclose_active + 0.5 * self.m1_width,
                                          self.initial_yoffset)
        self.lower_nmos_inst.place(self.lower_nmos_position)

        # adds the upper nmos(s) to layout with 2 M2 tracks
        ydiff = self.nmos.height + 2 * self.m2_pitch + self.poly_width
        self.upper_nmos1_pos = self.lower_nmos_position + vector(0, ydiff)
        self.upper_nmos1_inst.place(self.upper_nmos1_pos)

        # Second nmos to the right of the first
        # upper_nmos2_pos = self.upper_nmos1_pos + overlap_offset
        # self.upper_nmos2_inst.place(upper_nmos2_pos)
        # if self.implant_enclose_poly > 0:
        #     self.add_rect(layer="pimplant",
        #                 offset=vector(self.upper_nmos1_pos.x + overlap_offset.x, self.initial_yoffset - self.poly_extend_active - self.implant_enclose_poly),
        #                 width=self.nmos.pimplant_width - self.implant_enclose_active,
        #                 height=ydiff)


    def connect_poly(self):
        """
        Connects the upper and lower nmos together
        """

        offset = self.lower_nmos_inst.get_pin("G").ul()
        # connects the top and bottom nmos' gates together
        ylength = self.upper_nmos1_inst.get_pin("G").ll().y - offset.y
        self.add_rect(layer="poly",
                      offset=offset,
                      width=self.poly_width,
                      height=ylength)

        # connects the two poly for the two upper nmos(s)
        offset = offset + vector(0, ylength - self.poly_width)
        xlength = self.upper_nmos1_inst.get_pin("G").lx() \
                  - self.upper_nmos1_inst.get_pin("G").lx() \
                  + self.poly_width
        self.add_rect(layer="poly",
                      offset=offset,
                      width=xlength,
                      height=self.poly_width)

    def route_en(self):
        """
        Adds the en input rail, en contact/vias, and connects to the nmos
        """

        # adds the en contact to connect the gates to the en rail
        pin_offset = self.lower_nmos_inst.get_pin("G").lr()
        # This is an extra space down for some techs with contact to active spacing
        contact_space = max(self.poly_space,
                            self.poly_contact_to_gate) + 0.5 * self.poly_contact.first_layer_height
        offset = pin_offset - vector(0, contact_space)
        self.add_via_stack_center(from_layer="poly",
                                  to_layer=self.en_layer,
                                  offset=offset)
        if self.implant_enclose_poly > 0:
            implant_width = self.implant_enclose_poly * 2 + self.poly_enclose_contact * 2 + self.contact_width
            self.add_rect(layer="nimplant",
                        offset=offset - vector(implant_width/2, implant_width/2),
                        width=implant_width,
                        height=implant_width)
        self.add_path("poly",
                      [self.lower_nmos_inst.get_pin("G").bc(), offset])
        # adds the en rail
        self.add_layout_pin_segment_center(text="en",
                                           layer=self.en_layer,
                                           start=offset.scale(0, 1),
                                           end=offset.scale(0, 1) + vector(self.width, 0))

    def place_pwell_and_contact(self):
        """
        Adds a pwell tap to connect to the gnd rail
        """

        # adds the contact from active to metal1
        via = factory.create(module_type="contact",
                             layer_stack=self.active_stack,
                             dimensions=[1, 1],
                             directions=None,
                             implant_type="p",
                             well_type="p")
        offset_height = self.upper_nmos1_inst.uy() + \
                        self.active_contact.height + \
                        self.pwell_extend_active + \
                        via.height * 1.5
        self.well_contact_pos = (self.upper_nmos1_inst.get_pin("S").center().scale(1, 0) + \
                                vector(0, offset_height)).snap_to_grid()

        print("place pwell and contact well_contact_pos = ", self.well_contact_pos)

        self.well_contact = self.add_via_center(layers=self.active_stack,
                                                offset=self.well_contact_pos,
                                                implant_type="p",
                                                well_type="p",
                                                directions=("V", "V"))
        self.add_via_stack_center(from_layer=self.active_stack[2],
                                  to_layer=self.bitline_layer,
                                  offset=self.well_contact_pos,
                                  min_area = True)

        self.height = self.well_contact_pos.y + self.active_contact.height + self.m1_space + self.well_enclose_active

        # pwell should span the whole design since it is nmos only
        self.add_rect(layer="pwell",
                      offset=vector(0, 0),
                      width=self.width,
                      height=self.height)

    def route_bitlines(self):
        """
        Adds both bit-line and bit-line-bar to the module
        """
        layer_pitch = getattr(self, "{}_pitch".format(self.bitline_layer))

        # adds the BL
        # self.rbl_xoffset = layer_pitch
        self.rbl_xoffset = self.width - layer_pitch
        top_pos = vector(self.rbl_xoffset, self.height)
        pin_pos = vector(self.rbl_xoffset, 0)
        self.add_path(self.bitline_layer, [top_pos, pin_pos])
        self.rbl_pin = self.add_layout_pin_segment_center(text=self.gain_cell_rbl,
                                                         layer=self.bitline_layer,
                                                         start=pin_pos,
                                                         end=top_pos)

        # adds the BR
        # self.gnd_xoffset = self.width - layer_pitch
        self.gnd_xoffset = layer_pitch
        top_pos = vector(self.gnd_xoffset, self.height)
        pin_pos = vector(self.gnd_xoffset, 0)
        self.add_path(self.bitline_layer, [top_pos, pin_pos])
        self.gnd_pin = self.add_layout_pin_segment_center(text="gnd",
                                                         layer=self.bitline_layer,
                                                         start=pin_pos,
                                                         end=top_pos)

    def connect_to_bitlines(self):
        """
        Connect the bitlines to the devices
        """
        self.add_bitline_contacts()
        self.connect_nmos(self.lower_nmos_inst.get_pin("D"),
                          self.rbl_xoffset)
        self.connect_nmos(self.lower_nmos_inst.get_pin("S"),
                          self.gnd_xoffset)

        self.connect_nmos(self.upper_nmos1_inst.get_pin("D"),
                          self.rbl_xoffset)
        self.connect_nmos(self.upper_nmos1_inst.get_pin("S"),
                          self.gnd_xoffset)

    def add_bitline_contacts(self):
        """
        Adds contacts/via from metal1 to metal2 for bit-lines
        """

        # BL
        for lower_pin in [self.lower_nmos_inst.get_pin("D"), self.lower_nmos_inst.get_pin("S")]:
            self.add_via_stack_center(from_layer=lower_pin.layer,
                                      to_layer=self.bitline_layer,
                                      offset=lower_pin.center(),
                                      directions=("V", "V"),
                                      min_area=True)

        # BR
        # for upper_pin in [self.upper_nmos1_inst.get_pin("D"), self.upper_nmos2_inst.get_pin("S")]:
        #     self.add_via_stack_center(from_layer=upper_pin.layer,
        #                               to_layer=self.bitline_layer,
        #                               offset=upper_pin.center(),
        #                               directions=("V", "V"),
        #                               min_area=True)
        for upper_pin in [self.upper_nmos1_inst.get_pin("D")]:
            self.add_via_stack_center(from_layer=upper_pin.layer,
                                      to_layer=self.bitline_layer,
                                      offset=upper_pin.center(),
                                      directions=("V", "V"),
                                      min_area=True)

    def connect_nmos(self, nmos_pin, bit_xoffset):
        """
        Connect a nmos pin to bitline pin
        """

        left_pos = vector(min(nmos_pin.cx(), bit_xoffset), nmos_pin.cy())
        right_pos = vector(max(nmos_pin.cx(), bit_xoffset), nmos_pin.cy())

        self.add_path(self.bitline_layer,
                      [left_pos, right_pos],
                      width=nmos_pin.height())
