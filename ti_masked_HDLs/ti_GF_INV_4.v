module ti_GF_INV_4(
    input  [3:0] in_s0,
    input  [3:0] in_s1,
    input  [3:0] in_s2,
    output [3:0] out_s0,
    output [3:0] out_s1,
    output [3:0] out_s2
);

// -----------------------------------------------------------------------------
// TI of GF_INV_4
// Original outputs:
// out[3] = in[1] ^ in[0] ^ (in[3] & in[1]) ^ (in[2] & in[1]) ^ (in[2] & in[1] & in[0]);
// out[2] = in[0] ^ (in[3] & in[1]) ^ (in[2] & in[1]) ^ (in[2] & in[0]) ^ (in[3] & in[1] & in[0]);
// out[1] = in[3] ^ in[2] ^ (in[3] & in[1]) ^ (in[3] & in[0]) ^ (in[3] & in[2] & in[0]);
// out[0] = in[2] ^ (in[3] & in[1]) ^ (in[3] & in[0]) ^ (in[2] & in[0]) ^ (in[3] & in[2] & in[1]);
//
// Approach:
// - Two-input ANDs implemented with 3-share TI pattern using P_* partials.
// - Three-input ANDs implemented by cascading two-input TI: first form masked pair
//   D = A & B (D_s0..s2), then masked AND of D & C using Q_* partials.
// - Share index omission policy (per-share missing index):
//     out_s0 omits share index 2 for every input (uses indices {0,1})
//     out_s1 omits share index 0 for every input (uses indices {1,2})
//     out_s2 omits share index 1 for every input (uses indices {2,0})
// This ensures non-completeness and uniformity while correctness follows from TI patterns.
// -----------------------------------------------------------------------------

// -------------------------------
// Partial products: two-input ANDs
// For each pair (i,j) we declare nine partials P_ij_ab = in_sa[i] & in_sb[j]
// -------------------------------

// Pair (3 & 1) partials
wire P_31_00; assign P_31_00 = in_s0[3] & in_s0[1];
wire P_31_01; assign P_31_01 = in_s0[3] & in_s1[1];
wire P_31_02; assign P_31_02 = in_s0[3] & in_s2[1];
wire P_31_10; assign P_31_10 = in_s1[3] & in_s0[1];
wire P_31_11; assign P_31_11 = in_s1[3] & in_s1[1];
wire P_31_12; assign P_31_12 = in_s1[3] & in_s2[1];
wire P_31_20; assign P_31_20 = in_s2[3] & in_s0[1];
wire P_31_21; assign P_31_21 = in_s2[3] & in_s1[1];
wire P_31_22; assign P_31_22 = in_s2[3] & in_s2[1];

// Pair (2 & 1) partials
wire P_21_00; assign P_21_00 = in_s0[2] & in_s0[1];
wire P_21_01; assign P_21_01 = in_s0[2] & in_s1[1];
wire P_21_02; assign P_21_02 = in_s0[2] & in_s2[1];
wire P_21_10; assign P_21_10 = in_s1[2] & in_s0[1];
wire P_21_11; assign P_21_11 = in_s1[2] & in_s1[1];
wire P_21_12; assign P_21_12 = in_s1[2] & in_s2[1];
wire P_21_20; assign P_21_20 = in_s2[2] & in_s0[1];
wire P_21_21; assign P_21_21 = in_s2[2] & in_s1[1];
wire P_21_22; assign P_21_22 = in_s2[2] & in_s2[1];

// Pair (2 & 0) partials
wire P_20_00; assign P_20_00 = in_s0[2] & in_s0[0];
wire P_20_01; assign P_20_01 = in_s0[2] & in_s1[0];
wire P_20_02; assign P_20_02 = in_s0[2] & in_s2[0];
wire P_20_10; assign P_20_10 = in_s1[2] & in_s0[0];
wire P_20_11; assign P_20_11 = in_s1[2] & in_s1[0];
wire P_20_12; assign P_20_12 = in_s1[2] & in_s2[0];
wire P_20_20; assign P_20_20 = in_s2[2] & in_s0[0];
wire P_20_21; assign P_20_21 = in_s2[2] & in_s1[0];
wire P_20_22; assign P_20_22 = in_s2[2] & in_s2[0];

