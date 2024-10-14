module determinant_2x2(
    input [1:0] d11, d12, d21, d22,  // 2-bit elements of the 2x2 matrix
    output reg [3:0] det             // 4-bit output for the determinant
);

    always @(*) begin
        // Determinant formula for 2x2 matrix: det = (d11 * d22) - (d12 * d21)
        // Since (d11 * d22) and (d12 * d21) can be at most 3 (2 * 2) each,
        // their difference can be at most 6, so a 4-bit output is sufficient.
        det = (d11 * d22) - (d12 * d21);
    end

endmodule


module determinant_2x2_gate_level(
    input [1:0] d11, d12, d21, d22,  // 2-bit elements of the 2x2 matrix
    output [3:0] det                 // 4-bit output for the determinant
);
    
    wire [3:0] mult1, mult2;  // Intermediate wires for the products
    wire [3:0] diff;          // Intermediate wire for the difference
    wire borrow;              // Borrow wire for subtraction

    // Gate-level multiplication (d11 * d22)
    // Multiply each bit of d11 with each bit of d22
    assign mult1[0] = d11[0] & d22[0];
    assign mult1[1] = (d11[1] & d22[0]) ^ (d11[0] & d22[1]);
    assign mult1[2] = (d11[1] & d22[1]) ^ ((d11[1] & d22[0]) & (d11[0] & d22[1]));
    assign mult1[3] = d11[1] & d22[1];

    // Gate-level multiplication (d12 * d21)
    assign mult2[0] = d12[0] & d21[0];
    assign mult2[1] = (d12[1] & d21[0]) ^ (d12[0] & d21[1]);
    assign mult2[2] = (d12[1] & d21[1]) ^ ((d12[1] & d21[0]) & (d12[0] & d21[1]));
    assign mult2[3] = d12[1] & d21[1];

    // Gate-level subtraction: det = mult1 - mult2
    assign {borrow, det} = mult1 - mult2; // Result goes into 'det'

endmodule
