module debouncer#(
    parameter CLK_FREQ = 100_000_000,   
    parameter DEBOUNCE_TIME_MS = 5
)(
    input   logic clk,
    input   logic [3:0] btn_in,

    output  logic [3:0] btn_out = 4'b0
);

localparam COUNTER_MAX = (CLK_FREQ / 1000) * DEBOUNCE_TIME_MS;
localparam COUNTER_WIDTH = $clog2(COUNTER_MAX + 1);

logic [3:0] sync1 = 0;
logic [3:0] sync2 = 0;
logic [COUNTER_WIDTH-1:0] counter [3:0]; 
initial begin
    for (int i = 0; i < 4; i++)
        counter[i] = 0;
end

always_ff @(posedge clk) begin
    sync1 <= btn_in;
    sync2 <= sync1;
end

always_ff @(posedge clk) begin
    for(int i=0;i<4;i++) begin
        if(sync2[i] != btn_out[i]) begin
            counter[i] <= counter[i] + 1;
            if(counter[i] >= COUNTER_MAX) begin
                btn_out[i] <= sync2[i];
                counter[i] <= 0;
            end
        end
        else begin
            counter[i] <= 0;
        end
    end
end

endmodule