# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="ns")
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

    expected = [0, -95, -190, 86, 362, 38, -286, 390, 1066, 1142, 1218, 1665, 2112, 2464, 2816, 3168, 3520, 3872, 4224, 4576, 4928, 5280, 5632, 5984, 6336, 6688, 7040, 7392, 7744, 8096]
    
    await ClockCycles(dut.clk, 80)
   # binary_str = bin(num & 0xFFFF)[2:].zfill(16)
    for i in range(0,256):        
        dut.ui_in.value = i
        await ClockCycles(dut.clk, 80)
        x = ((dut.uio_out.value << 8) + dut.uo_out.value)
        dut._log.info(f"input: {dut.ui_in.value} (dec:{i}) --> Output: {dut.uio_out.value}{dut.uo_out.value} (dec:{x}) Expected: {expected[i]} (16'b: {bin(expected[i] & 0xFFFF)[2:].zfill(16)})")
        #print(dut.ui_in.value, "-->" ,dut.uio_out.value, dut.uo_out.value)
        #assert( (int(dut.uio_out.value) + int(dut.uo_out.value)) == expected[i])

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
