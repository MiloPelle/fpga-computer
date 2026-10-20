module LEDCounter (
    input clk,
    output reg [5:0] led_out = 6'b101010);

    reg [20:0] counter = 20'h0;

    always @(posedge clk) begin
        if (counter == 20'h1) begin
               led_out <= ~led_out;
        end
        counter <= counter + 1;
    end
endmodule