module memory (
    input clk,
    input we,
    input [3:0] addr, 
    input [7:0] data_in,
    output [7:0] data_out
);

    reg [7:0] mem [15:0];
    initial begin
        $readmemh("../src/program.hex", mem);
    end

    always @(posedge clk) begin
        if (we) begin
            mem[addr] <= data_in;
        end
    end

    assign data_out = mem[addr];
endmodule