module A_mult (
  in,
  out
);
  input [7:0] in;
  output [7:0] out;

  wire xor_out0_0, xor_out0_1, xor_out0_2;
  wire xor_out1_0, xor_out1_1, xor_out1_2;
  wire xor_out2_0, xor_out2_1, xor_out2_2;
  wire xor_out3_0, xor_out3_1, xor_out3_2;
  wire xor_out4_0, xor_out4_1, xor_out4_2;
  wire xor_out5_0, xor_out5_1, xor_out5_2;
  wire xor_out6_0, xor_out6_1, xor_out6_2;
  wire xor_out7_0, xor_out7_1, xor_out7_2;

  XOR2_X1 U0 (
    .A(in[7]),
    .B(in[6]),
    .Y(xor_out7_0)
  );
  XOR2_X1 U1 (
    .A(xor_out7_0),
    .B(in[5]),
    .Y(xor_out7_1)
  );
  XOR2_X1 U2 (
    .A(xor_out7_1),
    .B(in[4]),
    .Y(xor_out7_2)
  );
  XOR2_X1 U3 (
    .A(xor_out7_2),
    .B(in[3]),
    .Y(out[7])
  );
  XOR2_X1 U4 (
    .A(in[6]),
    .B(in[5]),
    .Y(xor_out6_0)
  );
  XOR2_X1 U5 (
    .A(xor_out6_0),
    .B(in[4]),
    .Y(xor_out6_1)
  );
  XOR2_X1 U6 (
    .A(xor_out6_1),
    .B(in[3]),
    .Y(xor_out6_2)
  );
  XOR2_X1 U7 (
    .A(xor_out6_2),
    .B(in[2]),
    .Y(out[6])
  );
  XOR2_X1 U8 (
    .A(in[5]),
    .B(in[4]),
    .Y(xor_out5_0)
  );
  XOR2_X1 U9 (
    .A(xor_out5_0),
    .B(in[3]),
    .Y(xor_out5_1)
  );
  XOR2_X1 U10 (
    .A(xor_out5_1),
    .B(in[2]),
    .Y(xor_out5_2)
  );
  XOR2_X1 U11 (
    .A(xor_out5_2),
    .B(in[1]),
    .Y(out[5])
  );
  XOR2_X1 U12 (
    .A(in[4]),
    .B(in[3]),
    .Y(xor_out4_0)
  );
  XOR2_X1 U13 (
    .A(xor_out4_0),
    .B(in[2]),
    .Y(xor_out4_1)
  );
  XOR2_X1 U14 (
    .A(xor_out4_1),
    .B(in[1]),
    .Y(xor_out4_2)
  );
  XOR2_X1 U15 (
    .A(xor_out4_2),
    .B(in[0]),
    .Y(out[4])
  );
  XOR2_X1 U16 (
    .A(in[7]),
    .B(in[3]),
    .Y(xor_out3_0)
  );
  XOR2_X1 U17 (
    .A(xor_out3_0),
    .B(in[2]),
    .Y(xor_out3_1)
  );
  XOR2_X1 U18 (
    .A(xor_out3_1),
    .B(in[1]),
    .Y(xor_out3_2)
  );
  XOR2_X1 U19 (
    .A(xor_out3_2),
    .B(in[0]),
    .Y(out[3])
  );
  XOR2_X1 U20 (
    .A(in[7]),
    .B(in[6]),
    .Y(xor_out2_0)
  );
  XOR2_X1 U21 (
    .A(xor_out2_0),
    .B(in[2]),
    .Y(xor_out2_1)
  );
  XOR2_X1 U22 (
    .A(xor_out2_1),
    .B(in[1]),
    .Y(xor_out2_2)
  );
  XOR2_X1 U23 (
    .A(xor_out2_2),
    .B(in[0]),
    .Y(out[2])
  );
  XOR2_X1 U24 (
    .A(in[7]),
    .B(in[6]),
    .Y(xor_out1_0)
  );
  XOR2_X1 U25 (
    .A(xor_out1_0),
    .B(in[5]),
    .Y(xor_out1_1)
  );
  XOR2_X1 U26 (
    .A(xor_out1_1),
    .B(in[1]),
    .Y(xor_out1_2)
  );
  XOR2_X1 U27 (
    .A(xor_out1_2),
    .B(in[0]),
    .Y(out[1])
  );
  XOR2_X1 U28 (
    .A(in[7]),
    .B(in[6]),
    .Y(xor_out0_0)
  );
  XOR2_X1 U29 (
    .A(xor_out0_0),
    .B(in[5]),
    .Y(xor_out0_1)
  );
  XOR2_X1 U30 (
    .A(xor_out0_1),
    .B(in[4]),
    .Y(xor_out0_2)
  );
  XOR2_X1 U31 (
    .A(xor_out0_2),
    .B(in[0]),
    .Y(out[0])
  );
endmodule
