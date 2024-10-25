<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

The 8-bit carry select adder works through the full adder and mux. How it works is essentially two ripple adders, with one having cin = 0 and the other cin = 1. Through this procedure, we are able to speed up the calculation of selecting which sum depending on our cin.

## How to test

We tested all the combinations. This means two 8 bits input sum to a 8 bit output, and we ignore the carry out bit.

Therefore, we expect both the input and the output to be in the range of 0 to 255.

## External hardware

We did not use any external hardware.
