module pwm_cfg(

    input  logic clk,

    input  logic [1:0] selected_channel,
    input  logic [3:0] duty_sw,
    input  logic write_btn,

    input  logic align_sw,
    input  logic polarity_sw,

    output logic [3:0] duty [4],

    output logic align_mode,
    output logic polarity
);

endmodule