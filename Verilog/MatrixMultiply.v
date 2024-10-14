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


module matrix_multiply_gate_level(
    input [7:0] A, // 2x2 matrix A elements, packed: {a11, a12, a21, a22} - 2 bits each
    input [7:0] B, // 2x2 matrix B elements, packed: {b11, b12, b21, b22} - 2 bits each
    output [15:0] C // Resulting 2x2 matrix C elements, packed: {c11, c12, c21, c22} - 4 bits each
);

    wire [1:0] a11, a12, a21, a22;  // Unpacked 2-bit elements of matrix A
    wire [1:0] b11, b12, b21, b22;  // Unpacked 2-bit elements of matrix B

    wire [3:0] c11, c12, c21, c22;  // 4-bit result matrix elements

    // Partial product and adder wires
    wire [3:0] p11_1, p11_2, sum_c11;
    wire [3:0] p12_1, p12_2, sum_c12;
    wire [3:0] p21_1, p21_2, sum_c21;
    wire [3:0] p22_1, p22_2, sum_c22;

    // Unpack the matrix elements
    assign a11 = A[7:6];
    assign a12 = A[5:4];
    assign a21 = A[3:2];
    assign a22 = A[1:0];

    assign b11 = B[7:6];
    assign b12 = B[5:4];
    assign b21 = B[3:2];
    assign b22 = B[1:0];

    // Matrix multiplication logic using gate-level design

    // c11 = (a11 * b11) + (a12 * b21)
    multiply_2bit p11_mult (.a(a11), .b(b11), .p(p11_1));
    multiply_2bit p12_mult (.a(a12), .b(b21), .p(p11_2));
    adder_4bit c11_add (.a(p11_1), .b(p11_2), .sum(sum_c11));
    assign c11 = sum_c11;

    // c12 = (a11 * b12) + (a12 * b22)
    multiply_2bit p13_mult (.a(a11), .b(b12), .p(p12_1));
    multiply_2bit p14_mult (.a(a12), .b(b22), .p(p12_2));
    adder_4bit c12_add (.a(p12_1), .b(p12_2), .sum(sum_c12));
    assign c12 = sum_c12;

    // c21 = (a21 * b11) + (a22 * b21)
    multiply_2bit p21_mult (.a(a21), .b(b11), .p(p21_1));
    multiply_2bit p22_mult (.a(a22), .b(b21), .p(p21_2));
    adder_4bit c21_add (.a(p21_1), .b(p21_2), .sum(sum_c21));
    assign c21 = sum_c21;

    // c22 = (a21 * b12) + (a22 * b22)
    multiply_2bit p23_mult (.a(a21), .b(b12), .p(p22_1));
    multiply_2bit p24_mult (.a(a22), .b(b22), .p(p22_2));
    adder_4bit c22_add (.a(p22_1), .b(p22_2), .sum(sum_c22));
    assign c22 = sum_c22;

    // Packing the output matrix
    assign C = {c11, c12, c21, c22};

endmodule

// 2-bit multiplier module (gate-level)
module multiply_2bit (
    input [1:0] a, b,
    output [3:0] p // 4-bit product
);
    wire p0, p1, p2, p3;

    assign p0 = a[0] & b[0];             // Least significant bit
    assign p1 = (a[1] & b[0]) ^ (a[0] & b[1]);
    assign p2 = (a[1] & b[0]) & (a[0] & b[1]) ^ (a[1] & b[1]);
    assign p3 = (a[1] & b[1]);           // Most significant bit

    assign p = {p3, p2, p1, p0};         // Combine into 4-bit product

endmodule

// 4-bit adder module (gate-level)
module adder_4bit (
    input [3:0] a, b,
    output [3:0] sum
);
    wire carry1, carry2, carry3;

    full_adder FA1 (.a(a[0]), .b(b[0]), .cin(1'b0), .sum(sum[0]), .cout(carry1));
    full_adder FA2 (.a(a[1]), .b(b[1]), .cin(carry1), .sum(sum[1]), .cout(carry2));
    full_adder FA3 (.a(a[2]), .b(b[2]), .cin(carry2), .sum(sum[2]), .cout(carry3));
    full_adder FA4 (.a(a[3]), .b(b[3]), .cin(carry3), .sum(sum[3]), .cout());

endmodule

// Full adder module
module full_adder (
    input a, b, cin,          // Inputs: two bits and carry-in
    output sum, cout          // Outputs: sum and carry-out
);
    assign sum = a ^ b ^ cin; // XOR for sum
    assign cout = (a & b) | (cin & (a ^ b)); // Carry-out logic
endmodule
