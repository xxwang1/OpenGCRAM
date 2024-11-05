# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California and The Board
# of Regents for the Oklahoma Agricultural and Mechanical College
# (acting for and on behalf of Oklahoma State University)
# All rights reserved.
#
import math
from openram import debug
from openram.base import vector
from openram.sram_factory import factory
from openram import OPTS
from .gain_cell_control_logic_base import gain_cell_control_logic_base


class gain_cell_control_logic(gain_cell_control_logic_base):
    """
    Dynamically generated Control logic for the total gain_cell circuit.
    """

    def __init__(self, num_rows, words_per_row, word_size, spare_columns=None, gain_cell=None, port_type="rw", name=""):
        """ Constructor """
        super().__init__(num_rows, words_per_row, word_size, spare_columns, gain_cell, port_type, name)

    def add_pins(self):
        """ Add the pins to the control logic module. """
        self.add_pin_list(self.input_list + ["clk"] + self.rbl_list, "INPUT")
        self.add_pin_list(self.output_list, "OUTPUT")
        self.add_pin("vdd", "POWER")
        self.add_pin("gnd", "GROUND")

    def add_modules(self):
        """ Add all the required modules """

        self.gain_cell_dff = factory.create(module_type="gain_cell_dff_buf")
        gain_cell_dff_height = self.gain_cell_dff.height

        self.ctrl_gain_cell_dff_array = factory.create(module_type="gain_cell_dff_buf_array",
                                             rows=self.num_control_signals,
                                             columns=1)

        self.and2 = factory.create(module_type="pand2",
                                   size=12,
                                   height=gain_cell_dff_height)

        self.rbl_driver = factory.create(module_type="pbuf",
                                         size=self.num_cols,
                                         height=gain_cell_dff_height)

        # clk_buf drives a flop for every address
        addr_flops = math.log(self.num_words, 2) + math.log(self.words_per_row, 2)
        # plus data flops and control flops
        num_flops = addr_flops + self.word_size + self.num_spare_cols + self.num_control_signals
        # each flop internally has a FO 5 approximately
        # plus about 5 fanouts for the control logic
        clock_fanout = 5 * num_flops + 5
        self.clk_buf_driver = factory.create(module_type="pdriver",
                                             fanout=clock_fanout,
                                             height=gain_cell_dff_height)

        # We will use the maximum since this same value is used to size the wl_en
        # and the p_en_bar drivers
        # max_fanout = max(self.num_rows, self.num_cols)

        # wl_en drives every row in the bank
        # MRG 9/3/2021: Ensure that this is two stages to prevent race conditions with the write driver
        size_list = [max(int(self.num_rows / 9), 1), max(int(self.num_rows / 3), 1)]
        self.wl_en_driver = factory.create(module_type="pdriver",
                                           size_list=size_list,
                                           height=gain_cell_dff_height)

        # w_en drives every write driver
        self.wen_and = factory.create(module_type="pand3",
                                      size=self.word_size + 8,
                                      height=gain_cell_dff_height)

        # s_en drives every sense amp
        self.sen_and3 = factory.create(module_type="pand3",
                                       size=self.word_size + self.num_spare_cols,
                                       height=gain_cell_dff_height)

        # used to generate inverted signals with low fanout
        self.inv = factory.create(module_type="pinv",
                                  size=1,
                                  height=gain_cell_dff_height)

        # p_en_bar drives every column in the bitcell array
        # but it is sized the same as the wl_en driver with
        # prepended 3 inverter stages to guarantee it is slower and odd polarity
        if self.port_type == "w":
            self.p_en_bar_driver = factory.create(module_type="pdriver",
                                                fanout=self.num_cols,
                                                height=gain_cell_dff_height)
        if self.port_type == "r":
            self.p_en_driver = factory.create(module_type="pdriver",
                                                fanout=self.num_cols,
                                                height=gain_cell_dff_height)

        self.nand2 = factory.create(module_type="pnand2",
                                    height=gain_cell_dff_height)

        debug.check(OPTS.delay_chain_stages % 2,
                    "Must use odd number of delay chain stages for inverting delay chain.")
        self.delay_chain=factory.create(module_type="delay_chain",
                                        fanout_list = OPTS.delay_chain_stages * [ OPTS.delay_chain_fanout_per_stage ])

    def setup_signal_busses(self):
        """ Setup bus names, determine the size of the busses etc """

        # List of input control signals
        if self.port_type == "rw":
            self.input_list = ["csb", "web"]
            self.rbl_list = ["rbl_bl"]
        else:
            if self.port_type == "r":
                self.input_list = ["csb"]
                self.rbl_list = ["rbl_rbl"]
            if self.port_type == "w":
                self.input_list = ["web"]
                self.rbl_list = ["rbl_wbl"]

        if self.port_type == "rw":
            self.gain_cell_dff_output_list = ["cs_bar", "cs", "we_bar", "we"]
        else:
            if self.port_type == "r":
                self.gain_cell_dff_output_list = ["cs_bar", "cs"]
            if self.port_type == "w":
                self.gain_cell_dff_output_list = ["we_bar", "we"]

        # list of output control signals (for making a vertical bus)
        if self.port_type == "rw":
            self.internal_bus_list = ["rbl_bl_delay_bar", "rbl_bl_delay", "gated_clk_bar", "gated_clk_buf", "we", "we_bar", "clk_buf", "cs"]
        else:
            if self.port_type == "r":
                self.internal_bus_list = ["rbl_rbl_delay_bar", "rbl_rbl_delay", "gated_clk_bar", "gated_clk_buf", "clk_buf", "cs"]
            if self.port_type == "w":
                self.internal_bus_list = ["rbl_wbl_delay_bar", "rbl_wbl_delay", "gated_clk_bar", "gated_clk_buf", "clk_buf", "we", "we_bar"]
        # leave space for the bus plus one extra space
        self.internal_bus_width = (len(self.internal_bus_list) + 1) * self.m2_pitch

        # Outputs to the bank
        if self.port_type == "rw":
            self.output_list = ["s_en", "w_en"]
        elif self.port_type == "r":
            self.output_list = ["s_en"]
        else:
            self.output_list = ["w_en"]
        if self.port_type == "w":
            self.output_list.append("p_en_bar")
        if self.port_type == "r":
            self.output_list.append("p_en")
        if self.port_type == "r": self.output_list.append("rwl_en")
        if self.port_type == "w": self.output_list.append("wwl_en")
        self.output_list.append("clk_buf")

        self.supply_list = ["vdd", "gnd"]

    def create_instances(self):
        """ Create all the instances """
        self.create_gain_cell_dffs()
        self.create_clk_buf_row()
        self.create_gated_clk_bar_row()
        self.create_gated_clk_buf_row()
        self.create_wlen_row()
        if (self.port_type == "rw") or (self.port_type == "w"):
            self.create_rbl_delay_row()
            self.create_wen_row()
        if (self.port_type == "rw") or (self.port_type == "r"):
            self.create_sen_row()
        self.create_delay()
        self.create_pen_row()

    def place_logic_rows(self):
        row = 0
        self.place_clk_buf_row(row)
        row += 1
        self.place_gated_clk_bar_row(row)
        row += 1
        self.place_gated_clk_buf_row(row)
        row += 1
        if (self.port_type == "rw") or (self.port_type == "r"):
            self.place_sen_row(row)
            row += 1
        if (self.port_type == "rw") or (self.port_type == "w"):
            self.place_wen_row(row)
            row += 1
        self.place_pen_row(row)
        row += 1
        if (self.port_type == "rw") or (self.port_type == "w"):
            self.place_rbl_delay_row(row)
            row += 1
        self.place_wlen_row(row)

        self.control_center_y = self.wl_en_inst.uy() + self.m3_pitch

    def route_all(self):
        """ Routing between modules """
        self.route_rails()
        self.route_gain_cell_dffs()
        self.route_wlen()
        if (self.port_type == "rw") or (self.port_type == "w"):
            self.route_rbl_delay()
            self.route_wen()
        if (self.port_type == "rw") or (self.port_type == "r"):
            self.route_sen()
        self.route_delay()
        self.route_pen()
        self.route_clk_buf()
        self.route_gated_clk_bar()
        self.route_gated_clk_buf()
        self.route_supplies()

    def create_delay(self):
        """ Create the delay chain """
        self.delay_inst=self.add_inst(name="delay_chain",
                                      mod=self.delay_chain)
        # rbl_bl_delay is asserted (1) when the bitline has been discharged
        if self.port_type == "r":
            self.connect_inst(["rbl_rbl", "rbl_rbl_delay", "vdd", "gnd"])
        if self.port_type == "w":
            self.connect_inst(["rbl_wbl", "rbl_wbl_delay", "vdd", "gnd"])

    def route_delay(self):

        out_pos = self.delay_inst.get_pin("out").center()
        # Connect to the rail level with the vdd rail
        # Use gated clock since it is in every type of control logic
        vdd_ypos = self.gated_clk_buf_inst.get_pin("vdd").cy() + self.m1_pitch
        if self.port_type == "r":
            in_pos = vector(self.input_bus["rbl_rbl_delay"].cx(), vdd_ypos)
        if self.port_type == "w":
            in_pos = vector(self.input_bus["rbl_wbl_delay"].cx(), vdd_ypos)
        mid1 = vector(out_pos.x, in_pos.y)
        self.add_wire(self.m1_stack, [out_pos, mid1, in_pos])
        self.add_via_center(layers=self.m1_stack,
                            offset=in_pos)

        # Input from RBL goes to the delay line for futher delay
        if self.port_type == "r":
            self.copy_layout_pin(self.delay_inst, "in", "rbl_rbl")
        if self.port_type == "w":
            self.copy_layout_pin(self.delay_inst, "in", "rbl_wbl")

    def create_wlen_row(self):
        # input pre_p_en, output: wl_en
        if self.port_type == "r":
            self.wl_en_inst=self.add_inst(name="buf_rwl_en",
                                        mod=self.wl_en_driver)
            self.connect_inst(["gated_clk_bar", "rwl_en", "vdd", "gnd"])
        if self.port_type == "w":
            self.wl_en_inst=self.add_inst(name="buf_wwl_en",
                                        mod=self.wl_en_driver)
            self.connect_inst(["gated_clk_bar", "wwl_en", "vdd", "gnd"])

    def place_wlen_row(self, row):
        x_offset = self.control_x_offset + self.implant_space

        x_offset = self.place_util(self.wl_en_inst, x_offset, row, pp_space = True)

        self.row_end_inst.append(self.wl_en_inst)

    def route_wlen(self):
        wlen_map = zip(["A"], ["gated_clk_bar"])
        self.connect_vertical_bus(wlen_map, self.wl_en_inst, self.input_bus)
        if self.port_type == "r":
            self.connect_output(self.wl_en_inst, "Z", "rwl_en")
        if self.port_type == "w":
            self.connect_output(self.wl_en_inst, "Z", "wwl_en")

    def create_pen_row(self):
        # nand2_1
        if self.port_type == "w":
            self.p_en_bar_nand_inst=self.add_inst(name="nand_p_en_bar",
                                                mod=self.nand2)
            # We use the rbl_bl_delay here to ensure that the p_en is only asserted when the
            # bitlines have already been discharged. Otherwise, it is a combination loop.
            if self.port_type == "r": 
                self.connect_inst(["gated_clk_buf", "rbl_rbl_delay", "p_en_bar_unbuf", "vdd", "gnd"])
            if self.port_type == "w": 
                self.connect_inst(["gated_clk_buf", "rbl_wbl_delay", "p_en_bar_unbuf", "vdd", "gnd"])
            # pdirver_4
            self.p_en_bar_driver_inst=self.add_inst(name="buf_p_en_bar",
                                                    mod=self.p_en_bar_driver)
            self.connect_inst(["p_en_bar_unbuf", "p_en_bar", "vdd", "gnd"])

        if self.port_type == "r":
            self.p_en_and_inst=self.add_inst(name="nand_p_en",
                                                mod=self.and2)
            # We use the rbl_bl_delay here to ensure that the p_en is only asserted when the
            # bitlines have already been discharged. Otherwise, it is a combination loop.
            if self.port_type == "r": 
                self.connect_inst(["gated_clk_buf", "rbl_rbl_delay", "p_en_unbuf", "vdd", "gnd"])
            if self.port_type == "w": 
                self.connect_inst(["gated_clk_buf", "rbl_wbl_delay", "p_en_unbuf", "vdd", "gnd"])
            # pdirver_4
            self.p_en_driver_inst=self.add_inst(name="buf_p_en",
                                                    mod=self.p_en_driver)
            self.connect_inst(["p_en_unbuf", "p_en", "vdd", "gnd"])

    def place_pen_row(self, row):
        x_offset = self.control_x_offset + self.nwell_space
        if self.port_type == "w":
            x_offset = self.place_util(self.p_en_bar_nand_inst, x_offset, row, pp_space = False)
            # print("place_pen_row x_offset, control_x_offset, nwell_enclose_implant, nwell_space, w_en_gate_inst.width = ", x_offset, self.control_x_offset, self.nwell_enclose_implant, self.nwell_space, self.w_en_gate_inst.width)
            if self.port_type == "w": x_offset = self.place_util(self.p_en_bar_driver_inst, self.control_x_offset + 2 * self.nwell_enclose_implant + self.nwell_space + self.w_en_gate_inst.width, row, pp_space = False) 
            if self.port_type == "r": x_offset = self.place_util(self.p_en_bar_driver_inst, self.control_x_offset + 2 * self.nwell_enclose_implant + self.nwell_space + self.s_en_gate_inst.width, row, pp_space = False)
            self.row_end_inst.append(self.p_en_bar_driver_inst)
        if self.port_type == "r":
            x_offset = self.place_util(self.p_en_and_inst, x_offset, row, pp_space = False)
            # print("place_pen_row x_offset, control_x_offset, nwell_enclose_implant, nwell_space, w_en_gate_inst.width = ", x_offset, self.control_x_offset, self.nwell_enclose_implant, self.nwell_space, self.w_en_gate_inst.width)
            if self.port_type == "w": x_offset = self.place_util(self.p_en_driver_inst, self.control_x_offset + 2 * self.nwell_enclose_implant + self.nwell_space + self.w_en_gate_inst.width, row, pp_space = False) 
            if self.port_type == "r": x_offset = self.place_util(self.p_en_driver_inst, self.control_x_offset + 2 * self.nwell_enclose_implant + self.nwell_space + self.s_en_gate_inst.width, row, pp_space = False)
            self.row_end_inst.append(self.p_en_driver_inst)

    def route_pen(self):
        if self.port_type == "r": 
            in_map = zip(["A", "B"], ["gated_clk_buf", "rbl_rbl_delay"])
        if self.port_type == "w": 
            in_map = zip(["A", "B"], ["gated_clk_buf", "rbl_wbl_delay"])
        
        if self.port_type == "w":
            self.connect_vertical_bus(in_map, self.p_en_bar_nand_inst, self.input_bus)

            out_pin = self.p_en_bar_nand_inst.get_pin("Z")
            out_pos = out_pin.center()
            in_pin = self.p_en_bar_driver_inst.get_pin("A")
            in_pos = in_pin.center()
            mid1 = vector(in_pos.x, out_pos.y)
            self.add_path(out_pin.layer, [out_pos, mid1, in_pos])
            self.add_via_stack_center(from_layer=out_pin.layer,
                                    to_layer=in_pin.layer,
                                    offset=in_pin.center())

            self.connect_output(self.p_en_bar_driver_inst, "Z", "p_en_bar")
        if self.port_type == "r":
            self.connect_vertical_bus(in_map, self.p_en_and_inst, self.input_bus)

            out_pin = self.p_en_and_inst.get_pin("Z")
            out_pos = out_pin.center()
            in_pin = self.p_en_driver_inst.get_pin("A")
            in_pos = in_pin.center()
            mid1 = vector(in_pos.x, out_pos.y)
            self.add_path(out_pin.layer, [out_pos, mid1, in_pos])
            self.add_via_stack_center(from_layer=out_pin.layer,
                                    to_layer=in_pin.layer,
                                    offset=in_pin.center())

            self.connect_output(self.p_en_driver_inst, "Z", "p_en")

    def create_sen_row(self):
        """ Create the sense enable buffer. """
        if self.port_type=="rw":
            input_name = "we_bar"
        else:
            input_name = "cs"
        # GATE FOR S_EN
        self.s_en_gate_inst = self.add_inst(name="buf_s_en_and",
                                            mod=self.sen_and3)
        # s_en is asserted in the second half of the cycle during a read.
        # we also must wait until the bitline has been discharged enough for proper sensing
        # hence we use rbl_bl_delay as well.
        self.connect_inst(["rbl_rbl_delay", "gated_clk_bar", input_name, "s_en", "vdd", "gnd"])

    def place_sen_row(self, row):
        x_offset = self.control_x_offset

        x_offset = self.place_util(self.s_en_gate_inst, x_offset, row)

        self.row_end_inst.append(self.s_en_gate_inst)

    def route_sen(self):

        if self.port_type=="rw":
            input_name = "we_bar"
        else:
            input_name = "cs"

        sen_map = zip(["A", "B", "C"], ["rbl_rbl_delay", "gated_clk_bar", input_name])
        self.connect_vertical_bus(sen_map, self.s_en_gate_inst, self.input_bus)

        self.connect_output(self.s_en_gate_inst, "Z", "s_en")

    def create_rbl_delay_row(self):
        if self.port_type == "r":
            self.rbl_bl_delay_inv_inst = self.add_inst(name="rbl_rbl_delay_inv",
                                                    mod=self.inv)
            self.connect_inst(["rbl_rbl_delay", "rbl_rbl_delay_bar", "vdd", "gnd"])
        if self.port_type == "w":
            self.rbl_bl_delay_inv_inst = self.add_inst(name="rbl_wbl_delay_inv",
                                                    mod=self.inv)
            self.connect_inst(["rbl_wbl_delay", "rbl_wbl_delay_bar", "vdd", "gnd"])

    def place_rbl_delay_row(self, row):
        x_offset = self.control_x_offset

        x_offset = self.place_util(self.rbl_bl_delay_inv_inst, x_offset, row)

        self.row_end_inst.append(self.rbl_bl_delay_inv_inst)

    def route_rbl_delay(self):
        # Connect from delay line
        # Connect to rail
        print("Running route_rbl_delay")
        print("self.rbl_bl_delay_inv_inst = ", self.rbl_bl_delay_inv_inst)
        if self.port_type == "r":
            self.route_output_to_bus_jogged(self.rbl_bl_delay_inv_inst, "rbl_rbl_delay_bar")

            bl_map = zip(["A"], ["rbl_rbl_delay"])
        if self.port_type == "w":
            self.route_output_to_bus_jogged(self.rbl_bl_delay_inv_inst, "rbl_wbl_delay_bar")

            bl_map = zip(["A"], ["rbl_wbl_delay"])
        self.connect_vertical_bus(bl_map, self.rbl_bl_delay_inv_inst, self.input_bus)

    def create_wen_row(self):

        # input: we (or cs) output: w_en
        if self.port_type == "rw":
            input_name = "we"
        else:
            # No we for write-only reports, so use cs
            input_name = "we"

        # GATE THE W_EN
        self.w_en_gate_inst = self.add_inst(name="w_en_and",
                                            mod=self.wen_and)
        # Only drive the writes in the second half of the clock cycle during a write operation.
        self.connect_inst([input_name, "rbl_wbl_delay_bar", "gated_clk_bar", "w_en", "vdd", "gnd"])

    def place_wen_row(self, row):
        x_offset = self.control_x_offset

        x_offset = self.place_util(self.w_en_gate_inst, x_offset, row)

        self.row_end_inst.append(self.w_en_gate_inst)

    def route_wen(self):
        if (self.port_type == "rw") or (self.port_type == "w"):
            input_name = "we"
        else:
            # No we for write-only reports, so use cs
            input_name = "we"

        wen_map = zip(["A", "B", "C"], [input_name, "rbl_wbl_delay_bar", "gated_clk_bar"])
        self.connect_vertical_bus(wen_map, self.w_en_gate_inst, self.input_bus)

        self.connect_output(self.w_en_gate_inst, "Z", "w_en")
