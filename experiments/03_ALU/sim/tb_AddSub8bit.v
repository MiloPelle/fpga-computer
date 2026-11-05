`timescale 1ns/1ps          // time units: #1 = 1 nanosecond

module tb_AddSub8Bit;       // no ports: nothing connects to a testbench

    // Inputs you control → reg (you assign them in the initial block)
    reg  [7:0] a, b;
    reg        sub;

    // Outputs you watch → wire (the ALU drives them)
    wire [7:0] result;
    wire       carry;
    wire zero;

    // The design under test, often called "dut"
    AddSub8Bit dut (
    .a(a), .b(b), .sub(sub),
    .result(result),
    .carry_out(carry),      // ALU's port name . (testbench's wire name)
    .zero_flag(zero)
    );

    initial begin
        $dumpfile("alu.vcd");          // record every signal for GTKWave
        $dumpvars(0, tb_AddSub8Bit);

        // Test 1: 7 + 3
        a = 8'd7; b = 8'd3; sub = 0;
        #10;                           // wait for the logic to settle
        $display("7 + 3 = %d, carry = %b", result, carry);

        // Test 2: 7 - 3
        a = 8'd7; b = 8'd3; sub = 1;
        #10;
        $display("7 - 3 = %d, carry = %b", result, carry);

        // Test 3: 3 - 7
        a = 8'd3; b = 8'd7; sub = 1;
        #10;
        $display("3 - 7 = %d, carry = %b", result, carry);

        // Test 4: 200 + 100
        a = 8'd200; b = 8'd100; sub = 0;
        #10;
        $display("200 + 100 = %d, carry = %b", result, carry);

        // Test 5: 128 + 128
        a = 8'd128; b = 8'd128; sub = 0;
        #10;
        $display("128 + 128 = %d, carry = %b", result, carry);

        $finish;                       // end the simulation
    end
endmodule