/*
    Team Name: S2-T15
*/

module matrix_adder_2x2(
    input [2:0] a11, a12, a21, a22,  // Elements of matrix A (3-bit)
    input [2:0] b11, b12, b21, b22,  // Elements of matrix B (3-bit)
    output [3:0] c11, c12, c21, c22  // Elements of result matrix C (4-bit)
);

    // Addition operations
    assign c11 = a11 + b11;
    assign c12 = a12 + b12;
    assign c21 = a21 + b21;
    assign c22 = a22 + b22;

endmodule

module matrix_adder_2x2_gate_level(
    input [2:0] a11, a12, a21, a22,  // Elements of matrix A (3-bit)
    input [2:0] b11, b12, b21, b22,  // Elements of matrix B (3-bit)
    output [3:0] c11, c12, c21, c22  // Elements of result matrix C (4-bit)
);

    wire carry11_1, carry11_2, carry11_3;  // Carry wires for c11 addition
    wire carry12_1, carry12_2, carry12_3;  // Carry wires for c12 addition
    wire carry21_1, carry21_2, carry21_3;  // Carry wires for c21 addition
    wire carry22_1, carry22_2, carry22_3;  // Carry wires for c22 addition

    // Full Adder for c11 = a11 + b11
    full_adder FA11_0 (.a(a11[0]), .b(b11[0]), .cin(1'b0),   .sum(c11[0]), .cout(carry11_1));
    full_adder FA11_1 (.a(a11[1]), .b(b11[1]), .cin(carry11_1), .sum(c11[1]), .cout(carry11_2));
    full_adder FA11_2 (.a(a11[2]), .b(b11[2]), .cin(carry11_2), .sum(c11[2]), .cout(carry11_3));
    assign c11[3] = carry11_3;  // Final carry goes to MSB of c11

    // Full Adder for c12 = a12 + b12
    full_adder FA12_0 (.a(a12[0]), .b(b12[0]), .cin(1'b0),   .sum(c12[0]), .cout(carry12_1));
    full_adder FA12_1 (.a(a12[1]), .b(b12[1]), .cin(carry12_1), .sum(c12[1]), .cout(carry12_2));
    full_adder FA12_2 (.a(a12[2]), .b(b12[2]), .cin(carry12_2), .sum(c12[2]), .cout(carry12_3));
    assign c12[3] = carry12_3;  // Final carry goes to MSB of c12

    // Full Adder for c21 = a21 + b21
    full_adder FA21_0 (.a(a21[0]), .b(b21[0]), .cin(1'b0),   .sum(c21[0]), .cout(carry21_1));
    full_adder FA21_1 (.a(a21[1]), .b(b21[1]), .cin(carry21_1), .sum(c21[1]), .cout(carry21_2));
    full_adder FA21_2 (.a(a21[2]), .b(b21[2]), .cin(carry21_2), .sum(c21[2]), .cout(carry21_3));
    assign c21[3] = carry21_3;  // Final carry goes to MSB of c21

    // Full Adder for c22 = a22 + b22
    full_adder FA22_0 (.a(a22[0]), .b(b22[0]), .cin(1'b0),   .sum(c22[0]), .cout(carry22_1));
    full_adder FA22_1 (.a(a22[1]), .b(b22[1]), .cin(carry22_1), .sum(c22[1]), .cout(carry22_2));
    full_adder FA22_2 (.a(a22[2]), .b(b22[2]), .cin(carry22_2), .sum(c22[2]), .cout(carry22_3));
    assign c22[3] = carry22_3;  // Final carry goes to MSB of c22

endmodule

// Full Adder module definition
module full_adder (
    input a, b, cin,          // Inputs: two bits and carry-in
    output sum, cout          // Outputs: sum and carry-out
);
    assign sum  = a ^ b ^ cin;  // Sum is XOR of inputs
    assign cout = (a & b) | (cin & (a ^ b));  // Carry-out
endmodule
