module pwm_counter #(

    parameter CLK_FREQ = 50_000_000

)(

    input logic clk,
    input logic align_mode,

    output logic [31:0] counter
);

endmodule