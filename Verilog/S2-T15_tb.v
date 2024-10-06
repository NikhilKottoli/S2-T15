`timescale 1ns / 1ps
`include "MatrixAdd.v"

module tb_matrix_adder_2x2();

    // Inputs
    reg [2:0] a11, a12, a21, a22;
    reg [2:0] b11, b12, b21, b22;

    // Outputs
    wire [3:0] c11, c12, c21, c22;

    // Instantiate the Unit Under Test (UUT)
    matrix_adder_2x2 uut (
        .a11(a11), .a12(a12), .a21(a21), .a22(a22),
        .b11(b11), .b12(b12), .b21(b21), .b22(b22),
        .c11(c11), .c12(c12), .c21(c21), .c22(c22)
    );

    // Task to display matrices
    task display_matrices;
        begin
            $display("Matrix A (3-bit):");
            $display("%3b (%0d) %3b (%0d)", a11, a11, a12, a12);
            $display("%3b (%0d) %3b (%0d)", a21, a21, a22, a22);

            $display("Matrix B (3-bit):");
            $display("%3b (%0d) %3b (%0d)", b11, b11, b12, b12);
            $display("%3b (%0d) %3b (%0d)", b21, b21, b22, b22);

            $display("Result Matrix C (4-bit):");
            $display("%4b (%0d) %4b (%0d)", c11, c11, c12, c12);
            $display("%4b (%0d) %4b (%0d)", c21, c21, c22, c22);

            $display("--------------------");
        end
    endtask

    initial begin
        // Test Case 1: Small numbers
        a11 = 3'd2; a12 = 3'd3; a21 = 3'd4; a22 = 3'd5;
        b11 = 3'd1; b12 = 3'd2; b21 = 3'd3; b22 = 3'd4;
        #10;
        $display("Test Case 1 (Small numbers):");
        display_matrices();

        // Test Case 2: Larger numbers (within 3-bit range)
        a11 = 3'd5; a12 = 3'd6; a21 = 3'd7; a22 = 3'd0;
        b11 = 3'd2; b12 = 3'd3; b21 = 3'd4; b22 = 3'd5;
        #10;
        $display("Test Case 2 (Larger numbers):");
        display_matrices();

        // Test Case 3: Testing overflow
        a11 = 3'd7; a12 = 3'd7; a21 = 3'd7; a22 = 3'd7;
        b11 = 3'd1; b12 = 3'd1; b21 = 3'd1; b22 = 3'd1;
        #10;
        $display("Test Case 3 (Overflow Test):");
        display_matrices();

        $finish;
    end

endmodule