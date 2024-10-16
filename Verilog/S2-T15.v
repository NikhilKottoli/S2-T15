/*
    Team:S2-T15
    Member-1:Aditya Suresh 231CS203
    Member-2:Nikhil Kottoli 231CS236
    Member-3:Vishal 231CS263
*/


module determinant_2x2(
    input [1:0] d11, d12, d21, d22,  // 2-bit elements of the 2x2 matrix
    output reg [3:0] det             // 4-bit output for the determinant
);

    always @(*) begin
        det = (d11 * d22) - (d12 * d21);
    end

endmodule


module determinant_2x2_gate_level(
    input [1:0] d11, d12, d21, d22,  // Matrix elements
    output [3:0] det                 // Determinant output
);
    
    wire [3:0] mult1;  // Product of d11 and d22
    wire [3:0] mult2;  // Product of d12 and d21
    wire borrow;       // Borrow signal for subtraction

    // Multiplication for d11 * d22
    wire p00, p01, p10, p11; // Partial products
    and (p00, d11[0], d22[0]);
    and (p01, d11[0], d22[1]);
    and (p10, d11[1], d22[0]);
    and (p11, d11[1], d22[1]);

    xor (mult1[1], p01, p10);  // Sum for second bit
    xor (mult1[2], p01, p11);  // Sum for third bit
    and (mult1[0], p00, 1'b1);  // LSB
    and (mult1[3], p11, 1'b1);   // MSB

    // Multiplication for d12 * d21
    wire q00, q01, q10, q11; // Partial products
    and (q00, d12[0], d21[0]);
    and (q01, d12[0], d21[1]);
    and (q10, d12[1], d21[0]);
    and (q11, d12[1], d21[1]);

    xor (mult2[1], q01, q10);  // Sum for second bit
    xor (mult2[2], q01, q11);  // Sum for third bit
    and (mult2[0], q00, 1'b1);  // LSB
    and (mult2[3], q11, 1'b1);   // MSB

    // Subtract mult2 from mult1
    wire [3:0] temp; // Result of subtraction
    wire b0, b1, b2, b3;

    // First bit
    xor (temp[0], mult1[0], mult2[0]); 
    not (b0, mult2[0]);                 
    and (b1, b0, mult1[0]);             

    // Second bit
    xor (temp[1], mult1[1], mult2[1]);
    and (b2, b0, mult1[1]);
    and (b3, mult2[1], mult1[0]);
    or (borrow, b1, b2);               

    // Third bit
    xor (temp[2], mult1[2], mult2[2]);

    // Final output using buffers instead of assign
    buf (det[0], temp[0]);
    buf (det[1], temp[1]);
    buf (det[2], temp[2]);
    buf (det[3], 1'b0);  // If you want to set the MSB to 0, adjust accordingly

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
    input [3:0] d11, d12, d21, d22,   // Input elements of the 2x2 matrix
    output [3:0] inv11, inv12, inv21, inv22 // Inverse matrix elements
);

    // Wires for negative values
    wire [3:0] neg_d12;
    wire [3:0] neg_d21;

    // Generate negation of d12 and d21 using NOT gates
    not(neg_d12[0], d12[0]);
    not(neg_d12[1], d12[1]);
    not(neg_d12[2], d12[2]);
    not(neg_d12[3], d12[3]);

    not(neg_d21[0], d21[0]);
    not(neg_d21[1], d21[1]);
    not(neg_d21[2], d21[2]);
    not(neg_d21[3], d21[3]);

    // inv11 = d22
    wire inv11_0, inv11_1, inv11_2, inv11_3;
    and(inv11_0, d22[0], 1'b1); // d22[0] 
    and(inv11_1, d22[1], 1'b1); // d22[1] 
    and(inv11_2, d22[2], 1'b1); // d22[2] 
    and(inv11_3, d22[3], 1'b1); // d22[3] 

    // inv12 = -d12
    wire inv12_0, inv12_1, inv12_2, inv12_3;
    and(inv12_0, neg_d12[0], 1'b1); // -d12[0]
    and(inv12_1, neg_d12[1], 1'b1); // -d12[1]
    and(inv12_2, neg_d12[2], 1'b1); // -d12[2]
    and(inv12_3, neg_d12[3], 1'b1); // -d12[3]

    // inv21 = -d21
    wire inv21_0, inv21_1, inv21_2, inv21_3;
    and(inv21_0, neg_d21[0], 1'b1); // -d21[0]
    and(inv21_1, neg_d21[1], 1'b1); // -d21[1]
    and(inv21_2, neg_d21[2], 1'b1); // -d21[2]
    and(inv21_3, neg_d21[3], 1'b1); // -d21[3]

    // inv22 = d11
    wire inv22_0, inv22_1, inv22_2, inv22_3;
    and(inv22_0, d11[0], 1'b1); // d11[0]
    and(inv22_1, d11[1], 1'b1); // d11[1]
    and(inv22_2, d11[2], 1'b1); // d11[2]
    and(inv22_3, d11[3], 1'b1); // d11[3]

    and(inv11[0], inv11_0, 1'b1);
    and(inv11[1], inv11_1, 1'b1);
    and(inv11[2], inv11_2, 1'b1);
    and(inv11[3], inv11_3, 1'b1);

    and(inv12[0], inv12_0, 1'b1);
    and(inv12[1], inv12_1, 1'b1);
    and(inv12[2], inv12_2, 1'b1);
    and(inv12[3], inv12_3, 1'b1);

    and(inv21[0], inv21_0, 1'b1);
    and(inv21[1], inv21_1, 1'b1);
    and(inv21[2], inv21_2, 1'b1);
    and(inv21[3], inv21_3, 1'b1);

    and(inv22[0], inv22_0, 1'b1);
    and(inv22[1], inv22_1, 1'b1);
    and(inv22[2], inv22_2, 1'b1);
    and(inv22[3], inv22_3, 1'b1);

endmodule

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


module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire a_xor_b, a_and_b, a_xor_b_and_cin;

    // Logic for Full Adder
    xor(a_xor_b, a, b);              
    xor(sum, a_xor_b, cin);         
    and(a_and_b, a, b);             
    and(a_xor_b_and_cin, a_xor_b, cin); 
    or(cout, a_and_b, a_xor_b_and_cin); 
endmodule

module matrix_adder_2x2_gate_level(
    input [2:0] a11, a12, a21, a22,  // Matrix A elements
    input [2:0] b11, b12, b21, b22,  // Matrix B elements
    output [3:0] c11, c12, c21, c22  // Result matrix elements
);

    // Carry wires
    wire carry11_1, carry11_2, carry11_3;  
    wire carry12_1, carry12_2, carry12_3;  
    wire carry21_1, carry21_2, carry21_3;  
    wire carry22_1, carry22_2, carry22_3;  

    // c11 addition
    full_adder FA11_0 (.a(a11[0]), .b(b11[0]), .cin(1'b0),   .sum(c11[0]), .cout(carry11_1));
    full_adder FA11_1 (.a(a11[1]), .b(b11[1]), .cin(carry11_1), .sum(c11[1]), .cout(carry11_2));
    full_adder FA11_2 (.a(a11[2]), .b(b11[2]), .cin(carry11_2), .sum(c11[2]), .cout(carry11_3));
    and(c11[3], carry11_3, 1'b1);  // MSB for c11

    // c12 addition
    full_adder FA12_0 (.a(a12[0]), .b(b12[0]), .cin(1'b0),   .sum(c12[0]), .cout(carry12_1));
    full_adder FA12_1 (.a(a12[1]), .b(b12[1]), .cin(carry12_1), .sum(c12[1]), .cout(carry12_2));
    full_adder FA12_2 (.a(a12[2]), .b(b12[2]), .cin(carry12_2), .sum(c12[2]), .cout(carry12_3));
    and(c12[3], carry12_3, 1'b1);  // MSB for c12

    // c21 addition
    full_adder FA21_0 (.a(a21[0]), .b(b21[0]), .cin(1'b0),   .sum(c21[0]), .cout(carry21_1));
    full_adder FA21_1 (.a(a21[1]), .b(b21[1]), .cin(carry21_1), .sum(c21[1]), .cout(carry21_2));
    full_adder FA21_2 (.a(a21[2]), .b(b21[2]), .cin(carry21_2), .sum(c21[2]), .cout(carry21_3));
    and(c21[3], carry21_3, 1'b1);  // MSB for c21

    // c22 addition
    full_adder FA22_0 (.a(a22[0]), .b(b22[0]), .cin(1'b0),   .sum(c22[0]), .cout(carry22_1));
    full_adder FA22_1 (.a(a22[1]), .b(b22[1]), .cin(carry22_1), .sum(c22[1]), .cout(carry22_2));
    full_adder FA22_2 (.a(a22[2]), .b(b22[2]), .cin(carry22_2), .sum(c22[2]), .cout(carry22_3));
    and(c22[3], carry22_3, 1'b1);  // MSB for c22

endmodule


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

module full_subtractor (
    input a,
    input b,
    input bin,      // Borrow input
    output diff,    // Difference output
    output bout      // Borrow output
);
    wire a_xor_b, a_nand_b, a_nxor_bin;

    // Logic for Full Subtractor
    xor(a_xor_b, a, b);                  
    xor(diff, a_xor_b, bin);             
    nand(a_nand_b, a, b);                
    xor(a_nxor_bin, a_xor_b, bin);      
    and(bout, a_nand_b, 1'b1);           
    or(bout, bout, a_nxor_bin);
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
    input [7:0] A, // 2x2 matrix A elements packed: {a11, a12, a21, a22}
    input [7:0] B, // 2x2 matrix B elements packed: {b11, b12, b21, b22}
    output [15:0] C // Resulting 2x2 matrix C elements packed: {c11, c12, c21, c22}
);

    // Unpack matrix A
    wire [1:0] a11 = A[7:6];
    wire [1:0] a12 = A[5:4];
    wire [1:0] a21 = A[3:2];
    wire [1:0] a22 = A[1:0];

    // Unpack matrix B
    wire [1:0] b11 = B[7:6];
    wire [1:0] b12 = B[5:4];
    wire [1:0] b21 = B[3:2];
    wire [1:0] b22 = B[1:0];

    // Intermediate products for C
    wire [3:0] p11, p12, p21, p22;
    wire [3:0] p13, p14, p21_temp, p22_temp;
    wire [3:0] p23, p24;

    // c11 = a11 * b11 + a12 * b21
    and (p11[0], a11[0], b11[0]);
    and (p11[1], a11[0], b11[1]);
    and (p11[2], a11[1], b11[0]);
    and (p11[3], a11[1], b11[1]);

    and (p12[0], a12[0], b21[0]);
    and (p12[1], a12[0], b21[1]);
    and (p12[2], a12[1], b21[0]);
    and (p12[3], a12[1], b21[1]);

    // c12 = a11 * b12 + a12 * b22
    and (p13[0], a11[0], b12[0]);
    and (p13[1], a11[0], b12[1]);
    and (p13[2], a11[1], b12[0]);
    and (p13[3], a11[1], b12[1]);

    and (p14[0], a12[0], b22[0]);
    and (p14[1], a12[0], b22[1]);
    and (p14[2], a12[1], b22[0]);
    and (p14[3], a12[1], b22[1]);

    // c21 = a21 * b11 + a22 * b21
    and (p21_temp[0], a21[0], b11[0]);
    and (p21_temp[1], a21[0], b11[1]);
    and (p21_temp[2], a21[1], b11[0]);
    and (p21_temp[3], a21[1], b11[1]);

    and (p22_temp[0], a22[0], b21[0]);
    and (p22_temp[1], a22[0], b21[1]);
    and (p22_temp[2], a22[1], b21[0]);
    and (p22_temp[3], a22[1], b21[1]);

    // c22 = a21 * b12 + a22 * b22
    and (p23[0], a21[0], b12[0]);
    and (p23[1], a21[0], b12[1]);
    and (p23[2], a21[1], b12[0]);
    and (p23[3], a21[1], b12[1]);

    and (p24[0], a22[0], b22[0]);
    and (p24[1], a22[0], b22[1]);
    and (p24[2], a22[1], b22[0]);
    and (p24[3], a22[1], b22[1]);

    // c11 Calculation (using half adders)
    wire c11_temp1, c11_temp2, c11_carry1, c11_carry2;
    or (c11_temp1, p11[0], p12[0]);
    or (c11_temp2, p11[1], p12[1]);
    
    and (c11_carry1, p11[0], p12[0]);
    and (c11_carry2, p11[1], p12[1]);

    // c12 Calculation
    wire c12_temp1, c12_temp2, c12_carry1, c12_carry2;
    or (c12_temp1, p13[0], p14[0]);
    or (c12_temp2, p13[1], p14[1]);

    and (c12_carry1, p13[0], p14[0]);
    and (c12_carry2, p13[1], p14[1]);

    // c21 Calculation
    wire c21_temp1, c21_temp2, c21_carry1, c21_carry2;
    or (c21_temp1, p21_temp[0], p22_temp[0]);
    or (c21_temp2, p21_temp[1], p22_temp[1]);

    and (c21_carry1, p21_temp[0], p22_temp[0]);
    and (c21_carry2, p21_temp[1], p22_temp[1]);

    // c22 Calculation
    wire c22_temp1, c22_temp2, c22_carry1, c22_carry2;
    or (c22_temp1, p23[0], p24[0]);
    or (c22_temp2, p23[1], p24[1]);

    and (c22_carry1, p23[0], p24[0]);
    and (c22_carry2, p23[1], p24[1]);

    // Final outputs for C using only gates
    // c11 output
    wire c11_final, c12_final, c21_final, c22_final;

    or (C[15], c11_temp1, c11_temp2); // c11's carry output
    or (C[14], c11_carry1, c11_carry2); // c11's carry output

    // c12 output
    or (C[13], c12_temp1, c12_temp2); // c12's carry output
    or (C[12], c12_carry1, c12_carry2); // c12's carry output

    // c21 output
    or (C[11], c21_temp1, c21_temp2); // c21's carry output
    or (C[10], c21_carry1, c21_carry2); // c21's carry output

    // c22 output
    or (C[9], c22_temp1, c22_temp2); // c22's carry output
    or (C[8], c22_carry1, c22_carry2); // c22's carry output

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

module matrix_transpose_2x2_gate(
    input [2:0] a11, a12, a21, a22,  // Elements of matrix A (3-bit each)
    output [2:0] t11, t12, t21, t22  // Elements of transposed matrix T (3-bit each)
);

    // Intermediate wires to hold the transposed values
    wire [2:0] temp1; // Holds t11 and t22
    wire [2:0] temp2; // Holds t12 and t21

    // Assigning top-left and bottom-right directly
    // Using AND gates to route the original values
    and (t11[0], a11[0], 1'b1); // t11[0] = a11[0]
    and (t11[1], a11[1], 1'b1); // t11[1] = a11[1]
    and (t11[2], a11[2], 1'b1); // t11[2] = a11[2]

    and (t22[0], a22[0], 1'b1); // t22[0] = a22[0]
    and (t22[1], a22[1], 1'b1); // t22[1] = a22[1]
    and (t22[2], a22[2], 1'b1); // t22[2] = a22[2]

    // Transposing top-right to bottom-left
    and (t12[0], a21[0], 1'b1); // t12[0] = a21[0]
    and (t12[1], a21[1], 1'b1); // t12[1] = a21[1]
    and (t12[2], a21[2], 1'b1); // t12[2] = a21[2]

    // Transposing bottom-left to top-right
    and (t21[0], a12[0], 1'b1); // t21[0] = a12[0]
    and (t21[1], a12[1], 1'b1); // t21[1] = a12[1]
    and (t21[2], a12[2], 1'b1); // t21[2] = a12[2]

endmodule
