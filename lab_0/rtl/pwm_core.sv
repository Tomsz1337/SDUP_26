module pwm_core #(
    parameter CLK_FREQ = 100_000_000,
    parameter PWM_FREQ = 50
)(
    input   logic clk,

    input   logic [3:0] channel_id,   
    input   logic [3:0] duty,
    input   logic       align_mode,
    input   logic       polarity_mode,

    output  logic pwm_out
);

localparam  PERIOD = CLK_FREQ / PWM_FREQ;
localparam  CNT_W = $clog2(PERIOD);

logic [CNT_W-1:0] counter;
logic dir;

always_ff @(posedge clk) begin
    
    if(!align_mode) begin
        counter <= (counter == PERIOD-1) ? 0 : counter + 1;
    end
    else begin
        if(!dir) begin
            if(counter == PERIOD-1) dir <= 1;
            else counter <= counter + 1;
        end
        else begin
            if(counter == 0) dir <= 0;
            else counter <= counter - 1;
        end
    end
end

logic [CNT_W-1:0] threshold;
assign threshold = (PERIOD * duty) / 10;

logic pwm_raw;
assign pwm_raw = (counter < threshold);
logic pwm_pol;
assign pwm_pol = active_low ? ~pwm_raw : pwm_raw;
assign pwm_out = {4{pwm_pol}} & channel_id;

endmodule
