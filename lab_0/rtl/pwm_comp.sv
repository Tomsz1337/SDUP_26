module pwm_comp(

    input logic [31:0] counter,

    input logic [3:0] duty [4],

    input logic polarity,

    output logic [3:0] pwm_out
);

endmodule