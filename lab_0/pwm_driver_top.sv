`timescale 1ps/1ps
//-----------------------------------------------------------------------------
// 4 Channel PWM driver 
//-----------------------------------------------------------------------------
module pwm_driver_top (
	// inputs
	input logic CLK,
	input logic [5 : 0] SW,
    input logic [3 : 0] BTN,
	// outputs
	output logic [3 : 0] PWM_OUT
);

// logic here
logic [3:0] btn_db;

debouncer #(
	.CLK_FREQ (100_000_000),
	.DEBOUNCE_TIME_MS (0)
) u_debouncer (
	.clk	(CLK),
	.btn_in	(BTN),
	.btn_out(btn_db)
);

logic [3:0] channel_id;
logic		align_mode;
logic		polarity_mode;
logic [3:0] duty;

pwm_cfg u_pwm_cfg (
	.clk(CLK),
	.btn(btn_db),
	.sw(SW),
	.selected_channel(channel_id),
	.align_mode(align_mode),
	.polarity_mode(polarity_mode),
	.duty(duty)
);

pwm_core #(
	.CLK_FREQ (100_000_000),
	.PWM_FREQ (10_000_000)
) u_pwm_core (
	.clk(CLK),
	.channel_id(channel_id),
	.duty(duty),
	.align_mode(align_mode),
	.polarity_mode(polarity_mode),
	.pwm_out(PWM_OUT)
);

endmodule