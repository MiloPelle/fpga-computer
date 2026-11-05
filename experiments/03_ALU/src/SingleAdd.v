module SingleAdd (
    input  carry_in,
    input  a,
    input  b,
    output sum,
    output carry_out
);
    assign sum = a ^ b ^ carry_in;
    assign carry_out = (a & b) | (a & carry_in) | (b & carry_in);
endmodule