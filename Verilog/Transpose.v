/*
    Team Name: S2-T15
    Transpose of a 2x2 Matrix
*/

module matrix_transpose_2x2(
    input [2:0] a11, a12, a21, a22,  // Elements of matrix A (3-bit each)
    output [2:0] t11, t12, t21, t22  // Elements of transposed matrix T (3-bit each)
);

    // Transpose logic
    assign t11 = a11;  // Top-left element stays the same
    assign t12 = a21;  // Top-right element becomes bottom-left
    assign t21 = a12;  // Bottom-left element becomes top-right
    assign t22 = a22;  // Bottom-right element stays the same

endmodule
