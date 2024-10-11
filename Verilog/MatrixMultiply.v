module matrix_multiply(
    input [7:0] A, // 2x2 matrix A elements, packed: {a11, a12, a21, a22} - 2 bits each
    input [7:0] B, // 2x2 matrix B elements, packed: {b11, b12, b21, b22} - 2 bits each
    output reg [15:0] C // Resulting 2x2 matrix C elements, packed: {c11, c12, c21, c22} - 4 bits each
);

    // Unpack the matrix elements from A and B (each element is 2 bits)
    reg [1:0] a11, a12, a21, a22;
    reg [1:0] b11, b12, b21, b22;

    reg [3:0] c11, c12, c21, c22; // Results should fit within 4 bits

    always @(*) begin
        // Unpacking the input matrices
        a11 = A[7:6];
        a12 = A[5:4];
        a21 = A[3:2];
        a22 = A[1:0];

        b11 = B[7:6];
        b12 = B[5:4];
        b21 = B[3:2];
        b22 = B[1:0];

        // Matrix multiplication logic
        c11 = (a11 * b11) + (a12 * b21); // Top-left element
        c12 = (a11 * b12) + (a12 * b22); // Top-right element
        c21 = (a21 * b11) + (a22 * b21); // Bottom-left element
        c22 = (a21 * b12) + (a22 * b22); // Bottom-right element

        // Packing the output matrix (packing 4-bit results into 16-bit output)
        C = {c11, c12, c21, c22};
    end
endmodule
