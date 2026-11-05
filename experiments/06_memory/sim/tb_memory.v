`timescale 1ns/1ps

module tb_memory;

    // Inputs
    reg clk;
    reg we;
    reg [3:0] addr;
    reg [7:0] data_in;

    // Outputs
    wire [7:0] data_out;

    memory dut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("memory.vcd");
        $dumpvars(0, tb_memory);

        // Test 1: Checking address value
        addr = 4'b0000; we = 0;
        #10;
        $display("Should be 5: %d", data_out);
        $display("");

        //Test 2: Writing
        addr = 4'B0000; we = 0;
        #10;
        $display("Should be 5: %d", data_out);
        we = 1; data_in = 8'b00000001;
        #10;
        $display("Should be 1: %d", data_out);
        $display("");

        $finish;
    end
endmodule