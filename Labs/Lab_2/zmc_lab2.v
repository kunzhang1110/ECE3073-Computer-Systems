module zmc_lab2 (CLOCK_50,KEY,LEDG,LEDR,GPIO_1);

input CLOCK_50;
input [0:0] KEY;
output [0:0] LEDG;
output [2:2] GPIO_1;
output [7:0] LEDR;

assign LEDG[0] = KEY[0];


  Processor_after_generate Processor_after_generate_inst
    (
      .clk_0                     (CLOCK_50),
      .out_port_from_the_FlagPIO (GPIO_1[2:2]),
      .out_port_from_the_LEDPIO  (LEDR[7:0]),
      .reset_n                   (KEY[0])
    );

endmodule