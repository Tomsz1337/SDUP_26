module pwm_core #(
    parameter CLK_FREQ = 100_000_000,
    parameter PWM_FREQ = 50
)(
    input   logic clk,
    input   logic rst_n,
    input   logic [3:0] channel_id,   
    input   logic [3:0] duty,         
    input   logic       align_mode,   
    input   logic       polarity_mode, 
    output  logic [3:0] pwm_out      
);

localparam PERIOD = CLK_FREQ / PWM_FREQ;
localparam CNT_W  = $clog2(PERIOD);

logic [CNT_W-1:0] counter;
logic dir;
logic pwm_raw;
logic [CNT_W-1:0] threshold;

always_ff @(posedge clk) begin
    if(!rst_n) begin
        counter <= '0;
        dir <= 0;
        pwm_raw <= 0;
    end
    else begin
        if(!align_mode) begin
            counter <= (counter == PERIOD-1) ? 0 : counter + 1;
        end 
        else begin
            if(!dir) begin
                counter <= counter + 1;
                if(counter == PERIOD-1) 
                    dir <= 1;
            end 
            else begin
                counter <= counter - 1;
                if(counter == 0) dir <= 0;
            end
        end
    end 
end

assign threshold = (PERIOD * duty) / 10;

always_comb begin

    if(channel_id != 0) begin
        if(align_mode) begin
            if(!dir) pwm_raw = (counter < threshold);
            else      pwm_raw = (counter > (PERIOD - threshold));
        end else begin
            pwm_raw = (counter < threshold);
        end
    end
end

assign pwm_out = polarity_mode ? (pwm_raw ? channel_id : 0) : (~pwm_raw ? channel_id : 0);

endmodule