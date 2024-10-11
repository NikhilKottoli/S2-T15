/*
    Team Name: S2-T15
*/

`timescale 1ns / 1ps
`include "MatrixAdd.v"
`include "MatrixMultiply.v"

module matrix_operations_2x2();  // Renamed main module

    // Inputs for addition
    reg [2:0] a11, a12, a21, a22;
    reg [2:0] b11, b12, b21, b22;

    // Outputs for addition
    wire [3:0] c11, c12, c21, c22;

    // Instantiate the Unit Under Test (UUT) for addition
    matrix_adder_2x2 uut_add (
        .a11(a11), .a12(a12), .a21(a21), .a22(a22),
        .b11(b11), .b12(b12), .b21(b21), .b22(b22),
        .c11(c11), .c12(c12), .c21(c21), .c22(c22)
    );

    // Packed 8-bit inputs for matrix multiplication
    reg [7:0] A_mul;
    reg [7:0] B_mul;

    // Outputs for multiplication (16-bit result for 2x2 matrix)
    wire [15:0] C_mul;

    // Instantiate the Unit Under Test (UUT) for multiplication
    matrix_multiply uut_mul (
        .A(A_mul),  // Packed matrix A
        .B(B_mul),  // Packed matrix B
        .C(C_mul)   // Packed result matrix C
    );

    // Task to display matrices (for addition results)
    task display_addition_results;
    begin
        $display("Matrix A:");
        $display("%0d %0d", a11, a12);
        $display("%0d %0d", a21, a22);

        $display("Matrix B:");
        $display("%0d %0d", b11, b12);
        $display("%0d %0d", b21, b22);

        $display("Result Matrix C:");
        $display("%0d %0d", c11, c12);
        $display("%0d %0d", c21, c22);

        $display("--------------------");
    end
    endtask
    
    task display_multiplication_results;
    reg [3:0] A11, A12, A21, A22; // 2x2 matrix elements for A
    reg [3:0] B11, B12, B21, B22; // 2x2 matrix elements for B
    reg [7:0] C11, C12, C21, C22; // 2x2 matrix elements for result C (16-bit)

    begin
        // Unpacking matrix A (each element is 2 bits)
        A11 = A_mul[7:6];
        A12 = A_mul[5:4];
        A21 = A_mul[3:2];
        A22 = A_mul[1:0];

        // Unpacking matrix B (each element is 2 bits)
        B11 = B_mul[7:6];
        B12 = B_mul[5:4];
        B21 = B_mul[3:2];
        B22 = B_mul[1:0];

        // Unpacking matrix C (result is 4-bit per element in a 2x2 matrix)
        C11 = C_mul[15:12];
        C12 = C_mul[11:8];
        C21 = C_mul[7:4];
        C22 = C_mul[3:0];

        // Display Matrix A
        $display("Matrix A:");
        $display("%2d %2d", A11, A12);
        $display("%2d %2d", A21, A22);

        // Display Matrix B
        $display("Matrix B:");
        $display("%2d %2d", B11, B12);
        $display("%2d %2d", B21, B22);

        // Display Result Matrix C
        $display("Result Matrix C:");
        $display("%2d %2d", C11, C12);
        $display("%2d %2d", C21, C22);

        $display("--------------------");
        end
    endtask


    initial begin
        // Test Case 1: Small numbers for addition
        a11 = 3'd2; a12 = 3'd3; a21 = 3'd4; a22 = 3'd5;
        b11 = 3'd1; b12 = 3'd2; b21 = 3'd3; b22 = 3'd4;
        #10;
        $display("Addition Test Case 1:");
        display_addition_results();

        // Test Case 1: Multiplication with packed matrix inputs
        A_mul = 8'b00011011; // Represents 2x2 matrix with elements: {00, 01, 10, 11}
        B_mul = 8'b01001101; // Represents 2x2 matrix with elements: {01, 00, 11, 01}
        #10;
        $display("Multiplication Test Case:");
        display_multiplication_results();

        $finish;
    end

endmodule
