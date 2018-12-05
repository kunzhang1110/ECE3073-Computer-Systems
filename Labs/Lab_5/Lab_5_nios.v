module Lab_5_nios (CLOCK_50,KEY,LEDG,UART_RXD,UART_TXD);

input wire CLOCK_50;
input wire [1:0] KEY;
input wire UART_RXD;
output wire UART_TXD;
output wire [1:0] LEDG;
reg [19:0] count;


always @ (posedge CLOCK_50)
begin
count = count + 1;
end

	 assign LEDG[0] = ~KEY[0];

  nios_processor nios_processor_inst
    (
      //.UART_RXD_to_the_rs232_0            (UART_RXD),
      //.UART_TXD_from_the_rs232_0          (UART_TXD),
		.clk_0                            	(CLOCK_50),
      .in_port_to_the_in_KEY1         		(KEY[1]),		
      .in_port_to_the_in_MSB_interrupt    (count[19]),
      .reset_n                         	(KEY[0]),
		.rxd_to_the_uart_0              		(UART_RXD),
      .txd_from_the_uart_0           		(UART_TXD)
    );

endmodule