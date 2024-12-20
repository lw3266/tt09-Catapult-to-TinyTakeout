module tt_um_example (
    input  wire       VGND,
    input  wire       VDPWR,    // 1.8v power supply
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    inout  wire [7:0] ua,       // Analog pins, only ua[5:0] can be used
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Internal signals for mapping
  wire [7:0] x_rsc_dat; // input to fir_core from uio_in
  wire [15:0] y_rsc_dat; // output from fir_core to uo_out and uio_out
  wire x_triosy_lz; // control signal for input
  wire y_triosy_lz; // control signal for output

  // Instantiate the fir_core module
  fir_core fir_core_inst (
      .clk(clk),
      .rst(rst_n),
      .y_rsc_dat(y_rsc_dat), // 16-bit output
      .y_triosy_lz(y_triosy_lz),
      .x_rsc_dat(x_rsc_dat), // 8-bit input
      .x_triosy_lz(x_triosy_lz)
  );

  // Map input and output signals to/from fir_core
  assign x_rsc_dat = uio_in;        // Map uio_in (8 bits) to x_rsc_dat (8 bits)
  assign uo_out = y_rsc_dat[7:0];   // Map lower 8 bits of y_rsc_dat to uo_out
  assign uio_out = y_rsc_dat[15:8]; // Map upper 8 bits of y_rsc_dat to uio_out
  assign uio_oe = y_triosy_lz;      // Enable signal for IOs from y_triosy_lz

  // Synchronize tri-state signals for IO control
  mgc_io_sync_v2 #(.valid(0)) y_triosy_obj (
      .ld(y_triosy_lz),
      .lz(uio_oe)
  );
  mgc_io_sync_v2 #(.valid(0)) x_triosy_obj (
      .ld(x_triosy_lz),
      .lz(uio_oe)
  );

endmodule


module ccs_out_v1 (dat, idat);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output   [width-1:0] dat;
  input    [width-1:0] idat;

  wire     [width-1:0] dat;

  assign dat = idat;

endmodule

module ccs_in_v1 (idat, dat);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] idat;
  input  [width-1:0] dat;

  wire   [width-1:0] idat;

  assign idat = dat;

endmodule

module mgc_io_sync_v2 (ld, lz);
    parameter valid = 0;

    input  ld;
    output lz;

    wire   lz;

    assign lz = ld;

endmodule

