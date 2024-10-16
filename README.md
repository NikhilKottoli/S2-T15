# MatrixManipulator

<!-- First Section -->
## Team Details
<details>
  <summary>Detail</summary>
	  
  <ul>
    <li>Section: S2 Team-15</li>
    <li>Semester: 3rd Sem B. Tech. CSE</li>
    <li>Member-1: Aditya Suresh, 231CS203, adityasuresh.231cs203@nitk.edu.in</li>
    <li>Member-2: Nikhil Kottoli, 231CS236, nikhilkottoli.231cs236@nitk.edu.in</li>
    <li>Member-3: Vishal, 231CS263, vishalgangani.231cs263@nitk.edu.in</li>
  </ul>
</details>

<!-- Second Section -->
## Abstract
<details>
  <summary>Detail</summary>
  
  - **Motivation:**  
  Efficient handling of matrices is crucial in various fields, including computer graphics, engineering, data science, and machine learning. The need for systems that can efficiently perform these operations and which can be easily scaled are essential. We aimed to make a system which not only performs the most common operations but also is easy to scale and modular.

- **Problem Statement:**  
  This project addresses the need for efficient matrix operations by developing a tool that exclusively uses combinational and sequential circuits to perform multiplication, transposition, and determinant calculations. This solution is grounded in digital systems and implements most used matrix operations in as little hardware as possible.

- **Features:**  
  - **Matrix Multiplication:** Efficiently multiplies two matrices, handling various inputs and displaying the resulting product in a clear format.
  - **Transpose Calculation and Arithmetic Operations:** Allows users to easily find the transpose of any matrix, visually presenting the result. It also performs scalar multiplication and matrix subtraction and addition.
  - **Determinant Finder:** Accurately computes the determinant of square matrices and indicates the existence of an inverse.
  - **User-Friendly Interface:** Provides an easy-to-use interface, simplifying data input and output display using a seven-segment display.

  
</details>

<!-- Block Diagram Section -->
## Functional Block Diagram
<details>
  <summary>View Block Diagram</summary>
  <img src="/Snapshots/BlockDiagram.png" alt="Block Diagram" style="display: block; margin: 20px auto;">
</details>

<!-- Third Section -->
## Working

<details>
  <summary>Detail</summary>

  ### DESCRIPTION

The core structure of the project is built around modules responsible for accepting inputs, determining which operation to perform, the operations themselves, and displaying the output in simple decimal form. The project operates by allowing a user to input two 2x2 matrices (where each element is of 2 bits) and lets them perform the following operations:

- **Addition (A + B)**:  
  The Addition module computes the sum by adding corresponding elements of matrix A and B.

