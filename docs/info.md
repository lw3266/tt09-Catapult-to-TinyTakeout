<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This FIR (Finite Impulse Response) Filter works through sythesized verilog generated via Siemen's Catapult using a baseline of C code (HLS). This FIR Filter is specifically designed to be a band-pass filter which rejects low values of input as well as high-values of input. When synthesizing this design, a pipelining of 5 was used as well as no unroll (this led to high throughput but also high latency). The resulting circuit design has a latency of about 89 clock cycles which means that the expected output should be observed around 89 clock cycles after the input has been changed. It is designed with a clock speed of 100MHz in mind.

## How to test

We tested the first 30 cases of input. This was done since past this, the expected inputs exceeded the bitrange needed to express the calculated output

The input ranges from 8 bits (past input = 30 (decimial), output is assumed to be junk due to TinyTapeout pin limitations causing overflow errors to be present)

The output ranges from 16 bits (2's complement) 

## External hardware

We did not use any external hardware.
