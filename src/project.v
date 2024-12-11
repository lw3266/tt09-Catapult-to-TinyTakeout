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

  // Internal Signals
  wire [31:0] a;
  wire [31:0] b;
  wire c0,c1,rst;

  assign a[7:0] = ui_in[7:0]; 

  fir fir_inst (
      .clk(clk),
    .rst(rst),
    .y_rsc_dat(b),
    .y_triosy_lz(c0),
    .x_rsc_dat(a),
    .x_triosy_lz(c1)
  );

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = b;  // Example: ou_out is the sum of ui_in and uio_in
  assign uo_out = b[7:0];
  assign uio_out = b[15:8];

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, rst_n, rst, uio_in,  1'b0};

endmodule

module tt_um_fir_core_core_fsm ( 
  clk, rst, fsm_output, Shift_Accum_Loop_C_4_tr0
);
  input clk;
  input rst;
  output [6:0] fsm_output;
  reg [6:0] fsm_output;
  input Shift_Accum_Loop_C_4_tr0;

  // FSM State Type Declaration for fir_core_core_fsm_1
  parameter
    main_C_0 = 3'd0,
    Shift_Accum_Loop_C_0 = 3'd1,
    Shift_Accum_Loop_C_1 = 3'd2,
    Shift_Accum_Loop_C_2 = 3'd3,
    Shift_Accum_Loop_C_3 = 3'd4,
    Shift_Accum_Loop_C_4 = 3'd5,
    main_C_1 = 3'd6;

  reg [2:0] state_var;
  reg [2:0] state_var_NS;

  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : fir_core_core_fsm_1
    case (state_var)
      Shift_Accum_Loop_C_0 : begin
        fsm_output = 7'b0000010;
        state_var_NS = Shift_Accum_Loop_C_1;
      end
      Shift_Accum_Loop_C_1 : begin
        fsm_output = 7'b0000100;
        state_var_NS = Shift_Accum_Loop_C_2;
      end
      Shift_Accum_Loop_C_2 : begin
        fsm_output = 7'b0001000;
        state_var_NS = Shift_Accum_Loop_C_3;
      end
      Shift_Accum_Loop_C_3 : begin
        fsm_output = 7'b0010000;
        state_var_NS = Shift_Accum_Loop_C_4;
      end
      Shift_Accum_Loop_C_4 : begin
        fsm_output = 7'b0100000;
        if ( Shift_Accum_Loop_C_4_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = Shift_Accum_Loop_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 7'b1000000;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 7'b0000001;
        state_var_NS = Shift_Accum_Loop_C_0;
      end
    endcase
  end

  always @(posedge clk) begin
    if ( rst ) begin
      state_var <= main_C_0;
    end
    else begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    fir_core
// ------------------------------------------------------------------


module fir_core (
  clk, rst, y_rsc_dat, y_triosy_lz, x_rsc_dat, x_triosy_lz
);
  input clk;
  input rst;
  output [31:0] y_rsc_dat;
  output y_triosy_lz;
  input [31:0] x_rsc_dat;
  output x_triosy_lz;

  // Interconnect Declarations
  reg [31:0] y_rsci_idat;
  wire [31:0] x_rsci_idat;
  wire [6:0] fsm_output;
  wire [4:0] Shift_Accum_Loop_acc_1_tmp;
  wire [5:0] nl_Shift_Accum_Loop_acc_1_tmp;
  wire and_dcpl;
  wire or_tmp_3;
  reg [3:0] i_4_0_sva_3_0;
  reg i_4_0_sva_1_4;
  reg reg_x_triosy_obj_ld_cse;
  wire reg_y_and_cse;
  wire or_tmp_28;
  reg [31:0] shift_reg_0_lpi_2;
  reg [31:0] shift_reg_7_lpi_2;
  reg [31:0] shift_reg_8_lpi_2;
  reg [31:0] shift_reg_6_lpi_2;
  reg [31:0] shift_reg_9_lpi_2;
  reg [31:0] shift_reg_5_lpi_2;
  reg [31:0] shift_reg_10_lpi_2;
  reg [31:0] shift_reg_4_lpi_2;
  reg [31:0] shift_reg_11_lpi_2;
  reg [31:0] shift_reg_3_lpi_2;
  reg [31:0] shift_reg_12_lpi_2;
  reg [31:0] shift_reg_2_lpi_2;
  reg [31:0] shift_reg_13_lpi_2;
  reg [31:0] shift_reg_1_lpi_2;
  reg [31:0] shift_reg_14_lpi_2;
  reg [31:0] x_sva;
  reg [31:0] acc_sva;
  wire [31:0] Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_32_31_0_1_cse_sva_1;
  wire [7:0] ROM_1i4_1o8_d696dcf5844c155a2ae249853341a28f2e_1;
  wire [1:0] ROM_1i4_1o2_69443db1eaa1d9e970efd8ef438226512e_1;
  wire [3:0] Shift_Accum_Loop_else_acc_1_tmp;
  wire [4:0] nl_Shift_Accum_Loop_else_acc_1_tmp;
  wire nand_cse;
  wire nor_5_cse;
  wire nand_6_cse;
  wire [31:0] Shift_Accum_Loop_else_mul_itm;
  wire signed [42:0] nl_Shift_Accum_Loop_else_mul_itm;

  wire[31:0] Shift_Accum_Loop_else_acc_nl;
  wire[32:0] nl_Shift_Accum_Loop_else_acc_nl;
  wire[24:0] Shift_Accum_Loop_else_mux_4_nl;
  wire[24:0] Shift_Accum_Loop_if_acc_6_nl;
  wire[25:0] nl_Shift_Accum_Loop_if_acc_6_nl;
  wire[24:0] Shift_Accum_Loop_if_acc_7_nl;
  wire[25:0] nl_Shift_Accum_Loop_if_acc_7_nl;
  wire[26:0] Shift_Accum_Loop_else_mux_5_nl;
  wire[26:0] Shift_Accum_Loop_if_acc_8_nl;
  wire[27:0] nl_Shift_Accum_Loop_if_acc_8_nl;
  wire[4:0] Shift_Accum_Loop_else_mux_6_nl;
  wire acc_not_nl;
  wire[3:0] Shift_Accum_Loop_mux_nl;
  wire and_19_nl;

  // Interconnect Declarations for Component Instantiations 
  ccs_out_v1 #(.rscid(32'sd1),
  .width(32'sd32)) y_rsci (
      .idat(y_rsci_idat),
      .dat(y_rsc_dat)
    );
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd32)) x_rsci (
      .idat(x_rsci_idat),
      .dat(x_rsc_dat)
    );
  fir_core_core_fsm fir_core_core_fsm_inst(
    .clk(clk),
    .rst(rst),
    .fsm_output(fsm_output),
    .Shift_Accum_Loop_C_4_tr0(Shift_Accum_Loop_else_acc_1_tmp[0])
  );

  always @(posedge clk) begin
    if (rst) begin
      y_rsci_idat <= 32'd0;
    end else if (fsm_output[0] == 1'b1) begin
      y_rsci_idat <= x_rsci_idat;
    end
  end

  assign y_triosy_lz = (fsm_output[0] == 1'b0);

endmodule
