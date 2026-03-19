module pwm_cfg(

    input   logic clk,
    input   logic [3:0] btn,
    input   logic [5:0] sw,   

    output  logic [3:0] selected_channel,
    output  logic       align_mode,
    output  logic       polarity_mode,
    output  logic [3:0] duty;
);

logic [5:0] sw_sync;
logic [3:0] channel_reg;

always_ff @(posedge clk) begin

    case(1'b1)
        btn[0]: channel_reg <= 4'b0001;
        btn[1]: channel_reg <= 4'b0010;
        btn[2]: channel_reg <= 4'b0100;
        btn[3]: channel_reg <= 4'b1000;
        default;
    endcase
end

always_ff @(posedge clk) begin
    sw_sync <= sw;
end

assign selected_channel = channel_reg;
assign align_mode = sw_sync[5];
assign polarity_mode = sw_sync[4];
assign duty = sw_sync[3:0];


endmodule