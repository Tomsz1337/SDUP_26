module debounce#(
    parameter CLK_FREQ = 50_000_000,   
    parameter DEBOUNCE_TIME_MS = 20
)(
    input   logic clk,
    input   logic rst_n,
    input   logic btn_in,

    output  logic btn_out
);

localparam COUNTER_MAX = (CLK_FREQ / 1000) * DEBOUNCE_TIME_MS;
localparam COUNTER_WIDTH = $clog2(COUNTER_MAX + 1);

logic sync1, sync2;
logic counter [COUNTER_WIDTH-1:0];

always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        sync1 <= '0;
        sync2 <= '0;
    end
    else begin
        sync1 <= btn_in;
        sync2 <= sync1;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        counter <= '0;
        btn_out <= 1'b0;
    end
    else begin
        if(sync2 != btn_out) begin
            counter = counter + 1;
            if(counter >= COUNTER_MAX) begin
                btn_out <= sync2;
                counter <= 0;
            end
        end
        else begin
            counter <= 0;
        end
    end
end
endmodule
