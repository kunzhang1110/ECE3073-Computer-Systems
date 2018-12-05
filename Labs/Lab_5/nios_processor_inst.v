  //Example instantiation for system 'nios_processor'
  nios_processor nios_processor_inst
    (
      .clk_0                           (clk_0),
      .in_port_to_the_in_KEY1          (in_port_to_the_in_KEY1),
      .in_port_to_the_in_MSB_interrupt (in_port_to_the_in_MSB_interrupt),
      .reset_n                         (reset_n),
      .rxd_to_the_uart_0               (rxd_to_the_uart_0),
      .txd_from_the_uart_0             (txd_from_the_uart_0)
    );

