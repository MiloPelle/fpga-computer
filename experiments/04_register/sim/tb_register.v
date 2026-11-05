`timescale 1ns/1ps          // time units: #1 = 1 nanosecond

module tb_register;

    // Inputs
    reg clk;
    reg rst;
    reg [7:0] data_in;
    reg load;

    // Outputs
    wire [7:0] data_out;
    
    // Linking test variables to a method
    register dut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .load(load),
        .data_out(data_out)
    );

    initial clk = 0; // creating a clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("register.vcd");
        $dumpvars(0, tb_register);

        // Test 1: output becomes 0 on rst
        data_in = 8'd1; load = 1; rst = 0;
        #10; // wait for logic to reset
        $display("data_out = %d, rst = %b", data_out, rst);
        rst = 1;
        #10; // wait for rst
        $display("data_in = %d, rst = %b", data_out, rst);
        $display("");

        // Test 2: with load on, output takes data_in on next clock tick
        data_in = 8'd1; load = 1; rst = 0;
        #10; // wait for logic to reset
        $display("data_in = %d, load = %b", data_out, load);
        $display("");

        // Test 3: with load off, data keeps its original value
        data_in = 8'd1; load = 1; rst = 0;
        #10; // wait for logic to reset
        $display("data_in = %d, load = %b", data_out, load);
        data_in = 8'd2; load = 0; rst = 0;
        #10;
        $display("data_in = %d, load = %b", data_out, load);
        $display("");

        // Test 4: rst had priority over load when both on
        data_in = 8'd1; load = 1; rst = 1;
        #10; // wait for logic to reset
        $display("data_in = %d, load = %b, rst = %b", data_out, load, rst);
        $display("");

        $finish;
    end
endmodule