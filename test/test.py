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

    # for i in range (0,256):
    #     for j in range(0,256):
    #         # set input vals
    #         dut.ui_in.value = i
    #         dut.uio_in.value = j

    #         # Wait for three clock cycle to see the output values
    #         # await ClockCycles(dut.clk, 3)

    #         # The following assersion is just an example of how to check the output values.
    #         # Change it to match the actual expected output of your module:
    #         assert dut.uo_out.value == (i+j)%256

    expected = [0, -95, -190, 86, 362, 38, -286, 390, 1066, 1142, 1218, 1665, 2112, 2464, 2816, 3168, 3520, 3872, 4224, 4576, 4928, 5280, 5632, 5984, 6336, 6688, 7040, 7392, 7744, 8096]
    for i in range(30):
        dut.ui_in.value = i
        await ClockCycles(dut.clk, 3)
        assert(dut.uo_out.value == expected[i])

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