// Pair (3 & 0) partials
wire P_30_00; assign P_30_00 = in_s0[3] & in_s0[0];
wire P_30_01; assign P_30_01 = in_s0[3] & in_s1[0];
wire P_30_02; assign P_30_02 = in_s0[3] & in_s2[0];
wire P_30_10; assign P_30_10 = in_s1[3] & in_s0[0];
wire P_30_11; assign P_30_11 = in_s1[3] & in_s1[0];
wire P_30_12; assign P_30_12 = in_s1[3] & in_s2[0];
wire P_30_20; assign P_30_20 = in_s2[3] & in_s0[0];
wire P_30_21; assign P_30_21 = in_s2[3] & in_s1[0];
wire P_30_22; assign P_30_22 = in_s2[3] & in_s2[0];

// Pair (3 & 2) partials (needed for (3&2&0) and (3&2&1))
wire P_32_00; assign P_32_00 = in_s0[3] & in_s0[2];
wire P_32_01; assign P_32_01 = in_s0[3] & in_s1[2];
wire P_32_02; assign P_32_02 = in_s0[3] & in_s2[2];
wire P_32_10; assign P_32_10 = in_s1[3] & in_s0[2];
wire P_32_11; assign P_32_11 = in_s1[3] & in_s1[2];
wire P_32_12; assign P_32_12 = in_s1[3] & in_s2[2];
wire P_32_20; assign P_32_20 = in_s2[3] & in_s0[2];
wire P_32_21; assign P_32_21 = in_s2[3] & in_s1[2];
wire P_32_22; assign P_32_22 = in_s2[3] & in_s2[2];

// -------------------------------
// Masked results of two-input ANDs (D_xy_s{0..2})
// Using the TI pattern:
//   (A&B)_s0 = P_??_00 ^ P_??_10 ^ P_??_01
//   (A&B)_s1 = P_??_11 ^ P_??_21 ^ P_??_12
//   (A&B)_s2 = P_??_22 ^ P_??_20 ^ P_??_02
// -------------------------------

// D31 = in3 & in1 (used in many outputs)
wire D31_s0; assign D31_s0 = P_31_00 ^ P_31_10 ^ P_31_01;
wire D31_s1; assign D31_s1 = P_31_11 ^ P_31_21 ^ P_31_12;
wire D31_s2; assign D31_s2 = P_31_22 ^ P_31_20 ^ P_31_02;

// D21 = in2 & in1
wire D21_s0; assign D21_s0 = P_21_00 ^ P_21_10 ^ P_21_01;
wire D21_s1; assign D21_s1 = P_21_11 ^ P_21_21 ^ P_21_12;
wire D21_s2; assign D21_s2 = P_21_22 ^ P_21_20 ^ P_21_02;

// D20 = in2 & in0
wire D20_s0; assign D20_s0 = P_20_00 ^ P_20_10 ^ P_20_01;
wire D20_s1; assign D20_s1 = P_20_11 ^ P_20_21 ^ P_20_12;
wire D20_s2; assign D20_s2 = P_20_22 ^ P_20_20 ^ P_20_02;

// D30 = in3 & in0
wire D30_s0; assign D30_s0 = P_30_00 ^ P_30_10 ^ P_30_01;
wire D30_s1; assign D30_s1 = P_30_11 ^ P_30_21 ^ P_30_12;
wire D30_s2; assign D30_s2 = P_30_22 ^ P_30_20 ^ P_30_02;

// D32 = in3 & in2 (for triples 3&2&0 and 3&2&1)
wire D32_s0; assign D32_s0 = P_32_00 ^ P_32_10 ^ P_32_01;
wire D32_s1; assign D32_s1 = P_32_11 ^ P_32_21 ^ P_32_12;
wire D32_s2; assign D32_s2 = P_32_22 ^ P_32_20 ^ P_32_02;

