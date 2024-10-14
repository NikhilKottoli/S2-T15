/*
    Team Name: S2-T15
*/

module matrix_subtractor_2x2(
    input [2:0] a11, a12, a21, a22,  // Elements of matrix A (3-bit)
    input [2:0] b11, b12, b21, b22,  // Elements of matrix B (3-bit)
    output [3:0] c11, c12, c21, c22  // Elements of result matrix C (4-bit)
);

    // Subtraction operations
    assign c11 = a11 - b11;
    assign c12 = a12 - b12;
    assign c21 = a21 - b21;
    assign c22 = a22 - b22;

endmodule



module matrix_subtractor_2x2_gate_level(
    input [2:0] a11, a12, a21, a22,  // Elements of matrix A (3-bit)
    input [2:0] b11, b12, b21, b22,  // Elements of matrix B (3-bit)
    output [3:0] c11, c12, c21, c22  // Elements of result matrix C (4-bit)
);

    wire borrow11_1, borrow11_2, borrow11_3;  // Borrow wires for c11 subtraction
    wire borrow12_1, borrow12_2, borrow12_3;  // Borrow wires for c12 subtraction
    wire borrow21_1, borrow21_2, borrow21_3;  // Borrow wires for c21 subtraction
    wire borrow22_1, borrow22_2, borrow22_3;  // Borrow wires for c22 subtraction

    // Full Subtractor for c11 = a11 - b11
    full_subtractor FS11_0 (.a(a11[0]), .b(b11[0]), .bin(1'b0), .diff(c11[0]), .bout(borrow11_1));
    full_subtractor FS11_1 (.a(a11[1]), .b(b11[1]), .bin(borrow11_1), .diff(c11[1]), .bout(borrow11_2));
    full_subtractor FS11_2 (.a(a11[2]), .b(b11[2]), .bin(borrow11_2), .diff(c11[2]), .bout(borrow11_3));
    assign c11[3] = borrow11_3;  // Final borrow goes to MSB of c11

    // Full Subtractor for c12 = a12 - b12
    full_subtractor FS12_0 (.a(a12[0]), .b(b12[0]), .bin(1'b0), .diff(c12[0]), .bout(borrow12_1));
    full_subtractor FS12_1 (.a(a12[1]), .b(b12[1]), .bin(borrow12_1), .diff(c12[1]), .bout(borrow12_2));
    full_subtractor FS12_2 (.a(a12[2]), .b(b12[2]), .bin(borrow12_2), .diff(c12[2]), .bout(borrow12_3));
    assign c12[3] = borrow12_3;  // Final borrow goes to MSB of c12

    // Full Subtractor for c21 = a21 - b21
    full_subtractor FS21_0 (.a(a21[0]), .b(b21[0]), .bin(1'b0), .diff(c21[0]), .bout(borrow21_1));
    full_subtractor FS21_1 (.a(a21[1]), .b(b21[1]), .bin(borrow21_1), .diff(c21[1]), .bout(borrow21_2));
    full_subtractor FS21_2 (.a(a21[2]), .b(b21[2]), .bin(borrow21_2), .diff(c21[2]), .bout(borrow21_3));
    assign c21[3] = borrow21_3;  // Final borrow goes to MSB of c21

    // Full Subtractor for c22 = a22 - b22
    full_subtractor FS22_0 (.a(a22[0]), .b(b22[0]), .bin(1'b0), .diff(c22[0]), .bout(borrow22_1));
    full_subtractor FS22_1 (.a(a22[1]), .b(b22[1]), .bin(borrow22_1), .diff(c22[1]), .bout(borrow22_2));
    full_subtractor FS22_2 (.a(a22[2]), .b(b22[2]), .bin(borrow22_2), .diff(c22[2]), .bout(borrow22_3));
    assign c22[3] = borrow22_3;  // Final borrow goes to MSB of c22

endmodule

// Full Subtractor module definition
module full_subtractor (
    input a, b, bin,          // Inputs: two bits and borrow-in
    output diff, bout         // Outputs: difference and borrow-out
);
    assign diff = a ^ b ^ bin;  // Difference is XOR of inputs
    assign bout = (~a & b) | ((~a | b) & bin);  // Borrow-out logic
endmodule
