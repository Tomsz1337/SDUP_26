module btn_debouncer(

    input   logic clk,
    input   logic rst_n; 
    input   logic [3:0] btn,

    output  logic [3:0] btn_db
);

generate
    for(genvar i = 0; i<4; i++) 
endgenerate

endmodule