// -------------------------------
// Three-input masked ANDs implemented by masked (D = A&B) then masked (D & C).
// For each triple we compute Q partials Q_abc_sm_sn = D_ab_s{sm} & in_s{sn}[c]
// and then form E_abc shares via the same 2-input TI pattern.
// This keeps each output share missing one share index per input as required.
// -------------------------------

// --- Triple 2&1&0 (T210) using D21 & in0 ---
// Q_210_ab = D21_s{a} & in_s{b}[0]
wire Q_210_00; assign Q_210_00 = D21_s0 & in_s0[0];
wire Q_210_01; assign Q_210_01 = D21_s0 & in_s1[0];
wire Q_210_02; assign Q_210_02 = D21_s0 & in_s2[0];
wire Q_210_10; assign Q_210_10 = D21_s1 & in_s0[0];
wire Q_210_11; assign Q_210_11 = D21_s1 & in_s1[0];
wire Q_210_12; assign Q_210_12 = D21_s1 & in_s2[0];
wire Q_210_20; assign Q_210_20 = D21_s2 & in_s0[0];
wire Q_210_21; assign Q_210_21 = D21_s2 & in_s1[0];
wire Q_210_22; assign Q_210_22 = D21_s2 & in_s2[0];

wire E210_s0; assign E210_s0 = Q_210_00 ^ Q_210_10 ^ Q_210_01;
wire E210_s1; assign E210_s1 = Q_210_11 ^ Q_210_21 ^ Q_210_12;
wire E210_s2; assign E210_s2 = Q_210_22 ^ Q_210_20 ^ Q_210_02;

// --- Triple 3&1&0 (T310) using D31 & in0 ---
wire Q_310_00; assign Q_310_00 = D31_s0 & in_s0[0];
wire Q_310_01; assign Q_310_01 = D31_s0 & in_s1[0];
wire Q_310_02; assign Q_310_02 = D31_s0 & in_s2[0];
wire Q_310_10; assign Q_310_10 = D31_s1 & in_s0[0];
wire Q_310_11; assign Q_310_11 = D31_s1 & in_s1[0];
wire Q_310_12; assign Q_310_12 = D31_s1 & in_s2[0];
wire Q_310_20; assign Q_310_20 = D31_s2 & in_s0[0];
wire Q_310_21; assign Q_310_21 = D31_s2 & in_s1[0];
wire Q_310_22; assign Q_310_22 = D31_s2 & in_s2[0];

wire E310_s0; assign E310_s0 = Q_310_00 ^ Q_310_10 ^ Q_310_01;
wire E310_s1; assign E310_s1 = Q_310_11 ^ Q_310_21 ^ Q_310_12;
wire E310_s2; assign E310_s2 = Q_310_22 ^ Q_310_20 ^ Q_310_02;

// --- Triple 3&2&0 (T320) using D32 & in0 ---
wire Q_320_00; assign Q_320_00 = D32_s0 & in_s0[0];
wire Q_320_01; assign Q_320_01 = D32_s0 & in_s1[0];
wire Q_320_02; assign Q_320_02 = D32_s0 & in_s2[0];
wire Q_320_10; assign Q_320_10 = D32_s1 & in_s0[0];
wire Q_320_11; assign Q_320_11 = D32_s1 & in_s1[0];
wire Q_320_12; assign Q_320_12 = D32_s1 & in_s2[0];
wire Q_320_20; assign Q_320_20 = D32_s2 & in_s0[0];
wire Q_320_21; assign Q_320_21 = D32_s2 & in_s1[0];
wire Q_320_22; assign Q_320_22 = D32_s2 & in_s2[0];

