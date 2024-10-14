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
