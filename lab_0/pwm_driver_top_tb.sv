`timescale 1ns/1ps

module pwm_driver_top_tb;

logic clk;
logic rst_n;
logic [3:0] BTN;
logic [5:0] SW;

logic [3:0] PWM_OUT;

pwm_driver_top dut (
    .CLK     (clk),
    .RST_N   (rst_n),
    .BTN     (BTN),
    .SW      (SW),
    .PWM_OUT (PWM_OUT)
);

initial begin : clk_proc
    clk = '0;
    forever begin
      #100 clk = ~clk;
    end
end

initial begin : cfg_proc
    SW <= '0;
    BTN <= '0;
end

initial begin
    rst_n     <= '0;
    #100 rst_n <= 1;
    SW[3] <=1;
    #100
    BTN[1] <= 1;
    #200
    BTN[1] <= 0;
    #2000
    BTN[2] <= 1;
    #200
    BTN[2] <= 0;
    #200_000
    $finish;
end

endmodule