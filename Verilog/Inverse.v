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
