`timescale 1ns/1ps

module tb_program_counter;

    // Inputs
    reg clk;
    reg rst;
    reg jump;
    reg [3:0] jump_address;
    reg incr;

    // Outputs
    wire [3:0] pc_out;

    program_counter dut (
        .clk(clk),
        .rst(rst),
        .jump(jump),
        .jump_address(jump_address),
        .incr(incr),
        .pc_out(pc_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("program_counter.vcd");
        $dumpvars(0, tb_program_counter);

        // Test 1: pc_out jumps to the starting address
        jump = 1; jump_address = 4'd15; rst = 0;
        #10;
        $display("address: %d, rst = %b", pc_out, rst);
        rst = 1;
        #10;
        $display("address: %d, rst = %b", pc_out, rst);
        $display("");
        
        // Test 2: simple increment
        jump = 1; jump_address = 4'd0; rst = 0;
        #10;
        $display("address: %d", pc_out);
        jump = 0; incr = 1;
        #10;
        $display("address: %d", pc_out);
        $display("");

        // Test 3: pc won't change when jump and incr are off
        jump = 1; jump_address = 4'd0;
        #10;
        $display("address: %d", pc_out);
        jump = 0; incr = 1;
        #10;
        $display("address: %d", pc_out);
        jump = 0; incr = 0;
        #10;
        $display("address: %d", pc_out);
        $display("");

        // Test 4: Jump has priority over increment
        jump = 1; jump_address = 4'd2; incr = 1;
        #10;
        $display("address: %d", pc_out);
        $display("");

        // Test 5: Wraps around back to 0000
        jump = 1; jump_address = 4'd15;
        #10;
        jump = 0; incr = 1;
        #10;
        $display("address: %d", pc_out);
        $display("");

        $finish;
    end
endmodule
        