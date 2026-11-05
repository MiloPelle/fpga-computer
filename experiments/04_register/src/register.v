module register(
    input clk,
    input rst,
    input [7:0] data_in,
    input load,
    output reg [7:0] data_out
);
    always @(posedge clk) begin
        if (rst) begin
            data_out <= 8'b0; // Reset the register to 0
        end else if (load) begin
            data_out <= data_in; // Load new data into the register
        end
    end
endmodule