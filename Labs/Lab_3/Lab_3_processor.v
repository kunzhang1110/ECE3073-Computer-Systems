module Lab_3_processor (CLOCK_50,KEY,LEDR,LEDG,GPIO_1);

input CLOCK_50;
input [1:0] KEY;
output [7:0] LEDR;
output [1:0] LEDG;
output [12:2] GPIO_1;
reg [19:0] count;

always @ (posedge CLOCK_50)
begin
count = count + 1;
end
	 assign GPIO_1[2:2] = count[19];
	 assign LEDG[0] = ~KEY[0];

  Lab_3_Nios_processor Lab_3_Nios_processor_inst
    (
      .clk_0                             (CLOCK_50),
      .in_port_to_the_IN_MSB_1_bit       (count[19]),
      .in_port_to_the_KEY1_1_bit         (KEY[1]),
      .out_port_from_the_FLAG_1_bit      (GPIO_1[12:12]),
      .out_port_from_the_LEDG_1_bit      (LEDG[1]),
      .out_port_from_the_OUT_LEDR_8_Bits (LEDR[7:0]),
      .reset_n                           (KEY[0])
    );

endmodule