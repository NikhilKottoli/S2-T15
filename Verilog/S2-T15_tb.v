/*
    Team Name: S2-T15
*/

`timescale 1ns / 1ps
`include "MatrixAdd.v"
`include "MatrixMultiply.v"
`include "MatrixSubtract.v"

module matrix_operations_2x2();

    // Inputs for matrix addition and subtraction (3-bit each element)
    reg [2:0] a11, a12, a21, a22;
    reg [2:0] b11, b12, b21, b22;

    // Outputs for matrix addition and subtraction (4-bit each element)
    wire [3:0] c11_add, c12_add, c21_add, c22_add;
    wire [3:0] c11_sub, c12_sub, c21_sub, c22_sub;

    // Packed 8-bit inputs for matrix multiplication
    reg [7:0] A_mul;
    reg [7:0] B_mul;

    // Outputs for matrix multiplication (16-bit result for 2x2 matrix)
    wire [15:0] C_mul;

    // Instantiate the Unit Under Test (UUT) for matrix addition
    matrix_adder_2x2 uut_add (
        .a11(a11), .a12(a12), .a21(a21), .a22(a22),
        .b11(b11), .b12(b12), .b21(b21), .b22(b22),
        .c11(c11_add), .c12(c12_add), .c21(c21_add), .c22(c22_add)
    );

    // Instantiate the Unit Under Test (UUT) for matrix subtraction
    matrix_subtractor_2x2 uut_sub (
        .a11(a11), .a12(a12), .a21(a21), .a22(a22),
        .b11(b11), .b12(b12), .b21(b21), .b22(b22),
        .c11(c11_sub), .c12(c12_sub), .c21(c21_sub), .c22(c22_sub)
    );

    // Instantiate the Unit Under Test (UUT) for matrix multiplication
    matrix_multiply uut_mul (
        .A(A_mul),  // Packed matrix A (8-bit)
        .B(B_mul),  // Packed matrix B (8-bit)
        .C(C_mul)   // Packed result matrix C (16-bit)
    );

    // Task to display matrix addition results
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

    // Task to display matrix subtraction results
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

    // Task to display matrix multiplication results
    task display_multiplication_results;
    reg [3:0] A11, A12, A21, A22;  // Elements for matrix A
    reg [3:0] B11, B12, B21, B22;  // Elements for matrix B
    reg [3:0] C11, C12, C21, C22;  // Elements for result matrix C

    begin
        // Unpacking matrix A (each element is 2 bits)
        A11 = A_mul[7:6]; A12 = A_mul[5:4];
        A21 = A_mul[3:2]; A22 = A_mul[1:0];

        // Unpacking matrix B (each element is 2 bits)
        B11 = B_mul[7:6]; B12 = B_mul[5:4];
        B21 = B_mul[3:2]; B22 = B_mul[1:0];

        // Unpacking matrix C (result is 4-bit per element)
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

        // Display Result Matrix C (Multiplication):
        $display("Result Matrix C (Multiplication):");
        $display("%2d %2d", C11, C12);
        $display("%2d %2d", C21, C22);

        $display("--------------------");
    end
    endtask

    // Test cases in initial block
    initial begin
        // Test case for matrix addition
        // Matrix A inputs
        a11 = 3'd2; a12 = 3'd3;
        a21 = 3'd4; a22 = 3'd5;

        // Matrix B inputs
        b11 = 3'd1; b12 = 3'd2;
        b21 = 3'd3; b22 = 3'd4;

        // Wait for some time before checking results
        #10;
        $display("Addition Test Case 1:");
        display_addition_results();

        // Test case for matrix subtraction
        #10;
        $display("Subtraction Test Case 1:");
        display_subtraction_results();

        // Test case for matrix multiplication
        // Packing 2x2 matrices into 8-bit inputs
        A_mul = 8'b00011011;  // Matrix A elements: {00, 01, 10, 11}
        B_mul = 8'b01001101;  // Matrix B elements: {01, 00, 11, 01}

        // Wait for some time before checking results
        #10;
        $display("Multiplication Test Case 1:");
        display_multiplication_results();

        // Finish simulation
        $finish;
    end

endmodule
