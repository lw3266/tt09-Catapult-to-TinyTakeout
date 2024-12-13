`default_nettype none
`include "concat_sim_rtl.v"


module tt_um_fir (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Declare signals for fir_core inputs/outputs
  wire [7:0] x_rsc_dat;       // Input data to fir_core (from uio_in)
  wire [15:0] y_rsc_dat;      // Output data from fir_core (to be split into uo_out, uio_out)
  wire y_triosy_lz;           // Output tri-state signal (not used in our case)
  wire x_triosy_lz;           // Input tri-state signal (not used in our case)

  // Instantiate fir_core
  fir_core fir_core_inst (
    .clk(clk),
    .rst(~rst_n),               // Active-low reset
    .y_rsc_dat(y_rsc_dat),      // 16-bit output data
    .y_triosy_lz(y_triosy_lz),  // Tri-state output signal (not used)
    .x_rsc_dat(x_rsc_dat),      // 8-bit input data (from uio_in)
    .x_triosy_lz(x_triosy_lz)   // Tri-state input signal (not used)
  );

  // Map `uio_in` to `fir_core` input `x_rsc_dat`
  assign x_rsc_dat = uio_in;

  // Split the 16-bit output `y_rsc_dat` into two 8-bit outputs
  assign uo_out = y_rsc_dat[7:0];      // Lower 8 bits of the 16-bit output
  assign uio_out = y_rsc_dat[15:8];    // Upper 8 bits of the 16-bit output

  // Set `uio_oe` to active high (output enable for uio_out)
  assign uio_oe = 8'b11111111;         // Enable all IOs as output

endmodule
