#!/usr/bin/env python3
# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California, Santa Cruz
# All rights reserved.
#
import sys, os
import unittest
from testutils import *

import openram
from openram import debug
from openram.sram_factory import factory
from openram import OPTS


class port_data_wmask_1rw_1r_test(openram_test):

    def runTest(self):
        config_file = "{}/tests/configs/config".format(os.getenv("OPENRAM_HOME"))
        openram.init_openram(config_file, is_unit_test=True)
        from openram import sram_config

        OPTS.num_rw_ports = 1
        OPTS.num_r_ports = 1
        OPTS.num_w_ports = 0
        openram.setup_bitcell()

        c = sram_config(word_size=16,
                        write_size=4,
                        num_words=16)

        c.words_per_row = 1
        c.recompute_sizes()
        debug.info(1, "No column mux")
        a = factory.create("port_data", sram_config=c, port=0, has_rbl=True)
        self.local_check(a)

        c.num_words = 32
        c.words_per_row = 2
        c.recompute_sizes()
        debug.info(1, "Two way column mux")
        a = factory.create("port_data", sram_config=c, port=0, has_rbl=True)
        self.local_check(a)

        c.num_words = 64
        c.words_per_row = 4
        c.recompute_sizes()
        debug.info(1, "Four way column mux")
        a = factory.create("port_data", sram_config=c, port=0, has_rbl=True)
        self.local_check(a)

        c.num_words = 128
        c.words_per_row = 8
        c.recompute_sizes()
        debug.info(1, "Eight way column mux")
        a = factory.create("port_data", sram_config=c, port=0, has_rbl=True)
        self.local_check(a)

        OPTS.num_rw_ports = 0
        OPTS.num_r_ports = 1
        OPTS.num_w_ports = 1
        openram.setup_bitcell()

        c.num_words = 16
        c.words_per_row = 1
        c.recompute_sizes()
        debug.info(1, "No column mux")
        a = factory.create("port_data", sram_config=c, port=0, has_rbl=True)
        self.local_check(a)
        a = factory.create("port_data", sram_config=c, port=1, has_rbl=True)
        self.local_check(a)
        #
        c.num_words = 32
        c.words_per_row = 2
        c.recompute_sizes()
        debug.info(1, "Two way column mux")
        a = factory.create("port_data", sram_config=c, port=0, has_rbl=True)
        self.local_check(a)
        a = factory.create("port_data", sram_config=c, port=1, has_rbl=True)
        self.local_check(a)

        c.num_words = 64
        c.words_per_row = 4
        c.recompute_sizes()
        debug.info(1, "Four way column mux")
        a = factory.create("port_data", sram_config=c, port=0, has_rbl=True)
        self.local_check(a)
        a = factory.create("port_data", sram_config=c, port=1, has_rbl=True)
        self.local_check(a)

        c.word_size = 8
        c.num_words = 128
        c.words_per_row = 8
        c.recompute_sizes()
        debug.info(1, "Eight way column mux")
        a = factory.create("port_data", sram_config=c, port=0, has_rbl=True)
        self.local_check(a)
        a = factory.create("port_data", sram_config=c, port=1, has_rbl=True)
        self.local_check(a)

        openram.end_openram()


# run the test from the command line
if __name__ == "__main__":
    (OPTS, args) = openram.parse_args()
    del sys.argv[1:]
    header(__file__, OPTS.tech_name)
    unittest.main(testRunner=debugTestRunner())
