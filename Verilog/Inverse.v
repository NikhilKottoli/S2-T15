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
