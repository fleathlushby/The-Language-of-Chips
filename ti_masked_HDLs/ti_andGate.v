module ti_andGate (
    input  a_s0_in,
    input  a_s1_in,
    input  a_s2_in,
    input  b_s0_in,
    input  b_s1_in,
    input  b_s2_in,
    output out_s0,
    output out_s1,
    output out_s2
);

    // Drive internal share nets from the input ports so that the share
    // signals are driven by assign statements (tool required).
    wire a_s0; wire a_s1; wire a_s2;
    wire b_s0; wire b_s1; wire b_s2;

    assign a_s0 = a_s0_in;
    assign a_s1 = a_s1_in;
    assign a_s2 = a_s2_in;
    assign b_s0 = b_s0_in;
    assign b_s1 = b_s1_in;
    assign b_s2 = b_s2_in;

    // Partial products
    wire p00 = a_s0 & b_s0;
    wire p01 = a_s0 & b_s1;
    wire p02 = a_s0 & b_s2;
    wire p10 = a_s1 & b_s0;
    wire p11 = a_s1 & b_s1;
    wire p12 = a_s1 & b_s2;
    wire p20 = a_s2 & b_s0;
    wire p21 = a_s2 & b_s1;
    wire p22 = a_s2 & b_s2;

    // out_s0 combines a_s0/a_s1 with b_s0/b_s1 (omits a_s2 and b_s2)
    assign out_s0 = p00 ^ p10 ^ p01;

    // out_s1 combines a_s1/a_s2 with b_s1/b_s2 (omits a_s0 and b_s0)
    assign out_s1 = p11 ^ p21 ^ p12;

    // out_s2 combines a_s2/a_s0 with b_s2/b_s0 (omits a_s1 and b_s1)
    assign out_s2 = p22 ^ p20 ^ p02;

endmodule