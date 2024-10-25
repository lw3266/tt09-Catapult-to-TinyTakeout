/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module FA(output sum, cout, input a, b, cin);
  wire w0, w1, w2;
  
  xor #(2) (w0, a, b);
  xor #(2) (sum, w0, cin);
  
  and #(1) (w1, w0, cin);
  and #(1) (w2, a, b);
  or #(1) (cout, w1, w2);
endmodule

// Ripple Carry Adder with cin - 4 bits
module RCA4(output [3:0] sum, output cout, input [3:0] a, b, input cin);
  
  wire [3:1] c;
  
  FA fa0(sum[0], c[1], a[0], b[0], cin);
  FA fa[2:1](sum[2:1], c[3:2], a[2:1], b[2:1], c[2:1]);
  FA fa31(sum[3], cout, a[3], b[3], c[3]);
  
endmodule

module MUX2to1_w1(output y, input i0, i1, s);

  wire e0, e1;
  not #(1) (sn, s);
  
  and #(1) (e0, i0, sn);
  and #(1) (e1, i1, s);
  
  or #(1) (y, e0, e1);
  
endmodule

module MUX2to1_w4(output [3:0] y, input [3:0] i0, i1, input s);

  wire [3:0] e0, e1;
  not #(1) (sn, s);
  
  and #(1) (e0[0], i0[0], sn);
  and #(1) (e0[1], i0[1], sn);
  and #(1) (e0[2], i0[2], sn);
  and #(1) (e0[3], i0[3], sn);
      
  and #(1) (e1[0], i1[0], s);
  and #(1) (e1[1], i1[1], s);
  and #(1) (e1[2], i1[2], s);
  and #(1) (e1[3], i1[3], s);
  
  or #(1) (y[0], e0[0], e1[0]);
  or #(1) (y[1], e0[1], e1[1]);
  or #(1) (y[2], e0[2], e1[2]);
  or #(1) (y[3], e0[3], e1[3]);
  
endmodule

// Carry Select Adder - 8 bits
module CSelA8(output [7:0] sum, output cout, input [7:0] a, b);

  wire [7:0] sum0, sum1;
  wire c1;

  RCA4 rca0_0(sum0[3:0], cout0_0, a[3:0], b[3:0], 0);
  RCA4 rca0_1(sum1[3:0], cout0_1, a[3:0], b[3:0], 1);
  MUX2to1_w4 mux0_sum(sum[3:0], sum0[3:0], sum1[3:0], 0);
  MUX2to1_w1 mux0_cout(c1, cout0_0, cout0_1, 0);

  RCA4 rca1_0(sum0[7:4], cout1_0, a[7:4], b[7:4], 0);
  RCA4 rca1_1(sum1[7:4], cout1_1, a[7:4], b[7:4], 1);
  MUX2to1_w4 mux1_sum(sum[7:4], sum0[7:4], sum1[7:4], c1);
  MUX2to1_w1 mux1_cout(cout, cout1_0, cout1_1, c1);
  
endmodule

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);


    
    
  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
