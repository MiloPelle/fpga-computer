module LEDCounter (
    input wire clk,
    output [5:0] led_out);

    reg [5:0] led_outFlip = 6'h0;
    reg [25:0] counter = 26'h0;

    always @(posedge clk) begin
        if (counter == 26'h1) begin
            led_outFlip <= led_outFlip + 1;
        end
        counter <= counter + 1;
    end
    assign led_out = ~led_outFlip;
endmodule