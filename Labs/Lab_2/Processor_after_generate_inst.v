  //Example instantiation for system 'Processor_after_generate'
  Processor_after_generate Processor_after_generate_inst
    (
      .clk_0                     (clk_0),
      .out_port_from_the_FlagPIO (out_port_from_the_FlagPIO),
      .out_port_from_the_LEDPIO  (out_port_from_the_LEDPIO),
      .reset_n                   (reset_n)
    );

