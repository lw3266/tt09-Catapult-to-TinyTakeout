# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # i: 0 - y: 0
    # i: 1 - y: -95
    # i: 2 - y: -190
    # i: 3 - y: 86
    # i: 4 - y: 362
    # i: 5 - y: 38
    # i: 6 - y: -286
    # i: 7 - y: 390
    # i: 8 - y: 1066
    # i: 9 - y: 1142
    # i: 10 - y: 1218
    # i: 11 - y: 1665
    # i: 12 - y: 2112
    # i: 13 - y: 2464
    # i: 14 - y: 2816
    # i: 15 - y: 3168
    # i: 16 - y: 3520
    # i: 17 - y: 3872
    # i: 18 - y: 4224
    # i: 19 - y: 4576
    # i: 20 - y: 4928
    # i: 21 - y: 5280
    # i: 22 - y: 5632
    # i: 23 - y: 5984
    # i: 24 - y: 6336
    # i: 25 - y: 6688
    # i: 26 - y: 7040
    # i: 27 - y: 7392
    # i: 28 - y: 7744
    # i: 29 - y: 8096

    expected = [0, -95, -190, 86, 362, 38, -286, 390, 1066, 1142, 1218, 1665, 2112, 2464, 2816, 3168, 3520, 3872, 4224, 4576, 4928, 5280, 5632, 5984, 6336, 6688, 7040, 7392, 7744, 8096]
    for i in range(30):
        dut.ui_in.value = i
        await ClockCycles(dut.clk, 3)
        assert(dut.uo_out.value == expected[i])


    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
