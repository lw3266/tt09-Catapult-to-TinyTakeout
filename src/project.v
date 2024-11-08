/*
 * Copyright (c) Krishna Subramanian <https://github.com/mongrelgem>
 * Modified in 2024 by Juan Gil & Leyang Wang
 * 
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module FA(output wire sum,
          output wire cout,
          input wire a,
          input wire b,
          input wire cin);
  wire w0, w1, w2;
  
  assign w0 = a ^ b;
  assign sum = w0 ^ cin;

  assign w1 = w0 & cin;
  assign w2 = a & b;
  assign cout = w1 | w2;
  
endmodule

// Ripple Carry Adder with cin - 4 bits
module RCA4(output wire [3:0] sum,
            output wire cout,
            input wire [3:0] a,
            input wire [3:0] b,
            input wire cin);
  
  wire [3:1] c;
  
  FA fa0(sum[0], c[1], a[0], b[0], cin);
  FA fa[2:1](sum[2:1], c[3:2], a[2:1], b[2:1], c[2:1]);
  FA fa31(sum[3], cout, a[3], b[3], c[3]);
  
endmodule

module MUX2to1_w1(output wire y,
                  input wire i0,
                  input wire i1,
                  input wire s);
  wire sn;
  wire e0, e1;
  assign sn = ~s;

  assign e0 = i0 & sn;
  assign e1 = i1 & s;
  assign y = e0 | e1;
  
endmodule

module MUX2to1_w4(output wire [3:0] y,
                  input wire [3:0] i0,
                  input wire [3:0] i1,
                  input wire s);
  wire sn;
  wire [3:0] e0, e1;
  assign sn = ~s;

  assign e0[0] =  i0[0] & sn;
  assign e0[1] =  i0[1] & sn;
  assign e0[2] =  i0[2] & sn;
  assign e0[3] =  i0[3] & sn;

  assign e1[0] = i1[0] & s;
  assign e1[1] = i1[1] & s;
  assign e1[2] = i1[2] & s;
  assign e1[3] = i1[3] & s;

  assign y[0] = e0[0] | e1[0];
  assign y[1] = e0[1] | e1[1];
  assign y[2] = e0[2] | e1[2];
  assign y[3] = e0[3] | e1[3];
  
endmodule

module tt_um_CarrySelect8bit (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Internal Signals
  wire [7:0] sum, sum0, sum1, a, b;
  wire cout, cout0_0, cout0_1, cout1_0, cout1_1, c1;

          assign a[7:0] = ui_in[7:0]; 
          assign b[7:0] = uio_in[7:0];

          
          RCA4 rca0_0(sum0[3:0], cout0_0, a[3:0], b[3:0], 1'b0); //calculates 4 LSB of a + b with cin = 0
          RCA4 rca0_1(sum1[3:0], cout0_1, a[3:0], b[3:0], 1'b1); //calculates 4 LSB of a + b with cin = 1
          MUX2to1_w4 mux0_sum(sum[3:0], sum0[3:0], sum1[3:0], 1'b0); // this will always give sum0
          MUX2to1_w1 mux0_cout(c1, cout0_0, cout0_1, 1'b0); // this will always give cout0_0

          RCA4 rca1_0(sum0[7:4], cout1_0, a[7:4], b[7:4], 1'b0); //calculates 4 MSB of a + b with cin = 0
          RCA4 rca1_1(sum1[7:4], cout1_1, a[7:4], b[7:4], 1'b1); //calculates 4 MSB of a + b with cin = 0
  MUX2to1_w4 mux1_sum(sum[7:4], sum0[7:4], sum1[7:4], c1); // this will always select sum0, as c1 is always cout0_0
  MUX2to1_w1 mux1_cout(cout, cout1_0, cout1_1, c1);


    
    
  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = sum;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
