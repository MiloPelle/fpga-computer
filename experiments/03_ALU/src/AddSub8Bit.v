module AddSub8Bit (
    input [7:0] a,
    input [7:0] b,
    input sub,
    output [7:0] result,
    output carry_out,
    output zero_flag
);
    wire [8:0] carry;
    assign carry[0] = sub; // Set the initial carry-in based on the sub input
    wire [7:0] b_flipped = b ^ {8{sub}}; // XOR b with sub to perform subtraction when sub is 1
    
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : add_sub_loop
            SingleAdd add_sub_unit (
                .carry_in(carry[i]),
                .a(a[i]),
                .b(b_flipped[i]),
                .sum(result[i]),
                .carry_out(carry[i + 1])
            );
        end
    endgenerate

    assign carry_out = carry[8]; // The final carry-out after the last addition/subtraction
    assign zero_flag = (result == 8'b00000000); // Set zero flag if result is zero
endmodule