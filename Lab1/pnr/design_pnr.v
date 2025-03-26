module counter_gen (clk,
    rstn,
    out);
 input clk;
 input rstn;
 output [7:0] out;

 wire _08_;
 wire _09_;
 wire _10_;
 wire _11_;
 wire _12_;
 wire _13_;
 wire _14_;
 wire _15_;
 wire _16_;
 wire _17_;
 wire _18_;
 wire _19_;
 wire _20_;
 wire _21_;
 wire clknet_0_clk;
 wire clknet_1_0__leaf_clk;
 wire clknet_1_1__leaf_clk;

 sky130_fd_sc_hd__clkinv_1 _32_ (.A(out[0]),
    .Y(_08_));
 sky130_fd_sc_hd__nand2_1 _33_ (.A(out[1]),
    .B(out[0]),
    .Y(_16_));
 sky130_fd_sc_hd__xor2_1 _34_ (.A(out[1]),
    .B(out[0]),
    .X(_09_));
 sky130_fd_sc_hd__xnor2_1 _35_ (.A(out[2]),
    .B(_16_),
    .Y(_10_));
 sky130_fd_sc_hd__and4_1 _36_ (.A(out[1]),
    .B(out[0]),
    .C(out[2]),
    .D(out[3]),
    .X(_17_));
 sky130_fd_sc_hd__a31oi_1 _37_ (.A1(out[1]),
    .A2(out[0]),
    .A3(out[2]),
    .B1(out[3]),
    .Y(_18_));
 sky130_fd_sc_hd__nor2_1 _38_ (.A(_17_),
    .B(_18_),
    .Y(_11_));
 sky130_fd_sc_hd__nand2_1 _39_ (.A(out[4]),
    .B(_17_),
    .Y(_19_));
 sky130_fd_sc_hd__xor2_1 _40_ (.A(out[4]),
    .B(_17_),
    .X(_12_));
 sky130_fd_sc_hd__xnor2_1 _41_ (.A(out[5]),
    .B(_19_),
    .Y(_13_));
 sky130_fd_sc_hd__nand4_1 _42_ (.A(out[4]),
    .B(out[5]),
    .C(out[6]),
    .D(_17_),
    .Y(_20_));
 sky130_fd_sc_hd__a31oi_1 _43_ (.A1(out[4]),
    .A2(out[5]),
    .A3(_17_),
    .B1(out[6]),
    .Y(_21_));
 sky130_fd_sc_hd__lpflow_isobufsrc_1 _44_ (.A(_20_),
    .SLEEP(_21_),
    .X(_14_));
 sky130_fd_sc_hd__xnor2_1 _45_ (.A(out[7]),
    .B(_20_),
    .Y(_15_));
 sky130_fd_sc_hd__dfrtp_1 _46_ (.CLK(clknet_1_0__leaf_clk),
    .D(_08_),
    .RESET_B(rstn),
    .Q(out[0]));
 sky130_fd_sc_hd__dfrtp_1 _47_ (.CLK(clknet_1_0__leaf_clk),
    .D(_09_),
    .RESET_B(rstn),
    .Q(out[1]));
 sky130_fd_sc_hd__dfrtp_1 _48_ (.CLK(clknet_1_0__leaf_clk),
    .D(_10_),
    .RESET_B(rstn),
    .Q(out[2]));
 sky130_fd_sc_hd__dfrtp_1 _49_ (.CLK(clknet_1_0__leaf_clk),
    .D(_11_),
    .RESET_B(rstn),
    .Q(out[3]));
 sky130_fd_sc_hd__dfrtp_1 _50_ (.CLK(clknet_1_1__leaf_clk),
    .D(_12_),
    .RESET_B(rstn),
    .Q(out[4]));
 sky130_fd_sc_hd__dfrtp_1 _51_ (.CLK(clknet_1_1__leaf_clk),
    .D(_13_),
    .RESET_B(rstn),
    .Q(out[5]));
 sky130_fd_sc_hd__dfrtp_1 _52_ (.CLK(clknet_1_1__leaf_clk),
    .D(_14_),
    .RESET_B(rstn),
    .Q(out[6]));
 sky130_fd_sc_hd__dfrtp_1 _53_ (.CLK(clknet_1_1__leaf_clk),
    .D(_15_),
    .RESET_B(rstn),
    .Q(out[7]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_0 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_1 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_2 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_3 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_4 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_5 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_6 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_7 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_8 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_9 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_10 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_11 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_12 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_13 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_14 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_15 ();
 sky130_fd_sc_hd__clkbuf_4 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
 sky130_fd_sc_hd__clkbuf_4 clkbuf_1_0__f_clk (.A(clknet_0_clk),
    .X(clknet_1_0__leaf_clk));
 sky130_fd_sc_hd__clkbuf_4 clkbuf_1_1__f_clk (.A(clknet_0_clk),
    .X(clknet_1_1__leaf_clk));
 sky130_fd_sc_hd__fill_8 FILLER_0_0 ();
 sky130_fd_sc_hd__fill_8 FILLER_0_8 ();
 sky130_fd_sc_hd__fill_8 FILLER_0_16 ();
 sky130_fd_sc_hd__fill_4 FILLER_0_24 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_28 ();
 sky130_fd_sc_hd__fill_8 FILLER_0_31 ();
 sky130_fd_sc_hd__fill_8 FILLER_0_39 ();
 sky130_fd_sc_hd__fill_8 FILLER_0_47 ();
 sky130_fd_sc_hd__fill_4 FILLER_0_55 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_59 ();
 sky130_fd_sc_hd__fill_8 FILLER_0_61 ();
 sky130_fd_sc_hd__fill_8 FILLER_0_69 ();
 sky130_fd_sc_hd__fill_8 FILLER_0_77 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_85 ();
 sky130_fd_sc_hd__fill_8 FILLER_1_0 ();
 sky130_fd_sc_hd__fill_8 FILLER_1_8 ();
 sky130_fd_sc_hd__fill_8 FILLER_1_16 ();
 sky130_fd_sc_hd__fill_8 FILLER_1_24 ();
 sky130_fd_sc_hd__fill_8 FILLER_1_32 ();
 sky130_fd_sc_hd__fill_8 FILLER_1_40 ();
 sky130_fd_sc_hd__fill_8 FILLER_1_48 ();
 sky130_fd_sc_hd__fill_4 FILLER_1_56 ();
 sky130_fd_sc_hd__fill_8 FILLER_1_61 ();
 sky130_fd_sc_hd__fill_8 FILLER_1_69 ();
 sky130_fd_sc_hd__fill_8 FILLER_1_77 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_85 ();
 sky130_fd_sc_hd__fill_8 FILLER_2_0 ();
 sky130_fd_sc_hd__fill_8 FILLER_2_8 ();
 sky130_fd_sc_hd__fill_8 FILLER_2_16 ();
 sky130_fd_sc_hd__fill_4 FILLER_2_24 ();
 sky130_fd_sc_hd__fill_2 FILLER_2_28 ();
 sky130_fd_sc_hd__fill_8 FILLER_2_31 ();
 sky130_fd_sc_hd__fill_8 FILLER_2_39 ();
 sky130_fd_sc_hd__fill_8 FILLER_2_47 ();
 sky130_fd_sc_hd__fill_8 FILLER_2_55 ();
 sky130_fd_sc_hd__fill_8 FILLER_2_63 ();
 sky130_fd_sc_hd__fill_8 FILLER_2_71 ();
 sky130_fd_sc_hd__fill_4 FILLER_2_79 ();
 sky130_fd_sc_hd__fill_2 FILLER_2_83 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_85 ();
 sky130_fd_sc_hd__fill_8 FILLER_3_0 ();
 sky130_fd_sc_hd__fill_8 FILLER_3_8 ();
 sky130_fd_sc_hd__fill_8 FILLER_3_16 ();
 sky130_fd_sc_hd__fill_8 FILLER_3_24 ();
 sky130_fd_sc_hd__fill_8 FILLER_3_32 ();
 sky130_fd_sc_hd__fill_8 FILLER_3_40 ();
 sky130_fd_sc_hd__fill_8 FILLER_3_48 ();
 sky130_fd_sc_hd__fill_4 FILLER_3_56 ();
 sky130_fd_sc_hd__fill_8 FILLER_3_61 ();
 sky130_fd_sc_hd__fill_8 FILLER_3_69 ();
 sky130_fd_sc_hd__fill_8 FILLER_3_77 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_85 ();
 sky130_fd_sc_hd__fill_8 FILLER_4_0 ();
 sky130_fd_sc_hd__fill_8 FILLER_4_8 ();
 sky130_fd_sc_hd__fill_8 FILLER_4_16 ();
 sky130_fd_sc_hd__fill_4 FILLER_4_24 ();
 sky130_fd_sc_hd__fill_2 FILLER_4_28 ();
 sky130_fd_sc_hd__fill_8 FILLER_4_31 ();
 sky130_fd_sc_hd__fill_8 FILLER_4_39 ();
 sky130_fd_sc_hd__fill_8 FILLER_4_47 ();
 sky130_fd_sc_hd__fill_8 FILLER_4_55 ();
 sky130_fd_sc_hd__fill_8 FILLER_4_63 ();
 sky130_fd_sc_hd__fill_8 FILLER_4_71 ();
 sky130_fd_sc_hd__fill_4 FILLER_4_79 ();
 sky130_fd_sc_hd__fill_2 FILLER_4_83 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_85 ();
 sky130_fd_sc_hd__fill_2 FILLER_5_0 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_2 ();
 sky130_fd_sc_hd__fill_8 FILLER_5_26 ();
 sky130_fd_sc_hd__fill_8 FILLER_5_34 ();
 sky130_fd_sc_hd__fill_8 FILLER_5_42 ();
 sky130_fd_sc_hd__fill_8 FILLER_5_50 ();
 sky130_fd_sc_hd__fill_2 FILLER_5_58 ();
 sky130_fd_sc_hd__fill_4 FILLER_5_81 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_85 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_0 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_29 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_31 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_33 ();
 sky130_fd_sc_hd__fill_8 FILLER_6_40 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_48 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_50 ();
 sky130_fd_sc_hd__fill_2 FILLER_7_0 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_15 ();
 sky130_fd_sc_hd__fill_2 FILLER_7_21 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_23 ();
 sky130_fd_sc_hd__fill_8 FILLER_7_44 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_52 ();
 sky130_fd_sc_hd__fill_2 FILLER_8_0 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_5 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_29 ();
 sky130_fd_sc_hd__fill_8 FILLER_8_31 ();
 sky130_fd_sc_hd__fill_8 FILLER_8_39 ();
 sky130_fd_sc_hd__fill_8 FILLER_8_47 ();
 sky130_fd_sc_hd__fill_4 FILLER_8_55 ();
 sky130_fd_sc_hd__fill_2 FILLER_8_59 ();
 sky130_fd_sc_hd__fill_8 FILLER_9_0 ();
 sky130_fd_sc_hd__fill_4 FILLER_9_8 ();
 sky130_fd_sc_hd__fill_8 FILLER_9_19 ();
 sky130_fd_sc_hd__fill_8 FILLER_9_27 ();
 sky130_fd_sc_hd__fill_8 FILLER_9_35 ();
 sky130_fd_sc_hd__fill_8 FILLER_9_43 ();
 sky130_fd_sc_hd__fill_8 FILLER_9_51 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_59 ();
 sky130_fd_sc_hd__fill_2 FILLER_9_61 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_63 ();
 sky130_fd_sc_hd__fill_2 FILLER_9_70 ();
 sky130_fd_sc_hd__fill_4 FILLER_9_79 ();
 sky130_fd_sc_hd__fill_2 FILLER_9_83 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_85 ();
 sky130_fd_sc_hd__fill_8 FILLER_10_0 ();
 sky130_fd_sc_hd__fill_8 FILLER_10_8 ();
 sky130_fd_sc_hd__fill_8 FILLER_10_16 ();
 sky130_fd_sc_hd__fill_4 FILLER_10_24 ();
 sky130_fd_sc_hd__fill_2 FILLER_10_28 ();
 sky130_fd_sc_hd__fill_8 FILLER_10_31 ();
 sky130_fd_sc_hd__fill_8 FILLER_10_39 ();
 sky130_fd_sc_hd__fill_8 FILLER_10_47 ();
 sky130_fd_sc_hd__fill_8 FILLER_10_55 ();
 sky130_fd_sc_hd__fill_8 FILLER_10_63 ();
 sky130_fd_sc_hd__fill_8 FILLER_10_71 ();
 sky130_fd_sc_hd__fill_4 FILLER_10_79 ();
 sky130_fd_sc_hd__fill_2 FILLER_10_83 ();
 sky130_fd_sc_hd__fill_1 FILLER_10_85 ();
 sky130_fd_sc_hd__fill_8 FILLER_11_0 ();
 sky130_fd_sc_hd__fill_8 FILLER_11_8 ();
 sky130_fd_sc_hd__fill_8 FILLER_11_16 ();
 sky130_fd_sc_hd__fill_8 FILLER_11_24 ();
 sky130_fd_sc_hd__fill_8 FILLER_11_32 ();
 sky130_fd_sc_hd__fill_8 FILLER_11_40 ();
 sky130_fd_sc_hd__fill_8 FILLER_11_48 ();
 sky130_fd_sc_hd__fill_4 FILLER_11_56 ();
 sky130_fd_sc_hd__fill_8 FILLER_11_61 ();
 sky130_fd_sc_hd__fill_8 FILLER_11_69 ();
 sky130_fd_sc_hd__fill_8 FILLER_11_77 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_85 ();
 sky130_fd_sc_hd__fill_8 FILLER_12_0 ();
 sky130_fd_sc_hd__fill_8 FILLER_12_8 ();
 sky130_fd_sc_hd__fill_8 FILLER_12_16 ();
 sky130_fd_sc_hd__fill_4 FILLER_12_24 ();
 sky130_fd_sc_hd__fill_2 FILLER_12_28 ();
 sky130_fd_sc_hd__fill_8 FILLER_12_31 ();
 sky130_fd_sc_hd__fill_8 FILLER_12_39 ();
 sky130_fd_sc_hd__fill_8 FILLER_12_47 ();
 sky130_fd_sc_hd__fill_8 FILLER_12_55 ();
 sky130_fd_sc_hd__fill_8 FILLER_12_63 ();
 sky130_fd_sc_hd__fill_8 FILLER_12_71 ();
 sky130_fd_sc_hd__fill_4 FILLER_12_79 ();
 sky130_fd_sc_hd__fill_2 FILLER_12_83 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_85 ();
 sky130_fd_sc_hd__fill_8 FILLER_13_0 ();
 sky130_fd_sc_hd__fill_8 FILLER_13_8 ();
 sky130_fd_sc_hd__fill_8 FILLER_13_16 ();
 sky130_fd_sc_hd__fill_4 FILLER_13_24 ();
 sky130_fd_sc_hd__fill_2 FILLER_13_28 ();
 sky130_fd_sc_hd__fill_8 FILLER_13_31 ();
 sky130_fd_sc_hd__fill_8 FILLER_13_39 ();
 sky130_fd_sc_hd__fill_8 FILLER_13_47 ();
 sky130_fd_sc_hd__fill_4 FILLER_13_55 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_59 ();
 sky130_fd_sc_hd__fill_8 FILLER_13_61 ();
 sky130_fd_sc_hd__fill_8 FILLER_13_69 ();
 sky130_fd_sc_hd__fill_8 FILLER_13_77 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_85 ();
endmodule
