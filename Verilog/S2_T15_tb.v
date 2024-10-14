`timescale 1ns / 1ps
`include "S2_T15.v"

module matrix_operations_2x2_tb();

    // Inputs for matrix operations
    reg [2:0] a11, a12, a21, a22;
    reg [2:0] b11, b12, b21, b22;

    // Outputs for matrix addition
    wire [3:0] c11_add, c12_add, c21_add, c22_add;

    // Outputs for matrix subtraction
    wire [3:0] c11_sub, c12_sub, c21_sub, c22_sub;

    // Packed 8-bit inputs for matrix multiplication
    reg [7:0] A_mul;
    reg [7:0] B_mul;
    wire [15:0] C_mul;  // Outputs for matrix multiplication

    // Outputs for matrix transpose
    wire [2:0] t11, t12, t21, t22;

    // Instantiate Unit Under Test (UUT) for matrix addition
    matrix_adder_2x2 uut_add (
        .a11(a11), .a12(a12), .a21(a21), .a22(a22),
        .b11(b11), .b12(b12), .b21(b21), .b22(b22),
        .c11(c11_add), .c12(c12_add), .c21(c21_add), .c22(c22_add)
    );

    // Instantiate Unit Under Test (UUT) for matrix subtraction
    matrix_subtractor_2x2 uut_sub (
        .a11(a11), .a12(a12), .a21(a21), .a22(a22),
        .b11(b11), .b12(b12), .b21(b21), .b22(b22),
        .c11(c11_sub), .c12(c12_sub), .c21(c21_sub), .c22(c22_sub)
    );

    // Instantiate Unit Under Test (UUT) for matrix multiplication
    matrix_multiply uut_mul (
        .A(A_mul),  // Packed matrix A
        .B(B_mul),  // Packed matrix B
        .C(C_mul)   // Packed result matrix C
    );

    // Instantiate Unit Under Test (UUT) for matrix transpose
    matrix_transpose_2x2 uut_trans (
        .a11(a11), .a12(a12), .a21(a21), .a22(a22),
        .t11(t11), .t12(t12), .t21(t21), .t22(t22)
    );

    // Inputs for determinant calculation
    reg [1:0] d11, d12, d21, d22; // 2 bits for each matrix element
    wire [3:0] det; // Use signed to accommodate negative results

    // Instantiate Unit Under Test (UUT) for determinant calculation
    determinant_2x2 duut (
        .d11(d11),
        .d12(d12),
        .d21(d21),
        .d22(d22),
        .det(det)
    );

    // Matrix inputs
    reg signed [3:0] i11, i12, i21, i22;
    wire [3:0] inv11, inv12, inv21, inv22;
    wire valid;                // Valid flag

    // Instantiate the inverse_2x2 module
    inverse_2x2 uut (
        .d11(i11),
        .d12(i12),
        .d21(i21),
        .d22(i22),
        .inv11(inv11),
        .inv12(inv12),
        .inv21(inv21),
        .inv22(inv22),
        .valid(valid)
    );

    // Task to display addition results
    task display_addition_results;
    begin
        $display("Matrix A:");
        $display("%0d %0d", a11, a12);
        $display("%0d %0d", a21, a22);

        $display("Matrix B:");
        $display("%0d %0d", b11, b12);
        $display("%0d %0d", b21, b22);

        $display("Result Matrix C (Addition):");
        $display("%0d %0d", c11_add, c12_add);
        $display("%0d %0d", c21_add, c22_add);

        $display("--------------------");
    end
    endtask

    // Task to display subtraction results
    task display_subtraction_results;
    begin
        $display("Matrix A:");
        $display("%0d %0d", a11, a12);
        $display("%0d %0d", a21, a22);

        $display("Matrix B:");
        $display("%0d %0d", b11, b12);
        $display("%0d %0d", b21, b22);

        $display("Result Matrix C (Subtraction):");
        $display("%0d %0d", c11_sub, c12_sub);
        $display("%0d %0d", c21_sub, c22_sub);

        $display("--------------------");
    end
    endtask

    // Task to display multiplication results
    task display_multiplication_results;
    reg [3:0] A11, A12, A21, A22; // 2x2 matrix elements for A
    reg [3:0] B11, B12, B21, B22; // 2x2 matrix elements for B
    reg [7:0] C11, C12, C21, C22; // 2x2 matrix elements for result C

    begin
        // Unpacking matrix A
        A11 = A_mul[7:6]; A12 = A_mul[5:4];
        A21 = A_mul[3:2]; A22 = A_mul[1:0];

        // Unpacking matrix B
        B11 = B_mul[7:6]; B12 = B_mul[5:4];
        B21 = B_mul[3:2]; B22 = B_mul[1:0];

        // Unpacking matrix C (result)
        C11 = C_mul[15:12]; C12 = C_mul[11:8];
        C21 = C_mul[7:4]; C22 = C_mul[3:0];

        // Display Matrix A
        $display("Matrix A:");
        $display("%2d %2d", A11, A12);
        $display("%2d %2d", A21, A22);

        // Display Matrix B
        $display("Matrix B:");
        $display("%2d %2d", B11, B12);
        $display("%2d %2d", B21, B22);

        // Display Result Matrix C
        $display("Result Matrix C (Multiplication):");
        $display("%2d %2d", C11, C12);
        $display("%2d %2d", C21, C22);

        $display("--------------------");
    end
    endtask

    // Task to display transpose results
    task display_transpose_results;
    begin
        $display("Original Matrix A:");
        $display("%0d %0d", a11, a12);
        $display("%0d %0d", a21, a22);

        $display("Transposed Matrix T:");
        $display("%0d %0d", t11, t12);
        $display("%0d %0d", t21, t22);

        $display("--------------------");
    end
    endtask

    // Task to display determinant
    task display_determinant;
        input [1:0] d11, d12, d21, d22; // Matrix elements
        input signed [3:0] determinant;  // Determinant value
    begin
        $display("Matrix D:");
        $display("%0d %0d", d11, d12);
        $display("%0d %0d", d21, d22);
        $display("Determinant = %0d", determinant);
        $display("--------------------");
    end
    endtask

    // Task to display inverse results
    task display_inverse_results;
        input [1:0] d11, d12, d21, d22; // Input matrix elements
        input signed [3:0] det;          // Determinant
        input signed [3:0] inv11, inv12, inv21, inv22; // Inverse matrix elements
        input valid;                      // Validity flag
    begin
        $display("Matrix D:");
        $display("%0d %0d", d11, d12);
        $display("%0d %0d", d21, d22);
        $display("Determinant = %0d", det);
        
        if (valid) begin
            $display("Inverse Matrix:");
            $display("%0d %0d", inv11, inv12);
            $display("%0d %0d", inv21, inv22);
        end else begin
            $display("Matrix is singular; inverse does not exist.");
        end
        $display("--------------------");
    end
    endtask

    initial begin
        // Initialize matrices A and B
        a11 = 3; a12 = 2; a21 = 1; a22 = 4; // A
        b11 = 1; b12 = 1; b21 = 1; b22 = 1; // B

        // Call display_addition_results
        #10; // Wait for the addition operation
        display_addition_results;

        // Call display_subtraction_results
        #10; // Wait for the subtraction operation
        display_subtraction_results;

        // Initialize matrices for multiplication
        A_mul = {a11, a12, a21, a22}; // Pack matrix A
        B_mul = {b11, b12, b21, b22}; // Pack matrix B
        #10; // Wait for the multiplication operation
        display_multiplication_results;

        // Call display_transpose_results
        #10; // Wait for the transpose operation
        display_transpose_results;

        // Initialize for determinant calculation
        d11 = 1; d12 = 2; d21 = 3; d22 = 4; // Example matrix for determinant
        #10; // Wait for determinant calculation
        display_determinant(d11, d12, d21, d22, det);

        // Initialize for inverse calculation
        i11 = 0; i12 = 3; i21 = 2; i22 = 1; // Example matrix for inverse
        #10; // Wait for inverse calculation
        display_inverse_results(i11, i12, i21, i22, det, inv11, inv12, inv21, inv22, valid);

        $finish; // End simulation
    end

endmodule