- **Subtraction (A - B)**:  
  The Subtraction module computes the difference by subtracting the corresponding elements of matrix A and B. It can also return negative outputs by converting the conventional output (2's complement form) into decimal form along with a negative sign by comparing the inputs initially.

- **Multiplication (A × B)**:  
  The Matrix Multiplier module computes the product by following the mathematical formulae for finding the product of two 2x2 matrices.

- **Scalar Multiplication (k × A)**:  
  The Scalar Multiplier module computes the scalar product by multiplying every individual element with the given scalar input.

- **Transpose (A^T)**:  
  The Transpose module computes the transpose of the given matrix (A) by swapping the elements along the right diagonal.

- **Determinant (det(A))**:  
  The Determinant module computes the determinant of the given matrix (A) by following the mathematical formulae for finding the determinant of a 2x2 matrix.

- **Inverse (A^(-1)) (if det(A) ≠ 0)**:  
  The Inverse module computes the inverse of the given matrix (A) by following the mathematical formulae for finding the inverse of a 2x2 matrix, provided the determinant is not zero.

	<p>Wherein the Inverse module computes the inverse of the given matrix (A) by following the mathematical formulae for finding the inverse of a 2x2 matrix if and only if the determinant of the
	given matrix is non - zero. If the determinant is found to be zero, the circuit is programmed to return the values:
	<table border="1" style="border-collapse: collapse;">
          <tr>
            <td>00</td>
            <td>-00</td>
          </tr>
          <tr>
            <td>-00</td>
            <td>00</td>
          </tr>
        </table></p>

  
  ### AN EXAMPLE WITH A TRUTH TABLE
  
  Let the inputs be two 2x2 matrices, with each element represented as a 2-bit binary number:
  
 <table>
    <tr>
      <td>A =</td>
      <td>
        <table border="1" style="border-collapse: collapse;">
          <tr>
            <td>01</td>
            <td>10</td>
          </tr>
          <tr>
            <td>11</td>
            <td>00</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td>B =</td>
      <td>
        <table border="1" style="border-collapse: collapse;">
          <tr>
            <td>10</td>
            <td>11</td>
          </tr>
          <tr>
            <td>00</td>
            <td>01</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

  Note: Each element of the matrices \(A\) and \(B\) can take values from 0 to 3 (i.e., \(00\) to \(11\) in binary).

 The operations performed on these matrices are as follows:

- **000:** Addition (A + B)
- **001:** Subtraction (A - B)
- **010:** Multiplication (A × B)
- **011:** Scalar Multiplication (k × A)
- **100:** Transpose (A^T)
- **101:** Determinant (det(A))
- **110:** Inverse (A^(-1)) (if det(A) ≠ 0)

  ### Truth Tables for Each Operation

  | Control Signal S | $a_{11}$ | $a_{12}$ | $a_{21}$ | $a_{22}$ | $b_{11}$ | $b_{12}$ | $b_{21}$ | $b_{22}$ | Output 1 | Output 2 | Output 3 | Output 4 |
  |-----------------------|------------|------------|------------|------------|------------|------------|------------|------------|----------|----------|----------|----------|
  | 000                   | 01         | 10         | 11         | 00         | 10         | 11         | 00         | 01         | 011      | 101      | 011      | 001      |
  | 001                   | 01         | 10         | 11         | 00         | 10         | 11         | 00         | 01         | 101      | 101      | 11       | 101      |
  | 010                   | 01         | 10         | 11         | 00         | 10         | 11         | 00         | 01         | 011      | 011      | 011      | 001      |
  | 100                   | 01         | 10         | 11         | 00         | -          | -          | -          | -          | 001      | 011      | 010      | 000      |
  | 101                   | 01         | 10         | 11         | 00         | -          | -          | -          | -          | 011      | -        | -        | -        |
  | 110                   | 01         | 10         | 11         | 00         | -          | -          | -          | -          | 000      | 110      | 111      | 001      |

  **Table 1:** Truth Tables for Matrix Addition, Subtraction, Multiplication, and Transpose

| Control Signal $S$ | $a_{11}$ | $a_{12}$ | $a_{21}$ | $a_{22}$ | Scalar $k$ | $k \cdot a_{11}$ | $k \cdot a_{12}$ | $k \cdot a_{21}$ | $k \cdot a_{22}$ |
|--------------------|----------|----------|----------|----------|------------|------------------|------------------|------------------|------------------|
| 011                   | 01         | 10         | 11         | 00         | 10            | 010               | 100               | 110               | 00                |

  **Table 2:** Truth Table for Scalar Multiplication
</details>



<!-- Fourth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Detail</summary>
	<h2>Main</h2>
	<p> The following is the main module with which the user interacts to compute his operations.</p>
  <img src="/Snapshots/S2-T15.png" alt="Logisim Circuit Diagram" style="display: block; margin: 20px auto;">
	<h4> The main submodules are: </h4>
  <h2>Storage</h2>
	<p>The storage module stores the first input set given by the user and allows us to use the same set of switches to give in another separate set of inputs.</p>
	 <img src="/Snapshots/Storage.png" alt="Logisim Circuit Diagram" style="display: block; margin: 20px auto;">
<h2>Adder</h2>
	<p>The Adder module performs the function of addition of two matrices.</p>
	 <img src="/Snapshots/Adder.png" alt="Logisim Circuit Diagram" style="display: block; margin: 20px auto;">
<h2>Subtractor</h2>
	<p>The Subtractor module performs the function of subtracting one matrix from another.</p>
	 <img src="/Snapshots/Subtractor.png" alt="Logisim Circuit Diagram" style="display: block; margin: 20px auto;">
<h2>Matrix Multiplier</h2>
	<p>The Matrix Multiplier module performs the function of Multiplying two matrices.</p>
	 <img src="/Snapshots/MatrixMultiplier.png" alt="Logisim Circuit Diagram" style="display: block; margin: 20px auto;">
<h2>Scalar Multiplier</h2>
	<p>The Scalar Multiplier module performs the function of multiplying a martix with a scalar number.</p>
	 <img src="/Snapshots/ScalarMultiplier.png" alt="Logisim Circuit Diagram" style="display: block; margin: 20px auto;">
<h2>Transpose</h2>
	<p>The Transpose module performs the function of computing the transpose of the input matrix.</p>
	 <img src="/Snapshots/Transpose.png" alt="Logisim Circuit Diagram" style="display: block; margin: 20px auto;">
<h2>Determinant</h2>
	<p>The Determinant module performs the function of computing the Determinant of the input matrix.</p>
	 <img src="/Snapshots/Determinant.png" alt="Logisim Circuit Diagram" style="display: block; margin: 20px auto;">
<h2>Inverse</h2>
	<p>The Inverse module performs the function of computing the inverse of the input matrix.</p>
	 <img src="/Snapshots/Inverse.png" alt="Logisim Circuit Diagram" style="display: block; margin: 20px auto;">
<h2>7-Segment</h2>
	<p>The 7Segment module performs the function of displaying the output binary number in the form of a readable decimal number.</p>
	 <img src="/Snapshots/7Segment.png" alt="Logisim Circuit Diagram" style="display: block; margin: 20px auto;">
</details>

<!-- Fifth Section -->
## Verilog Code
<details>
  <summary>Details</summary>
  <details>
  <summary>Modules</summary>

```verilog
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


```
</details>
<details>
  <summary>TestBench</summary>

```verilog
`timescale 1ns / 1ps
`include "S2-T15.v"

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
```
</details>
<details>
	<summary>Sample Output</summary>
	<img src = "/Snapshots/VerilogSampleOutput.png" alt="Sample output">
</details>
</details>
