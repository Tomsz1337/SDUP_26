`timescale 1ns/1ps

module pwm_driver_top_tb;

logic clk = 0;

logic [3:0] BTN = '0;
logic [5:0] SW = '0;

logic [3:0] PWM_OUT;

pwm_driver_top dut (
    .CLK     (clk),
    .BTN     (BTN),
    .SW      (SW),
    .PWM_OUT (PWM_OUT)
);

always #500 clk = ~clk;

initial begin
    SW = 6'b000101;
    BTN = 4'b0001;
    #2000
    BTN =4'b0;
    #2_000_000
    SW = 6'b100101;
    BTN =4'b0010;
    
    #2_000_000
    $finish;
end

endmodule