# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California, Santa Cruz
# All rights reserved.
#
from openram import debug
from openram.base.vector import vector
from openram import OPTS
from .graph import graph
from .graph_shape import graph_shape
from .router import router


class supply_router(router):
    """
    This is the supply router that uses the Hanan grid graph method.
    """

    def __init__(self, layers, design, bbox=None, pin_type=None):

        # `router` is the base router class
        router.__init__(self, layers, design, bbox)

        # Side supply pin type
        # (can be "top", "bottom", "right", "left", and "ring")
        self.pin_type = pin_type
        # New pins are the side supply pins
        self.new_pins = {}


    def route(self, vdd_name="vdd", gnd_name="gnd"):
        """ Route the given pins in the given order. """
        debug.info(1, "Running router for {} and {}...".format(vdd_name, gnd_name))

        # Save pin names
        self.vdd_name = vdd_name
        self.gnd_name = gnd_name
        if OPTS.level_shifter:
            vddio_name = "vddio"

        # Prepare gdsMill to find pins and blockages
        self.prepare_gds_reader()

        # Find pins to be routed
        self.find_pins(vdd_name)
        if OPTS.level_shifter:
            self.find_pins(vddio_name)
        self.find_pins(gnd_name)

        # Find blockages and vias
        self.find_blockages()
        self.find_vias()

        # Convert blockages and vias if they overlap a pin
        self.convert_vias()
        self.convert_blockages()

        # Add side pins
        if self.pin_type in ["top", "bottom", "right", "left"]:
            
            self.add_side_pin(vdd_name)
            if OPTS.level_shifter:
                self.add_side_pin(vddio_name)
            self.add_side_pin(gnd_name)
        elif self.pin_type == "ring":
            self.add_ring_pin(vdd_name)
            if OPTS.level_shifter:
                self.add_ring_pin(vddio_name)
            self.add_ring_pin(gnd_name)
        else:
            debug.warning("Side supply pins aren't created.")

        # Add vdd and gnd pins as blockages as well
        # NOTE: This is done to make vdd and gnd pins DRC-safe
        for pin in self.all_pins:
            self.blockages.append(self.inflate_shape(pin))

        # Route vdd and gnd
        routed_count = 0
        routed_max = len(self.pins[vdd_name]) + len(self.pins[gnd_name])
        if OPTS.level_shifter:
            routed_max += len(self.pins[vddio_name])
        fake_pins_ll_x_m5 = []
        fake_pins_ll_y_m5 = []
        fake_pins_ur_x_m5 = []
        fake_pins_ur_y_m5 = []
        fake_pins_ll_x_m6 = []
        fake_pins_ll_y_m6 = []
        fake_pins_ur_x_m6 = []
        fake_pins_ur_y_m6 = []

        for pin in self.fake_pins:
            if pin.layer == "m5":
                ll, ur = pin.rect
                fake_pins_ll_x_m5.append(ll.x)
                fake_pins_ll_y_m5.append(ll.y)
                fake_pins_ur_x_m5.append(ur.x)
                fake_pins_ur_y_m5.append(ur.y)
            elif pin.layer == "m6":
                ll, ur = pin.rect
                fake_pins_ll_x_m6.append(ll.x)
                fake_pins_ll_y_m6.append(ll.y)
                fake_pins_ur_x_m6.append(ur.x)
                fake_pins_ur_y_m6.append(ur.y)

        if OPTS.level_shifter:
            pin_name_list = [vdd_name, vddio_name, gnd_name]
        else:
            pin_name_list = [vdd_name, gnd_name]
        for pin_name in pin_name_list:
            pins = self.pins[pin_name]
            # Route closest pins according to the minimum spanning tree
            source_list = []
            target_list = []
            source_target_pair_list = []
            via_list_from = []
            via_list_to = []
            for source, target in self.get_mst_pairs(list(pins)):
                # Create the graph
                if (source, target) in source_target_pair_list or (target, source) in source_target_pair_list:
                    pass
                else:
                    source_target_pair_list.append((source, target))
                    g = graph(self)
                    print("source, target = ", source, target)
                    print("self.new_pins[vdd_name] =", self.new_pins[vdd_name])
                    if OPTS.level_shifter:
                        print("self.new_pins[vddio_name] =", self.new_pins[vddio_name])
                    print("self.new_pins[gnd_name] =", self.new_pins[gnd_name])
                    print("self.fake_pins =", self.fake_pins)
                    print("fake_pins_ll_y_m5 = ", fake_pins_ll_y_m5)
                    print("fake_pins_ll_x_m5 = ", fake_pins_ll_x_m5)
                    print("fake_pins_ll_y_m6 = ", fake_pins_ll_y_m6)
                    print("fake_pins_ll_x_m6 = ", fake_pins_ll_x_m6)
                    g.create_graph(source, target)
                    
                    # Find the shortest path from source to target
                    path = g.find_shortest_path()
                    print("path = ", path)
                    if path == None:
                        source_cp = source
                        source = target
                        target = source_cp
                        g.create_graph(source, target)
                        path = g.find_shortest_path()

                    sub_via_list_from = []
                    sub_via_list_to = []
                    sub_via_index = []
                    if path:
                        for i in range(len(path) - 1):
                            direction = path[i].get_direction(path[i+1])
                            if direction == (1, 1):
                                sub_via_list_from.append(path[i])
                                sub_via_list_to.append(path[i+1])
                                sub_via_index.append(i)
                        via_list_from.append(sub_via_list_from)
                        via_list_to.append(sub_via_list_to)
                    # If no path is found, throw an error
                    if path is None:
                        self.write_debug_gds(gds_name="{}error.gds".format(OPTS.openram_temp), g=g, source=source, target=target)
                        pass
                        # debug.error("Couldn't route from {} to {}.".format(source, target), -1)
                    # Create the path shapes on layout
                    if path:
                        source_ll, source_ur = source.rect
                        target_ll, target_ur = target.rect
                        # if (source_ur.x - source_ll.x >=18 or source_ur.y - source_ll.y >= 18) or (target_ur.x - target_ll.x >=18 or target_ur.y - target_ll.y >= 18):
                            # if (source_ur.x - source_ll.x >=18 or source_ur.y - source_ll.y >= 18):
                        # if source in self.new_pins[vdd_name] or source in self.new_pins[gnd_name]:
                        if source in source_list:
                            index = source_list.index(source)
                            target_to_compare = target_list[index]
                            if target.layer == target_to_compare.layer:
                                # target_ll, target_ur = target.rect
                                target_c_ll, target_c_ur = target_to_compare.rect
                                if (target_ll.x == target_c_ll.x and target.layer == "m6") or (target_ll.y == target_c_ll.y and target.layer == "m5"):
                                    if len(sub_via_list_from) == 1:
                                    # for i in range(len(sub_via_list_from)):
                                        if sub_via_list_from[0].center != via_list_from[index][0].center:
                                            path[sub_via_index[0]] = via_list_from[index][0]
                                            path[sub_via_index[0] + 1] = via_list_to[index][0]
                        # elif source in target_list:
                        #     index = target_list.index(source)
                        #     source_to_compare = source_list[index]
                        #     if target.layer == source_to_compare.layer:
                        #         # target_ll, target_ur = target.rect
                        #         source_c_ll, source_c_ur = source_to_compare.rect
                        #         if target_ll.x == source_c_ll.x or target_ll.y == source_c_ll.y:
                        #             pass
                        # elif target in source_list:
                        #     index = source_list.index(target)
                        #     target_to_compare = target_list[index]
                        #     if source.layer == target_to_compare.layer:
                        #         # source_ll, source_ur = source.rect
                        #         target_c_ll, target_c_ur = target_to_compare.rect
                        #         if source_ll.x == target_c_ll.x or source_ll.y == target_c_ll.y:
                        #             pass
                        # elif target in target_list:
                        #     index = target_list.index(target)
                        #     source_to_compare = source_list[index]
                        #     if source.layer == source_to_compare.layer:
                        #         # source_ll, source_ur = source.rect
                        #         source_c_ll, source_c_ur = source_to_compare.rect
                        #         if (source_ll.x == source_c_ll.x and source.layer == "m6") or (source_ll.y == source_c_ll.y and source.layer == "m5"):
                        #             pass

                        # else: 
                        if source.layer == "m5" and target.layer == "m6":
                            if source_ll.y in fake_pins_ll_y_m5 and (target_ll.x not in fake_pins_ll_x_m6): 
                                print("source_ll.y in fake_pins_ll_y_m5")
                                multiple_via5="SV"
                            elif target_ll.x in fake_pins_ll_x_m6 and (source_ll.y not in fake_pins_ll_y_m5): 
                                print("target_ll.x in fake_pins_ll_x_m6")
                                multiple_via5="TH"
                            else: multiple_via5 = False
                        elif source.layer == "m6"and target.layer == "m5":
                            if source_ll.x in fake_pins_ll_x_m6 and (target_ll.y not in fake_pins_ll_y_m5): 
                                print("source_ll.x in fake_pins_ll_x_m6")
                                multiple_via5="SH"
                            elif target_ll.y in fake_pins_ll_y_m5 and (source_ll.x not in fake_pins_ll_x_m6): 
                                print("target_ll.y in fake_pins_ll_y_m5")
                                multiple_via5="TV"
                            else: multiple_via5 = False
                        elif source.layer == "m5" and target.layer == "m5":
                            if source_ll.y in fake_pins_ll_y_m5 and (target_ll.y not in fake_pins_ll_y_m5): 
                                print("source_ll.y in fake_pins_ll_y_m5")
                                multiple_via5="SV"
                            elif target_ll.y in fake_pins_ll_y_m5 and (source_ll.y not in fake_pins_ll_y_m5): 
                                print("target_ll.y in fake_pins_ll_y_m5")
                                multiple_via5="TV"
                            else: multiple_via5 = False
                        elif source.layer == "m6" and target.layer == "m6":
                            if source_ll.x in fake_pins_ll_x_m6 and (target_ll.x not in fake_pins_ll_x_m6): 
                                print("source_ll.x in fake_pins_ll_x_m6")
                                multiple_via5="SH"
                            elif target_ll.x in fake_pins_ll_x_m6 and (source_ll.x not in fake_pins_ll_x_m6): 
                                print("target_ll.x in fake_pins_ll_x_m6")
                                multiple_via5="TH"
                            else: multiple_via5 = False

                            #     elif source.layer=="m6": multiple_via5="SH"
                            #     # elif (target_ur.x - target_ll.x >=18 or target_ur.y - target_ll.y >= 18):
                            # elif target in self.new_pins[vdd_name] or target in self.new_pins[gnd_name]: 
                            #     if target.layer=="m5": multiple_via5="TV"
                            #     elif target.layer=="m6": multiple_via5="TH"
                        else: multiple_via5=False
                        # multiple_via5=False
                        new_wires, new_vias = self.add_path(path, multiple_via5=multiple_via5)
                        # Find the recently added shapes
                        self.find_blockages(pin_name, new_wires)
                        self.find_vias(new_vias)
                        # Report routed count
                        routed_count += 1
                        source_list.append(source)
                        target_list.append(target)
                        debug.info(2, "Routed {} of {} supply pins".format(routed_count, routed_max))


    def add_side_pin(self, pin_name, side, num_vias=3, num_fake_pins=4):
        """ Add supply pin to one side of the layout. """

        ll, ur = self.bbox
        vertical = side in ["left", "right"]
        inner = pin_name == self.gnd_name
        if OPTS.level_shifter:
            middle = pin_name == self.vdd_name
        else:
            middle = False
        # Calculate wires' wideness
        wideness = self.track_wire * num_vias + self.track_space * (num_vias - 1)

        # Calculate the offset for the inner ring
        if OPTS.level_shifter:
            if inner:
            
                margin = wideness * 2
            elif middle:
                margin = 0
            else:
                margin = wideness * (-2)
        else:
            if inner:
                margin = wideness * 2
            else:
                margin = 0

        # Calculate the lower left coordinate
        if side == "top":
            offset = vector(ll.x + margin, ur.y - wideness - margin)
        elif side == "bottom":
            offset = vector(ll.x + margin, ll.y + margin)
        elif side == "left":
            offset = vector(ll.x + margin, ll.y + margin)
        elif side == "right":
            offset = vector(ur.x - wideness - margin, ll.y + margin)

        # Calculate width and height
        shape = ur - ll
        if vertical:
            shape_width = wideness
            shape_height = shape.y
        else:
            shape_width = shape.x
            shape_height = wideness
        # if inner:
        #     if OPTS.level_shifter:
        #         if vertical:
        #             shape_height -= margin * 4
        #         else:
        #             shape_width -= margin * 4
        #     else:
        #         if vertical:
        #             shape_height -= margin * 2
        #         else:
        #             shape_width -= margin * 2
        # if middle:
        if vertical:
            shape_height -= margin * 2
        else:
            shape_width -= margin * 2

        # Add this new pin
        layer = self.get_layer(int(vertical))
        # layer = "m5"
        pin = self.design.add_layout_pin(text=pin_name,
                                         layer=layer,
                                         offset=offset,
                                         width=shape_width,
                                         height=shape_height)

        # Add fake pins on this new pin evenly
        fake_pins = []
        if vertical:
            space = (shape_height - (2 * wideness) - num_fake_pins * self.track_wire) / (num_fake_pins + 1)
            start_offset = vector(offset.x, offset.y + wideness)
        else:
            space = (shape_width - (2 * wideness) - num_fake_pins * self.track_wire) / (num_fake_pins + 1)
            start_offset = vector(offset.x + wideness, offset.y)
        for i in range(1, num_fake_pins + 1):
            if vertical:
                offset = vector(start_offset.x, start_offset.y + i * (space + self.track_wire))
                ll = vector(offset.x, offset.y - self.track_wire)
                ur = vector(offset.x + wideness, offset.y)
            else:
                offset = vector(start_offset.x + i * (space + self.track_wire), start_offset.y)
                ll = vector(offset.x - self.track_wire, offset.y)
                ur = vector(offset.x, offset.y + wideness)
            rect = [ll, ur]
            fake_pin = graph_shape(name=pin_name,
                                   rect=rect,
                                   layer_name_pp=layer)
            fake_pins.append(fake_pin)
        return pin, fake_pins


    def add_ring_pin(self, pin_name, num_vias=3, num_fake_pins=4):
        """ Add the supply ring to the layout. """

        # Add side pins
        new_pins = []
        for side in ["top", "bottom", "right", "left"]:
            new_shape, fake_pins = self.add_side_pin(pin_name, side, num_vias, num_fake_pins)
            ll, ur = new_shape.rect
            rect = [ll, ur]
            layer = self.get_layer(side in ["left", "right"])
            # layer = "m5"
            new_pin = graph_shape(name=pin_name,
                                  rect=rect,
                                  layer_name_pp=layer)
            new_pins.append(new_pin)
            # layer = self.get_layer(side in ["top", "bottom"])
            # new_pin = graph_shape(name=pin_name,
            #                       rect=rect,
            #                       layer_name_pp=layer)
            # new_pins.append(new_pin)
            self.pins[pin_name].update(fake_pins)
            self.fake_pins.extend(fake_pins)

        # Add vias to the corners
        shift = self.track_wire + self.track_space
        half_wide = self.track_wire / 2
        for i in range(4):
            ll, ur = new_pins[i].rect
            if i % 2:
                top_left = vector(ur.x - (num_vias - 1) * shift - half_wide, ll.y + (num_vias - 1) * shift + half_wide)
            else:
                top_left = vector(ll.x + half_wide, ur.y - half_wide)
            for j in range(num_vias):
                for k in range(num_vias):
                    offset = vector(top_left.x + j * shift, top_left.y - k * shift)
                    self.design.add_via_center(layers=self.layers,
                                               offset=offset,
                                               multiple_via5=False)

        # Save side pins for routing
        self.new_pins[pin_name] = new_pins
        for pin in new_pins:
            self.blockages.append(self.inflate_shape(pin))


    def get_mst_pairs(self, pins):
        """
        Return the pin pairs from the minimum spanning tree in a graph that
        connects all pins together.
        """

        pin_count = len(pins)

        # Create an adjacency matrix that connects all pins
        edges = [[0] * pin_count for i in range(pin_count)]
        for i in range(pin_count):
            for j in range(pin_count):
                # Skip if they're the same pin
                if i == j:
                    continue
                # Skip if both pins are fake
                if pins[i] in self.fake_pins and pins[j] in self.fake_pins:
                    continue
                edges[i][j] = pins[i].distance(pins[j])

        pin_connected = [False] * pin_count
        pin_connected[0] = True

        # Add the minimum cost edge in each iteration (Prim's)
        mst_pairs = []
        for i in range(pin_count - 1):
            min_cost = float("inf")
            s = 0
            t = 0
            # Iterate over already connected pins
            for m in range(pin_count):
                # Skip if not connected
                if not pin_connected[m]:
                    continue
                # Iterate over this pin's neighbors
                for n in range(pin_count):
                    # Skip if already connected or isn't a neighbor
                    if pin_connected[n] or edges[m][n] == 0:
                        continue
                    # Choose this edge if it's better the the current one
                    if edges[m][n] < min_cost:
                        min_cost = edges[m][n]
                        s = m
                        t = n
            pin_connected[t] = True
            mst_pairs.append((pins[s], pins[t]))

        return mst_pairs


    def get_new_pins(self, name):
        """ Return the new supply pins added by this router. """

        return self.new_pins[name]
