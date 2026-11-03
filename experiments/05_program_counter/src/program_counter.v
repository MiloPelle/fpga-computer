module program_counter (
    input clk,
    input rst,
    input jump,
    input [3:0] jump_address
    input incr
    output reg [3:0] pc_out
);
    always @(posedge clk) begin
        if (rst) begin
            pc_out <= 4'h0; // Reset the program counter to 0
        end else if (jump) begin
            pc_out <= jump_address; // Jump to the specified address
        end else if (incr) begin
            pc_out <= pc_out + 1; // Increment the program counter
        end
    end
endmodule