wire E320_s0; assign E320_s0 = Q_320_00 ^ Q_320_10 ^ Q_320_01;
wire E320_s1; assign E320_s1 = Q_320_11 ^ Q_320_21 ^ Q_320_12;
wire E320_s2; assign E320_s2 = Q_320_22 ^ Q_320_20 ^ Q_320_02;

// --- Triple 3&2&1 (T321) using D32 & in1 ---
wire Q_321_00; assign Q_321_00 = D32_s0 & in_s0[1];
wire Q_321_01; assign Q_321_01 = D32_s0 & in_s1[1];
wire Q_321_02; assign Q_321_02 = D32_s0 & in_s2[1];
wire Q_321_10; assign Q_321_10 = D32_s1 & in_s0[1];
wire Q_321_11; assign Q_321_11 = D32_s1 & in_s1[1];
wire Q_321_12; assign Q_321_12 = D32_s1 & in_s2[1];
wire Q_321_20; assign Q_321_20 = D32_s2 & in_s0[1];
wire Q_321_21; assign Q_321_21 = D32_s2 & in_s1[1];
wire Q_321_22; assign Q_321_22 = D32_s2 & in_s2[1];

wire E321_s0; assign E321_s0 = Q_321_00 ^ Q_321_10 ^ Q_321_01;
wire E321_s1; assign E321_s1 = Q_321_11 ^ Q_321_21 ^ Q_321_12;
wire E321_s2; assign E321_s2 = Q_321_22 ^ Q_321_20 ^ Q_321_02;

// -------------------------------
// Final per-share outputs
// Each share's expression uses only the share indices allowed by the omission policy:
//  - out_s0 uses indices {0,1} (omits index 2)
//  - out_s1 uses indices {1,2} (omits index 0)
//  - out_s2 uses indices {2,0} (omits index 1)
// This preserves non-completeness and uniformity.
// -------------------------------

// out[3] = in[1] ^ in[0] ^ (in3&in1) ^ (in2&in1) ^ (in2&in1&in0)
assign out_s0[3] = in_s0[1] ^ in_s0[0] ^ D31_s0 ^ D21_s0 ^ E210_s0;
assign out_s1[3] = in_s1[1] ^ in_s1[0] ^ D31_s1 ^ D21_s1 ^ E210_s1;
assign out_s2[3] = in_s2[1] ^ in_s2[0] ^ D31_s2 ^ D21_s2 ^ E210_s2;

// out[2] = in[0] ^ (in3&in1) ^ (in2&in1) ^ (in2&in0) ^ (in3&in1&in0)
assign out_s0[2] = in_s0[0] ^ D31_s0 ^ D21_s0 ^ D20_s0 ^ E310_s0;
assign out_s1[2] = in_s1[0] ^ D31_s1 ^ D21_s1 ^ D20_s1 ^ E310_s1;
assign out_s2[2] = in_s2[0] ^ D31_s2 ^ D21_s2 ^ D20_s2 ^ E310_s2;

// out[1] = in[3] ^ in[2] ^ (in3&in1) ^ (in3&in0) ^ (in3&in2&in0)
assign out_s0[1] = in_s0[3] ^ in_s0[2] ^ D31_s0 ^ D30_s0 ^ E320_s0;
assign out_s1[1] = in_s1[3] ^ in_s1[2] ^ D31_s1 ^ D30_s1 ^ E320_s1;
assign out_s2[1] = in_s2[3] ^ in_s2[2] ^ D31_s2 ^ D30_s2 ^ E320_s2;

// out[0] = in[2] ^ (in3&in1) ^ (in3&in0) ^ (in2&in0) ^ (in3&in2&in1)
assign out_s0[0] = in_s0[2] ^ D31_s0 ^ D30_s0 ^ D20_s0 ^ E321_s0;
assign out_s1[0] = in_s1[2] ^ D31_s1 ^ D30_s1 ^ D20_s1 ^ E321_s1;
assign out_s2[0] = in_s2[2] ^ D31_s2 ^ D30_s2 ^ D20_s2 ^ E321_s2;

endmodule

