module GF_INV_4(in, out);
  input [3:0] in;
  output [3:0] out;

  wire w_i3_i1;
  wire w_i2_i1;
  wire w_i2_i0;
  wire w_i3_i0;
  wire w_i3_i2;
  wire w_i2_i1_i0;
  wire w_i3_i1_i0;
  wire w_i3_i2_i0;
  wire w_i3_i2_i1;

  wire _xor0_w, _xor1_w, _xor2_w;
  wire _xor3_w, _xor4_w, _xor5_w;
  wire _xor6_w, _xor7_w, _xor8_w;
  wire _xor9_w, _xor10_w, _xor11_w;

  $_AND_ AND_0 ( .A(in[3]), .B(in[1]), .Y(w_i3_i1) );
  $_AND_ AND_1 ( .A(in[2]), .B(in[1]), .Y(w_i2_i1) );
  $_AND_ AND_2 ( .A(in[2]), .B(in[0]), .Y(w_i2_i0) );
  $_AND_ AND_3 ( .A(in[3]), .B(in[0]), .Y(w_i3_i0) );
  $_AND_ AND_4 ( .A(in[3]), .B(in[2]), .Y(w_i3_i2) );
  $_AND_ AND_5 ( .A(w_i2_i1), .B(in[0]), .Y(w_i2_i1_i0) );
  $_AND_ AND_6 ( .A(w_i3_i1), .B(in[0]), .Y(w_i3_i1_i0) );
  $_AND_ AND_7 ( .A(w_i3_i2), .B(in[0]), .Y(w_i3_i2_i0) );
  $_AND_ AND_8 ( .A(w_i3_i2), .B(in[1]), .Y(w_i3_i2_i1) );

  $_XOR_ XOR_OUT3_0 ( .A(in[1]), .B(in[0]), .Y(_xor0_w) );
  $_XOR_ XOR_OUT3_1 ( .A(_xor0_w), .B(w_i3_i1), .Y(_xor1_w) );
  $_XOR_ XOR_OUT3_2 ( .A(_xor1_w), .B(w_i2_i1), .Y(_xor2_w) );
  $_XOR_ XOR_OUT3_3 ( .A(_xor2_w), .B(w_i2_i1_i0), .Y(out[3]) );

  $_XOR_ XOR_OUT2_0 ( .A(in[0]), .B(w_i3_i1), .Y(_xor3_w) );
  $_XOR_ XOR_OUT2_1 ( .A(_xor3_w), .B(w_i2_i1), .Y(_xor4_w) );
  $_XOR_ XOR_OUT2_2 ( .A(_xor4_w), .B(w_i2_i0), .Y(_xor5_w) );
  $_XOR_ XOR_OUT2_3 ( .A(_xor5_w), .B(w_i3_i1_i0), .Y(out[2]) );

  $_XOR_ XOR_OUT1_0 ( .A(in[3]), .B(in[2]), .Y(_xor6_w) );
  $_XOR_ XOR_OUT1_1 ( .A(_xor6_w), .B(w_i3_i1), .Y(_xor7_w) );
  $_XOR_ XOR_OUT1_2 ( .A(_xor7_w), .B(w_i3_i0), .Y(_xor8_w) );
  $_XOR_ XOR_OUT1_3 ( .A(_xor8_w), .B(w_i3_i2_i0), .Y(out[1]) );

  $_XOR_ XOR_OUT0_0 ( .A(in[2]), .B(w_i3_i1), .Y(_xor9_w) );
  $_XOR_ XOR_OUT0_1 ( .A(_xor9_w), .B(w_i3_i0), .Y(_xor10_w) );
  $_XOR_ XOR_OUT0_2 ( .A(_xor10_w), .B(w_i2_i0), .Y(_xor11_w) );
  $_XOR_ XOR_OUT0_3 ( .A(_xor11_w), .B(w_i3_i2_i1), .Y(out[0]) );

endmodule