module ROM_1i4_1o8_61aabc893f7aad8730a2695a2c5e7b36ba (
  I_1, O_1
);
  input [3:0] I_1;
  output [7:0] O_1;

  // Interconnect Declarations for Component Instantiations 
  assign O_1 = MUX_v_8_16_2x0(8'b00000000, 8'b00101110, 8'b00000000, 8'b10110101,
      8'b00000000, 8'b01111101, 8'b00000000, 8'b10110101, 8'b00000000, 8'b00101110,
      8'b00000000, 8'b11110100, 8'b00000000, 8'b00000000, 8'b00000000, I_1);

  function automatic [7:0] MUX_v_8_16_2x0;
    input [7:0] input_1;
    input [7:0] input_2;
    input [7:0] input_3;
    input [7:0] input_4;
    input [7:0] input_5;
    input [7:0] input_6;
    input [7:0] input_7;
    input [7:0] input_8;
    input [7:0] input_9;
    input [7:0] input_10;
    input [7:0] input_11;
    input [7:0] input_12;
    input [7:0] input_13;
    input [7:0] input_14;
    input [7:0] input_15;
    input [3:0] sel;
    reg [7:0] result;
  begin
    case (sel)
      4'b0001 : begin
        result = input_1;
      end
      4'b0010 : begin
        result = input_2;
      end
      4'b0011 : begin
        result = input_3;
      end
      4'b0100 : begin
        result = input_4;
      end
      4'b0101 : begin
        result = input_5;
      end
      4'b0110 : begin
        result = input_6;
      end
      4'b0111 : begin
        result = input_7;
      end
      4'b1000 : begin
        result = input_8;
      end
      4'b1001 : begin
        result = input_9;
      end
      4'b1010 : begin
        result = input_10;
      end
      4'b1011 : begin
        result = input_11;
      end
      4'b1100 : begin
        result = input_12;
      end
      4'b1101 : begin
        result = input_13;
      end
      4'b1110 : begin
        result = input_14;
      end
      default : begin
        result = input_15;
      end
    endcase
    MUX_v_8_16_2x0 = result;
  end
  endfunction

endmodule

module ROM_1i4_1o2_ab69eb043606de84137f91d54a43d592ba (
  I_1, O_1
);
  input [3:0] I_1;
  output [1:0] O_1;

  // Interconnect Declarations for Component Instantiations 
  assign O_1 = MUX_v_2_16_2x0(2'b00, 2'b11, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00,
      2'b00, 2'b11, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, I_1);

  function automatic [1:0] MUX_v_2_16_2x0;
    input [1:0] input_1;
    input [1:0] input_2;
    input [1:0] input_3;
    input [1:0] input_4;
    input [1:0] input_5;
    input [1:0] input_6;
    input [1:0] input_7;
    input [1:0] input_8;
    input [1:0] input_9;
    input [1:0] input_10;
    input [1:0] input_11;
    input [1:0] input_12;
    input [1:0] input_13;
    input [1:0] input_14;
    input [1:0] input_15;
    input [3:0] sel;
    reg [1:0] result;
  begin
    case (sel)
      4'b0001 : begin
        result = input_1;
      end
      4'b0010 : begin
        result = input_2;
      end
      4'b0011 : begin
        result = input_3;
      end
      4'b0100 : begin
        result = input_4;
      end
      4'b0101 : begin
        result = input_5;
      end
      4'b0110 : begin
        result = input_6;
      end
      4'b0111 : begin
        result = input_7;
      end
      4'b1000 : begin
        result = input_8;
      end
      4'b1001 : begin
        result = input_9;
      end
      4'b1010 : begin
        result = input_10;
      end
      4'b1011 : begin
        result = input_11;
      end
      4'b1100 : begin
        result = input_12;
      end
      4'b1101 : begin
        result = input_13;
      end
      4'b1110 : begin
        result = input_14;
      end
      default : begin
        result = input_15;
      end
    endcase
    MUX_v_2_16_2x0 = result;
  end
  endfunction

endmodule

module fir_core_core_fsm (
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

module fir_core (
  clk, rst, y_rsc_dat, y_triosy_lz, x_rsc_dat, x_triosy_lz
);
  input clk;
  input rst;
  output [15:0] y_rsc_dat;
  output y_triosy_lz;
  input [7:0] x_rsc_dat;
  output x_triosy_lz;

  // Interconnect Declarations
  reg [15:0] y_rsci_idat;
  wire [7:0] x_rsci_idat;
  wire [6:0] fsm_output;
  wire [4:0] Shift_Accum_Loop_acc_1_tmp;
  wire [5:0] nl_Shift_Accum_Loop_acc_1_tmp;
  wire and_dcpl;
  wire or_tmp_3;
  reg [3:0] i_4_0_sva_3_0;
  reg i_4_0_sva_1_4;
  reg reg_x_triosy_obj_ld_cse;
  wire reg_y_and_cse;
  reg [7:0] shift_reg_0_lpi_2;
  reg [7:0] shift_reg_7_lpi_2;
  reg [7:0] shift_reg_8_lpi_2;
  reg [7:0] shift_reg_6_lpi_2;
  reg [7:0] shift_reg_9_lpi_2;
  reg [7:0] shift_reg_5_lpi_2;
  reg [7:0] shift_reg_10_lpi_2;
  reg [7:0] shift_reg_4_lpi_2;
  reg [7:0] shift_reg_11_lpi_2;
  reg [7:0] shift_reg_3_lpi_2;
  reg [7:0] shift_reg_12_lpi_2;
  reg [7:0] shift_reg_2_lpi_2;
  reg [7:0] shift_reg_13_lpi_2;
  reg [7:0] shift_reg_1_lpi_2;
  reg [7:0] shift_reg_14_lpi_2;
  reg [7:0] x_sva;
  reg [15:0] acc_15_0_sva;
  wire [8:0] Shift_Accum_Loop_if_acc_4_sdt_1;
  wire [9:0] nl_Shift_Accum_Loop_if_acc_4_sdt_1;
  wire [7:0] Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
  wire [7:0] ROM_1i4_1o8_d696dcf5844c155a2ae249853341a28f2e_1;
  wire [1:0] ROM_1i4_1o2_69443db1eaa1d9e970efd8ef438226512e_1;
  wire [3:0] Shift_Accum_Loop_else_acc_1_tmp;
  wire [4:0] nl_Shift_Accum_Loop_else_acc_1_tmp;
  wire nand_cse;
  wire nor_5_cse;
  wire nand_6_cse;

  wire[15:0] Shift_Accum_Loop_else_acc_nl;
  wire[16:0] nl_Shift_Accum_Loop_else_acc_nl;
  wire[15:0] Shift_Accum_Loop_else_mux_2_nl;
  wire[15:0] operator_8_true_1_mul_1_nl;
  wire signed [18:0] nl_operator_8_true_1_mul_1_nl;
  wire[7:0] Shift_Accum_Loop_if_acc_6_nl;
  wire[8:0] nl_Shift_Accum_Loop_if_acc_6_nl;
  wire and_139_nl;
  wire not_39_nl;
  wire[3:0] Shift_Accum_Loop_mux_nl;
  wire and_19_nl;

  // Interconnect Declarations for Component Instantiations 
  ccs_out_v1 #(.rscid(32'sd1),
  .width(32'sd16)) y_rsci (
      .idat(y_rsci_idat),
      .dat(y_rsc_dat)
    );
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd8)) x_rsci (
      .dat(x_rsc_dat),
      .idat(x_rsci_idat)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) y_triosy_obj (
      .ld(reg_x_triosy_obj_ld_cse),
      .lz(y_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) x_triosy_obj (
      .ld(reg_x_triosy_obj_ld_cse),
      .lz(x_triosy_lz)
    );
  ROM_1i4_1o8_61aabc893f7aad8730a2695a2c5e7b36ba  U_ROM_1i4_1o8_d696dcf5844c155a2ae249853341a28f2e_rg
      (
      .I_1(i_4_0_sva_3_0),
      .O_1(ROM_1i4_1o8_d696dcf5844c155a2ae249853341a28f2e_1)
    );
  ROM_1i4_1o2_ab69eb043606de84137f91d54a43d592ba  U_ROM_1i4_1o2_69443db1eaa1d9e970efd8ef438226512e_rg
      (
      .I_1(i_4_0_sva_3_0),
      .O_1(ROM_1i4_1o2_69443db1eaa1d9e970efd8ef438226512e_1)
    );
  fir_core_core_fsm fir_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .Shift_Accum_Loop_C_4_tr0(i_4_0_sva_1_4)
    );
  assign nor_5_cse = ~((i_4_0_sva_3_0[2:1]!=2'b00));
  assign nand_cse = ~((Shift_Accum_Loop_else_acc_1_tmp[1:0]==2'b11));
  assign nand_6_cse = ~((Shift_Accum_Loop_else_acc_1_tmp[3:2]==2'b11));
  assign reg_y_and_cse = (fsm_output[5]) & i_4_0_sva_1_4;
  assign nl_Shift_Accum_Loop_if_acc_4_sdt_1 = conv_s2u_8_9(x_sva) + conv_u2u_3_9({(~
      (x_sva[7])) , (x_sva[6:5])});
  assign Shift_Accum_Loop_if_acc_4_sdt_1 = nl_Shift_Accum_Loop_if_acc_4_sdt_1[8:0];
  assign nl_Shift_Accum_Loop_else_acc_1_tmp = i_4_0_sva_3_0 + 4'b1111;
  assign Shift_Accum_Loop_else_acc_1_tmp = nl_Shift_Accum_Loop_else_acc_1_tmp[3:0];
  assign Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1
      = MUX_v_8_15_2(shift_reg_0_lpi_2, shift_reg_1_lpi_2, shift_reg_2_lpi_2, shift_reg_3_lpi_2,
      shift_reg_4_lpi_2, shift_reg_5_lpi_2, shift_reg_6_lpi_2, shift_reg_7_lpi_2,
      shift_reg_8_lpi_2, shift_reg_9_lpi_2, shift_reg_10_lpi_2, shift_reg_11_lpi_2,
      shift_reg_12_lpi_2, shift_reg_13_lpi_2, shift_reg_14_lpi_2, Shift_Accum_Loop_else_acc_1_tmp);
  assign nl_Shift_Accum_Loop_acc_1_tmp = conv_u2s_4_5(i_4_0_sva_3_0) + 5'b11111;
  assign Shift_Accum_Loop_acc_1_tmp = nl_Shift_Accum_Loop_acc_1_tmp[4:0];
  assign and_dcpl = ~((fsm_output[6]) | (fsm_output[0]));
  assign or_tmp_3 = (fsm_output[6]) | (fsm_output[0]);
  always @(posedge clk) begin
    if ( rst ) begin
      x_sva <= 8'b00000000;
    end
    else if ( ~ and_dcpl ) begin
      x_sva <= x_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      acc_15_0_sva <= 16'b0000000000000000;
    end
    else if ( (fsm_output[0]) | (fsm_output[6]) | (fsm_output[1]) ) begin
      acc_15_0_sva <= MUX_v_16_2_2(16'b0000000000000000, Shift_Accum_Loop_else_acc_nl,
          not_39_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      i_4_0_sva_3_0 <= 4'b0000;
      reg_x_triosy_obj_ld_cse <= 1'b0;
    end
    else begin
      i_4_0_sva_3_0 <= MUX_v_4_2_2(Shift_Accum_Loop_mux_nl, 4'b1111, or_tmp_3);
      reg_x_triosy_obj_ld_cse <= reg_y_and_cse;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_0_lpi_2 <= 8'b00000000;
    end
    else if ( (i_4_0_sva_3_0==4'b0000) & (fsm_output[1]) ) begin
      shift_reg_0_lpi_2 <= x_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_1_lpi_2 <= 8'b00000000;
    end
    else if ( ((Shift_Accum_Loop_else_acc_1_tmp!=4'b0001)) & (i_4_0_sva_3_0[0]) &
        nor_5_cse & (fsm_output[1]) & (~ (i_4_0_sva_3_0[3])) ) begin
      shift_reg_1_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_2_lpi_2 <= 8'b00000000;
    end
    else if ( (~((~((Shift_Accum_Loop_else_acc_1_tmp!=4'b0010))) | (i_4_0_sva_3_0[0])))
        & (i_4_0_sva_3_0[2:1]==2'b01) & (fsm_output[1]) & (~ (i_4_0_sva_3_0[3]))
        ) begin
      shift_reg_2_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_3_lpi_2 <= 8'b00000000;
    end
    else if ( ((Shift_Accum_Loop_else_acc_1_tmp[3:2]!=2'b00) | nand_cse) & (i_4_0_sva_3_0[2:0]==3'b011)
        & (fsm_output[1]) & (~ (i_4_0_sva_3_0[3])) ) begin
      shift_reg_3_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_4_lpi_2 <= 8'b00000000;
    end
    else if ( (~((~((Shift_Accum_Loop_else_acc_1_tmp!=4'b0100))) | (i_4_0_sva_3_0[0])))
        & (i_4_0_sva_3_0[2:1]==2'b10) & (fsm_output[1]) & (~ (i_4_0_sva_3_0[3]))
        ) begin
      shift_reg_4_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_5_lpi_2 <= 8'b00000000;
    end
    else if ( ((Shift_Accum_Loop_else_acc_1_tmp!=4'b0101)) & (i_4_0_sva_3_0[2:0]==3'b101)
        & (fsm_output[1]) & (~ (i_4_0_sva_3_0[3])) ) begin
      shift_reg_5_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_6_lpi_2 <= 8'b00000000;
    end
    else if ( (~((~((Shift_Accum_Loop_else_acc_1_tmp!=4'b0110))) | (i_4_0_sva_3_0[0])))
        & (i_4_0_sva_3_0[2:1]==2'b11) & (fsm_output[1]) & (~ (i_4_0_sva_3_0[3]))
        ) begin
      shift_reg_6_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_7_lpi_2 <= 8'b00000000;
    end
    else if ( ((Shift_Accum_Loop_else_acc_1_tmp[3:2]!=2'b01) | nand_cse) & (i_4_0_sva_3_0[2:0]==3'b111)
        & (fsm_output[1]) & (~ (i_4_0_sva_3_0[3])) ) begin
      shift_reg_7_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_8_lpi_2 <= 8'b00000000;
    end
    else if ( (~((~((Shift_Accum_Loop_else_acc_1_tmp!=4'b1000))) | (i_4_0_sva_3_0[0])))
        & nor_5_cse & (fsm_output[1]) & (i_4_0_sva_3_0[3]) ) begin
      shift_reg_8_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_9_lpi_2 <= 8'b00000000;
    end
    else if ( ((Shift_Accum_Loop_else_acc_1_tmp!=4'b1001)) & (i_4_0_sva_3_0[0]) &
        nor_5_cse & (fsm_output[1]) & (i_4_0_sva_3_0[3]) ) begin
      shift_reg_9_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_10_lpi_2 <= 8'b00000000;
    end
    else if ( (~((~((Shift_Accum_Loop_else_acc_1_tmp!=4'b1010))) | (i_4_0_sva_3_0[0])))
        & (i_4_0_sva_3_0[2:1]==2'b01) & (fsm_output[1]) & (i_4_0_sva_3_0[3]) ) begin
      shift_reg_10_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_11_lpi_2 <= 8'b00000000;
    end
    else if ( ((Shift_Accum_Loop_else_acc_1_tmp[3:2]!=2'b10) | nand_cse) & (i_4_0_sva_3_0[2:0]==3'b011)
        & (fsm_output[1]) & (i_4_0_sva_3_0[3]) ) begin
      shift_reg_11_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_12_lpi_2 <= 8'b00000000;
    end
    else if ( (~((~(nand_6_cse | (Shift_Accum_Loop_else_acc_1_tmp[1:0]!=2'b00)))
        | (i_4_0_sva_3_0[0]))) & (i_4_0_sva_3_0[2:1]==2'b10) & (fsm_output[1]) &
        (i_4_0_sva_3_0[3]) ) begin
      shift_reg_12_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_13_lpi_2 <= 8'b00000000;
    end
    else if ( (nand_6_cse | (Shift_Accum_Loop_else_acc_1_tmp[1:0]!=2'b01)) & (i_4_0_sva_3_0[2:0]==3'b101)
        & (fsm_output[1]) & (i_4_0_sva_3_0[3]) ) begin
      shift_reg_13_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      shift_reg_14_lpi_2 <= 8'b00000000;
    end
    else if ( (~((~(nand_6_cse | (Shift_Accum_Loop_else_acc_1_tmp[1:0]!=2'b10)))
        | (i_4_0_sva_3_0[0]))) & (i_4_0_sva_3_0[2:1]==2'b11) & (fsm_output[1]) &
        (i_4_0_sva_3_0[3]) ) begin
      shift_reg_14_lpi_2 <= Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      y_rsci_idat <= 16'b0000000000000000;
    end
    else if ( reg_y_and_cse ) begin
      y_rsci_idat <= acc_15_0_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      i_4_0_sva_1_4 <= 1'b0;
    end
    else if ( fsm_output[1] ) begin
      i_4_0_sva_1_4 <= Shift_Accum_Loop_acc_1_tmp[4];
    end
  end
  assign nl_operator_8_true_1_mul_1_nl = $signed(Shift_Accum_Loop_else_Shift_Accum_Loop_else_slc_shift_reg_8_7_0_1_cse_sva_1)
      * $signed(({ROM_1i4_1o8_d696dcf5844c155a2ae249853341a28f2e_1 , 1'b0 , ROM_1i4_1o2_69443db1eaa1d9e970efd8ef438226512e_1}));
  assign operator_8_true_1_mul_1_nl = nl_operator_8_true_1_mul_1_nl[15:0];
  assign nl_Shift_Accum_Loop_if_acc_6_nl = (~ x_sva) + conv_s2s_7_8(Shift_Accum_Loop_if_acc_4_sdt_1[8:2]);
  assign Shift_Accum_Loop_if_acc_6_nl = nl_Shift_Accum_Loop_if_acc_6_nl[7:0];
  assign and_139_nl = (i_4_0_sva_3_0==4'b0000) & (fsm_output[1]);
  assign Shift_Accum_Loop_else_mux_2_nl = MUX_v_16_2_2(operator_8_true_1_mul_1_nl,
      (signext_16_15({Shift_Accum_Loop_if_acc_6_nl , (Shift_Accum_Loop_if_acc_4_sdt_1[1:0])
      , (x_sva[4:0])})), and_139_nl);
  assign nl_Shift_Accum_Loop_else_acc_nl = acc_15_0_sva + Shift_Accum_Loop_else_mux_2_nl;
  assign Shift_Accum_Loop_else_acc_nl = nl_Shift_Accum_Loop_else_acc_nl[15:0];
  assign not_39_nl = ~ or_tmp_3;
  assign and_19_nl = and_dcpl & (~ (fsm_output[1]));
  assign Shift_Accum_Loop_mux_nl = MUX_v_4_2_2((Shift_Accum_Loop_acc_1_tmp[3:0]),
      i_4_0_sva_3_0, and_19_nl);

  function automatic [15:0] MUX_v_16_2_2;
    input [15:0] input_0;
    input [15:0] input_1;
    input  sel;
    reg [15:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_16_2_2 = result;
  end
  endfunction


  function automatic [3:0] MUX_v_4_2_2;
    input [3:0] input_0;
    input [3:0] input_1;
    input  sel;
    reg [3:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_4_2_2 = result;
  end
  endfunction


  function automatic [7:0] MUX_v_8_15_2;
    input [7:0] input_0;
    input [7:0] input_1;
    input [7:0] input_2;
    input [7:0] input_3;
    input [7:0] input_4;
    input [7:0] input_5;
    input [7:0] input_6;
    input [7:0] input_7;
    input [7:0] input_8;
    input [7:0] input_9;
    input [7:0] input_10;
    input [7:0] input_11;
    input [7:0] input_12;
    input [7:0] input_13;
    input [7:0] input_14;
    input [3:0] sel;
    reg [7:0] result;
  begin
    case (sel)
      4'b0000 : begin
        result = input_0;
      end
      4'b0001 : begin
        result = input_1;
      end
      4'b0010 : begin
        result = input_2;
      end
      4'b0011 : begin
        result = input_3;
      end
      4'b0100 : begin
        result = input_4;
      end
      4'b0101 : begin
        result = input_5;
      end
      4'b0110 : begin
        result = input_6;
      end
      4'b0111 : begin
        result = input_7;
      end
      4'b1000 : begin
        result = input_8;
      end
      4'b1001 : begin
        result = input_9;
      end
      4'b1010 : begin
        result = input_10;
      end
      4'b1011 : begin
        result = input_11;
      end
      4'b1100 : begin
        result = input_12;
      end
      4'b1101 : begin
        result = input_13;
      end
      default : begin
        result = input_14;
      end
    endcase
    MUX_v_8_15_2 = result;
  end
  endfunction


  function automatic [15:0] signext_16_15;
    input [14:0] vector;
  begin
    signext_16_15= {{1{vector[14]}}, vector};
  end
  endfunction


  function automatic [7:0] conv_s2s_7_8 ;
    input [6:0]  vector ;
  begin
    conv_s2s_7_8 = {vector[6], vector};
  end
  endfunction


  function automatic [8:0] conv_s2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_s2u_8_9 = {vector[7], vector};
  end
  endfunction


  function automatic [4:0] conv_u2s_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2s_4_5 =  {1'b0, vector};
  end
  endfunction


  function automatic [8:0] conv_u2u_3_9 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_9 = {{6{1'b0}}, vector};
  end
  endfunction

endmodule

module fir (
  clk, rst, y_rsc_dat, y_triosy_lz, x_rsc_dat, x_triosy_lz
);
  input clk;
  input rst;
  output [15:0] y_rsc_dat;
  output y_triosy_lz;
  input [7:0] x_rsc_dat;
  output x_triosy_lz;

  // Interconnect Declarations for Component Instantiations 
  fir_core fir_core_inst (
      .clk(clk),
      .rst(rst),
      .y_rsc_dat(y_rsc_dat),
      .y_triosy_lz(y_triosy_lz),
      .x_rsc_dat(x_rsc_dat),
      .x_triosy_lz(x_triosy_lz)
    );
endmodule
