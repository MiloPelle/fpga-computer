module stepButton(
    input clk,
    input button1,
    output [5:0] led_out
);
    reg [5:0] led_swap = 6'b010101;
    reg  clean = 1'b0;

    //counter
    reg [19:0] counter = 20'd0;

    //Synchronizer
    reg btn_sync1 = 1'b0;
    reg btn_sync2 = 1'b0;

    //debouncer
    reg debouncer = 1'b0;

    always @(posedge clk) begin
        btn_sync1 <= button1;
        btn_sync2 <= btn_sync1;

        if (counter == 20'd540000) begin
            counter <= 20'd0;
            debouncer <= btn_sync2;
        end else begin
            counter <= counter + 1;
        end
    end

    //edge detector
    always @(posedge clk) begin
        if (debouncer == 1'b1 && clean == 1'b1) begin
            led_swap <= ~led_swap;
            clean <= 1'b0;
        end else if (debouncer == 1'b0) begin
            clean <= 1'b1;
        end
    end
    assign led_out = led_swap;
endmodule