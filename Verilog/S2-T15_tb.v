`timescale 1ns / 1ps
`include "MatrixAdd.v"
`include "MatrixSubtract.v"
`include "MatrixMultiply.v"
`include "Transpose.v"

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

    // Initial block
    initial begin
        // Test case for matrix addition
        a11 = 3'd2; a12 = 3'd3;
        a21 = 3'd4; a22 = 3'd5;
        b11 = 3'd1; b12 = 3'd2;
        b21 = 3'd3; b22 = 3'd4;
        #10;
        $display("Addition Test Case 1:");
        display_addition_results();

        // Test case for matrix subtraction
        #10;
        $display("Subtraction Test Case 1:");
        display_subtraction_results();

        // Test case for matrix multiplication
        A_mul = 8'b00011011;  // Matrix A: {00, 01, 10, 11}
        B_mul = 8'b01001101;  // Matrix B: {01, 00, 11, 01}
        #10;
        $display("Multiplication Test Case 1:");
        display_multiplication_results();

        // Test case for matrix transpose
        #10;
        $display("Transpose Test Case 1:");
        display_transpose_results();

        // Finish the simulation
        $finish;
    end

endmodule
