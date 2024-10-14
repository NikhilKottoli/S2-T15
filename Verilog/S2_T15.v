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

module inverse_2x2(
    input signed [3:0] d11, d12, d21, d22,  // Input elements of the 2x2 matrix
    output reg signed [3:0] inv11, inv12, inv21, inv22, // Output for the inverse matrix
    output reg valid                  // Output valid flag
);

    reg signed [5:0] det; // Determinant with wider bit-width for intermediate results

    // Determinant calculation
    always @(*) begin
        det = (d11 * d22) - (d12 * d21);
    end

    // Check if determinant is non-zero and calculate the inverse
    always @(*) begin
        if (det != 0) begin
            valid = 1; // Inverse exists
            inv11 = d22;         // Assign d22 directly
            inv12 = -d12;        // Assign negative of d12
            inv21 = -d21;        // Assign negative of d21
            inv22 = d11;         // Assign d11 directly
        end else begin
            valid = 0; // Inverse does not exist
            inv11 = 4'b0000; // Output 0
            inv12 = 4'b0000; // Output 0
            inv21 = 4'b0000; // Output 0
            inv22 = 4'b0000; // Output 0
        end
    end

endmodule

module inverse_2x2_gate(
    input [3:0] d11, d12, d21, d22,   // Input elements of the 2x2 matrix (signed 4-bit)
    output [3:0] inv11, inv12, inv21, inv22, // Inverse matrix elements (signed 4-bit)
    output valid                      // Valid flag
);

    wire [5:0] prod1, prod2; // 6-bit products for determinant
    wire [5:0] det;          // 6-bit determinant
    wire [3:0] neg_d12, neg_d21; // Two's complement of d12 and d21
    wire det_zero;           // Flag to check if det is zero
    wire [3:0] zero;         // Zero constant

    assign zero = 4'b0000; // 4-bit zero
    
    // --- Step 1: Multiply d11 * d22 using AND gates and adders ---
    // We'll use full adders for the multiplication (gate-level multiplication)
    // Multiply d11 and d22, and d12 and d21
    
    // Implement 2-bit x 2-bit multipliers for all 2-bit pairs:
    and (prod1[0], d11[0], d22[0]); // First partial product
    and (prod1[1], d11[1], d22[0]); // Second partial product
    and (prod1[2], d11[0], d22[1]); // Third partial product
    and (prod1[3], d11[1], d22[1]); // Fourth partial product

    and (prod2[0], d12[0], d21[0]); // First partial product
    and (prod2[1], d12[1], d21[0]); // Second partial product
    and (prod2[2], d12[0], d21[1]); // Third partial product
    and (prod2[3], d12[1], d21[1]); // Fourth partial product

    // --- Step 2: Compute determinant = (d11 * d22) - (d12 * d21) using logic ---
    // For subtraction, we do two's complement of (d12 * d21) and then add.

    // Invert prod2 for subtraction
    not (neg_d12[0], prod2[0]);
    not (neg_d12[1], prod2[1]);
    not (neg_d12[2], prod2[2]);
    not (neg_d12[3], prod2[3]);

    // --- Step 3: Check if det = 0 using NOR gates ---
    nor(det_zero, det[0], det[1], det[2], det[3]);

    // --- Step 4: Calculate Inverse if det != 0 ---
    // Use multiplexers (constructed with AND, OR, and NOT gates) to select
    // inverse elements or zero if determinant is zero.
    and(valid, ~det_zero); // valid = ~det_zero, only valid if det != 0

    // Output elements for the inverse matrix
    // inv11 = d22, inv12 = -d12, inv21 = -d21, inv22 = d11
    assign inv11 = (valid) ? d22 : zero;
    assign inv12 = (valid) ? neg_d12 : zero;
    assign inv21 = (valid) ? neg_d21 : zero;
    assign inv22 = (valid) ? d11 : zero;

endmodule

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
