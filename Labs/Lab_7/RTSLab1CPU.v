//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


//Legal Notice: (C)2013 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX0_s1_arbitrator (
                            // inputs:
                             HEX0_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX0_s1_address,
                             HEX0_s1_chipselect,
                             HEX0_s1_readdata_from_sa,
                             HEX0_s1_reset_n,
                             HEX0_s1_write_n,
                             HEX0_s1_writedata,
                             cpu_0_data_master_granted_HEX0_s1,
                             cpu_0_data_master_qualified_request_HEX0_s1,
                             cpu_0_data_master_read_data_valid_HEX0_s1,
                             cpu_0_data_master_requests_HEX0_s1,
                             d1_HEX0_s1_end_xfer
                          )
;

  output  [  1: 0] HEX0_s1_address;
  output           HEX0_s1_chipselect;
  output  [  6: 0] HEX0_s1_readdata_from_sa;
  output           HEX0_s1_reset_n;
  output           HEX0_s1_write_n;
  output  [  6: 0] HEX0_s1_writedata;
  output           cpu_0_data_master_granted_HEX0_s1;
  output           cpu_0_data_master_qualified_request_HEX0_s1;
  output           cpu_0_data_master_read_data_valid_HEX0_s1;
  output           cpu_0_data_master_requests_HEX0_s1;
  output           d1_HEX0_s1_end_xfer;
  input   [  6: 0] HEX0_s1_readdata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX0_s1_address;
  wire             HEX0_s1_allgrants;
  wire             HEX0_s1_allow_new_arb_cycle;
  wire             HEX0_s1_any_bursting_master_saved_grant;
  wire             HEX0_s1_any_continuerequest;
  wire             HEX0_s1_arb_counter_enable;
  reg     [  1: 0] HEX0_s1_arb_share_counter;
  wire    [  1: 0] HEX0_s1_arb_share_counter_next_value;
  wire    [  1: 0] HEX0_s1_arb_share_set_values;
  wire             HEX0_s1_beginbursttransfer_internal;
  wire             HEX0_s1_begins_xfer;
  wire             HEX0_s1_chipselect;
  wire             HEX0_s1_end_xfer;
  wire             HEX0_s1_firsttransfer;
  wire             HEX0_s1_grant_vector;
  wire             HEX0_s1_in_a_read_cycle;
  wire             HEX0_s1_in_a_write_cycle;
  wire             HEX0_s1_master_qreq_vector;
  wire             HEX0_s1_non_bursting_master_requests;
  wire    [  6: 0] HEX0_s1_readdata_from_sa;
  reg              HEX0_s1_reg_firsttransfer;
  wire             HEX0_s1_reset_n;
  reg              HEX0_s1_slavearbiterlockenable;
  wire             HEX0_s1_slavearbiterlockenable2;
  wire             HEX0_s1_unreg_firsttransfer;
  wire             HEX0_s1_waits_for_read;
  wire             HEX0_s1_waits_for_write;
  wire             HEX0_s1_write_n;
  wire    [  6: 0] HEX0_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX0_s1;
  wire             cpu_0_data_master_qualified_request_HEX0_s1;
  wire             cpu_0_data_master_read_data_valid_HEX0_s1;
  wire             cpu_0_data_master_requests_HEX0_s1;
  wire             cpu_0_data_master_saved_grant_HEX0_s1;
  reg              d1_HEX0_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 19: 0] shifted_address_to_HEX0_s1_from_cpu_0_data_master;
  wire             wait_for_HEX0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX0_s1_end_xfer;
    end


  assign HEX0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX0_s1));
  //assign HEX0_s1_readdata_from_sa = HEX0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX0_s1_readdata_from_sa = HEX0_s1_readdata;

  assign cpu_0_data_master_requests_HEX0_s1 = ({cpu_0_data_master_address_to_slave[19 : 4] , 4'b0} == 20'h81030) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX0_s1_arb_share_counter set values, which is an e_mux
  assign HEX0_s1_arb_share_set_values = 1;

  //HEX0_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX0_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX0_s1;

  //HEX0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX0_s1_any_bursting_master_saved_grant = 0;

  //HEX0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX0_s1_arb_share_counter_next_value = HEX0_s1_firsttransfer ? (HEX0_s1_arb_share_set_values - 1) : |HEX0_s1_arb_share_counter ? (HEX0_s1_arb_share_counter - 1) : 0;

  //HEX0_s1_allgrants all slave grants, which is an e_mux
  assign HEX0_s1_allgrants = |HEX0_s1_grant_vector;

  //HEX0_s1_end_xfer assignment, which is an e_assign
  assign HEX0_s1_end_xfer = ~(HEX0_s1_waits_for_read | HEX0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX0_s1 = HEX0_s1_end_xfer & (~HEX0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX0_s1 & HEX0_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX0_s1 & ~HEX0_s1_non_bursting_master_requests);

  //HEX0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX0_s1_arb_share_counter <= 0;
      else if (HEX0_s1_arb_counter_enable)
          HEX0_s1_arb_share_counter <= HEX0_s1_arb_share_counter_next_value;
    end


  //HEX0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX0_s1_slavearbiterlockenable <= 0;
      else if ((|HEX0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX0_s1) | (end_xfer_arb_share_counter_term_HEX0_s1 & ~HEX0_s1_non_bursting_master_requests))
          HEX0_s1_slavearbiterlockenable <= |HEX0_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX0/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX0_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX0_s1_slavearbiterlockenable2 = |HEX0_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX0_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX0_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX0_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX0_s1 = cpu_0_data_master_requests_HEX0_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX0_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX0_s1 = cpu_0_data_master_granted_HEX0_s1 & cpu_0_data_master_read & ~HEX0_s1_waits_for_read;

  //HEX0_s1_writedata mux, which is an e_mux
  assign HEX0_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX0_s1 = cpu_0_data_master_qualified_request_HEX0_s1;

  //cpu_0/data_master saved-grant HEX0/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX0_s1 = cpu_0_data_master_requests_HEX0_s1;

  //allow new arb cycle for HEX0/s1, which is an e_assign
  assign HEX0_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX0_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX0_s1_master_qreq_vector = 1;

  //HEX0_s1_reset_n assignment, which is an e_assign
  assign HEX0_s1_reset_n = reset_n;

  assign HEX0_s1_chipselect = cpu_0_data_master_granted_HEX0_s1;
  //HEX0_s1_firsttransfer first transaction, which is an e_assign
  assign HEX0_s1_firsttransfer = HEX0_s1_begins_xfer ? HEX0_s1_unreg_firsttransfer : HEX0_s1_reg_firsttransfer;

  //HEX0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX0_s1_unreg_firsttransfer = ~(HEX0_s1_slavearbiterlockenable & HEX0_s1_any_continuerequest);

  //HEX0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX0_s1_reg_firsttransfer <= 1'b1;
      else if (HEX0_s1_begins_xfer)
          HEX0_s1_reg_firsttransfer <= HEX0_s1_unreg_firsttransfer;
    end


  //HEX0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX0_s1_beginbursttransfer_internal = HEX0_s1_begins_xfer;

  //~HEX0_s1_write_n assignment, which is an e_mux
  assign HEX0_s1_write_n = ~(cpu_0_data_master_granted_HEX0_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX0_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX0_s1_address mux, which is an e_mux
  assign HEX0_s1_address = shifted_address_to_HEX0_s1_from_cpu_0_data_master >> 2;

  //d1_HEX0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX0_s1_end_xfer <= 1;
      else 
        d1_HEX0_s1_end_xfer <= HEX0_s1_end_xfer;
    end


  //HEX0_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX0_s1_waits_for_read = HEX0_s1_in_a_read_cycle & HEX0_s1_begins_xfer;

  //HEX0_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX0_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX0_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX0_s1_in_a_read_cycle;

  //HEX0_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX0_s1_waits_for_write = HEX0_s1_in_a_write_cycle & 0;

  //HEX0_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX0_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX0_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX0_s1_in_a_write_cycle;

  assign wait_for_HEX0_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX1_s1_arbitrator (
                            // inputs:
                             HEX1_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX1_s1_address,
                             HEX1_s1_chipselect,
                             HEX1_s1_readdata_from_sa,
                             HEX1_s1_reset_n,
                             HEX1_s1_write_n,
                             HEX1_s1_writedata,
                             cpu_0_data_master_granted_HEX1_s1,
                             cpu_0_data_master_qualified_request_HEX1_s1,
                             cpu_0_data_master_read_data_valid_HEX1_s1,
                             cpu_0_data_master_requests_HEX1_s1,
                             d1_HEX1_s1_end_xfer
                          )
;

  output  [  1: 0] HEX1_s1_address;
  output           HEX1_s1_chipselect;
  output  [  6: 0] HEX1_s1_readdata_from_sa;
  output           HEX1_s1_reset_n;
  output           HEX1_s1_write_n;
  output  [  6: 0] HEX1_s1_writedata;
  output           cpu_0_data_master_granted_HEX1_s1;
  output           cpu_0_data_master_qualified_request_HEX1_s1;
  output           cpu_0_data_master_read_data_valid_HEX1_s1;
  output           cpu_0_data_master_requests_HEX1_s1;
  output           d1_HEX1_s1_end_xfer;
  input   [  6: 0] HEX1_s1_readdata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX1_s1_address;
  wire             HEX1_s1_allgrants;
  wire             HEX1_s1_allow_new_arb_cycle;
  wire             HEX1_s1_any_bursting_master_saved_grant;
  wire             HEX1_s1_any_continuerequest;
  wire             HEX1_s1_arb_counter_enable;
  reg     [  1: 0] HEX1_s1_arb_share_counter;
  wire    [  1: 0] HEX1_s1_arb_share_counter_next_value;
  wire    [  1: 0] HEX1_s1_arb_share_set_values;
  wire             HEX1_s1_beginbursttransfer_internal;
  wire             HEX1_s1_begins_xfer;
  wire             HEX1_s1_chipselect;
  wire             HEX1_s1_end_xfer;
  wire             HEX1_s1_firsttransfer;
  wire             HEX1_s1_grant_vector;
  wire             HEX1_s1_in_a_read_cycle;
  wire             HEX1_s1_in_a_write_cycle;
  wire             HEX1_s1_master_qreq_vector;
  wire             HEX1_s1_non_bursting_master_requests;
  wire    [  6: 0] HEX1_s1_readdata_from_sa;
  reg              HEX1_s1_reg_firsttransfer;
  wire             HEX1_s1_reset_n;
  reg              HEX1_s1_slavearbiterlockenable;
  wire             HEX1_s1_slavearbiterlockenable2;
  wire             HEX1_s1_unreg_firsttransfer;
  wire             HEX1_s1_waits_for_read;
  wire             HEX1_s1_waits_for_write;
  wire             HEX1_s1_write_n;
  wire    [  6: 0] HEX1_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX1_s1;
  wire             cpu_0_data_master_qualified_request_HEX1_s1;
  wire             cpu_0_data_master_read_data_valid_HEX1_s1;
  wire             cpu_0_data_master_requests_HEX1_s1;
  wire             cpu_0_data_master_saved_grant_HEX1_s1;
  reg              d1_HEX1_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX1_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 19: 0] shifted_address_to_HEX1_s1_from_cpu_0_data_master;
  wire             wait_for_HEX1_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX1_s1_end_xfer;
    end


  assign HEX1_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX1_s1));
  //assign HEX1_s1_readdata_from_sa = HEX1_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX1_s1_readdata_from_sa = HEX1_s1_readdata;

  assign cpu_0_data_master_requests_HEX1_s1 = ({cpu_0_data_master_address_to_slave[19 : 4] , 4'b0} == 20'h81040) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX1_s1_arb_share_counter set values, which is an e_mux
  assign HEX1_s1_arb_share_set_values = 1;

  //HEX1_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX1_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX1_s1;

  //HEX1_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX1_s1_any_bursting_master_saved_grant = 0;

  //HEX1_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX1_s1_arb_share_counter_next_value = HEX1_s1_firsttransfer ? (HEX1_s1_arb_share_set_values - 1) : |HEX1_s1_arb_share_counter ? (HEX1_s1_arb_share_counter - 1) : 0;

  //HEX1_s1_allgrants all slave grants, which is an e_mux
  assign HEX1_s1_allgrants = |HEX1_s1_grant_vector;

  //HEX1_s1_end_xfer assignment, which is an e_assign
  assign HEX1_s1_end_xfer = ~(HEX1_s1_waits_for_read | HEX1_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX1_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX1_s1 = HEX1_s1_end_xfer & (~HEX1_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX1_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX1_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX1_s1 & HEX1_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX1_s1 & ~HEX1_s1_non_bursting_master_requests);

  //HEX1_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX1_s1_arb_share_counter <= 0;
      else if (HEX1_s1_arb_counter_enable)
          HEX1_s1_arb_share_counter <= HEX1_s1_arb_share_counter_next_value;
    end


  //HEX1_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX1_s1_slavearbiterlockenable <= 0;
      else if ((|HEX1_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX1_s1) | (end_xfer_arb_share_counter_term_HEX1_s1 & ~HEX1_s1_non_bursting_master_requests))
          HEX1_s1_slavearbiterlockenable <= |HEX1_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX1/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX1_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX1_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX1_s1_slavearbiterlockenable2 = |HEX1_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX1/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX1_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX1_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX1_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX1_s1 = cpu_0_data_master_requests_HEX1_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX1_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX1_s1 = cpu_0_data_master_granted_HEX1_s1 & cpu_0_data_master_read & ~HEX1_s1_waits_for_read;

  //HEX1_s1_writedata mux, which is an e_mux
  assign HEX1_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX1_s1 = cpu_0_data_master_qualified_request_HEX1_s1;

  //cpu_0/data_master saved-grant HEX1/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX1_s1 = cpu_0_data_master_requests_HEX1_s1;

  //allow new arb cycle for HEX1/s1, which is an e_assign
  assign HEX1_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX1_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX1_s1_master_qreq_vector = 1;

  //HEX1_s1_reset_n assignment, which is an e_assign
  assign HEX1_s1_reset_n = reset_n;

  assign HEX1_s1_chipselect = cpu_0_data_master_granted_HEX1_s1;
  //HEX1_s1_firsttransfer first transaction, which is an e_assign
  assign HEX1_s1_firsttransfer = HEX1_s1_begins_xfer ? HEX1_s1_unreg_firsttransfer : HEX1_s1_reg_firsttransfer;

  //HEX1_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX1_s1_unreg_firsttransfer = ~(HEX1_s1_slavearbiterlockenable & HEX1_s1_any_continuerequest);

  //HEX1_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX1_s1_reg_firsttransfer <= 1'b1;
      else if (HEX1_s1_begins_xfer)
          HEX1_s1_reg_firsttransfer <= HEX1_s1_unreg_firsttransfer;
    end


  //HEX1_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX1_s1_beginbursttransfer_internal = HEX1_s1_begins_xfer;

  //~HEX1_s1_write_n assignment, which is an e_mux
  assign HEX1_s1_write_n = ~(cpu_0_data_master_granted_HEX1_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX1_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX1_s1_address mux, which is an e_mux
  assign HEX1_s1_address = shifted_address_to_HEX1_s1_from_cpu_0_data_master >> 2;

  //d1_HEX1_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX1_s1_end_xfer <= 1;
      else 
        d1_HEX1_s1_end_xfer <= HEX1_s1_end_xfer;
    end


  //HEX1_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX1_s1_waits_for_read = HEX1_s1_in_a_read_cycle & HEX1_s1_begins_xfer;

  //HEX1_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX1_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX1_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX1_s1_in_a_read_cycle;

  //HEX1_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX1_s1_waits_for_write = HEX1_s1_in_a_write_cycle & 0;

  //HEX1_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX1_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX1_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX1_s1_in_a_write_cycle;

  assign wait_for_HEX1_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX1/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX2_s1_arbitrator (
                            // inputs:
                             HEX2_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX2_s1_address,
                             HEX2_s1_chipselect,
                             HEX2_s1_readdata_from_sa,
                             HEX2_s1_reset_n,
                             HEX2_s1_write_n,
                             HEX2_s1_writedata,
                             cpu_0_data_master_granted_HEX2_s1,
                             cpu_0_data_master_qualified_request_HEX2_s1,
                             cpu_0_data_master_read_data_valid_HEX2_s1,
                             cpu_0_data_master_requests_HEX2_s1,
                             d1_HEX2_s1_end_xfer
                          )
;

  output  [  1: 0] HEX2_s1_address;
  output           HEX2_s1_chipselect;
  output  [  6: 0] HEX2_s1_readdata_from_sa;
  output           HEX2_s1_reset_n;
  output           HEX2_s1_write_n;
  output  [  6: 0] HEX2_s1_writedata;
  output           cpu_0_data_master_granted_HEX2_s1;
  output           cpu_0_data_master_qualified_request_HEX2_s1;
  output           cpu_0_data_master_read_data_valid_HEX2_s1;
  output           cpu_0_data_master_requests_HEX2_s1;
  output           d1_HEX2_s1_end_xfer;
  input   [  6: 0] HEX2_s1_readdata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX2_s1_address;
  wire             HEX2_s1_allgrants;
  wire             HEX2_s1_allow_new_arb_cycle;
  wire             HEX2_s1_any_bursting_master_saved_grant;
  wire             HEX2_s1_any_continuerequest;
  wire             HEX2_s1_arb_counter_enable;
  reg     [  1: 0] HEX2_s1_arb_share_counter;
  wire    [  1: 0] HEX2_s1_arb_share_counter_next_value;
  wire    [  1: 0] HEX2_s1_arb_share_set_values;
  wire             HEX2_s1_beginbursttransfer_internal;
  wire             HEX2_s1_begins_xfer;
  wire             HEX2_s1_chipselect;
  wire             HEX2_s1_end_xfer;
  wire             HEX2_s1_firsttransfer;
  wire             HEX2_s1_grant_vector;
  wire             HEX2_s1_in_a_read_cycle;
  wire             HEX2_s1_in_a_write_cycle;
  wire             HEX2_s1_master_qreq_vector;
  wire             HEX2_s1_non_bursting_master_requests;
  wire    [  6: 0] HEX2_s1_readdata_from_sa;
  reg              HEX2_s1_reg_firsttransfer;
  wire             HEX2_s1_reset_n;
  reg              HEX2_s1_slavearbiterlockenable;
  wire             HEX2_s1_slavearbiterlockenable2;
  wire             HEX2_s1_unreg_firsttransfer;
  wire             HEX2_s1_waits_for_read;
  wire             HEX2_s1_waits_for_write;
  wire             HEX2_s1_write_n;
  wire    [  6: 0] HEX2_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX2_s1;
  wire             cpu_0_data_master_qualified_request_HEX2_s1;
  wire             cpu_0_data_master_read_data_valid_HEX2_s1;
  wire             cpu_0_data_master_requests_HEX2_s1;
  wire             cpu_0_data_master_saved_grant_HEX2_s1;
  reg              d1_HEX2_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX2_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 19: 0] shifted_address_to_HEX2_s1_from_cpu_0_data_master;
  wire             wait_for_HEX2_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX2_s1_end_xfer;
    end


  assign HEX2_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX2_s1));
  //assign HEX2_s1_readdata_from_sa = HEX2_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX2_s1_readdata_from_sa = HEX2_s1_readdata;

  assign cpu_0_data_master_requests_HEX2_s1 = ({cpu_0_data_master_address_to_slave[19 : 4] , 4'b0} == 20'h81050) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX2_s1_arb_share_counter set values, which is an e_mux
  assign HEX2_s1_arb_share_set_values = 1;

  //HEX2_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX2_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX2_s1;

  //HEX2_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX2_s1_any_bursting_master_saved_grant = 0;

  //HEX2_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX2_s1_arb_share_counter_next_value = HEX2_s1_firsttransfer ? (HEX2_s1_arb_share_set_values - 1) : |HEX2_s1_arb_share_counter ? (HEX2_s1_arb_share_counter - 1) : 0;

  //HEX2_s1_allgrants all slave grants, which is an e_mux
  assign HEX2_s1_allgrants = |HEX2_s1_grant_vector;

  //HEX2_s1_end_xfer assignment, which is an e_assign
  assign HEX2_s1_end_xfer = ~(HEX2_s1_waits_for_read | HEX2_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX2_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX2_s1 = HEX2_s1_end_xfer & (~HEX2_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX2_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX2_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX2_s1 & HEX2_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX2_s1 & ~HEX2_s1_non_bursting_master_requests);

  //HEX2_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX2_s1_arb_share_counter <= 0;
      else if (HEX2_s1_arb_counter_enable)
          HEX2_s1_arb_share_counter <= HEX2_s1_arb_share_counter_next_value;
    end


  //HEX2_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX2_s1_slavearbiterlockenable <= 0;
      else if ((|HEX2_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX2_s1) | (end_xfer_arb_share_counter_term_HEX2_s1 & ~HEX2_s1_non_bursting_master_requests))
          HEX2_s1_slavearbiterlockenable <= |HEX2_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX2/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX2_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX2_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX2_s1_slavearbiterlockenable2 = |HEX2_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX2/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX2_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX2_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX2_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX2_s1 = cpu_0_data_master_requests_HEX2_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX2_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX2_s1 = cpu_0_data_master_granted_HEX2_s1 & cpu_0_data_master_read & ~HEX2_s1_waits_for_read;

  //HEX2_s1_writedata mux, which is an e_mux
  assign HEX2_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX2_s1 = cpu_0_data_master_qualified_request_HEX2_s1;

  //cpu_0/data_master saved-grant HEX2/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX2_s1 = cpu_0_data_master_requests_HEX2_s1;

  //allow new arb cycle for HEX2/s1, which is an e_assign
  assign HEX2_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX2_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX2_s1_master_qreq_vector = 1;

  //HEX2_s1_reset_n assignment, which is an e_assign
  assign HEX2_s1_reset_n = reset_n;

  assign HEX2_s1_chipselect = cpu_0_data_master_granted_HEX2_s1;
  //HEX2_s1_firsttransfer first transaction, which is an e_assign
  assign HEX2_s1_firsttransfer = HEX2_s1_begins_xfer ? HEX2_s1_unreg_firsttransfer : HEX2_s1_reg_firsttransfer;

  //HEX2_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX2_s1_unreg_firsttransfer = ~(HEX2_s1_slavearbiterlockenable & HEX2_s1_any_continuerequest);

  //HEX2_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX2_s1_reg_firsttransfer <= 1'b1;
      else if (HEX2_s1_begins_xfer)
          HEX2_s1_reg_firsttransfer <= HEX2_s1_unreg_firsttransfer;
    end


  //HEX2_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX2_s1_beginbursttransfer_internal = HEX2_s1_begins_xfer;

  //~HEX2_s1_write_n assignment, which is an e_mux
  assign HEX2_s1_write_n = ~(cpu_0_data_master_granted_HEX2_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX2_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX2_s1_address mux, which is an e_mux
  assign HEX2_s1_address = shifted_address_to_HEX2_s1_from_cpu_0_data_master >> 2;

  //d1_HEX2_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX2_s1_end_xfer <= 1;
      else 
        d1_HEX2_s1_end_xfer <= HEX2_s1_end_xfer;
    end


  //HEX2_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX2_s1_waits_for_read = HEX2_s1_in_a_read_cycle & HEX2_s1_begins_xfer;

  //HEX2_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX2_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX2_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX2_s1_in_a_read_cycle;

  //HEX2_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX2_s1_waits_for_write = HEX2_s1_in_a_write_cycle & 0;

  //HEX2_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX2_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX2_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX2_s1_in_a_write_cycle;

  assign wait_for_HEX2_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX2/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX3_s1_arbitrator (
                            // inputs:
                             HEX3_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX3_s1_address,
                             HEX3_s1_chipselect,
                             HEX3_s1_readdata_from_sa,
                             HEX3_s1_reset_n,
                             HEX3_s1_write_n,
                             HEX3_s1_writedata,
                             cpu_0_data_master_granted_HEX3_s1,
                             cpu_0_data_master_qualified_request_HEX3_s1,
                             cpu_0_data_master_read_data_valid_HEX3_s1,
                             cpu_0_data_master_requests_HEX3_s1,
                             d1_HEX3_s1_end_xfer
                          )
;

  output  [  1: 0] HEX3_s1_address;
  output           HEX3_s1_chipselect;
  output  [  6: 0] HEX3_s1_readdata_from_sa;
  output           HEX3_s1_reset_n;
  output           HEX3_s1_write_n;
  output  [  6: 0] HEX3_s1_writedata;
  output           cpu_0_data_master_granted_HEX3_s1;
  output           cpu_0_data_master_qualified_request_HEX3_s1;
  output           cpu_0_data_master_read_data_valid_HEX3_s1;
  output           cpu_0_data_master_requests_HEX3_s1;
  output           d1_HEX3_s1_end_xfer;
  input   [  6: 0] HEX3_s1_readdata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX3_s1_address;
  wire             HEX3_s1_allgrants;
  wire             HEX3_s1_allow_new_arb_cycle;
  wire             HEX3_s1_any_bursting_master_saved_grant;
  wire             HEX3_s1_any_continuerequest;
  wire             HEX3_s1_arb_counter_enable;
  reg     [  1: 0] HEX3_s1_arb_share_counter;
  wire    [  1: 0] HEX3_s1_arb_share_counter_next_value;
  wire    [  1: 0] HEX3_s1_arb_share_set_values;
  wire             HEX3_s1_beginbursttransfer_internal;
  wire             HEX3_s1_begins_xfer;
  wire             HEX3_s1_chipselect;
  wire             HEX3_s1_end_xfer;
  wire             HEX3_s1_firsttransfer;
  wire             HEX3_s1_grant_vector;
  wire             HEX3_s1_in_a_read_cycle;
  wire             HEX3_s1_in_a_write_cycle;
  wire             HEX3_s1_master_qreq_vector;
  wire             HEX3_s1_non_bursting_master_requests;
  wire    [  6: 0] HEX3_s1_readdata_from_sa;
  reg              HEX3_s1_reg_firsttransfer;
  wire             HEX3_s1_reset_n;
  reg              HEX3_s1_slavearbiterlockenable;
  wire             HEX3_s1_slavearbiterlockenable2;
  wire             HEX3_s1_unreg_firsttransfer;
  wire             HEX3_s1_waits_for_read;
  wire             HEX3_s1_waits_for_write;
  wire             HEX3_s1_write_n;
  wire    [  6: 0] HEX3_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX3_s1;
  wire             cpu_0_data_master_qualified_request_HEX3_s1;
  wire             cpu_0_data_master_read_data_valid_HEX3_s1;
  wire             cpu_0_data_master_requests_HEX3_s1;
  wire             cpu_0_data_master_saved_grant_HEX3_s1;
  reg              d1_HEX3_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX3_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 19: 0] shifted_address_to_HEX3_s1_from_cpu_0_data_master;
  wire             wait_for_HEX3_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX3_s1_end_xfer;
    end


  assign HEX3_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX3_s1));
  //assign HEX3_s1_readdata_from_sa = HEX3_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX3_s1_readdata_from_sa = HEX3_s1_readdata;

  assign cpu_0_data_master_requests_HEX3_s1 = ({cpu_0_data_master_address_to_slave[19 : 4] , 4'b0} == 20'h81060) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX3_s1_arb_share_counter set values, which is an e_mux
  assign HEX3_s1_arb_share_set_values = 1;

  //HEX3_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX3_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX3_s1;

  //HEX3_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX3_s1_any_bursting_master_saved_grant = 0;

  //HEX3_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX3_s1_arb_share_counter_next_value = HEX3_s1_firsttransfer ? (HEX3_s1_arb_share_set_values - 1) : |HEX3_s1_arb_share_counter ? (HEX3_s1_arb_share_counter - 1) : 0;

  //HEX3_s1_allgrants all slave grants, which is an e_mux
  assign HEX3_s1_allgrants = |HEX3_s1_grant_vector;

  //HEX3_s1_end_xfer assignment, which is an e_assign
  assign HEX3_s1_end_xfer = ~(HEX3_s1_waits_for_read | HEX3_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX3_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX3_s1 = HEX3_s1_end_xfer & (~HEX3_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX3_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX3_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX3_s1 & HEX3_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX3_s1 & ~HEX3_s1_non_bursting_master_requests);

  //HEX3_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX3_s1_arb_share_counter <= 0;
      else if (HEX3_s1_arb_counter_enable)
          HEX3_s1_arb_share_counter <= HEX3_s1_arb_share_counter_next_value;
    end


  //HEX3_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX3_s1_slavearbiterlockenable <= 0;
      else if ((|HEX3_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX3_s1) | (end_xfer_arb_share_counter_term_HEX3_s1 & ~HEX3_s1_non_bursting_master_requests))
          HEX3_s1_slavearbiterlockenable <= |HEX3_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX3/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX3_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX3_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX3_s1_slavearbiterlockenable2 = |HEX3_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX3/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX3_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX3_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX3_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX3_s1 = cpu_0_data_master_requests_HEX3_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX3_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX3_s1 = cpu_0_data_master_granted_HEX3_s1 & cpu_0_data_master_read & ~HEX3_s1_waits_for_read;

  //HEX3_s1_writedata mux, which is an e_mux
  assign HEX3_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX3_s1 = cpu_0_data_master_qualified_request_HEX3_s1;

  //cpu_0/data_master saved-grant HEX3/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX3_s1 = cpu_0_data_master_requests_HEX3_s1;

  //allow new arb cycle for HEX3/s1, which is an e_assign
  assign HEX3_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX3_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX3_s1_master_qreq_vector = 1;

  //HEX3_s1_reset_n assignment, which is an e_assign
  assign HEX3_s1_reset_n = reset_n;

  assign HEX3_s1_chipselect = cpu_0_data_master_granted_HEX3_s1;
  //HEX3_s1_firsttransfer first transaction, which is an e_assign
  assign HEX3_s1_firsttransfer = HEX3_s1_begins_xfer ? HEX3_s1_unreg_firsttransfer : HEX3_s1_reg_firsttransfer;

  //HEX3_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX3_s1_unreg_firsttransfer = ~(HEX3_s1_slavearbiterlockenable & HEX3_s1_any_continuerequest);

  //HEX3_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX3_s1_reg_firsttransfer <= 1'b1;
      else if (HEX3_s1_begins_xfer)
          HEX3_s1_reg_firsttransfer <= HEX3_s1_unreg_firsttransfer;
    end


  //HEX3_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX3_s1_beginbursttransfer_internal = HEX3_s1_begins_xfer;

  //~HEX3_s1_write_n assignment, which is an e_mux
  assign HEX3_s1_write_n = ~(cpu_0_data_master_granted_HEX3_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX3_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX3_s1_address mux, which is an e_mux
  assign HEX3_s1_address = shifted_address_to_HEX3_s1_from_cpu_0_data_master >> 2;

  //d1_HEX3_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX3_s1_end_xfer <= 1;
      else 
        d1_HEX3_s1_end_xfer <= HEX3_s1_end_xfer;
    end


  //HEX3_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX3_s1_waits_for_read = HEX3_s1_in_a_read_cycle & HEX3_s1_begins_xfer;

  //HEX3_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX3_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX3_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX3_s1_in_a_read_cycle;

  //HEX3_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX3_s1_waits_for_write = HEX3_s1_in_a_write_cycle & 0;

  //HEX3_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX3_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX3_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX3_s1_in_a_write_cycle;

  assign wait_for_HEX3_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX3/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX4_s1_arbitrator (
                            // inputs:
                             HEX4_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX4_s1_address,
                             HEX4_s1_chipselect,
                             HEX4_s1_readdata_from_sa,
                             HEX4_s1_reset_n,
                             HEX4_s1_write_n,
                             HEX4_s1_writedata,
                             cpu_0_data_master_granted_HEX4_s1,
                             cpu_0_data_master_qualified_request_HEX4_s1,
                             cpu_0_data_master_read_data_valid_HEX4_s1,
                             cpu_0_data_master_requests_HEX4_s1,
                             d1_HEX4_s1_end_xfer
                          )
;

  output  [  1: 0] HEX4_s1_address;
  output           HEX4_s1_chipselect;
  output  [  6: 0] HEX4_s1_readdata_from_sa;
  output           HEX4_s1_reset_n;
  output           HEX4_s1_write_n;
  output  [  6: 0] HEX4_s1_writedata;
  output           cpu_0_data_master_granted_HEX4_s1;
  output           cpu_0_data_master_qualified_request_HEX4_s1;
  output           cpu_0_data_master_read_data_valid_HEX4_s1;
  output           cpu_0_data_master_requests_HEX4_s1;
  output           d1_HEX4_s1_end_xfer;
  input   [  6: 0] HEX4_s1_readdata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX4_s1_address;
  wire             HEX4_s1_allgrants;
  wire             HEX4_s1_allow_new_arb_cycle;
  wire             HEX4_s1_any_bursting_master_saved_grant;
  wire             HEX4_s1_any_continuerequest;
  wire             HEX4_s1_arb_counter_enable;
  reg     [  1: 0] HEX4_s1_arb_share_counter;
  wire    [  1: 0] HEX4_s1_arb_share_counter_next_value;
  wire    [  1: 0] HEX4_s1_arb_share_set_values;
  wire             HEX4_s1_beginbursttransfer_internal;
  wire             HEX4_s1_begins_xfer;
  wire             HEX4_s1_chipselect;
  wire             HEX4_s1_end_xfer;
  wire             HEX4_s1_firsttransfer;
  wire             HEX4_s1_grant_vector;
  wire             HEX4_s1_in_a_read_cycle;
  wire             HEX4_s1_in_a_write_cycle;
  wire             HEX4_s1_master_qreq_vector;
  wire             HEX4_s1_non_bursting_master_requests;
  wire    [  6: 0] HEX4_s1_readdata_from_sa;
  reg              HEX4_s1_reg_firsttransfer;
  wire             HEX4_s1_reset_n;
  reg              HEX4_s1_slavearbiterlockenable;
  wire             HEX4_s1_slavearbiterlockenable2;
  wire             HEX4_s1_unreg_firsttransfer;
  wire             HEX4_s1_waits_for_read;
  wire             HEX4_s1_waits_for_write;
  wire             HEX4_s1_write_n;
  wire    [  6: 0] HEX4_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX4_s1;
  wire             cpu_0_data_master_qualified_request_HEX4_s1;
  wire             cpu_0_data_master_read_data_valid_HEX4_s1;
  wire             cpu_0_data_master_requests_HEX4_s1;
  wire             cpu_0_data_master_saved_grant_HEX4_s1;
  reg              d1_HEX4_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX4_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 19: 0] shifted_address_to_HEX4_s1_from_cpu_0_data_master;
  wire             wait_for_HEX4_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX4_s1_end_xfer;
    end


  assign HEX4_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX4_s1));
  //assign HEX4_s1_readdata_from_sa = HEX4_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX4_s1_readdata_from_sa = HEX4_s1_readdata;

  assign cpu_0_data_master_requests_HEX4_s1 = ({cpu_0_data_master_address_to_slave[19 : 4] , 4'b0} == 20'h81070) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX4_s1_arb_share_counter set values, which is an e_mux
  assign HEX4_s1_arb_share_set_values = 1;

  //HEX4_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX4_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX4_s1;

  //HEX4_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX4_s1_any_bursting_master_saved_grant = 0;

  //HEX4_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX4_s1_arb_share_counter_next_value = HEX4_s1_firsttransfer ? (HEX4_s1_arb_share_set_values - 1) : |HEX4_s1_arb_share_counter ? (HEX4_s1_arb_share_counter - 1) : 0;

  //HEX4_s1_allgrants all slave grants, which is an e_mux
  assign HEX4_s1_allgrants = |HEX4_s1_grant_vector;

  //HEX4_s1_end_xfer assignment, which is an e_assign
  assign HEX4_s1_end_xfer = ~(HEX4_s1_waits_for_read | HEX4_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX4_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX4_s1 = HEX4_s1_end_xfer & (~HEX4_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX4_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX4_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX4_s1 & HEX4_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX4_s1 & ~HEX4_s1_non_bursting_master_requests);

  //HEX4_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX4_s1_arb_share_counter <= 0;
      else if (HEX4_s1_arb_counter_enable)
          HEX4_s1_arb_share_counter <= HEX4_s1_arb_share_counter_next_value;
    end


  //HEX4_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX4_s1_slavearbiterlockenable <= 0;
      else if ((|HEX4_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX4_s1) | (end_xfer_arb_share_counter_term_HEX4_s1 & ~HEX4_s1_non_bursting_master_requests))
          HEX4_s1_slavearbiterlockenable <= |HEX4_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX4/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX4_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX4_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX4_s1_slavearbiterlockenable2 = |HEX4_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX4/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX4_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX4_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX4_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX4_s1 = cpu_0_data_master_requests_HEX4_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX4_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX4_s1 = cpu_0_data_master_granted_HEX4_s1 & cpu_0_data_master_read & ~HEX4_s1_waits_for_read;

  //HEX4_s1_writedata mux, which is an e_mux
  assign HEX4_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX4_s1 = cpu_0_data_master_qualified_request_HEX4_s1;

  //cpu_0/data_master saved-grant HEX4/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX4_s1 = cpu_0_data_master_requests_HEX4_s1;

  //allow new arb cycle for HEX4/s1, which is an e_assign
  assign HEX4_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX4_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX4_s1_master_qreq_vector = 1;

  //HEX4_s1_reset_n assignment, which is an e_assign
  assign HEX4_s1_reset_n = reset_n;

  assign HEX4_s1_chipselect = cpu_0_data_master_granted_HEX4_s1;
  //HEX4_s1_firsttransfer first transaction, which is an e_assign
  assign HEX4_s1_firsttransfer = HEX4_s1_begins_xfer ? HEX4_s1_unreg_firsttransfer : HEX4_s1_reg_firsttransfer;

  //HEX4_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX4_s1_unreg_firsttransfer = ~(HEX4_s1_slavearbiterlockenable & HEX4_s1_any_continuerequest);

  //HEX4_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX4_s1_reg_firsttransfer <= 1'b1;
      else if (HEX4_s1_begins_xfer)
          HEX4_s1_reg_firsttransfer <= HEX4_s1_unreg_firsttransfer;
    end


  //HEX4_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX4_s1_beginbursttransfer_internal = HEX4_s1_begins_xfer;

  //~HEX4_s1_write_n assignment, which is an e_mux
  assign HEX4_s1_write_n = ~(cpu_0_data_master_granted_HEX4_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX4_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX4_s1_address mux, which is an e_mux
  assign HEX4_s1_address = shifted_address_to_HEX4_s1_from_cpu_0_data_master >> 2;

  //d1_HEX4_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX4_s1_end_xfer <= 1;
      else 
        d1_HEX4_s1_end_xfer <= HEX4_s1_end_xfer;
    end


  //HEX4_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX4_s1_waits_for_read = HEX4_s1_in_a_read_cycle & HEX4_s1_begins_xfer;

  //HEX4_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX4_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX4_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX4_s1_in_a_read_cycle;

  //HEX4_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX4_s1_waits_for_write = HEX4_s1_in_a_write_cycle & 0;

  //HEX4_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX4_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX4_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX4_s1_in_a_write_cycle;

  assign wait_for_HEX4_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX4/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX5_s1_arbitrator (
                            // inputs:
                             HEX5_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX5_s1_address,
                             HEX5_s1_chipselect,
                             HEX5_s1_readdata_from_sa,
                             HEX5_s1_reset_n,
                             HEX5_s1_write_n,
                             HEX5_s1_writedata,
                             cpu_0_data_master_granted_HEX5_s1,
                             cpu_0_data_master_qualified_request_HEX5_s1,
                             cpu_0_data_master_read_data_valid_HEX5_s1,
                             cpu_0_data_master_requests_HEX5_s1,
                             d1_HEX5_s1_end_xfer
                          )
;

  output  [  1: 0] HEX5_s1_address;
  output           HEX5_s1_chipselect;
  output  [  6: 0] HEX5_s1_readdata_from_sa;
  output           HEX5_s1_reset_n;
  output           HEX5_s1_write_n;
  output  [  6: 0] HEX5_s1_writedata;
  output           cpu_0_data_master_granted_HEX5_s1;
  output           cpu_0_data_master_qualified_request_HEX5_s1;
  output           cpu_0_data_master_read_data_valid_HEX5_s1;
  output           cpu_0_data_master_requests_HEX5_s1;
  output           d1_HEX5_s1_end_xfer;
  input   [  6: 0] HEX5_s1_readdata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX5_s1_address;
  wire             HEX5_s1_allgrants;
  wire             HEX5_s1_allow_new_arb_cycle;
  wire             HEX5_s1_any_bursting_master_saved_grant;
  wire             HEX5_s1_any_continuerequest;
  wire             HEX5_s1_arb_counter_enable;
  reg     [  1: 0] HEX5_s1_arb_share_counter;
  wire    [  1: 0] HEX5_s1_arb_share_counter_next_value;
  wire    [  1: 0] HEX5_s1_arb_share_set_values;
  wire             HEX5_s1_beginbursttransfer_internal;
  wire             HEX5_s1_begins_xfer;
  wire             HEX5_s1_chipselect;
  wire             HEX5_s1_end_xfer;
  wire             HEX5_s1_firsttransfer;
  wire             HEX5_s1_grant_vector;
  wire             HEX5_s1_in_a_read_cycle;
  wire             HEX5_s1_in_a_write_cycle;
  wire             HEX5_s1_master_qreq_vector;
  wire             HEX5_s1_non_bursting_master_requests;
  wire    [  6: 0] HEX5_s1_readdata_from_sa;
  reg              HEX5_s1_reg_firsttransfer;
  wire             HEX5_s1_reset_n;
  reg              HEX5_s1_slavearbiterlockenable;
  wire             HEX5_s1_slavearbiterlockenable2;
  wire             HEX5_s1_unreg_firsttransfer;
  wire             HEX5_s1_waits_for_read;
  wire             HEX5_s1_waits_for_write;
  wire             HEX5_s1_write_n;
  wire    [  6: 0] HEX5_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX5_s1;
  wire             cpu_0_data_master_qualified_request_HEX5_s1;
  wire             cpu_0_data_master_read_data_valid_HEX5_s1;
  wire             cpu_0_data_master_requests_HEX5_s1;
  wire             cpu_0_data_master_saved_grant_HEX5_s1;
  reg              d1_HEX5_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX5_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 19: 0] shifted_address_to_HEX5_s1_from_cpu_0_data_master;
  wire             wait_for_HEX5_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX5_s1_end_xfer;
    end


  assign HEX5_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX5_s1));
  //assign HEX5_s1_readdata_from_sa = HEX5_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX5_s1_readdata_from_sa = HEX5_s1_readdata;

  assign cpu_0_data_master_requests_HEX5_s1 = ({cpu_0_data_master_address_to_slave[19 : 4] , 4'b0} == 20'h81080) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX5_s1_arb_share_counter set values, which is an e_mux
  assign HEX5_s1_arb_share_set_values = 1;

  //HEX5_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX5_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX5_s1;

  //HEX5_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX5_s1_any_bursting_master_saved_grant = 0;

  //HEX5_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX5_s1_arb_share_counter_next_value = HEX5_s1_firsttransfer ? (HEX5_s1_arb_share_set_values - 1) : |HEX5_s1_arb_share_counter ? (HEX5_s1_arb_share_counter - 1) : 0;

  //HEX5_s1_allgrants all slave grants, which is an e_mux
  assign HEX5_s1_allgrants = |HEX5_s1_grant_vector;

  //HEX5_s1_end_xfer assignment, which is an e_assign
  assign HEX5_s1_end_xfer = ~(HEX5_s1_waits_for_read | HEX5_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX5_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX5_s1 = HEX5_s1_end_xfer & (~HEX5_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX5_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX5_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX5_s1 & HEX5_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX5_s1 & ~HEX5_s1_non_bursting_master_requests);

  //HEX5_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX5_s1_arb_share_counter <= 0;
      else if (HEX5_s1_arb_counter_enable)
          HEX5_s1_arb_share_counter <= HEX5_s1_arb_share_counter_next_value;
    end


  //HEX5_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX5_s1_slavearbiterlockenable <= 0;
      else if ((|HEX5_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX5_s1) | (end_xfer_arb_share_counter_term_HEX5_s1 & ~HEX5_s1_non_bursting_master_requests))
          HEX5_s1_slavearbiterlockenable <= |HEX5_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX5/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX5_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX5_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX5_s1_slavearbiterlockenable2 = |HEX5_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX5/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX5_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX5_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX5_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX5_s1 = cpu_0_data_master_requests_HEX5_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX5_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX5_s1 = cpu_0_data_master_granted_HEX5_s1 & cpu_0_data_master_read & ~HEX5_s1_waits_for_read;

  //HEX5_s1_writedata mux, which is an e_mux
  assign HEX5_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX5_s1 = cpu_0_data_master_qualified_request_HEX5_s1;

  //cpu_0/data_master saved-grant HEX5/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX5_s1 = cpu_0_data_master_requests_HEX5_s1;

  //allow new arb cycle for HEX5/s1, which is an e_assign
  assign HEX5_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX5_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX5_s1_master_qreq_vector = 1;

  //HEX5_s1_reset_n assignment, which is an e_assign
  assign HEX5_s1_reset_n = reset_n;

  assign HEX5_s1_chipselect = cpu_0_data_master_granted_HEX5_s1;
  //HEX5_s1_firsttransfer first transaction, which is an e_assign
  assign HEX5_s1_firsttransfer = HEX5_s1_begins_xfer ? HEX5_s1_unreg_firsttransfer : HEX5_s1_reg_firsttransfer;

  //HEX5_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX5_s1_unreg_firsttransfer = ~(HEX5_s1_slavearbiterlockenable & HEX5_s1_any_continuerequest);

  //HEX5_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX5_s1_reg_firsttransfer <= 1'b1;
      else if (HEX5_s1_begins_xfer)
          HEX5_s1_reg_firsttransfer <= HEX5_s1_unreg_firsttransfer;
    end


  //HEX5_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX5_s1_beginbursttransfer_internal = HEX5_s1_begins_xfer;

  //~HEX5_s1_write_n assignment, which is an e_mux
  assign HEX5_s1_write_n = ~(cpu_0_data_master_granted_HEX5_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX5_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX5_s1_address mux, which is an e_mux
  assign HEX5_s1_address = shifted_address_to_HEX5_s1_from_cpu_0_data_master >> 2;

  //d1_HEX5_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX5_s1_end_xfer <= 1;
      else 
        d1_HEX5_s1_end_xfer <= HEX5_s1_end_xfer;
    end


  //HEX5_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX5_s1_waits_for_read = HEX5_s1_in_a_read_cycle & HEX5_s1_begins_xfer;

  //HEX5_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX5_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX5_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX5_s1_in_a_read_cycle;

  //HEX5_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX5_s1_waits_for_write = HEX5_s1_in_a_write_cycle & 0;

  //HEX5_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX5_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX5_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX5_s1_in_a_write_cycle;

  assign wait_for_HEX5_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX5/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX6_s1_arbitrator (
                            // inputs:
                             HEX6_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX6_s1_address,
                             HEX6_s1_chipselect,
                             HEX6_s1_readdata_from_sa,
                             HEX6_s1_reset_n,
                             HEX6_s1_write_n,
                             HEX6_s1_writedata,
                             cpu_0_data_master_granted_HEX6_s1,
                             cpu_0_data_master_qualified_request_HEX6_s1,
                             cpu_0_data_master_read_data_valid_HEX6_s1,
                             cpu_0_data_master_requests_HEX6_s1,
                             d1_HEX6_s1_end_xfer
                          )
;

  output  [  1: 0] HEX6_s1_address;
  output           HEX6_s1_chipselect;
  output  [  6: 0] HEX6_s1_readdata_from_sa;
  output           HEX6_s1_reset_n;
  output           HEX6_s1_write_n;
  output  [  6: 0] HEX6_s1_writedata;
  output           cpu_0_data_master_granted_HEX6_s1;
  output           cpu_0_data_master_qualified_request_HEX6_s1;
  output           cpu_0_data_master_read_data_valid_HEX6_s1;
  output           cpu_0_data_master_requests_HEX6_s1;
  output           d1_HEX6_s1_end_xfer;
  input   [  6: 0] HEX6_s1_readdata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX6_s1_address;
  wire             HEX6_s1_allgrants;
  wire             HEX6_s1_allow_new_arb_cycle;
  wire             HEX6_s1_any_bursting_master_saved_grant;
  wire             HEX6_s1_any_continuerequest;
  wire             HEX6_s1_arb_counter_enable;
  reg     [  1: 0] HEX6_s1_arb_share_counter;
  wire    [  1: 0] HEX6_s1_arb_share_counter_next_value;
  wire    [  1: 0] HEX6_s1_arb_share_set_values;
  wire             HEX6_s1_beginbursttransfer_internal;
  wire             HEX6_s1_begins_xfer;
  wire             HEX6_s1_chipselect;
  wire             HEX6_s1_end_xfer;
  wire             HEX6_s1_firsttransfer;
  wire             HEX6_s1_grant_vector;
  wire             HEX6_s1_in_a_read_cycle;
  wire             HEX6_s1_in_a_write_cycle;
  wire             HEX6_s1_master_qreq_vector;
  wire             HEX6_s1_non_bursting_master_requests;
  wire    [  6: 0] HEX6_s1_readdata_from_sa;
  reg              HEX6_s1_reg_firsttransfer;
  wire             HEX6_s1_reset_n;
  reg              HEX6_s1_slavearbiterlockenable;
  wire             HEX6_s1_slavearbiterlockenable2;
  wire             HEX6_s1_unreg_firsttransfer;
  wire             HEX6_s1_waits_for_read;
  wire             HEX6_s1_waits_for_write;
  wire             HEX6_s1_write_n;
  wire    [  6: 0] HEX6_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX6_s1;
  wire             cpu_0_data_master_qualified_request_HEX6_s1;
  wire             cpu_0_data_master_read_data_valid_HEX6_s1;
  wire             cpu_0_data_master_requests_HEX6_s1;
  wire             cpu_0_data_master_saved_grant_HEX6_s1;
  reg              d1_HEX6_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX6_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 19: 0] shifted_address_to_HEX6_s1_from_cpu_0_data_master;
  wire             wait_for_HEX6_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX6_s1_end_xfer;
    end


  assign HEX6_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX6_s1));
  //assign HEX6_s1_readdata_from_sa = HEX6_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX6_s1_readdata_from_sa = HEX6_s1_readdata;

  assign cpu_0_data_master_requests_HEX6_s1 = ({cpu_0_data_master_address_to_slave[19 : 4] , 4'b0} == 20'h81090) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX6_s1_arb_share_counter set values, which is an e_mux
  assign HEX6_s1_arb_share_set_values = 1;

  //HEX6_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX6_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX6_s1;

  //HEX6_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX6_s1_any_bursting_master_saved_grant = 0;

  //HEX6_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX6_s1_arb_share_counter_next_value = HEX6_s1_firsttransfer ? (HEX6_s1_arb_share_set_values - 1) : |HEX6_s1_arb_share_counter ? (HEX6_s1_arb_share_counter - 1) : 0;

  //HEX6_s1_allgrants all slave grants, which is an e_mux
  assign HEX6_s1_allgrants = |HEX6_s1_grant_vector;

  //HEX6_s1_end_xfer assignment, which is an e_assign
  assign HEX6_s1_end_xfer = ~(HEX6_s1_waits_for_read | HEX6_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX6_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX6_s1 = HEX6_s1_end_xfer & (~HEX6_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX6_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX6_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX6_s1 & HEX6_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX6_s1 & ~HEX6_s1_non_bursting_master_requests);

  //HEX6_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX6_s1_arb_share_counter <= 0;
      else if (HEX6_s1_arb_counter_enable)
          HEX6_s1_arb_share_counter <= HEX6_s1_arb_share_counter_next_value;
    end


  //HEX6_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX6_s1_slavearbiterlockenable <= 0;
      else if ((|HEX6_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX6_s1) | (end_xfer_arb_share_counter_term_HEX6_s1 & ~HEX6_s1_non_bursting_master_requests))
          HEX6_s1_slavearbiterlockenable <= |HEX6_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX6/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX6_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX6_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX6_s1_slavearbiterlockenable2 = |HEX6_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX6/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX6_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX6_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX6_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX6_s1 = cpu_0_data_master_requests_HEX6_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX6_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX6_s1 = cpu_0_data_master_granted_HEX6_s1 & cpu_0_data_master_read & ~HEX6_s1_waits_for_read;

  //HEX6_s1_writedata mux, which is an e_mux
  assign HEX6_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX6_s1 = cpu_0_data_master_qualified_request_HEX6_s1;

  //cpu_0/data_master saved-grant HEX6/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX6_s1 = cpu_0_data_master_requests_HEX6_s1;

  //allow new arb cycle for HEX6/s1, which is an e_assign
  assign HEX6_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX6_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX6_s1_master_qreq_vector = 1;

  //HEX6_s1_reset_n assignment, which is an e_assign
  assign HEX6_s1_reset_n = reset_n;

  assign HEX6_s1_chipselect = cpu_0_data_master_granted_HEX6_s1;
  //HEX6_s1_firsttransfer first transaction, which is an e_assign
  assign HEX6_s1_firsttransfer = HEX6_s1_begins_xfer ? HEX6_s1_unreg_firsttransfer : HEX6_s1_reg_firsttransfer;

  //HEX6_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX6_s1_unreg_firsttransfer = ~(HEX6_s1_slavearbiterlockenable & HEX6_s1_any_continuerequest);

  //HEX6_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX6_s1_reg_firsttransfer <= 1'b1;
      else if (HEX6_s1_begins_xfer)
          HEX6_s1_reg_firsttransfer <= HEX6_s1_unreg_firsttransfer;
    end


  //HEX6_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX6_s1_beginbursttransfer_internal = HEX6_s1_begins_xfer;

  //~HEX6_s1_write_n assignment, which is an e_mux
  assign HEX6_s1_write_n = ~(cpu_0_data_master_granted_HEX6_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX6_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX6_s1_address mux, which is an e_mux
  assign HEX6_s1_address = shifted_address_to_HEX6_s1_from_cpu_0_data_master >> 2;

  //d1_HEX6_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX6_s1_end_xfer <= 1;
      else 
        d1_HEX6_s1_end_xfer <= HEX6_s1_end_xfer;
    end


  //HEX6_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX6_s1_waits_for_read = HEX6_s1_in_a_read_cycle & HEX6_s1_begins_xfer;

  //HEX6_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX6_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX6_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX6_s1_in_a_read_cycle;

  //HEX6_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX6_s1_waits_for_write = HEX6_s1_in_a_write_cycle & 0;

  //HEX6_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX6_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX6_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX6_s1_in_a_write_cycle;

  assign wait_for_HEX6_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX6/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX7_s1_arbitrator (
                            // inputs:
                             HEX7_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX7_s1_address,
                             HEX7_s1_chipselect,
                             HEX7_s1_readdata_from_sa,
                             HEX7_s1_reset_n,
                             HEX7_s1_write_n,
                             HEX7_s1_writedata,
                             cpu_0_data_master_granted_HEX7_s1,
                             cpu_0_data_master_qualified_request_HEX7_s1,
                             cpu_0_data_master_read_data_valid_HEX7_s1,
                             cpu_0_data_master_requests_HEX7_s1,
                             d1_HEX7_s1_end_xfer
                          )
;

  output  [  1: 0] HEX7_s1_address;
  output           HEX7_s1_chipselect;
  output  [  6: 0] HEX7_s1_readdata_from_sa;
  output           HEX7_s1_reset_n;
  output           HEX7_s1_write_n;
  output  [  6: 0] HEX7_s1_writedata;
  output           cpu_0_data_master_granted_HEX7_s1;
  output           cpu_0_data_master_qualified_request_HEX7_s1;
  output           cpu_0_data_master_read_data_valid_HEX7_s1;
  output           cpu_0_data_master_requests_HEX7_s1;
  output           d1_HEX7_s1_end_xfer;
  input   [  6: 0] HEX7_s1_readdata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX7_s1_address;
  wire             HEX7_s1_allgrants;
  wire             HEX7_s1_allow_new_arb_cycle;
  wire             HEX7_s1_any_bursting_master_saved_grant;
  wire             HEX7_s1_any_continuerequest;
  wire             HEX7_s1_arb_counter_enable;
  reg     [  1: 0] HEX7_s1_arb_share_counter;
  wire    [  1: 0] HEX7_s1_arb_share_counter_next_value;
  wire    [  1: 0] HEX7_s1_arb_share_set_values;
  wire             HEX7_s1_beginbursttransfer_internal;
  wire             HEX7_s1_begins_xfer;
  wire             HEX7_s1_chipselect;
  wire             HEX7_s1_end_xfer;
  wire             HEX7_s1_firsttransfer;
  wire             HEX7_s1_grant_vector;
  wire             HEX7_s1_in_a_read_cycle;
  wire             HEX7_s1_in_a_write_cycle;
  wire             HEX7_s1_master_qreq_vector;
  wire             HEX7_s1_non_bursting_master_requests;
  wire    [  6: 0] HEX7_s1_readdata_from_sa;
  reg              HEX7_s1_reg_firsttransfer;
  wire             HEX7_s1_reset_n;
  reg              HEX7_s1_slavearbiterlockenable;
  wire             HEX7_s1_slavearbiterlockenable2;
  wire             HEX7_s1_unreg_firsttransfer;
  wire             HEX7_s1_waits_for_read;
  wire             HEX7_s1_waits_for_write;
  wire             HEX7_s1_write_n;
  wire    [  6: 0] HEX7_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX7_s1;
  wire             cpu_0_data_master_qualified_request_HEX7_s1;
  wire             cpu_0_data_master_read_data_valid_HEX7_s1;
  wire             cpu_0_data_master_requests_HEX7_s1;
  wire             cpu_0_data_master_saved_grant_HEX7_s1;
  reg              d1_HEX7_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX7_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 19: 0] shifted_address_to_HEX7_s1_from_cpu_0_data_master;
  wire             wait_for_HEX7_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX7_s1_end_xfer;
    end


  assign HEX7_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX7_s1));
  //assign HEX7_s1_readdata_from_sa = HEX7_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX7_s1_readdata_from_sa = HEX7_s1_readdata;

  assign cpu_0_data_master_requests_HEX7_s1 = ({cpu_0_data_master_address_to_slave[19 : 4] , 4'b0} == 20'h810a0) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX7_s1_arb_share_counter set values, which is an e_mux
  assign HEX7_s1_arb_share_set_values = 1;

  //HEX7_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX7_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX7_s1;

  //HEX7_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX7_s1_any_bursting_master_saved_grant = 0;

  //HEX7_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX7_s1_arb_share_counter_next_value = HEX7_s1_firsttransfer ? (HEX7_s1_arb_share_set_values - 1) : |HEX7_s1_arb_share_counter ? (HEX7_s1_arb_share_counter - 1) : 0;

  //HEX7_s1_allgrants all slave grants, which is an e_mux
  assign HEX7_s1_allgrants = |HEX7_s1_grant_vector;

  //HEX7_s1_end_xfer assignment, which is an e_assign
  assign HEX7_s1_end_xfer = ~(HEX7_s1_waits_for_read | HEX7_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX7_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX7_s1 = HEX7_s1_end_xfer & (~HEX7_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX7_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX7_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX7_s1 & HEX7_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX7_s1 & ~HEX7_s1_non_bursting_master_requests);

  //HEX7_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX7_s1_arb_share_counter <= 0;
      else if (HEX7_s1_arb_counter_enable)
          HEX7_s1_arb_share_counter <= HEX7_s1_arb_share_counter_next_value;
    end


  //HEX7_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX7_s1_slavearbiterlockenable <= 0;
      else if ((|HEX7_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX7_s1) | (end_xfer_arb_share_counter_term_HEX7_s1 & ~HEX7_s1_non_bursting_master_requests))
          HEX7_s1_slavearbiterlockenable <= |HEX7_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX7/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX7_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX7_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX7_s1_slavearbiterlockenable2 = |HEX7_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX7/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX7_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX7_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX7_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX7_s1 = cpu_0_data_master_requests_HEX7_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX7_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX7_s1 = cpu_0_data_master_granted_HEX7_s1 & cpu_0_data_master_read & ~HEX7_s1_waits_for_read;

  //HEX7_s1_writedata mux, which is an e_mux
  assign HEX7_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX7_s1 = cpu_0_data_master_qualified_request_HEX7_s1;

  //cpu_0/data_master saved-grant HEX7/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX7_s1 = cpu_0_data_master_requests_HEX7_s1;

  //allow new arb cycle for HEX7/s1, which is an e_assign
  assign HEX7_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX7_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX7_s1_master_qreq_vector = 1;

  //HEX7_s1_reset_n assignment, which is an e_assign
  assign HEX7_s1_reset_n = reset_n;

  assign HEX7_s1_chipselect = cpu_0_data_master_granted_HEX7_s1;
  //HEX7_s1_firsttransfer first transaction, which is an e_assign
  assign HEX7_s1_firsttransfer = HEX7_s1_begins_xfer ? HEX7_s1_unreg_firsttransfer : HEX7_s1_reg_firsttransfer;

  //HEX7_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX7_s1_unreg_firsttransfer = ~(HEX7_s1_slavearbiterlockenable & HEX7_s1_any_continuerequest);

  //HEX7_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX7_s1_reg_firsttransfer <= 1'b1;
      else if (HEX7_s1_begins_xfer)
          HEX7_s1_reg_firsttransfer <= HEX7_s1_unreg_firsttransfer;
    end


  //HEX7_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX7_s1_beginbursttransfer_internal = HEX7_s1_begins_xfer;

  //~HEX7_s1_write_n assignment, which is an e_mux
  assign HEX7_s1_write_n = ~(cpu_0_data_master_granted_HEX7_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX7_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX7_s1_address mux, which is an e_mux
  assign HEX7_s1_address = shifted_address_to_HEX7_s1_from_cpu_0_data_master >> 2;

  //d1_HEX7_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX7_s1_end_xfer <= 1;
      else 
        d1_HEX7_s1_end_xfer <= HEX7_s1_end_xfer;
    end


  //HEX7_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX7_s1_waits_for_read = HEX7_s1_in_a_read_cycle & HEX7_s1_begins_xfer;

  //HEX7_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX7_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX7_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX7_s1_in_a_read_cycle;

  //HEX7_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX7_s1_waits_for_write = HEX7_s1_in_a_write_cycle & 0;

  //HEX7_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX7_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX7_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX7_s1_in_a_write_cycle;

  assign wait_for_HEX7_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX7/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module KEY_s1_arbitrator (
                           // inputs:
                            KEY_s1_irq,
                            KEY_s1_readdata,
                            clk,
                            cpu_0_data_master_address_to_slave,
                            cpu_0_data_master_latency_counter,
                            cpu_0_data_master_read,
                            cpu_0_data_master_write,
                            cpu_0_data_master_writedata,
                            reset_n,

                           // outputs:
                            KEY_s1_address,
                            KEY_s1_chipselect,
                            KEY_s1_irq_from_sa,
                            KEY_s1_readdata_from_sa,
                            KEY_s1_reset_n,
                            KEY_s1_write_n,
                            KEY_s1_writedata,
                            cpu_0_data_master_granted_KEY_s1,
                            cpu_0_data_master_qualified_request_KEY_s1,
                            cpu_0_data_master_read_data_valid_KEY_s1,
                            cpu_0_data_master_requests_KEY_s1,
                            d1_KEY_s1_end_xfer
                         )
;

  output  [  1: 0] KEY_s1_address;
  output           KEY_s1_chipselect;
  output           KEY_s1_irq_from_sa;
  output  [  3: 0] KEY_s1_readdata_from_sa;
  output           KEY_s1_reset_n;
  output           KEY_s1_write_n;
  output  [  3: 0] KEY_s1_writedata;
  output           cpu_0_data_master_granted_KEY_s1;
  output           cpu_0_data_master_qualified_request_KEY_s1;
  output           cpu_0_data_master_read_data_valid_KEY_s1;
  output           cpu_0_data_master_requests_KEY_s1;
  output           d1_KEY_s1_end_xfer;
  input            KEY_s1_irq;
  input   [  3: 0] KEY_s1_readdata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] KEY_s1_address;
  wire             KEY_s1_allgrants;
  wire             KEY_s1_allow_new_arb_cycle;
  wire             KEY_s1_any_bursting_master_saved_grant;
  wire             KEY_s1_any_continuerequest;
  wire             KEY_s1_arb_counter_enable;
  reg     [  1: 0] KEY_s1_arb_share_counter;
  wire    [  1: 0] KEY_s1_arb_share_counter_next_value;
  wire    [  1: 0] KEY_s1_arb_share_set_values;
  wire             KEY_s1_beginbursttransfer_internal;
  wire             KEY_s1_begins_xfer;
  wire             KEY_s1_chipselect;
  wire             KEY_s1_end_xfer;
  wire             KEY_s1_firsttransfer;
  wire             KEY_s1_grant_vector;
  wire             KEY_s1_in_a_read_cycle;
  wire             KEY_s1_in_a_write_cycle;
  wire             KEY_s1_irq_from_sa;
  wire             KEY_s1_master_qreq_vector;
  wire             KEY_s1_non_bursting_master_requests;
  wire    [  3: 0] KEY_s1_readdata_from_sa;
  reg              KEY_s1_reg_firsttransfer;
  wire             KEY_s1_reset_n;
  reg              KEY_s1_slavearbiterlockenable;
  wire             KEY_s1_slavearbiterlockenable2;
  wire             KEY_s1_unreg_firsttransfer;
  wire             KEY_s1_waits_for_read;
  wire             KEY_s1_waits_for_write;
  wire             KEY_s1_write_n;
  wire    [  3: 0] KEY_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_KEY_s1;
  wire             cpu_0_data_master_qualified_request_KEY_s1;
  wire             cpu_0_data_master_read_data_valid_KEY_s1;
  wire             cpu_0_data_master_requests_KEY_s1;
  wire             cpu_0_data_master_saved_grant_KEY_s1;
  reg              d1_KEY_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_KEY_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 19: 0] shifted_address_to_KEY_s1_from_cpu_0_data_master;
  wire             wait_for_KEY_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~KEY_s1_end_xfer;
    end


  assign KEY_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_KEY_s1));
  //assign KEY_s1_readdata_from_sa = KEY_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign KEY_s1_readdata_from_sa = KEY_s1_readdata;

  assign cpu_0_data_master_requests_KEY_s1 = ({cpu_0_data_master_address_to_slave[19 : 4] , 4'b0} == 20'h810c0) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //KEY_s1_arb_share_counter set values, which is an e_mux
  assign KEY_s1_arb_share_set_values = 1;

  //KEY_s1_non_bursting_master_requests mux, which is an e_mux
  assign KEY_s1_non_bursting_master_requests = cpu_0_data_master_requests_KEY_s1;

  //KEY_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign KEY_s1_any_bursting_master_saved_grant = 0;

  //KEY_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign KEY_s1_arb_share_counter_next_value = KEY_s1_firsttransfer ? (KEY_s1_arb_share_set_values - 1) : |KEY_s1_arb_share_counter ? (KEY_s1_arb_share_counter - 1) : 0;

  //KEY_s1_allgrants all slave grants, which is an e_mux
  assign KEY_s1_allgrants = |KEY_s1_grant_vector;

  //KEY_s1_end_xfer assignment, which is an e_assign
  assign KEY_s1_end_xfer = ~(KEY_s1_waits_for_read | KEY_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_KEY_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_KEY_s1 = KEY_s1_end_xfer & (~KEY_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //KEY_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign KEY_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_KEY_s1 & KEY_s1_allgrants) | (end_xfer_arb_share_counter_term_KEY_s1 & ~KEY_s1_non_bursting_master_requests);

  //KEY_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY_s1_arb_share_counter <= 0;
      else if (KEY_s1_arb_counter_enable)
          KEY_s1_arb_share_counter <= KEY_s1_arb_share_counter_next_value;
    end


  //KEY_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY_s1_slavearbiterlockenable <= 0;
      else if ((|KEY_s1_master_qreq_vector & end_xfer_arb_share_counter_term_KEY_s1) | (end_xfer_arb_share_counter_term_KEY_s1 & ~KEY_s1_non_bursting_master_requests))
          KEY_s1_slavearbiterlockenable <= |KEY_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master KEY/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = KEY_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //KEY_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign KEY_s1_slavearbiterlockenable2 = |KEY_s1_arb_share_counter_next_value;

  //cpu_0/data_master KEY/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = KEY_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //KEY_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign KEY_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_KEY_s1 = cpu_0_data_master_requests_KEY_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_KEY_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_KEY_s1 = cpu_0_data_master_granted_KEY_s1 & cpu_0_data_master_read & ~KEY_s1_waits_for_read;

  //KEY_s1_writedata mux, which is an e_mux
  assign KEY_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_KEY_s1 = cpu_0_data_master_qualified_request_KEY_s1;

  //cpu_0/data_master saved-grant KEY/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_KEY_s1 = cpu_0_data_master_requests_KEY_s1;

  //allow new arb cycle for KEY/s1, which is an e_assign
  assign KEY_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign KEY_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign KEY_s1_master_qreq_vector = 1;

  //KEY_s1_reset_n assignment, which is an e_assign
  assign KEY_s1_reset_n = reset_n;

  assign KEY_s1_chipselect = cpu_0_data_master_granted_KEY_s1;
  //KEY_s1_firsttransfer first transaction, which is an e_assign
  assign KEY_s1_firsttransfer = KEY_s1_begins_xfer ? KEY_s1_unreg_firsttransfer : KEY_s1_reg_firsttransfer;

  //KEY_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign KEY_s1_unreg_firsttransfer = ~(KEY_s1_slavearbiterlockenable & KEY_s1_any_continuerequest);

  //KEY_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY_s1_reg_firsttransfer <= 1'b1;
      else if (KEY_s1_begins_xfer)
          KEY_s1_reg_firsttransfer <= KEY_s1_unreg_firsttransfer;
    end


  //KEY_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign KEY_s1_beginbursttransfer_internal = KEY_s1_begins_xfer;

  //~KEY_s1_write_n assignment, which is an e_mux
  assign KEY_s1_write_n = ~(cpu_0_data_master_granted_KEY_s1 & cpu_0_data_master_write);

  assign shifted_address_to_KEY_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //KEY_s1_address mux, which is an e_mux
  assign KEY_s1_address = shifted_address_to_KEY_s1_from_cpu_0_data_master >> 2;

  //d1_KEY_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_KEY_s1_end_xfer <= 1;
      else 
        d1_KEY_s1_end_xfer <= KEY_s1_end_xfer;
    end


  //KEY_s1_waits_for_read in a cycle, which is an e_mux
  assign KEY_s1_waits_for_read = KEY_s1_in_a_read_cycle & KEY_s1_begins_xfer;

  //KEY_s1_in_a_read_cycle assignment, which is an e_assign
  assign KEY_s1_in_a_read_cycle = cpu_0_data_master_granted_KEY_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = KEY_s1_in_a_read_cycle;

  //KEY_s1_waits_for_write in a cycle, which is an e_mux
  assign KEY_s1_waits_for_write = KEY_s1_in_a_write_cycle & 0;

  //KEY_s1_in_a_write_cycle assignment, which is an e_assign
  assign KEY_s1_in_a_write_cycle = cpu_0_data_master_granted_KEY_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = KEY_s1_in_a_write_cycle;

  assign wait_for_KEY_s1_counter = 0;
  //assign KEY_s1_irq_from_sa = KEY_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign KEY_s1_irq_from_sa = KEY_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //KEY/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module LEDG_s1_arbitrator (
                            // inputs:
                             LEDG_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_byteenable,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             LEDG_s1_address,
                             LEDG_s1_chipselect,
                             LEDG_s1_readdata_from_sa,
                             LEDG_s1_reset_n,
                             LEDG_s1_write_n,
                             LEDG_s1_writedata,
                             cpu_0_data_master_granted_LEDG_s1,
                             cpu_0_data_master_qualified_request_LEDG_s1,
                             cpu_0_data_master_read_data_valid_LEDG_s1,
                             cpu_0_data_master_requests_LEDG_s1,
                             d1_LEDG_s1_end_xfer
                          )
;

  output  [  1: 0] LEDG_s1_address;
  output           LEDG_s1_chipselect;
  output  [  7: 0] LEDG_s1_readdata_from_sa;
  output           LEDG_s1_reset_n;
  output           LEDG_s1_write_n;
  output  [  7: 0] LEDG_s1_writedata;
  output           cpu_0_data_master_granted_LEDG_s1;
  output           cpu_0_data_master_qualified_request_LEDG_s1;
  output           cpu_0_data_master_read_data_valid_LEDG_s1;
  output           cpu_0_data_master_requests_LEDG_s1;
  output           d1_LEDG_s1_end_xfer;
  input   [  7: 0] LEDG_s1_readdata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] LEDG_s1_address;
  wire             LEDG_s1_allgrants;
  wire             LEDG_s1_allow_new_arb_cycle;
  wire             LEDG_s1_any_bursting_master_saved_grant;
  wire             LEDG_s1_any_continuerequest;
  wire             LEDG_s1_arb_counter_enable;
  reg     [  1: 0] LEDG_s1_arb_share_counter;
  wire    [  1: 0] LEDG_s1_arb_share_counter_next_value;
  wire    [  1: 0] LEDG_s1_arb_share_set_values;
  wire             LEDG_s1_beginbursttransfer_internal;
  wire             LEDG_s1_begins_xfer;
  wire             LEDG_s1_chipselect;
  wire             LEDG_s1_end_xfer;
  wire             LEDG_s1_firsttransfer;
  wire             LEDG_s1_grant_vector;
  wire             LEDG_s1_in_a_read_cycle;
  wire             LEDG_s1_in_a_write_cycle;
  wire             LEDG_s1_master_qreq_vector;
  wire             LEDG_s1_non_bursting_master_requests;
  wire             LEDG_s1_pretend_byte_enable;
  wire    [  7: 0] LEDG_s1_readdata_from_sa;
  reg              LEDG_s1_reg_firsttransfer;
  wire             LEDG_s1_reset_n;
  reg              LEDG_s1_slavearbiterlockenable;
  wire             LEDG_s1_slavearbiterlockenable2;
  wire             LEDG_s1_unreg_firsttransfer;
  wire             LEDG_s1_waits_for_read;
  wire             LEDG_s1_waits_for_write;
  wire             LEDG_s1_write_n;
  wire    [  7: 0] LEDG_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_LEDG_s1;
  wire             cpu_0_data_master_qualified_request_LEDG_s1;
  wire             cpu_0_data_master_read_data_valid_LEDG_s1;
  wire             cpu_0_data_master_requests_LEDG_s1;
  wire             cpu_0_data_master_saved_grant_LEDG_s1;
  reg              d1_LEDG_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_LEDG_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 19: 0] shifted_address_to_LEDG_s1_from_cpu_0_data_master;
  wire             wait_for_LEDG_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~LEDG_s1_end_xfer;
    end


  assign LEDG_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_LEDG_s1));
  //assign LEDG_s1_readdata_from_sa = LEDG_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign LEDG_s1_readdata_from_sa = LEDG_s1_readdata;

  assign cpu_0_data_master_requests_LEDG_s1 = ({cpu_0_data_master_address_to_slave[19 : 4] , 4'b0} == 20'h810b0) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //LEDG_s1_arb_share_counter set values, which is an e_mux
  assign LEDG_s1_arb_share_set_values = 1;

  //LEDG_s1_non_bursting_master_requests mux, which is an e_mux
  assign LEDG_s1_non_bursting_master_requests = cpu_0_data_master_requests_LEDG_s1;

  //LEDG_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign LEDG_s1_any_bursting_master_saved_grant = 0;

  //LEDG_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign LEDG_s1_arb_share_counter_next_value = LEDG_s1_firsttransfer ? (LEDG_s1_arb_share_set_values - 1) : |LEDG_s1_arb_share_counter ? (LEDG_s1_arb_share_counter - 1) : 0;

  //LEDG_s1_allgrants all slave grants, which is an e_mux
  assign LEDG_s1_allgrants = |LEDG_s1_grant_vector;

  //LEDG_s1_end_xfer assignment, which is an e_assign
  assign LEDG_s1_end_xfer = ~(LEDG_s1_waits_for_read | LEDG_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_LEDG_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_LEDG_s1 = LEDG_s1_end_xfer & (~LEDG_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //LEDG_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign LEDG_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_LEDG_s1 & LEDG_s1_allgrants) | (end_xfer_arb_share_counter_term_LEDG_s1 & ~LEDG_s1_non_bursting_master_requests);

  //LEDG_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LEDG_s1_arb_share_counter <= 0;
      else if (LEDG_s1_arb_counter_enable)
          LEDG_s1_arb_share_counter <= LEDG_s1_arb_share_counter_next_value;
    end


  //LEDG_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LEDG_s1_slavearbiterlockenable <= 0;
      else if ((|LEDG_s1_master_qreq_vector & end_xfer_arb_share_counter_term_LEDG_s1) | (end_xfer_arb_share_counter_term_LEDG_s1 & ~LEDG_s1_non_bursting_master_requests))
          LEDG_s1_slavearbiterlockenable <= |LEDG_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master LEDG/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = LEDG_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //LEDG_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign LEDG_s1_slavearbiterlockenable2 = |LEDG_s1_arb_share_counter_next_value;

  //cpu_0/data_master LEDG/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = LEDG_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //LEDG_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign LEDG_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_LEDG_s1 = cpu_0_data_master_requests_LEDG_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_LEDG_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_LEDG_s1 = cpu_0_data_master_granted_LEDG_s1 & cpu_0_data_master_read & ~LEDG_s1_waits_for_read;

  //LEDG_s1_writedata mux, which is an e_mux
  assign LEDG_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_LEDG_s1 = cpu_0_data_master_qualified_request_LEDG_s1;

  //cpu_0/data_master saved-grant LEDG/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_LEDG_s1 = cpu_0_data_master_requests_LEDG_s1;

  //allow new arb cycle for LEDG/s1, which is an e_assign
  assign LEDG_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign LEDG_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign LEDG_s1_master_qreq_vector = 1;

  //LEDG_s1_reset_n assignment, which is an e_assign
  assign LEDG_s1_reset_n = reset_n;

  assign LEDG_s1_chipselect = cpu_0_data_master_granted_LEDG_s1;
  //LEDG_s1_firsttransfer first transaction, which is an e_assign
  assign LEDG_s1_firsttransfer = LEDG_s1_begins_xfer ? LEDG_s1_unreg_firsttransfer : LEDG_s1_reg_firsttransfer;

  //LEDG_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign LEDG_s1_unreg_firsttransfer = ~(LEDG_s1_slavearbiterlockenable & LEDG_s1_any_continuerequest);

  //LEDG_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LEDG_s1_reg_firsttransfer <= 1'b1;
      else if (LEDG_s1_begins_xfer)
          LEDG_s1_reg_firsttransfer <= LEDG_s1_unreg_firsttransfer;
    end


  //LEDG_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign LEDG_s1_beginbursttransfer_internal = LEDG_s1_begins_xfer;

  //~LEDG_s1_write_n assignment, which is an e_mux
  assign LEDG_s1_write_n = ~(((cpu_0_data_master_granted_LEDG_s1 & cpu_0_data_master_write)) & LEDG_s1_pretend_byte_enable);

  assign shifted_address_to_LEDG_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //LEDG_s1_address mux, which is an e_mux
  assign LEDG_s1_address = shifted_address_to_LEDG_s1_from_cpu_0_data_master >> 2;

  //d1_LEDG_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_LEDG_s1_end_xfer <= 1;
      else 
        d1_LEDG_s1_end_xfer <= LEDG_s1_end_xfer;
    end


  //LEDG_s1_waits_for_read in a cycle, which is an e_mux
  assign LEDG_s1_waits_for_read = LEDG_s1_in_a_read_cycle & LEDG_s1_begins_xfer;

  //LEDG_s1_in_a_read_cycle assignment, which is an e_assign
  assign LEDG_s1_in_a_read_cycle = cpu_0_data_master_granted_LEDG_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = LEDG_s1_in_a_read_cycle;

  //LEDG_s1_waits_for_write in a cycle, which is an e_mux
  assign LEDG_s1_waits_for_write = LEDG_s1_in_a_write_cycle & 0;

  //LEDG_s1_in_a_write_cycle assignment, which is an e_assign
  assign LEDG_s1_in_a_write_cycle = cpu_0_data_master_granted_LEDG_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = LEDG_s1_in_a_write_cycle;

  assign wait_for_LEDG_s1_counter = 0;
  //LEDG_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  assign LEDG_s1_pretend_byte_enable = (cpu_0_data_master_granted_LEDG_s1)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //LEDG/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_jtag_debug_module_arbitrator (
                                            // inputs:
                                             clk,
                                             cpu_0_data_master_address_to_slave,
                                             cpu_0_data_master_byteenable,
                                             cpu_0_data_master_debugaccess,
                                             cpu_0_data_master_latency_counter,
                                             cpu_0_data_master_read,
                                             cpu_0_data_master_write,
                                             cpu_0_data_master_writedata,
                                             cpu_0_instruction_master_address_to_slave,
                                             cpu_0_instruction_master_latency_counter,
                                             cpu_0_instruction_master_read,
                                             cpu_0_jtag_debug_module_readdata,
                                             cpu_0_jtag_debug_module_resetrequest,
                                             reset_n,

                                            // outputs:
                                             cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_jtag_debug_module_address,
                                             cpu_0_jtag_debug_module_begintransfer,
                                             cpu_0_jtag_debug_module_byteenable,
                                             cpu_0_jtag_debug_module_chipselect,
                                             cpu_0_jtag_debug_module_debugaccess,
                                             cpu_0_jtag_debug_module_readdata_from_sa,
                                             cpu_0_jtag_debug_module_reset_n,
                                             cpu_0_jtag_debug_module_resetrequest_from_sa,
                                             cpu_0_jtag_debug_module_write,
                                             cpu_0_jtag_debug_module_writedata,
                                             d1_cpu_0_jtag_debug_module_end_xfer
                                          )
;

  output           cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  output  [  8: 0] cpu_0_jtag_debug_module_address;
  output           cpu_0_jtag_debug_module_begintransfer;
  output  [  3: 0] cpu_0_jtag_debug_module_byteenable;
  output           cpu_0_jtag_debug_module_chipselect;
  output           cpu_0_jtag_debug_module_debugaccess;
  output  [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  output           cpu_0_jtag_debug_module_reset_n;
  output           cpu_0_jtag_debug_module_resetrequest_from_sa;
  output           cpu_0_jtag_debug_module_write;
  output  [ 31: 0] cpu_0_jtag_debug_module_writedata;
  output           d1_cpu_0_jtag_debug_module_end_xfer;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_debugaccess;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 19: 0] cpu_0_instruction_master_address_to_slave;
  input   [  1: 0] cpu_0_instruction_master_latency_counter;
  input            cpu_0_instruction_master_read;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata;
  input            cpu_0_jtag_debug_module_resetrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_allgrants;
  wire             cpu_0_jtag_debug_module_allow_new_arb_cycle;
  wire             cpu_0_jtag_debug_module_any_bursting_master_saved_grant;
  wire             cpu_0_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] cpu_0_jtag_debug_module_arb_addend;
  wire             cpu_0_jtag_debug_module_arb_counter_enable;
  reg     [  1: 0] cpu_0_jtag_debug_module_arb_share_counter;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_share_counter_next_value;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_winner;
  wire             cpu_0_jtag_debug_module_arbitration_holdoff_internal;
  wire             cpu_0_jtag_debug_module_beginbursttransfer_internal;
  wire             cpu_0_jtag_debug_module_begins_xfer;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire    [  3: 0] cpu_0_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] cpu_0_jtag_debug_module_chosen_master_rot_left;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire             cpu_0_jtag_debug_module_end_xfer;
  wire             cpu_0_jtag_debug_module_firsttransfer;
  wire    [  1: 0] cpu_0_jtag_debug_module_grant_vector;
  wire             cpu_0_jtag_debug_module_in_a_read_cycle;
  wire             cpu_0_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] cpu_0_jtag_debug_module_master_qreq_vector;
  wire             cpu_0_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  reg              cpu_0_jtag_debug_module_reg_firsttransfer;
  wire             cpu_0_jtag_debug_module_reset_n;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] cpu_0_jtag_debug_module_saved_chosen_master_vector;
  reg              cpu_0_jtag_debug_module_slavearbiterlockenable;
  wire             cpu_0_jtag_debug_module_slavearbiterlockenable2;
  wire             cpu_0_jtag_debug_module_unreg_firsttransfer;
  wire             cpu_0_jtag_debug_module_waits_for_read;
  wire             cpu_0_jtag_debug_module_waits_for_write;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  reg              d1_cpu_0_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
  wire    [ 19: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master;
  wire    [ 19: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master;
  wire             wait_for_cpu_0_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~cpu_0_jtag_debug_module_end_xfer;
    end


  assign cpu_0_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module));
  //assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata;

  assign cpu_0_data_master_requests_cpu_0_jtag_debug_module = ({cpu_0_data_master_address_to_slave[19 : 11] , 11'b0} == 20'h80800) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //cpu_0_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign cpu_0_jtag_debug_module_arb_share_set_values = 1;

  //cpu_0_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign cpu_0_jtag_debug_module_non_bursting_master_requests = cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module |
    cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpu_0_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //cpu_0_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_share_counter_next_value = cpu_0_jtag_debug_module_firsttransfer ? (cpu_0_jtag_debug_module_arb_share_set_values - 1) : |cpu_0_jtag_debug_module_arb_share_counter ? (cpu_0_jtag_debug_module_arb_share_counter - 1) : 0;

  //cpu_0_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign cpu_0_jtag_debug_module_allgrants = (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector);

  //cpu_0_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_end_xfer = ~(cpu_0_jtag_debug_module_waits_for_read | cpu_0_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_end_xfer & (~cpu_0_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpu_0_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & cpu_0_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests);

  //cpu_0_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_share_counter <= 0;
      else if (cpu_0_jtag_debug_module_arb_counter_enable)
          cpu_0_jtag_debug_module_arb_share_counter <= cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|cpu_0_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests))
          cpu_0_jtag_debug_module_slavearbiterlockenable <= |cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //cpu_0_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpu_0_jtag_debug_module_slavearbiterlockenable2 = |cpu_0_jtag_debug_module_arb_share_counter_next_value;

  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign cpu_0_jtag_debug_module_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_data_master_requests_cpu_0_jtag_debug_module & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))) | cpu_0_instruction_master_arbiterlock);
  //local readdatavalid cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module, which is an e_mux
  assign cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_read & ~cpu_0_jtag_debug_module_waits_for_read;

  //cpu_0_jtag_debug_module_writedata mux, which is an e_mux
  assign cpu_0_jtag_debug_module_writedata = cpu_0_data_master_writedata;

  assign cpu_0_instruction_master_requests_cpu_0_jtag_debug_module = (({cpu_0_instruction_master_address_to_slave[19 : 11] , 11'b0} == 20'h80800) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  assign cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_instruction_master_requests_cpu_0_jtag_debug_module & ~((cpu_0_instruction_master_read & ((cpu_0_instruction_master_latency_counter != 0))) | cpu_0_data_master_arbiterlock);
  //local readdatavalid cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module = cpu_0_instruction_master_granted_cpu_0_jtag_debug_module & cpu_0_instruction_master_read & ~cpu_0_jtag_debug_module_waits_for_read;

  //allow new arb cycle for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/instruction_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[0];

  //cpu_0/instruction_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[0] && cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/data_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[1] = cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/data_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[1];

  //cpu_0/data_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[1] && cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_double_vector = {cpu_0_jtag_debug_module_master_qreq_vector, cpu_0_jtag_debug_module_master_qreq_vector} & ({~cpu_0_jtag_debug_module_master_qreq_vector, ~cpu_0_jtag_debug_module_master_qreq_vector} + cpu_0_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign cpu_0_jtag_debug_module_arb_winner = (cpu_0_jtag_debug_module_allow_new_arb_cycle & | cpu_0_jtag_debug_module_grant_vector) ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;

  //saved cpu_0_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (cpu_0_jtag_debug_module_allow_new_arb_cycle)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= |cpu_0_jtag_debug_module_grant_vector ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign cpu_0_jtag_debug_module_grant_vector = {(cpu_0_jtag_debug_module_chosen_master_double_vector[1] | cpu_0_jtag_debug_module_chosen_master_double_vector[3]),
    (cpu_0_jtag_debug_module_chosen_master_double_vector[0] | cpu_0_jtag_debug_module_chosen_master_double_vector[2])};

  //cpu_0/jtag_debug_module chosen master rotated left, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_rot_left = (cpu_0_jtag_debug_module_arb_winner << 1) ? (cpu_0_jtag_debug_module_arb_winner << 1) : 1;

  //cpu_0/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_addend <= 1;
      else if (|cpu_0_jtag_debug_module_grant_vector)
          cpu_0_jtag_debug_module_arb_addend <= cpu_0_jtag_debug_module_end_xfer? cpu_0_jtag_debug_module_chosen_master_rot_left : cpu_0_jtag_debug_module_grant_vector;
    end


  assign cpu_0_jtag_debug_module_begintransfer = cpu_0_jtag_debug_module_begins_xfer;
  //cpu_0_jtag_debug_module_reset_n assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_reset_n = reset_n;

  //assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest;

  assign cpu_0_jtag_debug_module_chipselect = cpu_0_data_master_granted_cpu_0_jtag_debug_module | cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  //cpu_0_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_firsttransfer = cpu_0_jtag_debug_module_begins_xfer ? cpu_0_jtag_debug_module_unreg_firsttransfer : cpu_0_jtag_debug_module_reg_firsttransfer;

  //cpu_0_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_unreg_firsttransfer = ~(cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_jtag_debug_module_any_continuerequest);

  //cpu_0_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (cpu_0_jtag_debug_module_begins_xfer)
          cpu_0_jtag_debug_module_reg_firsttransfer <= cpu_0_jtag_debug_module_unreg_firsttransfer;
    end


  //cpu_0_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpu_0_jtag_debug_module_beginbursttransfer_internal = cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign cpu_0_jtag_debug_module_arbitration_holdoff_internal = cpu_0_jtag_debug_module_begins_xfer & cpu_0_jtag_debug_module_firsttransfer;

  //cpu_0_jtag_debug_module_write assignment, which is an e_mux
  assign cpu_0_jtag_debug_module_write = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //cpu_0_jtag_debug_module_address mux, which is an e_mux
  assign cpu_0_jtag_debug_module_address = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master >> 2) :
    (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master >> 2);

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master = cpu_0_instruction_master_address_to_slave;
  //d1_cpu_0_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpu_0_jtag_debug_module_end_xfer <= 1;
      else 
        d1_cpu_0_jtag_debug_module_end_xfer <= cpu_0_jtag_debug_module_end_xfer;
    end


  //cpu_0_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_read = cpu_0_jtag_debug_module_in_a_read_cycle & cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_read_cycle = (cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpu_0_jtag_debug_module_in_a_read_cycle;

  //cpu_0_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_write = cpu_0_jtag_debug_module_in_a_write_cycle & 0;

  //cpu_0_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_write_cycle = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpu_0_jtag_debug_module_in_a_write_cycle;

  assign wait_for_cpu_0_jtag_debug_module_counter = 0;
  //cpu_0_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign cpu_0_jtag_debug_module_byteenable = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_byteenable :
    -1;

  //debugaccess mux, which is an e_mux
  assign cpu_0_jtag_debug_module_debugaccess = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_debugaccess :
    0;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_cpu_0_jtag_debug_module + cpu_0_instruction_master_granted_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module + cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_data_master_arbitrator (
                                      // inputs:
                                       HEX0_s1_readdata_from_sa,
                                       HEX1_s1_readdata_from_sa,
                                       HEX2_s1_readdata_from_sa,
                                       HEX3_s1_readdata_from_sa,
                                       HEX4_s1_readdata_from_sa,
                                       HEX5_s1_readdata_from_sa,
                                       HEX6_s1_readdata_from_sa,
                                       HEX7_s1_readdata_from_sa,
                                       KEY_s1_irq_from_sa,
                                       KEY_s1_readdata_from_sa,
                                       LEDG_s1_readdata_from_sa,
                                       clk,
                                       cpu_0_data_master_address,
                                       cpu_0_data_master_byteenable,
                                       cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0,
                                       cpu_0_data_master_granted_HEX0_s1,
                                       cpu_0_data_master_granted_HEX1_s1,
                                       cpu_0_data_master_granted_HEX2_s1,
                                       cpu_0_data_master_granted_HEX3_s1,
                                       cpu_0_data_master_granted_HEX4_s1,
                                       cpu_0_data_master_granted_HEX5_s1,
                                       cpu_0_data_master_granted_HEX6_s1,
                                       cpu_0_data_master_granted_HEX7_s1,
                                       cpu_0_data_master_granted_KEY_s1,
                                       cpu_0_data_master_granted_LEDG_s1,
                                       cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_granted_lcd_0_control_slave,
                                       cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0,
                                       cpu_0_data_master_granted_timer_0_s1,
                                       cpu_0_data_master_qualified_request_HEX0_s1,
                                       cpu_0_data_master_qualified_request_HEX1_s1,
                                       cpu_0_data_master_qualified_request_HEX2_s1,
                                       cpu_0_data_master_qualified_request_HEX3_s1,
                                       cpu_0_data_master_qualified_request_HEX4_s1,
                                       cpu_0_data_master_qualified_request_HEX5_s1,
                                       cpu_0_data_master_qualified_request_HEX6_s1,
                                       cpu_0_data_master_qualified_request_HEX7_s1,
                                       cpu_0_data_master_qualified_request_KEY_s1,
                                       cpu_0_data_master_qualified_request_LEDG_s1,
                                       cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_qualified_request_lcd_0_control_slave,
                                       cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0,
                                       cpu_0_data_master_qualified_request_timer_0_s1,
                                       cpu_0_data_master_read,
                                       cpu_0_data_master_read_data_valid_HEX0_s1,
                                       cpu_0_data_master_read_data_valid_HEX1_s1,
                                       cpu_0_data_master_read_data_valid_HEX2_s1,
                                       cpu_0_data_master_read_data_valid_HEX3_s1,
                                       cpu_0_data_master_read_data_valid_HEX4_s1,
                                       cpu_0_data_master_read_data_valid_HEX5_s1,
                                       cpu_0_data_master_read_data_valid_HEX6_s1,
                                       cpu_0_data_master_read_data_valid_HEX7_s1,
                                       cpu_0_data_master_read_data_valid_KEY_s1,
                                       cpu_0_data_master_read_data_valid_LEDG_s1,
                                       cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_read_data_valid_lcd_0_control_slave,
                                       cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0,
                                       cpu_0_data_master_read_data_valid_timer_0_s1,
                                       cpu_0_data_master_requests_HEX0_s1,
                                       cpu_0_data_master_requests_HEX1_s1,
                                       cpu_0_data_master_requests_HEX2_s1,
                                       cpu_0_data_master_requests_HEX3_s1,
                                       cpu_0_data_master_requests_HEX4_s1,
                                       cpu_0_data_master_requests_HEX5_s1,
                                       cpu_0_data_master_requests_HEX6_s1,
                                       cpu_0_data_master_requests_HEX7_s1,
                                       cpu_0_data_master_requests_KEY_s1,
                                       cpu_0_data_master_requests_LEDG_s1,
                                       cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_requests_lcd_0_control_slave,
                                       cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0,
                                       cpu_0_data_master_requests_timer_0_s1,
                                       cpu_0_data_master_write,
                                       cpu_0_data_master_writedata,
                                       cpu_0_jtag_debug_module_readdata_from_sa,
                                       d1_HEX0_s1_end_xfer,
                                       d1_HEX1_s1_end_xfer,
                                       d1_HEX2_s1_end_xfer,
                                       d1_HEX3_s1_end_xfer,
                                       d1_HEX4_s1_end_xfer,
                                       d1_HEX5_s1_end_xfer,
                                       d1_HEX6_s1_end_xfer,
                                       d1_HEX7_s1_end_xfer,
                                       d1_KEY_s1_end_xfer,
                                       d1_LEDG_s1_end_xfer,
                                       d1_cpu_0_jtag_debug_module_end_xfer,
                                       d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
                                       d1_lcd_0_control_slave_end_xfer,
                                       d1_timer_0_s1_end_xfer,
                                       d1_tri_state_bridge_0_avalon_slave_end_xfer,
                                       incoming_data_to_and_from_the_static_ram_0,
                                       jtag_uart_0_avalon_jtag_slave_irq_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
                                       lcd_0_control_slave_readdata_from_sa,
                                       lcd_0_control_slave_wait_counter_eq_0,
                                       reset_n,
                                       timer_0_s1_irq_from_sa,
                                       timer_0_s1_readdata_from_sa,

                                      // outputs:
                                       cpu_0_data_master_address_to_slave,
                                       cpu_0_data_master_dbs_address,
                                       cpu_0_data_master_dbs_write_16,
                                       cpu_0_data_master_irq,
                                       cpu_0_data_master_latency_counter,
                                       cpu_0_data_master_readdata,
                                       cpu_0_data_master_readdatavalid,
                                       cpu_0_data_master_waitrequest
                                    )
;

  output  [ 19: 0] cpu_0_data_master_address_to_slave;
  output  [  1: 0] cpu_0_data_master_dbs_address;
  output  [ 15: 0] cpu_0_data_master_dbs_write_16;
  output  [ 31: 0] cpu_0_data_master_irq;
  output  [  1: 0] cpu_0_data_master_latency_counter;
  output  [ 31: 0] cpu_0_data_master_readdata;
  output           cpu_0_data_master_readdatavalid;
  output           cpu_0_data_master_waitrequest;
  input   [  6: 0] HEX0_s1_readdata_from_sa;
  input   [  6: 0] HEX1_s1_readdata_from_sa;
  input   [  6: 0] HEX2_s1_readdata_from_sa;
  input   [  6: 0] HEX3_s1_readdata_from_sa;
  input   [  6: 0] HEX4_s1_readdata_from_sa;
  input   [  6: 0] HEX5_s1_readdata_from_sa;
  input   [  6: 0] HEX6_s1_readdata_from_sa;
  input   [  6: 0] HEX7_s1_readdata_from_sa;
  input            KEY_s1_irq_from_sa;
  input   [  3: 0] KEY_s1_readdata_from_sa;
  input   [  7: 0] LEDG_s1_readdata_from_sa;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0;
  input            cpu_0_data_master_granted_HEX0_s1;
  input            cpu_0_data_master_granted_HEX1_s1;
  input            cpu_0_data_master_granted_HEX2_s1;
  input            cpu_0_data_master_granted_HEX3_s1;
  input            cpu_0_data_master_granted_HEX4_s1;
  input            cpu_0_data_master_granted_HEX5_s1;
  input            cpu_0_data_master_granted_HEX6_s1;
  input            cpu_0_data_master_granted_HEX7_s1;
  input            cpu_0_data_master_granted_KEY_s1;
  input            cpu_0_data_master_granted_LEDG_s1;
  input            cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_granted_lcd_0_control_slave;
  input            cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0;
  input            cpu_0_data_master_granted_timer_0_s1;
  input            cpu_0_data_master_qualified_request_HEX0_s1;
  input            cpu_0_data_master_qualified_request_HEX1_s1;
  input            cpu_0_data_master_qualified_request_HEX2_s1;
  input            cpu_0_data_master_qualified_request_HEX3_s1;
  input            cpu_0_data_master_qualified_request_HEX4_s1;
  input            cpu_0_data_master_qualified_request_HEX5_s1;
  input            cpu_0_data_master_qualified_request_HEX6_s1;
  input            cpu_0_data_master_qualified_request_HEX7_s1;
  input            cpu_0_data_master_qualified_request_KEY_s1;
  input            cpu_0_data_master_qualified_request_LEDG_s1;
  input            cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_qualified_request_lcd_0_control_slave;
  input            cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0;
  input            cpu_0_data_master_qualified_request_timer_0_s1;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_read_data_valid_HEX0_s1;
  input            cpu_0_data_master_read_data_valid_HEX1_s1;
  input            cpu_0_data_master_read_data_valid_HEX2_s1;
  input            cpu_0_data_master_read_data_valid_HEX3_s1;
  input            cpu_0_data_master_read_data_valid_HEX4_s1;
  input            cpu_0_data_master_read_data_valid_HEX5_s1;
  input            cpu_0_data_master_read_data_valid_HEX6_s1;
  input            cpu_0_data_master_read_data_valid_HEX7_s1;
  input            cpu_0_data_master_read_data_valid_KEY_s1;
  input            cpu_0_data_master_read_data_valid_LEDG_s1;
  input            cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_read_data_valid_lcd_0_control_slave;
  input            cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0;
  input            cpu_0_data_master_read_data_valid_timer_0_s1;
  input            cpu_0_data_master_requests_HEX0_s1;
  input            cpu_0_data_master_requests_HEX1_s1;
  input            cpu_0_data_master_requests_HEX2_s1;
  input            cpu_0_data_master_requests_HEX3_s1;
  input            cpu_0_data_master_requests_HEX4_s1;
  input            cpu_0_data_master_requests_HEX5_s1;
  input            cpu_0_data_master_requests_HEX6_s1;
  input            cpu_0_data_master_requests_HEX7_s1;
  input            cpu_0_data_master_requests_KEY_s1;
  input            cpu_0_data_master_requests_LEDG_s1;
  input            cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_requests_lcd_0_control_slave;
  input            cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0;
  input            cpu_0_data_master_requests_timer_0_s1;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_HEX0_s1_end_xfer;
  input            d1_HEX1_s1_end_xfer;
  input            d1_HEX2_s1_end_xfer;
  input            d1_HEX3_s1_end_xfer;
  input            d1_HEX4_s1_end_xfer;
  input            d1_HEX5_s1_end_xfer;
  input            d1_HEX6_s1_end_xfer;
  input            d1_HEX7_s1_end_xfer;
  input            d1_KEY_s1_end_xfer;
  input            d1_LEDG_s1_end_xfer;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  input            d1_lcd_0_control_slave_end_xfer;
  input            d1_timer_0_s1_end_xfer;
  input            d1_tri_state_bridge_0_avalon_slave_end_xfer;
  input   [ 15: 0] incoming_data_to_and_from_the_static_ram_0;
  input            jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  input   [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  input            jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  input   [  7: 0] lcd_0_control_slave_readdata_from_sa;
  input            lcd_0_control_slave_wait_counter_eq_0;
  input            reset_n;
  input            timer_0_s1_irq_from_sa;
  input   [ 15: 0] timer_0_s1_readdata_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 19: 0] cpu_0_data_master_address_last_time;
  wire    [ 19: 0] cpu_0_data_master_address_to_slave;
  reg     [  3: 0] cpu_0_data_master_byteenable_last_time;
  reg     [  1: 0] cpu_0_data_master_dbs_address;
  wire    [  1: 0] cpu_0_data_master_dbs_increment;
  reg     [  1: 0] cpu_0_data_master_dbs_rdv_counter;
  wire    [  1: 0] cpu_0_data_master_dbs_rdv_counter_inc;
  wire    [ 15: 0] cpu_0_data_master_dbs_write_16;
  wire    [ 31: 0] cpu_0_data_master_irq;
  wire             cpu_0_data_master_is_granted_some_slave;
  reg     [  1: 0] cpu_0_data_master_latency_counter;
  wire    [  1: 0] cpu_0_data_master_next_dbs_rdv_counter;
  reg              cpu_0_data_master_read_but_no_slave_selected;
  reg              cpu_0_data_master_read_last_time;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_readdatavalid;
  wire             cpu_0_data_master_run;
  wire             cpu_0_data_master_waitrequest;
  reg              cpu_0_data_master_write_last_time;
  reg     [ 31: 0] cpu_0_data_master_writedata_last_time;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  reg     [ 15: 0] dbs_latent_16_reg_segment_0;
  wire             dbs_rdv_count_enable;
  wire             dbs_rdv_counter_overflow;
  wire    [  1: 0] latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire    [  1: 0] p1_cpu_0_data_master_latency_counter;
  wire    [ 15: 0] p1_dbs_latent_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_0_data_master_readdatavalid;
  wire             r_0;
  wire             r_1;
  wire             r_2;
  wire             r_3;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_0_data_master_qualified_request_HEX0_s1 | ~cpu_0_data_master_requests_HEX0_s1) & ((~cpu_0_data_master_qualified_request_HEX0_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX0_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX0_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_HEX1_s1 | ~cpu_0_data_master_requests_HEX1_s1) & ((~cpu_0_data_master_qualified_request_HEX1_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX1_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX1_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_HEX2_s1 | ~cpu_0_data_master_requests_HEX2_s1) & ((~cpu_0_data_master_qualified_request_HEX2_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX2_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX2_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_HEX3_s1 | ~cpu_0_data_master_requests_HEX3_s1) & ((~cpu_0_data_master_qualified_request_HEX3_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX3_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX3_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_HEX4_s1 | ~cpu_0_data_master_requests_HEX4_s1) & ((~cpu_0_data_master_qualified_request_HEX4_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX4_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX4_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_data_master_run = r_0 & r_1 & r_2 & r_3;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (cpu_0_data_master_qualified_request_HEX5_s1 | ~cpu_0_data_master_requests_HEX5_s1) & ((~cpu_0_data_master_qualified_request_HEX5_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX5_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX5_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_HEX6_s1 | ~cpu_0_data_master_requests_HEX6_s1) & ((~cpu_0_data_master_qualified_request_HEX6_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX6_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX6_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_HEX7_s1 | ~cpu_0_data_master_requests_HEX7_s1) & ((~cpu_0_data_master_qualified_request_HEX7_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX7_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX7_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_KEY_s1 | ~cpu_0_data_master_requests_KEY_s1) & ((~cpu_0_data_master_qualified_request_KEY_s1 | ~cpu_0_data_master_read | (1 & ~d1_KEY_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_KEY_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_LEDG_s1 | ~cpu_0_data_master_requests_LEDG_s1) & ((~cpu_0_data_master_qualified_request_LEDG_s1 | ~cpu_0_data_master_read | (1 & ~d1_LEDG_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_LEDG_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write)));

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) & (cpu_0_data_master_granted_cpu_0_jtag_debug_module | ~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_read | (1 & ~d1_cpu_0_jtag_debug_module_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave) & ((~cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & ((~cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & (cpu_0_data_master_qualified_request_lcd_0_control_slave | ~cpu_0_data_master_requests_lcd_0_control_slave) & ((~cpu_0_data_master_qualified_request_lcd_0_control_slave | ~cpu_0_data_master_read | (1 & ((lcd_0_control_slave_wait_counter_eq_0 & ~d1_lcd_0_control_slave_end_xfer)) & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_lcd_0_control_slave | ~cpu_0_data_master_write | (1 & ((lcd_0_control_slave_wait_counter_eq_0 & ~d1_lcd_0_control_slave_end_xfer)) & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_timer_0_s1 | ~cpu_0_data_master_requests_timer_0_s1) & ((~cpu_0_data_master_qualified_request_timer_0_s1 | ~cpu_0_data_master_read | (1 & ~d1_timer_0_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_timer_0_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0 | (cpu_0_data_master_write & !cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0 & cpu_0_data_master_dbs_address[1]) | ~cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0) & (cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0 | ~cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0);

  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = ((~cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0 | ~cpu_0_data_master_read | (1 & ~d1_tri_state_bridge_0_avalon_slave_end_xfer & (cpu_0_data_master_dbs_address[1]) & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0 | ~cpu_0_data_master_write | (1 & ~d1_tri_state_bridge_0_avalon_slave_end_xfer & (cpu_0_data_master_dbs_address[1]) & cpu_0_data_master_write)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_data_master_address_to_slave = cpu_0_data_master_address[19 : 0];

  //cpu_0_data_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_read_but_no_slave_selected <= 0;
      else 
        cpu_0_data_master_read_but_no_slave_selected <= cpu_0_data_master_read & cpu_0_data_master_run & ~cpu_0_data_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_0_data_master_is_granted_some_slave = cpu_0_data_master_granted_HEX0_s1 |
    cpu_0_data_master_granted_HEX1_s1 |
    cpu_0_data_master_granted_HEX2_s1 |
    cpu_0_data_master_granted_HEX3_s1 |
    cpu_0_data_master_granted_HEX4_s1 |
    cpu_0_data_master_granted_HEX5_s1 |
    cpu_0_data_master_granted_HEX6_s1 |
    cpu_0_data_master_granted_HEX7_s1 |
    cpu_0_data_master_granted_KEY_s1 |
    cpu_0_data_master_granted_LEDG_s1 |
    cpu_0_data_master_granted_cpu_0_jtag_debug_module |
    cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave |
    cpu_0_data_master_granted_lcd_0_control_slave |
    cpu_0_data_master_granted_timer_0_s1 |
    cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_0_data_master_readdatavalid = cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0 & dbs_rdv_counter_overflow;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_0_data_master_readdatavalid = cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX0_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX1_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX2_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX3_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX4_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX5_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX6_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX7_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_KEY_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_LEDG_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_lcd_0_control_slave |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_timer_0_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid;

  //cpu_0/data_master readdata mux, which is an e_mux
  assign cpu_0_data_master_readdata = ({32 {~(cpu_0_data_master_qualified_request_HEX0_s1 & cpu_0_data_master_read)}} | HEX0_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX1_s1 & cpu_0_data_master_read)}} | HEX1_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX2_s1 & cpu_0_data_master_read)}} | HEX2_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX3_s1 & cpu_0_data_master_read)}} | HEX3_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX4_s1 & cpu_0_data_master_read)}} | HEX4_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX5_s1 & cpu_0_data_master_read)}} | HEX5_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX6_s1 & cpu_0_data_master_read)}} | HEX6_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX7_s1 & cpu_0_data_master_read)}} | HEX7_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_KEY_s1 & cpu_0_data_master_read)}} | KEY_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_LEDG_s1 & cpu_0_data_master_read)}} | LEDG_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module & cpu_0_data_master_read)}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read)}} | jtag_uart_0_avalon_jtag_slave_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_lcd_0_control_slave & cpu_0_data_master_read)}} | lcd_0_control_slave_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_timer_0_s1 & cpu_0_data_master_read)}} | timer_0_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0}} | {incoming_data_to_and_from_the_static_ram_0[15 : 0],
    dbs_latent_16_reg_segment_0});

  //actual waitrequest port, which is an e_assign
  assign cpu_0_data_master_waitrequest = ~cpu_0_data_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_latency_counter <= 0;
      else 
        cpu_0_data_master_latency_counter <= p1_cpu_0_data_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_0_data_master_latency_counter = ((cpu_0_data_master_run & cpu_0_data_master_read))? latency_load_value :
    (cpu_0_data_master_latency_counter)? cpu_0_data_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = {2 {cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0}} & 2;

  //irq assign, which is an e_assign
  assign cpu_0_data_master_irq = {1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    KEY_s1_irq_from_sa,
    timer_0_s1_irq_from_sa,
    jtag_uart_0_avalon_jtag_slave_irq_from_sa};

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = (((~0) & cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0 & cpu_0_data_master_write & !cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0)) |
    (cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0 & cpu_0_data_master_read & 1 & 1 & ~d1_tri_state_bridge_0_avalon_slave_end_xfer) |
    (cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0 & cpu_0_data_master_write & 1 & 1 & ~d1_tri_state_bridge_0_avalon_slave_end_xfer);

  //input to latent dbs-16 stored 0, which is an e_mux
  assign p1_dbs_latent_16_reg_segment_0 = incoming_data_to_and_from_the_static_ram_0;

  //dbs register for latent dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_latent_16_reg_segment_0 <= 0;
      else if (dbs_rdv_count_enable & ((cpu_0_data_master_dbs_rdv_counter[1]) == 0))
          dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
    end


  //mux write dbs 1, which is an e_mux
  assign cpu_0_data_master_dbs_write_16 = (cpu_0_data_master_dbs_address[1])? cpu_0_data_master_writedata[31 : 16] :
    cpu_0_data_master_writedata[15 : 0];

  //dbs count increment, which is an e_mux
  assign cpu_0_data_master_dbs_increment = (cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_0_data_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_0_data_master_dbs_address + cpu_0_data_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_0_data_master_dbs_address <= next_dbs_address;
    end


  //p1 dbs rdv counter, which is an e_assign
  assign cpu_0_data_master_next_dbs_rdv_counter = cpu_0_data_master_dbs_rdv_counter + cpu_0_data_master_dbs_rdv_counter_inc;

  //cpu_0_data_master_rdv_inc_mux, which is an e_mux
  assign cpu_0_data_master_dbs_rdv_counter_inc = 2;

  //master any slave rdv, which is an e_mux
  assign dbs_rdv_count_enable = cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0;

  //dbs rdv counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_dbs_rdv_counter <= 0;
      else if (dbs_rdv_count_enable)
          cpu_0_data_master_dbs_rdv_counter <= cpu_0_data_master_next_dbs_rdv_counter;
    end


  //dbs rdv counter overflow, which is an e_assign
  assign dbs_rdv_counter_overflow = cpu_0_data_master_dbs_rdv_counter[1] & ~cpu_0_data_master_next_dbs_rdv_counter[1];


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0_data_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_address_last_time <= 0;
      else 
        cpu_0_data_master_address_last_time <= cpu_0_data_master_address;
    end


  //cpu_0/data_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_0_data_master_waitrequest & (cpu_0_data_master_read | cpu_0_data_master_write);
    end


  //cpu_0_data_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_address != cpu_0_data_master_address_last_time))
        begin
          $write("%0d ns: cpu_0_data_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_data_master_byteenable check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_byteenable_last_time <= 0;
      else 
        cpu_0_data_master_byteenable_last_time <= cpu_0_data_master_byteenable;
    end


  //cpu_0_data_master_byteenable matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_byteenable != cpu_0_data_master_byteenable_last_time))
        begin
          $write("%0d ns: cpu_0_data_master_byteenable did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_data_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_read_last_time <= 0;
      else 
        cpu_0_data_master_read_last_time <= cpu_0_data_master_read;
    end


  //cpu_0_data_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_read != cpu_0_data_master_read_last_time))
        begin
          $write("%0d ns: cpu_0_data_master_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_data_master_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_write_last_time <= 0;
      else 
        cpu_0_data_master_write_last_time <= cpu_0_data_master_write;
    end


  //cpu_0_data_master_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_write != cpu_0_data_master_write_last_time))
        begin
          $write("%0d ns: cpu_0_data_master_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_data_master_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_writedata_last_time <= 0;
      else 
        cpu_0_data_master_writedata_last_time <= cpu_0_data_master_writedata;
    end


  //cpu_0_data_master_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_writedata != cpu_0_data_master_writedata_last_time) & cpu_0_data_master_write)
        begin
          $write("%0d ns: cpu_0_data_master_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_instruction_master_arbitrator (
                                             // inputs:
                                              clk,
                                              cpu_0_instruction_master_address,
                                              cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0,
                                              cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0,
                                              cpu_0_instruction_master_read,
                                              cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0,
                                              cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0,
                                              cpu_0_jtag_debug_module_readdata_from_sa,
                                              d1_cpu_0_jtag_debug_module_end_xfer,
                                              d1_tri_state_bridge_0_avalon_slave_end_xfer,
                                              incoming_data_to_and_from_the_static_ram_0,
                                              reset_n,

                                             // outputs:
                                              cpu_0_instruction_master_address_to_slave,
                                              cpu_0_instruction_master_dbs_address,
                                              cpu_0_instruction_master_latency_counter,
                                              cpu_0_instruction_master_readdata,
                                              cpu_0_instruction_master_readdatavalid,
                                              cpu_0_instruction_master_waitrequest
                                           )
;

  output  [ 19: 0] cpu_0_instruction_master_address_to_slave;
  output  [  1: 0] cpu_0_instruction_master_dbs_address;
  output  [  1: 0] cpu_0_instruction_master_latency_counter;
  output  [ 31: 0] cpu_0_instruction_master_readdata;
  output           cpu_0_instruction_master_readdatavalid;
  output           cpu_0_instruction_master_waitrequest;
  input            clk;
  input   [ 19: 0] cpu_0_instruction_master_address;
  input            cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0;
  input            cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0;
  input            cpu_0_instruction_master_read;
  input            cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0;
  input            cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_tri_state_bridge_0_avalon_slave_end_xfer;
  input   [ 15: 0] incoming_data_to_and_from_the_static_ram_0;
  input            reset_n;

  reg              active_and_waiting_last_time;
  reg     [ 19: 0] cpu_0_instruction_master_address_last_time;
  wire    [ 19: 0] cpu_0_instruction_master_address_to_slave;
  reg     [  1: 0] cpu_0_instruction_master_dbs_address;
  wire    [  1: 0] cpu_0_instruction_master_dbs_increment;
  reg     [  1: 0] cpu_0_instruction_master_dbs_rdv_counter;
  wire    [  1: 0] cpu_0_instruction_master_dbs_rdv_counter_inc;
  wire             cpu_0_instruction_master_is_granted_some_slave;
  reg     [  1: 0] cpu_0_instruction_master_latency_counter;
  wire    [  1: 0] cpu_0_instruction_master_next_dbs_rdv_counter;
  reg              cpu_0_instruction_master_read_but_no_slave_selected;
  reg              cpu_0_instruction_master_read_last_time;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_readdatavalid;
  wire             cpu_0_instruction_master_run;
  wire             cpu_0_instruction_master_waitrequest;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  reg     [ 15: 0] dbs_latent_16_reg_segment_0;
  wire             dbs_rdv_count_enable;
  wire             dbs_rdv_counter_overflow;
  wire    [  1: 0] latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire    [  1: 0] p1_cpu_0_instruction_master_latency_counter;
  wire    [ 15: 0] p1_dbs_latent_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_0_instruction_master_readdatavalid;
  wire             r_2;
  wire             r_3;
  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) & (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_read | (1 & ~d1_cpu_0_jtag_debug_module_end_xfer & cpu_0_instruction_master_read))) & 1 & (cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0 | ~cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0);

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_instruction_master_run = r_2 & r_3;

  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = (cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0 | ~cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0) & ((~cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0 | ~cpu_0_instruction_master_read | (1 & ~d1_tri_state_bridge_0_avalon_slave_end_xfer & (cpu_0_instruction_master_dbs_address[1]) & cpu_0_instruction_master_read)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_instruction_master_address_to_slave = cpu_0_instruction_master_address[19 : 0];

  //cpu_0_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_but_no_slave_selected <= 0;
      else 
        cpu_0_instruction_master_read_but_no_slave_selected <= cpu_0_instruction_master_read & cpu_0_instruction_master_run & ~cpu_0_instruction_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_0_instruction_master_is_granted_some_slave = cpu_0_instruction_master_granted_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_0_instruction_master_readdatavalid = cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0 & dbs_rdv_counter_overflow;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_0_instruction_master_readdatavalid = cpu_0_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_0_instruction_master_readdatavalid |
    cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_0_instruction_master_readdatavalid;

  //cpu_0/instruction_master readdata mux, which is an e_mux
  assign cpu_0_instruction_master_readdata = ({32 {~(cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module & cpu_0_instruction_master_read)}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0}} | {incoming_data_to_and_from_the_static_ram_0[15 : 0],
    dbs_latent_16_reg_segment_0});

  //actual waitrequest port, which is an e_assign
  assign cpu_0_instruction_master_waitrequest = ~cpu_0_instruction_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_latency_counter <= 0;
      else 
        cpu_0_instruction_master_latency_counter <= p1_cpu_0_instruction_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_0_instruction_master_latency_counter = ((cpu_0_instruction_master_run & cpu_0_instruction_master_read))? latency_load_value :
    (cpu_0_instruction_master_latency_counter)? cpu_0_instruction_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = {2 {cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0}} & 2;

  //input to latent dbs-16 stored 0, which is an e_mux
  assign p1_dbs_latent_16_reg_segment_0 = incoming_data_to_and_from_the_static_ram_0;

  //dbs register for latent dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_latent_16_reg_segment_0 <= 0;
      else if (dbs_rdv_count_enable & ((cpu_0_instruction_master_dbs_rdv_counter[1]) == 0))
          dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
    end


  //dbs count increment, which is an e_mux
  assign cpu_0_instruction_master_dbs_increment = (cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_0_instruction_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_0_instruction_master_dbs_address + cpu_0_instruction_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_0_instruction_master_dbs_address <= next_dbs_address;
    end


  //p1 dbs rdv counter, which is an e_assign
  assign cpu_0_instruction_master_next_dbs_rdv_counter = cpu_0_instruction_master_dbs_rdv_counter + cpu_0_instruction_master_dbs_rdv_counter_inc;

  //cpu_0_instruction_master_rdv_inc_mux, which is an e_mux
  assign cpu_0_instruction_master_dbs_rdv_counter_inc = 2;

  //master any slave rdv, which is an e_mux
  assign dbs_rdv_count_enable = cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0;

  //dbs rdv counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_dbs_rdv_counter <= 0;
      else if (dbs_rdv_count_enable)
          cpu_0_instruction_master_dbs_rdv_counter <= cpu_0_instruction_master_next_dbs_rdv_counter;
    end


  //dbs rdv counter overflow, which is an e_assign
  assign dbs_rdv_counter_overflow = cpu_0_instruction_master_dbs_rdv_counter[1] & ~cpu_0_instruction_master_next_dbs_rdv_counter[1];

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0 & cpu_0_instruction_master_read & 1 & 1 & ~d1_tri_state_bridge_0_avalon_slave_end_xfer;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_address_last_time <= 0;
      else 
        cpu_0_instruction_master_address_last_time <= cpu_0_instruction_master_address;
    end


  //cpu_0/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_0_instruction_master_waitrequest & (cpu_0_instruction_master_read);
    end


  //cpu_0_instruction_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_address != cpu_0_instruction_master_address_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_last_time <= 0;
      else 
        cpu_0_instruction_master_read_last_time <= cpu_0_instruction_master_read;
    end


  //cpu_0_instruction_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_read != cpu_0_instruction_master_read_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module jtag_uart_0_avalon_jtag_slave_arbitrator (
                                                  // inputs:
                                                   clk,
                                                   cpu_0_data_master_address_to_slave,
                                                   cpu_0_data_master_latency_counter,
                                                   cpu_0_data_master_read,
                                                   cpu_0_data_master_write,
                                                   cpu_0_data_master_writedata,
                                                   jtag_uart_0_avalon_jtag_slave_dataavailable,
                                                   jtag_uart_0_avalon_jtag_slave_irq,
                                                   jtag_uart_0_avalon_jtag_slave_readdata,
                                                   jtag_uart_0_avalon_jtag_slave_readyfordata,
                                                   jtag_uart_0_avalon_jtag_slave_waitrequest,
                                                   reset_n,

                                                  // outputs:
                                                   cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
                                                   d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
                                                   jtag_uart_0_avalon_jtag_slave_address,
                                                   jtag_uart_0_avalon_jtag_slave_chipselect,
                                                   jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_irq_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_read_n,
                                                   jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_reset_n,
                                                   jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_write_n,
                                                   jtag_uart_0_avalon_jtag_slave_writedata
                                                )
;

  output           cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  output           d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  output           jtag_uart_0_avalon_jtag_slave_address;
  output           jtag_uart_0_avalon_jtag_slave_chipselect;
  output           jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_read_n;
  output  [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_reset_n;
  output           jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_write_n;
  output  [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            jtag_uart_0_avalon_jtag_slave_dataavailable;
  input            jtag_uart_0_avalon_jtag_slave_irq;
  input   [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata;
  input            jtag_uart_0_avalon_jtag_slave_readyfordata;
  input            jtag_uart_0_avalon_jtag_slave_waitrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave;
  reg              d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_address;
  wire             jtag_uart_0_avalon_jtag_slave_allgrants;
  wire             jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant;
  wire             jtag_uart_0_avalon_jtag_slave_any_continuerequest;
  wire             jtag_uart_0_avalon_jtag_slave_arb_counter_enable;
  reg     [  1: 0] jtag_uart_0_avalon_jtag_slave_arb_share_counter;
  wire    [  1: 0] jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
  wire    [  1: 0] jtag_uart_0_avalon_jtag_slave_arb_share_set_values;
  wire             jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal;
  wire             jtag_uart_0_avalon_jtag_slave_begins_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_chipselect;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_end_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_grant_vector;
  wire             jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_master_qreq_vector;
  wire             jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests;
  wire             jtag_uart_0_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  reg              jtag_uart_0_avalon_jtag_slave_reg_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_reset_n;
  reg              jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable;
  wire             jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2;
  wire             jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_waits_for_read;
  wire             jtag_uart_0_avalon_jtag_slave_waits_for_write;
  wire             jtag_uart_0_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  wire    [ 19: 0] shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master;
  wire             wait_for_jtag_uart_0_avalon_jtag_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~jtag_uart_0_avalon_jtag_slave_end_xfer;
    end


  assign jtag_uart_0_avalon_jtag_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave));
  //assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata;

  assign cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave = ({cpu_0_data_master_address_to_slave[19 : 3] , 3'b0} == 20'h810d0) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable;

  //assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata;

  //assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest;

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_arb_share_set_values = 1;

  //jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;

  //jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant = 0;

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value = jtag_uart_0_avalon_jtag_slave_firsttransfer ? (jtag_uart_0_avalon_jtag_slave_arb_share_set_values - 1) : |jtag_uart_0_avalon_jtag_slave_arb_share_counter ? (jtag_uart_0_avalon_jtag_slave_arb_share_counter - 1) : 0;

  //jtag_uart_0_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_allgrants = |jtag_uart_0_avalon_jtag_slave_grant_vector;

  //jtag_uart_0_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_end_xfer = ~(jtag_uart_0_avalon_jtag_slave_waits_for_read | jtag_uart_0_avalon_jtag_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave = jtag_uart_0_avalon_jtag_slave_end_xfer & (~jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & jtag_uart_0_avalon_jtag_slave_allgrants) | (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & ~jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests);

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_arb_share_counter <= 0;
      else if (jtag_uart_0_avalon_jtag_slave_arb_counter_enable)
          jtag_uart_0_avalon_jtag_slave_arb_share_counter <= jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= 0;
      else if ((|jtag_uart_0_avalon_jtag_slave_master_qreq_vector & end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave) | (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & ~jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests))
          jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= |jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 = |jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;

  //cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //jtag_uart_0_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave, which is an e_mux
  assign cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read & ~jtag_uart_0_avalon_jtag_slave_waits_for_read;

  //jtag_uart_0_avalon_jtag_slave_writedata mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;

  //cpu_0/data_master saved-grant jtag_uart_0/avalon_jtag_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;

  //allow new arb cycle for jtag_uart_0/avalon_jtag_slave, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign jtag_uart_0_avalon_jtag_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign jtag_uart_0_avalon_jtag_slave_master_qreq_vector = 1;

  //jtag_uart_0_avalon_jtag_slave_reset_n assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_reset_n = reset_n;

  assign jtag_uart_0_avalon_jtag_slave_chipselect = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  //jtag_uart_0_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_firsttransfer = jtag_uart_0_avalon_jtag_slave_begins_xfer ? jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer : jtag_uart_0_avalon_jtag_slave_reg_firsttransfer;

  //jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer = ~(jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable & jtag_uart_0_avalon_jtag_slave_any_continuerequest);

  //jtag_uart_0_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= 1'b1;
      else if (jtag_uart_0_avalon_jtag_slave_begins_xfer)
          jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
    end


  //jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal = jtag_uart_0_avalon_jtag_slave_begins_xfer;

  //~jtag_uart_0_avalon_jtag_slave_read_n assignment, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_read_n = ~(cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read);

  //~jtag_uart_0_avalon_jtag_slave_write_n assignment, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_write_n = ~(cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_write);

  assign shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //jtag_uart_0_avalon_jtag_slave_address mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_address = shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master >> 2;

  //d1_jtag_uart_0_avalon_jtag_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= 1;
      else 
        d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= jtag_uart_0_avalon_jtag_slave_end_xfer;
    end


  //jtag_uart_0_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_waits_for_read = jtag_uart_0_avalon_jtag_slave_in_a_read_cycle & jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_0_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_in_a_read_cycle = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;

  //jtag_uart_0_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_waits_for_write = jtag_uart_0_avalon_jtag_slave_in_a_write_cycle & jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_0_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_in_a_write_cycle = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;

  assign wait_for_jtag_uart_0_avalon_jtag_slave_counter = 0;
  //assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //jtag_uart_0/avalon_jtag_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module lcd_0_control_slave_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_0_data_master_address_to_slave,
                                         cpu_0_data_master_byteenable,
                                         cpu_0_data_master_latency_counter,
                                         cpu_0_data_master_read,
                                         cpu_0_data_master_write,
                                         cpu_0_data_master_writedata,
                                         lcd_0_control_slave_readdata,
                                         reset_n,

                                        // outputs:
                                         cpu_0_data_master_granted_lcd_0_control_slave,
                                         cpu_0_data_master_qualified_request_lcd_0_control_slave,
                                         cpu_0_data_master_read_data_valid_lcd_0_control_slave,
                                         cpu_0_data_master_requests_lcd_0_control_slave,
                                         d1_lcd_0_control_slave_end_xfer,
                                         lcd_0_control_slave_address,
                                         lcd_0_control_slave_begintransfer,
                                         lcd_0_control_slave_read,
                                         lcd_0_control_slave_readdata_from_sa,
                                         lcd_0_control_slave_wait_counter_eq_0,
                                         lcd_0_control_slave_write,
                                         lcd_0_control_slave_writedata
                                      )
;

  output           cpu_0_data_master_granted_lcd_0_control_slave;
  output           cpu_0_data_master_qualified_request_lcd_0_control_slave;
  output           cpu_0_data_master_read_data_valid_lcd_0_control_slave;
  output           cpu_0_data_master_requests_lcd_0_control_slave;
  output           d1_lcd_0_control_slave_end_xfer;
  output  [  1: 0] lcd_0_control_slave_address;
  output           lcd_0_control_slave_begintransfer;
  output           lcd_0_control_slave_read;
  output  [  7: 0] lcd_0_control_slave_readdata_from_sa;
  output           lcd_0_control_slave_wait_counter_eq_0;
  output           lcd_0_control_slave_write;
  output  [  7: 0] lcd_0_control_slave_writedata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [  7: 0] lcd_0_control_slave_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_lcd_0_control_slave;
  wire             cpu_0_data_master_qualified_request_lcd_0_control_slave;
  wire             cpu_0_data_master_read_data_valid_lcd_0_control_slave;
  wire             cpu_0_data_master_requests_lcd_0_control_slave;
  wire             cpu_0_data_master_saved_grant_lcd_0_control_slave;
  reg              d1_lcd_0_control_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_lcd_0_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] lcd_0_control_slave_address;
  wire             lcd_0_control_slave_allgrants;
  wire             lcd_0_control_slave_allow_new_arb_cycle;
  wire             lcd_0_control_slave_any_bursting_master_saved_grant;
  wire             lcd_0_control_slave_any_continuerequest;
  wire             lcd_0_control_slave_arb_counter_enable;
  reg     [  1: 0] lcd_0_control_slave_arb_share_counter;
  wire    [  1: 0] lcd_0_control_slave_arb_share_counter_next_value;
  wire    [  1: 0] lcd_0_control_slave_arb_share_set_values;
  wire             lcd_0_control_slave_beginbursttransfer_internal;
  wire             lcd_0_control_slave_begins_xfer;
  wire             lcd_0_control_slave_begintransfer;
  wire    [  5: 0] lcd_0_control_slave_counter_load_value;
  wire             lcd_0_control_slave_end_xfer;
  wire             lcd_0_control_slave_firsttransfer;
  wire             lcd_0_control_slave_grant_vector;
  wire             lcd_0_control_slave_in_a_read_cycle;
  wire             lcd_0_control_slave_in_a_write_cycle;
  wire             lcd_0_control_slave_master_qreq_vector;
  wire             lcd_0_control_slave_non_bursting_master_requests;
  wire             lcd_0_control_slave_pretend_byte_enable;
  wire             lcd_0_control_slave_read;
  wire    [  7: 0] lcd_0_control_slave_readdata_from_sa;
  reg              lcd_0_control_slave_reg_firsttransfer;
  reg              lcd_0_control_slave_slavearbiterlockenable;
  wire             lcd_0_control_slave_slavearbiterlockenable2;
  wire             lcd_0_control_slave_unreg_firsttransfer;
  reg     [  5: 0] lcd_0_control_slave_wait_counter;
  wire             lcd_0_control_slave_wait_counter_eq_0;
  wire             lcd_0_control_slave_waits_for_read;
  wire             lcd_0_control_slave_waits_for_write;
  wire             lcd_0_control_slave_write;
  wire    [  7: 0] lcd_0_control_slave_writedata;
  wire    [ 19: 0] shifted_address_to_lcd_0_control_slave_from_cpu_0_data_master;
  wire             wait_for_lcd_0_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~lcd_0_control_slave_end_xfer;
    end


  assign lcd_0_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_lcd_0_control_slave));
  //assign lcd_0_control_slave_readdata_from_sa = lcd_0_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign lcd_0_control_slave_readdata_from_sa = lcd_0_control_slave_readdata;

  assign cpu_0_data_master_requests_lcd_0_control_slave = ({cpu_0_data_master_address_to_slave[19 : 4] , 4'b0} == 20'h81020) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //lcd_0_control_slave_arb_share_counter set values, which is an e_mux
  assign lcd_0_control_slave_arb_share_set_values = 1;

  //lcd_0_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign lcd_0_control_slave_non_bursting_master_requests = cpu_0_data_master_requests_lcd_0_control_slave;

  //lcd_0_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign lcd_0_control_slave_any_bursting_master_saved_grant = 0;

  //lcd_0_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign lcd_0_control_slave_arb_share_counter_next_value = lcd_0_control_slave_firsttransfer ? (lcd_0_control_slave_arb_share_set_values - 1) : |lcd_0_control_slave_arb_share_counter ? (lcd_0_control_slave_arb_share_counter - 1) : 0;

  //lcd_0_control_slave_allgrants all slave grants, which is an e_mux
  assign lcd_0_control_slave_allgrants = |lcd_0_control_slave_grant_vector;

  //lcd_0_control_slave_end_xfer assignment, which is an e_assign
  assign lcd_0_control_slave_end_xfer = ~(lcd_0_control_slave_waits_for_read | lcd_0_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_lcd_0_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_lcd_0_control_slave = lcd_0_control_slave_end_xfer & (~lcd_0_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //lcd_0_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign lcd_0_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_lcd_0_control_slave & lcd_0_control_slave_allgrants) | (end_xfer_arb_share_counter_term_lcd_0_control_slave & ~lcd_0_control_slave_non_bursting_master_requests);

  //lcd_0_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_0_control_slave_arb_share_counter <= 0;
      else if (lcd_0_control_slave_arb_counter_enable)
          lcd_0_control_slave_arb_share_counter <= lcd_0_control_slave_arb_share_counter_next_value;
    end


  //lcd_0_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_0_control_slave_slavearbiterlockenable <= 0;
      else if ((|lcd_0_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_lcd_0_control_slave) | (end_xfer_arb_share_counter_term_lcd_0_control_slave & ~lcd_0_control_slave_non_bursting_master_requests))
          lcd_0_control_slave_slavearbiterlockenable <= |lcd_0_control_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master lcd_0/control_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = lcd_0_control_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //lcd_0_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign lcd_0_control_slave_slavearbiterlockenable2 = |lcd_0_control_slave_arb_share_counter_next_value;

  //cpu_0/data_master lcd_0/control_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = lcd_0_control_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //lcd_0_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign lcd_0_control_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_lcd_0_control_slave = cpu_0_data_master_requests_lcd_0_control_slave & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_lcd_0_control_slave, which is an e_mux
  assign cpu_0_data_master_read_data_valid_lcd_0_control_slave = cpu_0_data_master_granted_lcd_0_control_slave & cpu_0_data_master_read & ~lcd_0_control_slave_waits_for_read;

  //lcd_0_control_slave_writedata mux, which is an e_mux
  assign lcd_0_control_slave_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_lcd_0_control_slave = cpu_0_data_master_qualified_request_lcd_0_control_slave;

  //cpu_0/data_master saved-grant lcd_0/control_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_lcd_0_control_slave = cpu_0_data_master_requests_lcd_0_control_slave;

  //allow new arb cycle for lcd_0/control_slave, which is an e_assign
  assign lcd_0_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign lcd_0_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign lcd_0_control_slave_master_qreq_vector = 1;

  assign lcd_0_control_slave_begintransfer = lcd_0_control_slave_begins_xfer;
  //lcd_0_control_slave_firsttransfer first transaction, which is an e_assign
  assign lcd_0_control_slave_firsttransfer = lcd_0_control_slave_begins_xfer ? lcd_0_control_slave_unreg_firsttransfer : lcd_0_control_slave_reg_firsttransfer;

  //lcd_0_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign lcd_0_control_slave_unreg_firsttransfer = ~(lcd_0_control_slave_slavearbiterlockenable & lcd_0_control_slave_any_continuerequest);

  //lcd_0_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_0_control_slave_reg_firsttransfer <= 1'b1;
      else if (lcd_0_control_slave_begins_xfer)
          lcd_0_control_slave_reg_firsttransfer <= lcd_0_control_slave_unreg_firsttransfer;
    end


  //lcd_0_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign lcd_0_control_slave_beginbursttransfer_internal = lcd_0_control_slave_begins_xfer;

  //lcd_0_control_slave_read assignment, which is an e_mux
  assign lcd_0_control_slave_read = ((cpu_0_data_master_granted_lcd_0_control_slave & cpu_0_data_master_read))& ~lcd_0_control_slave_begins_xfer & (lcd_0_control_slave_wait_counter < 13);

  //lcd_0_control_slave_write assignment, which is an e_mux
  assign lcd_0_control_slave_write = ((cpu_0_data_master_granted_lcd_0_control_slave & cpu_0_data_master_write)) & ~lcd_0_control_slave_begins_xfer & (lcd_0_control_slave_wait_counter >= 13) & (lcd_0_control_slave_wait_counter < 26) & lcd_0_control_slave_pretend_byte_enable;

  assign shifted_address_to_lcd_0_control_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //lcd_0_control_slave_address mux, which is an e_mux
  assign lcd_0_control_slave_address = shifted_address_to_lcd_0_control_slave_from_cpu_0_data_master >> 2;

  //d1_lcd_0_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_lcd_0_control_slave_end_xfer <= 1;
      else 
        d1_lcd_0_control_slave_end_xfer <= lcd_0_control_slave_end_xfer;
    end


  //lcd_0_control_slave_waits_for_read in a cycle, which is an e_mux
  assign lcd_0_control_slave_waits_for_read = lcd_0_control_slave_in_a_read_cycle & wait_for_lcd_0_control_slave_counter;

  //lcd_0_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign lcd_0_control_slave_in_a_read_cycle = cpu_0_data_master_granted_lcd_0_control_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = lcd_0_control_slave_in_a_read_cycle;

  //lcd_0_control_slave_waits_for_write in a cycle, which is an e_mux
  assign lcd_0_control_slave_waits_for_write = lcd_0_control_slave_in_a_write_cycle & wait_for_lcd_0_control_slave_counter;

  //lcd_0_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign lcd_0_control_slave_in_a_write_cycle = cpu_0_data_master_granted_lcd_0_control_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = lcd_0_control_slave_in_a_write_cycle;

  assign lcd_0_control_slave_wait_counter_eq_0 = lcd_0_control_slave_wait_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_0_control_slave_wait_counter <= 0;
      else 
        lcd_0_control_slave_wait_counter <= lcd_0_control_slave_counter_load_value;
    end


  assign lcd_0_control_slave_counter_load_value = ((lcd_0_control_slave_in_a_read_cycle & lcd_0_control_slave_begins_xfer))? 24 :
    ((lcd_0_control_slave_in_a_write_cycle & lcd_0_control_slave_begins_xfer))? 37 :
    (~lcd_0_control_slave_wait_counter_eq_0)? lcd_0_control_slave_wait_counter - 1 :
    0;

  assign wait_for_lcd_0_control_slave_counter = lcd_0_control_slave_begins_xfer | ~lcd_0_control_slave_wait_counter_eq_0;
  //lcd_0_control_slave_pretend_byte_enable byte enable port mux, which is an e_mux
  assign lcd_0_control_slave_pretend_byte_enable = (cpu_0_data_master_granted_lcd_0_control_slave)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //lcd_0/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module timer_0_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_0_data_master_address_to_slave,
                                cpu_0_data_master_latency_counter,
                                cpu_0_data_master_read,
                                cpu_0_data_master_write,
                                cpu_0_data_master_writedata,
                                reset_n,
                                timer_0_s1_irq,
                                timer_0_s1_readdata,

                               // outputs:
                                cpu_0_data_master_granted_timer_0_s1,
                                cpu_0_data_master_qualified_request_timer_0_s1,
                                cpu_0_data_master_read_data_valid_timer_0_s1,
                                cpu_0_data_master_requests_timer_0_s1,
                                d1_timer_0_s1_end_xfer,
                                timer_0_s1_address,
                                timer_0_s1_chipselect,
                                timer_0_s1_irq_from_sa,
                                timer_0_s1_readdata_from_sa,
                                timer_0_s1_reset_n,
                                timer_0_s1_write_n,
                                timer_0_s1_writedata
                             )
;

  output           cpu_0_data_master_granted_timer_0_s1;
  output           cpu_0_data_master_qualified_request_timer_0_s1;
  output           cpu_0_data_master_read_data_valid_timer_0_s1;
  output           cpu_0_data_master_requests_timer_0_s1;
  output           d1_timer_0_s1_end_xfer;
  output  [  2: 0] timer_0_s1_address;
  output           timer_0_s1_chipselect;
  output           timer_0_s1_irq_from_sa;
  output  [ 15: 0] timer_0_s1_readdata_from_sa;
  output           timer_0_s1_reset_n;
  output           timer_0_s1_write_n;
  output  [ 15: 0] timer_0_s1_writedata;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;
  input            timer_0_s1_irq;
  input   [ 15: 0] timer_0_s1_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_timer_0_s1;
  wire             cpu_0_data_master_qualified_request_timer_0_s1;
  wire             cpu_0_data_master_read_data_valid_timer_0_s1;
  wire             cpu_0_data_master_requests_timer_0_s1;
  wire             cpu_0_data_master_saved_grant_timer_0_s1;
  reg              d1_reasons_to_wait;
  reg              d1_timer_0_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_timer_0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 19: 0] shifted_address_to_timer_0_s1_from_cpu_0_data_master;
  wire    [  2: 0] timer_0_s1_address;
  wire             timer_0_s1_allgrants;
  wire             timer_0_s1_allow_new_arb_cycle;
  wire             timer_0_s1_any_bursting_master_saved_grant;
  wire             timer_0_s1_any_continuerequest;
  wire             timer_0_s1_arb_counter_enable;
  reg     [  1: 0] timer_0_s1_arb_share_counter;
  wire    [  1: 0] timer_0_s1_arb_share_counter_next_value;
  wire    [  1: 0] timer_0_s1_arb_share_set_values;
  wire             timer_0_s1_beginbursttransfer_internal;
  wire             timer_0_s1_begins_xfer;
  wire             timer_0_s1_chipselect;
  wire             timer_0_s1_end_xfer;
  wire             timer_0_s1_firsttransfer;
  wire             timer_0_s1_grant_vector;
  wire             timer_0_s1_in_a_read_cycle;
  wire             timer_0_s1_in_a_write_cycle;
  wire             timer_0_s1_irq_from_sa;
  wire             timer_0_s1_master_qreq_vector;
  wire             timer_0_s1_non_bursting_master_requests;
  wire    [ 15: 0] timer_0_s1_readdata_from_sa;
  reg              timer_0_s1_reg_firsttransfer;
  wire             timer_0_s1_reset_n;
  reg              timer_0_s1_slavearbiterlockenable;
  wire             timer_0_s1_slavearbiterlockenable2;
  wire             timer_0_s1_unreg_firsttransfer;
  wire             timer_0_s1_waits_for_read;
  wire             timer_0_s1_waits_for_write;
  wire             timer_0_s1_write_n;
  wire    [ 15: 0] timer_0_s1_writedata;
  wire             wait_for_timer_0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~timer_0_s1_end_xfer;
    end


  assign timer_0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_timer_0_s1));
  //assign timer_0_s1_readdata_from_sa = timer_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_0_s1_readdata_from_sa = timer_0_s1_readdata;

  assign cpu_0_data_master_requests_timer_0_s1 = ({cpu_0_data_master_address_to_slave[19 : 5] , 5'b0} == 20'h81000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //timer_0_s1_arb_share_counter set values, which is an e_mux
  assign timer_0_s1_arb_share_set_values = 1;

  //timer_0_s1_non_bursting_master_requests mux, which is an e_mux
  assign timer_0_s1_non_bursting_master_requests = cpu_0_data_master_requests_timer_0_s1;

  //timer_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign timer_0_s1_any_bursting_master_saved_grant = 0;

  //timer_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign timer_0_s1_arb_share_counter_next_value = timer_0_s1_firsttransfer ? (timer_0_s1_arb_share_set_values - 1) : |timer_0_s1_arb_share_counter ? (timer_0_s1_arb_share_counter - 1) : 0;

  //timer_0_s1_allgrants all slave grants, which is an e_mux
  assign timer_0_s1_allgrants = |timer_0_s1_grant_vector;

  //timer_0_s1_end_xfer assignment, which is an e_assign
  assign timer_0_s1_end_xfer = ~(timer_0_s1_waits_for_read | timer_0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_timer_0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_timer_0_s1 = timer_0_s1_end_xfer & (~timer_0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //timer_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign timer_0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_timer_0_s1 & timer_0_s1_allgrants) | (end_xfer_arb_share_counter_term_timer_0_s1 & ~timer_0_s1_non_bursting_master_requests);

  //timer_0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_0_s1_arb_share_counter <= 0;
      else if (timer_0_s1_arb_counter_enable)
          timer_0_s1_arb_share_counter <= timer_0_s1_arb_share_counter_next_value;
    end


  //timer_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_0_s1_slavearbiterlockenable <= 0;
      else if ((|timer_0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_timer_0_s1) | (end_xfer_arb_share_counter_term_timer_0_s1 & ~timer_0_s1_non_bursting_master_requests))
          timer_0_s1_slavearbiterlockenable <= |timer_0_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master timer_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = timer_0_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //timer_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign timer_0_s1_slavearbiterlockenable2 = |timer_0_s1_arb_share_counter_next_value;

  //cpu_0/data_master timer_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = timer_0_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //timer_0_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign timer_0_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_timer_0_s1 = cpu_0_data_master_requests_timer_0_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_timer_0_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_timer_0_s1 = cpu_0_data_master_granted_timer_0_s1 & cpu_0_data_master_read & ~timer_0_s1_waits_for_read;

  //timer_0_s1_writedata mux, which is an e_mux
  assign timer_0_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_timer_0_s1 = cpu_0_data_master_qualified_request_timer_0_s1;

  //cpu_0/data_master saved-grant timer_0/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_timer_0_s1 = cpu_0_data_master_requests_timer_0_s1;

  //allow new arb cycle for timer_0/s1, which is an e_assign
  assign timer_0_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign timer_0_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign timer_0_s1_master_qreq_vector = 1;

  //timer_0_s1_reset_n assignment, which is an e_assign
  assign timer_0_s1_reset_n = reset_n;

  assign timer_0_s1_chipselect = cpu_0_data_master_granted_timer_0_s1;
  //timer_0_s1_firsttransfer first transaction, which is an e_assign
  assign timer_0_s1_firsttransfer = timer_0_s1_begins_xfer ? timer_0_s1_unreg_firsttransfer : timer_0_s1_reg_firsttransfer;

  //timer_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign timer_0_s1_unreg_firsttransfer = ~(timer_0_s1_slavearbiterlockenable & timer_0_s1_any_continuerequest);

  //timer_0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_0_s1_reg_firsttransfer <= 1'b1;
      else if (timer_0_s1_begins_xfer)
          timer_0_s1_reg_firsttransfer <= timer_0_s1_unreg_firsttransfer;
    end


  //timer_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign timer_0_s1_beginbursttransfer_internal = timer_0_s1_begins_xfer;

  //~timer_0_s1_write_n assignment, which is an e_mux
  assign timer_0_s1_write_n = ~(cpu_0_data_master_granted_timer_0_s1 & cpu_0_data_master_write);

  assign shifted_address_to_timer_0_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //timer_0_s1_address mux, which is an e_mux
  assign timer_0_s1_address = shifted_address_to_timer_0_s1_from_cpu_0_data_master >> 2;

  //d1_timer_0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_timer_0_s1_end_xfer <= 1;
      else 
        d1_timer_0_s1_end_xfer <= timer_0_s1_end_xfer;
    end


  //timer_0_s1_waits_for_read in a cycle, which is an e_mux
  assign timer_0_s1_waits_for_read = timer_0_s1_in_a_read_cycle & timer_0_s1_begins_xfer;

  //timer_0_s1_in_a_read_cycle assignment, which is an e_assign
  assign timer_0_s1_in_a_read_cycle = cpu_0_data_master_granted_timer_0_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = timer_0_s1_in_a_read_cycle;

  //timer_0_s1_waits_for_write in a cycle, which is an e_mux
  assign timer_0_s1_waits_for_write = timer_0_s1_in_a_write_cycle & 0;

  //timer_0_s1_in_a_write_cycle assignment, which is an e_assign
  assign timer_0_s1_in_a_write_cycle = cpu_0_data_master_granted_timer_0_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = timer_0_s1_in_a_write_cycle;

  assign wait_for_timer_0_s1_counter = 0;
  //assign timer_0_s1_irq_from_sa = timer_0_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_0_s1_irq_from_sa = timer_0_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //timer_0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module tri_state_bridge_0_avalon_slave_arbitrator (
                                                    // inputs:
                                                     clk,
                                                     cpu_0_data_master_address_to_slave,
                                                     cpu_0_data_master_byteenable,
                                                     cpu_0_data_master_dbs_address,
                                                     cpu_0_data_master_dbs_write_16,
                                                     cpu_0_data_master_latency_counter,
                                                     cpu_0_data_master_read,
                                                     cpu_0_data_master_write,
                                                     cpu_0_instruction_master_address_to_slave,
                                                     cpu_0_instruction_master_dbs_address,
                                                     cpu_0_instruction_master_latency_counter,
                                                     cpu_0_instruction_master_read,
                                                     reset_n,

                                                    // outputs:
                                                     address_to_the_static_ram_0,
                                                     byte_enable_to_the_static_ram_0,
                                                     chip_select_to_the_static_ram_0,
                                                     cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0,
                                                     cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0,
                                                     cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0,
                                                     cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0,
                                                     cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0,
                                                     cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0,
                                                     cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0,
                                                     cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0,
                                                     cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0,
                                                     d1_tri_state_bridge_0_avalon_slave_end_xfer,
                                                     data_to_and_from_the_static_ram_0,
                                                     incoming_data_to_and_from_the_static_ram_0,
                                                     read_n_to_the_static_ram_0,
                                                     write_n_to_the_static_ram_0
                                                  )
;

  output  [ 17: 0] address_to_the_static_ram_0;
  output  [  1: 0] byte_enable_to_the_static_ram_0;
  output           chip_select_to_the_static_ram_0;
  output  [  1: 0] cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0;
  output           cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0;
  output           cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0;
  output           cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0;
  output           cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0;
  output           cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0;
  output           cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0;
  output           cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0;
  output           cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0;
  output           d1_tri_state_bridge_0_avalon_slave_end_xfer;
  inout   [ 15: 0] data_to_and_from_the_static_ram_0;
  output  [ 15: 0] incoming_data_to_and_from_the_static_ram_0;
  output           read_n_to_the_static_ram_0;
  output           write_n_to_the_static_ram_0;
  input            clk;
  input   [ 19: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_dbs_address;
  input   [ 15: 0] cpu_0_data_master_dbs_write_16;
  input   [  1: 0] cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 19: 0] cpu_0_instruction_master_address_to_slave;
  input   [  1: 0] cpu_0_instruction_master_dbs_address;
  input   [  1: 0] cpu_0_instruction_master_latency_counter;
  input            cpu_0_instruction_master_read;
  input            reset_n;

  reg     [ 17: 0] address_to_the_static_ram_0 /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  reg     [  1: 0] byte_enable_to_the_static_ram_0 /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  reg              chip_select_to_the_static_ram_0 /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire    [  1: 0] cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0;
  wire    [  1: 0] cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0_segment_0;
  wire    [  1: 0] cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0_segment_1;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0;
  reg     [  1: 0] cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register;
  wire             cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register_in;
  wire             cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_data_master_saved_grant_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0;
  reg     [  1: 0] cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register;
  wire             cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register_in;
  wire             cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_instruction_master_saved_grant_static_ram_0_avalon_tristate_slave_0;
  reg              d1_in_a_write_cycle /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_ENABLE_REGISTER=ON"  */;
  reg     [ 15: 0] d1_outgoing_data_to_and_from_the_static_ram_0 /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  reg              d1_reasons_to_wait;
  reg              d1_tri_state_bridge_0_avalon_slave_end_xfer;
  wire    [ 15: 0] data_to_and_from_the_static_ram_0;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg     [ 15: 0] incoming_data_to_and_from_the_static_ram_0 /* synthesis ALTERA_ATTRIBUTE = "FAST_INPUT_REGISTER=ON"  */;
  reg              last_cycle_cpu_0_data_master_granted_slave_static_ram_0_avalon_tristate_slave_0;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_static_ram_0_avalon_tristate_slave_0;
  wire    [ 15: 0] outgoing_data_to_and_from_the_static_ram_0;
  wire    [ 17: 0] p1_address_to_the_static_ram_0;
  wire    [  1: 0] p1_byte_enable_to_the_static_ram_0;
  wire             p1_chip_select_to_the_static_ram_0;
  wire    [  1: 0] p1_cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register;
  wire    [  1: 0] p1_cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register;
  wire             p1_read_n_to_the_static_ram_0;
  wire             p1_write_n_to_the_static_ram_0;
  reg              read_n_to_the_static_ram_0 /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  wire             static_ram_0_avalon_tristate_slave_0_in_a_read_cycle;
  wire             static_ram_0_avalon_tristate_slave_0_in_a_write_cycle;
  wire             static_ram_0_avalon_tristate_slave_0_waits_for_read;
  wire             static_ram_0_avalon_tristate_slave_0_waits_for_write;
  wire             static_ram_0_avalon_tristate_slave_0_with_write_latency;
  wire             time_to_write;
  wire             tri_state_bridge_0_avalon_slave_allgrants;
  wire             tri_state_bridge_0_avalon_slave_allow_new_arb_cycle;
  wire             tri_state_bridge_0_avalon_slave_any_bursting_master_saved_grant;
  wire             tri_state_bridge_0_avalon_slave_any_continuerequest;
  reg     [  1: 0] tri_state_bridge_0_avalon_slave_arb_addend;
  wire             tri_state_bridge_0_avalon_slave_arb_counter_enable;
  reg     [  1: 0] tri_state_bridge_0_avalon_slave_arb_share_counter;
  wire    [  1: 0] tri_state_bridge_0_avalon_slave_arb_share_counter_next_value;
  wire    [  1: 0] tri_state_bridge_0_avalon_slave_arb_share_set_values;
  wire    [  1: 0] tri_state_bridge_0_avalon_slave_arb_winner;
  wire             tri_state_bridge_0_avalon_slave_arbitration_holdoff_internal;
  wire             tri_state_bridge_0_avalon_slave_beginbursttransfer_internal;
  wire             tri_state_bridge_0_avalon_slave_begins_xfer;
  wire    [  3: 0] tri_state_bridge_0_avalon_slave_chosen_master_double_vector;
  wire    [  1: 0] tri_state_bridge_0_avalon_slave_chosen_master_rot_left;
  wire             tri_state_bridge_0_avalon_slave_end_xfer;
  wire             tri_state_bridge_0_avalon_slave_firsttransfer;
  wire    [  1: 0] tri_state_bridge_0_avalon_slave_grant_vector;
  wire    [  1: 0] tri_state_bridge_0_avalon_slave_master_qreq_vector;
  wire             tri_state_bridge_0_avalon_slave_non_bursting_master_requests;
  wire             tri_state_bridge_0_avalon_slave_read_pending;
  reg              tri_state_bridge_0_avalon_slave_reg_firsttransfer;
  reg     [  1: 0] tri_state_bridge_0_avalon_slave_saved_chosen_master_vector;
  reg              tri_state_bridge_0_avalon_slave_slavearbiterlockenable;
  wire             tri_state_bridge_0_avalon_slave_slavearbiterlockenable2;
  wire             tri_state_bridge_0_avalon_slave_unreg_firsttransfer;
  wire             tri_state_bridge_0_avalon_slave_write_pending;
  wire             wait_for_static_ram_0_avalon_tristate_slave_0_counter;
  reg              write_n_to_the_static_ram_0 /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~tri_state_bridge_0_avalon_slave_end_xfer;
    end


  assign tri_state_bridge_0_avalon_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0 | cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0));
  assign cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0 = ({cpu_0_data_master_address_to_slave[19 : 18] , 18'b0} == 20'h40000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //~chip_select_to_the_static_ram_0 of type chipselect to ~p1_chip_select_to_the_static_ram_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          chip_select_to_the_static_ram_0 <= ~0;
      else 
        chip_select_to_the_static_ram_0 <= p1_chip_select_to_the_static_ram_0;
    end


  assign tri_state_bridge_0_avalon_slave_write_pending = 0;
  //tri_state_bridge_0/avalon_slave read pending calc, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_read_pending = 0;

  //tri_state_bridge_0_avalon_slave_arb_share_counter set values, which is an e_mux
  assign tri_state_bridge_0_avalon_slave_arb_share_set_values = (cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0)? 2 :
    (cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0)? 2 :
    (cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0)? 2 :
    (cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0)? 2 :
    1;

  //tri_state_bridge_0_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  assign tri_state_bridge_0_avalon_slave_non_bursting_master_requests = cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0 |
    cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0 |
    cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0 |
    cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0;

  //tri_state_bridge_0_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign tri_state_bridge_0_avalon_slave_any_bursting_master_saved_grant = 0;

  //tri_state_bridge_0_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_arb_share_counter_next_value = tri_state_bridge_0_avalon_slave_firsttransfer ? (tri_state_bridge_0_avalon_slave_arb_share_set_values - 1) : |tri_state_bridge_0_avalon_slave_arb_share_counter ? (tri_state_bridge_0_avalon_slave_arb_share_counter - 1) : 0;

  //tri_state_bridge_0_avalon_slave_allgrants all slave grants, which is an e_mux
  assign tri_state_bridge_0_avalon_slave_allgrants = (|tri_state_bridge_0_avalon_slave_grant_vector) |
    (|tri_state_bridge_0_avalon_slave_grant_vector) |
    (|tri_state_bridge_0_avalon_slave_grant_vector) |
    (|tri_state_bridge_0_avalon_slave_grant_vector);

  //tri_state_bridge_0_avalon_slave_end_xfer assignment, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_end_xfer = ~(static_ram_0_avalon_tristate_slave_0_waits_for_read | static_ram_0_avalon_tristate_slave_0_waits_for_write);

  //end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave = tri_state_bridge_0_avalon_slave_end_xfer & (~tri_state_bridge_0_avalon_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //tri_state_bridge_0_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave & tri_state_bridge_0_avalon_slave_allgrants) | (end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave & ~tri_state_bridge_0_avalon_slave_non_bursting_master_requests);

  //tri_state_bridge_0_avalon_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tri_state_bridge_0_avalon_slave_arb_share_counter <= 0;
      else if (tri_state_bridge_0_avalon_slave_arb_counter_enable)
          tri_state_bridge_0_avalon_slave_arb_share_counter <= tri_state_bridge_0_avalon_slave_arb_share_counter_next_value;
    end


  //tri_state_bridge_0_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tri_state_bridge_0_avalon_slave_slavearbiterlockenable <= 0;
      else if ((|tri_state_bridge_0_avalon_slave_master_qreq_vector & end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave) | (end_xfer_arb_share_counter_term_tri_state_bridge_0_avalon_slave & ~tri_state_bridge_0_avalon_slave_non_bursting_master_requests))
          tri_state_bridge_0_avalon_slave_slavearbiterlockenable <= |tri_state_bridge_0_avalon_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master tri_state_bridge_0/avalon_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = tri_state_bridge_0_avalon_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //tri_state_bridge_0_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_slavearbiterlockenable2 = |tri_state_bridge_0_avalon_slave_arb_share_counter_next_value;

  //cpu_0/data_master tri_state_bridge_0/avalon_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = tri_state_bridge_0_avalon_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master tri_state_bridge_0/avalon_slave arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = tri_state_bridge_0_avalon_slave_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master tri_state_bridge_0/avalon_slave arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = tri_state_bridge_0_avalon_slave_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted static_ram_0/avalon_tristate_slave_0 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_static_ram_0_avalon_tristate_slave_0 <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_static_ram_0_avalon_tristate_slave_0 <= cpu_0_instruction_master_saved_grant_static_ram_0_avalon_tristate_slave_0 ? 1 : (tri_state_bridge_0_avalon_slave_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_static_ram_0_avalon_tristate_slave_0;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_static_ram_0_avalon_tristate_slave_0 & cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0;

  //tri_state_bridge_0_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_mux
  assign tri_state_bridge_0_avalon_slave_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0 = cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0 & ~((cpu_0_data_master_read & (tri_state_bridge_0_avalon_slave_write_pending | (tri_state_bridge_0_avalon_slave_read_pending) | (2 < cpu_0_data_master_latency_counter))) | ((tri_state_bridge_0_avalon_slave_read_pending | !cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0) & cpu_0_data_master_write) | cpu_0_instruction_master_arbiterlock);
  //cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register_in = cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0 & cpu_0_data_master_read & ~static_ram_0_avalon_tristate_slave_0_waits_for_read;

  //shift register p1 cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register = {cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register, cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register_in};

  //cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register <= 0;
      else 
        cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register <= p1_cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register;
    end


  //local readdatavalid cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0, which is an e_mux
  assign cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0 = cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register[1];

  //data_to_and_from_the_static_ram_0 register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          incoming_data_to_and_from_the_static_ram_0 <= 0;
      else 
        incoming_data_to_and_from_the_static_ram_0 <= data_to_and_from_the_static_ram_0;
    end


  //static_ram_0_avalon_tristate_slave_0_with_write_latency assignment, which is an e_assign
  assign static_ram_0_avalon_tristate_slave_0_with_write_latency = in_a_write_cycle & (cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0 | cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0);

  //time to write the data, which is an e_mux
  assign time_to_write = (static_ram_0_avalon_tristate_slave_0_with_write_latency)? 1 :
    0;

  //d1_outgoing_data_to_and_from_the_static_ram_0 register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_outgoing_data_to_and_from_the_static_ram_0 <= 0;
      else 
        d1_outgoing_data_to_and_from_the_static_ram_0 <= outgoing_data_to_and_from_the_static_ram_0;
    end


  //write cycle delayed by 1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_in_a_write_cycle <= 0;
      else 
        d1_in_a_write_cycle <= time_to_write;
    end


  //d1_outgoing_data_to_and_from_the_static_ram_0 tristate driver, which is an e_assign
  assign data_to_and_from_the_static_ram_0 = (d1_in_a_write_cycle)? d1_outgoing_data_to_and_from_the_static_ram_0:{16{1'bz}};

  //outgoing_data_to_and_from_the_static_ram_0 mux, which is an e_mux
  assign outgoing_data_to_and_from_the_static_ram_0 = cpu_0_data_master_dbs_write_16;

  assign cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0 = (({cpu_0_instruction_master_address_to_slave[19 : 18] , 18'b0} == 20'h40000) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted static_ram_0/avalon_tristate_slave_0 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_static_ram_0_avalon_tristate_slave_0 <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_static_ram_0_avalon_tristate_slave_0 <= cpu_0_data_master_saved_grant_static_ram_0_avalon_tristate_slave_0 ? 1 : (tri_state_bridge_0_avalon_slave_arbitration_holdoff_internal | ~cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0) ? 0 : last_cycle_cpu_0_data_master_granted_slave_static_ram_0_avalon_tristate_slave_0;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_static_ram_0_avalon_tristate_slave_0 & cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0;

  assign cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0 = cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0 & ~((cpu_0_instruction_master_read & (tri_state_bridge_0_avalon_slave_write_pending | (tri_state_bridge_0_avalon_slave_read_pending) | (2 < cpu_0_instruction_master_latency_counter))) | cpu_0_data_master_arbiterlock);
  //cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register_in = cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0 & cpu_0_instruction_master_read & ~static_ram_0_avalon_tristate_slave_0_waits_for_read;

  //shift register p1 cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register = {cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register, cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register_in};

  //cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register <= 0;
      else 
        cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register <= p1_cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register;
    end


  //local readdatavalid cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0 = cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0_shift_register[1];

  //allow new arb cycle for tri_state_bridge_0/avalon_slave, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for static_ram_0/avalon_tristate_slave_0, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0;

  //cpu_0/instruction_master grant static_ram_0/avalon_tristate_slave_0, which is an e_assign
  assign cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0 = tri_state_bridge_0_avalon_slave_grant_vector[0];

  //cpu_0/instruction_master saved-grant static_ram_0/avalon_tristate_slave_0, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_static_ram_0_avalon_tristate_slave_0 = tri_state_bridge_0_avalon_slave_arb_winner[0] && cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0;

  //cpu_0/data_master assignment into master qualified-requests vector for static_ram_0/avalon_tristate_slave_0, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_master_qreq_vector[1] = cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0;

  //cpu_0/data_master grant static_ram_0/avalon_tristate_slave_0, which is an e_assign
  assign cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0 = tri_state_bridge_0_avalon_slave_grant_vector[1];

  //cpu_0/data_master saved-grant static_ram_0/avalon_tristate_slave_0, which is an e_assign
  assign cpu_0_data_master_saved_grant_static_ram_0_avalon_tristate_slave_0 = tri_state_bridge_0_avalon_slave_arb_winner[1] && cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0;

  //tri_state_bridge_0/avalon_slave chosen-master double-vector, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_chosen_master_double_vector = {tri_state_bridge_0_avalon_slave_master_qreq_vector, tri_state_bridge_0_avalon_slave_master_qreq_vector} & ({~tri_state_bridge_0_avalon_slave_master_qreq_vector, ~tri_state_bridge_0_avalon_slave_master_qreq_vector} + tri_state_bridge_0_avalon_slave_arb_addend);

  //stable onehot encoding of arb winner
  assign tri_state_bridge_0_avalon_slave_arb_winner = (tri_state_bridge_0_avalon_slave_allow_new_arb_cycle & | tri_state_bridge_0_avalon_slave_grant_vector) ? tri_state_bridge_0_avalon_slave_grant_vector : tri_state_bridge_0_avalon_slave_saved_chosen_master_vector;

  //saved tri_state_bridge_0_avalon_slave_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tri_state_bridge_0_avalon_slave_saved_chosen_master_vector <= 0;
      else if (tri_state_bridge_0_avalon_slave_allow_new_arb_cycle)
          tri_state_bridge_0_avalon_slave_saved_chosen_master_vector <= |tri_state_bridge_0_avalon_slave_grant_vector ? tri_state_bridge_0_avalon_slave_grant_vector : tri_state_bridge_0_avalon_slave_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign tri_state_bridge_0_avalon_slave_grant_vector = {(tri_state_bridge_0_avalon_slave_chosen_master_double_vector[1] | tri_state_bridge_0_avalon_slave_chosen_master_double_vector[3]),
    (tri_state_bridge_0_avalon_slave_chosen_master_double_vector[0] | tri_state_bridge_0_avalon_slave_chosen_master_double_vector[2])};

  //tri_state_bridge_0/avalon_slave chosen master rotated left, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_chosen_master_rot_left = (tri_state_bridge_0_avalon_slave_arb_winner << 1) ? (tri_state_bridge_0_avalon_slave_arb_winner << 1) : 1;

  //tri_state_bridge_0/avalon_slave's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tri_state_bridge_0_avalon_slave_arb_addend <= 1;
      else if (|tri_state_bridge_0_avalon_slave_grant_vector)
          tri_state_bridge_0_avalon_slave_arb_addend <= tri_state_bridge_0_avalon_slave_end_xfer? tri_state_bridge_0_avalon_slave_chosen_master_rot_left : tri_state_bridge_0_avalon_slave_grant_vector;
    end


  assign p1_chip_select_to_the_static_ram_0 = ~(cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0 | cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0);
  //tri_state_bridge_0_avalon_slave_firsttransfer first transaction, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_firsttransfer = tri_state_bridge_0_avalon_slave_begins_xfer ? tri_state_bridge_0_avalon_slave_unreg_firsttransfer : tri_state_bridge_0_avalon_slave_reg_firsttransfer;

  //tri_state_bridge_0_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_unreg_firsttransfer = ~(tri_state_bridge_0_avalon_slave_slavearbiterlockenable & tri_state_bridge_0_avalon_slave_any_continuerequest);

  //tri_state_bridge_0_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tri_state_bridge_0_avalon_slave_reg_firsttransfer <= 1'b1;
      else if (tri_state_bridge_0_avalon_slave_begins_xfer)
          tri_state_bridge_0_avalon_slave_reg_firsttransfer <= tri_state_bridge_0_avalon_slave_unreg_firsttransfer;
    end


  //tri_state_bridge_0_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_beginbursttransfer_internal = tri_state_bridge_0_avalon_slave_begins_xfer;

  //tri_state_bridge_0_avalon_slave_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign tri_state_bridge_0_avalon_slave_arbitration_holdoff_internal = tri_state_bridge_0_avalon_slave_begins_xfer & tri_state_bridge_0_avalon_slave_firsttransfer;

  //~read_n_to_the_static_ram_0 of type read to ~p1_read_n_to_the_static_ram_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          read_n_to_the_static_ram_0 <= ~0;
      else 
        read_n_to_the_static_ram_0 <= p1_read_n_to_the_static_ram_0;
    end


  //~p1_read_n_to_the_static_ram_0 assignment, which is an e_mux
  assign p1_read_n_to_the_static_ram_0 = ~((cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0 & cpu_0_instruction_master_read));

  //~write_n_to_the_static_ram_0 of type write to ~p1_write_n_to_the_static_ram_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          write_n_to_the_static_ram_0 <= ~0;
      else 
        write_n_to_the_static_ram_0 <= p1_write_n_to_the_static_ram_0;
    end


  //~byte_enable_to_the_static_ram_0 of type byteenable to ~p1_byte_enable_to_the_static_ram_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          byte_enable_to_the_static_ram_0 <= ~0;
      else 
        byte_enable_to_the_static_ram_0 <= p1_byte_enable_to_the_static_ram_0;
    end


  //~p1_write_n_to_the_static_ram_0 assignment, which is an e_mux
  assign p1_write_n_to_the_static_ram_0 = ~(cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0 & cpu_0_data_master_write);

  //address_to_the_static_ram_0 of type address to p1_address_to_the_static_ram_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          address_to_the_static_ram_0 <= 0;
      else 
        address_to_the_static_ram_0 <= p1_address_to_the_static_ram_0;
    end


  //p1_address_to_the_static_ram_0 mux, which is an e_mux
  assign p1_address_to_the_static_ram_0 = (cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0)? ({cpu_0_data_master_address_to_slave >> 2,
    cpu_0_data_master_dbs_address[1],
    {1 {1'b0}}}) :
    ({cpu_0_instruction_master_address_to_slave >> 2,
    cpu_0_instruction_master_dbs_address[1],
    {1 {1'b0}}});

  //d1_tri_state_bridge_0_avalon_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_tri_state_bridge_0_avalon_slave_end_xfer <= 1;
      else 
        d1_tri_state_bridge_0_avalon_slave_end_xfer <= tri_state_bridge_0_avalon_slave_end_xfer;
    end


  //static_ram_0_avalon_tristate_slave_0_waits_for_read in a cycle, which is an e_mux
  assign static_ram_0_avalon_tristate_slave_0_waits_for_read = static_ram_0_avalon_tristate_slave_0_in_a_read_cycle & tri_state_bridge_0_avalon_slave_begins_xfer;

  //static_ram_0_avalon_tristate_slave_0_in_a_read_cycle assignment, which is an e_assign
  assign static_ram_0_avalon_tristate_slave_0_in_a_read_cycle = (cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0 & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = static_ram_0_avalon_tristate_slave_0_in_a_read_cycle;

  //static_ram_0_avalon_tristate_slave_0_waits_for_write in a cycle, which is an e_mux
  assign static_ram_0_avalon_tristate_slave_0_waits_for_write = static_ram_0_avalon_tristate_slave_0_in_a_write_cycle & tri_state_bridge_0_avalon_slave_begins_xfer;

  //static_ram_0_avalon_tristate_slave_0_in_a_write_cycle assignment, which is an e_assign
  assign static_ram_0_avalon_tristate_slave_0_in_a_write_cycle = cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = static_ram_0_avalon_tristate_slave_0_in_a_write_cycle;

  assign wait_for_static_ram_0_avalon_tristate_slave_0_counter = 0;
  //~p1_byte_enable_to_the_static_ram_0 byte enable port mux, which is an e_mux
  assign p1_byte_enable_to_the_static_ram_0 = ~((cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0)? cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0 :
    -1);

  assign {cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0_segment_1,
cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0_segment_0} = cpu_0_data_master_byteenable;
  assign cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0 = ((cpu_0_data_master_dbs_address[1] == 0))? cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0_segment_0 :
    cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //static_ram_0/avalon_tristate_slave_0 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0 + cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_static_ram_0_avalon_tristate_slave_0 + cpu_0_instruction_master_saved_grant_static_ram_0_avalon_tristate_slave_0 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module tri_state_bridge_0_bridge_arbitrator 
;



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module RTSLab1CPU_reset_clk_0_domain_synch_module (
                                                    // inputs:
                                                     clk,
                                                     data_in,
                                                     reset_n,

                                                    // outputs:
                                                     data_out
                                                  )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module RTSLab1CPU (
                    // 1) global signals:
                     clk_0,
                     reset_n,

                    // the_HEX0
                     out_port_from_the_HEX0,

                    // the_HEX1
                     out_port_from_the_HEX1,

                    // the_HEX2
                     out_port_from_the_HEX2,

                    // the_HEX3
                     out_port_from_the_HEX3,

                    // the_HEX4
                     out_port_from_the_HEX4,

                    // the_HEX5
                     out_port_from_the_HEX5,

                    // the_HEX6
                     out_port_from_the_HEX6,

                    // the_HEX7
                     out_port_from_the_HEX7,

                    // the_KEY
                     in_port_to_the_KEY,

                    // the_LEDG
                     out_port_from_the_LEDG,

                    // the_lcd_0
                     LCD_E_from_the_lcd_0,
                     LCD_RS_from_the_lcd_0,
                     LCD_RW_from_the_lcd_0,
                     LCD_data_to_and_from_the_lcd_0,

                    // the_tri_state_bridge_0_avalon_slave
                     address_to_the_static_ram_0,
                     byte_enable_to_the_static_ram_0,
                     chip_select_to_the_static_ram_0,
                     data_to_and_from_the_static_ram_0,
                     read_n_to_the_static_ram_0,
                     write_n_to_the_static_ram_0
                  )
;

  output           LCD_E_from_the_lcd_0;
  output           LCD_RS_from_the_lcd_0;
  output           LCD_RW_from_the_lcd_0;
  inout   [  7: 0] LCD_data_to_and_from_the_lcd_0;
  output  [ 17: 0] address_to_the_static_ram_0;
  output  [  1: 0] byte_enable_to_the_static_ram_0;
  output           chip_select_to_the_static_ram_0;
  inout   [ 15: 0] data_to_and_from_the_static_ram_0;
  output  [  6: 0] out_port_from_the_HEX0;
  output  [  6: 0] out_port_from_the_HEX1;
  output  [  6: 0] out_port_from_the_HEX2;
  output  [  6: 0] out_port_from_the_HEX3;
  output  [  6: 0] out_port_from_the_HEX4;
  output  [  6: 0] out_port_from_the_HEX5;
  output  [  6: 0] out_port_from_the_HEX6;
  output  [  6: 0] out_port_from_the_HEX7;
  output  [  7: 0] out_port_from_the_LEDG;
  output           read_n_to_the_static_ram_0;
  output           write_n_to_the_static_ram_0;
  input            clk_0;
  input   [  3: 0] in_port_to_the_KEY;
  input            reset_n;

  wire    [  1: 0] HEX0_s1_address;
  wire             HEX0_s1_chipselect;
  wire    [  6: 0] HEX0_s1_readdata;
  wire    [  6: 0] HEX0_s1_readdata_from_sa;
  wire             HEX0_s1_reset_n;
  wire             HEX0_s1_write_n;
  wire    [  6: 0] HEX0_s1_writedata;
  wire    [  1: 0] HEX1_s1_address;
  wire             HEX1_s1_chipselect;
  wire    [  6: 0] HEX1_s1_readdata;
  wire    [  6: 0] HEX1_s1_readdata_from_sa;
  wire             HEX1_s1_reset_n;
  wire             HEX1_s1_write_n;
  wire    [  6: 0] HEX1_s1_writedata;
  wire    [  1: 0] HEX2_s1_address;
  wire             HEX2_s1_chipselect;
  wire    [  6: 0] HEX2_s1_readdata;
  wire    [  6: 0] HEX2_s1_readdata_from_sa;
  wire             HEX2_s1_reset_n;
  wire             HEX2_s1_write_n;
  wire    [  6: 0] HEX2_s1_writedata;
  wire    [  1: 0] HEX3_s1_address;
  wire             HEX3_s1_chipselect;
  wire    [  6: 0] HEX3_s1_readdata;
  wire    [  6: 0] HEX3_s1_readdata_from_sa;
  wire             HEX3_s1_reset_n;
  wire             HEX3_s1_write_n;
  wire    [  6: 0] HEX3_s1_writedata;
  wire    [  1: 0] HEX4_s1_address;
  wire             HEX4_s1_chipselect;
  wire    [  6: 0] HEX4_s1_readdata;
  wire    [  6: 0] HEX4_s1_readdata_from_sa;
  wire             HEX4_s1_reset_n;
  wire             HEX4_s1_write_n;
  wire    [  6: 0] HEX4_s1_writedata;
  wire    [  1: 0] HEX5_s1_address;
  wire             HEX5_s1_chipselect;
  wire    [  6: 0] HEX5_s1_readdata;
  wire    [  6: 0] HEX5_s1_readdata_from_sa;
  wire             HEX5_s1_reset_n;
  wire             HEX5_s1_write_n;
  wire    [  6: 0] HEX5_s1_writedata;
  wire    [  1: 0] HEX6_s1_address;
  wire             HEX6_s1_chipselect;
  wire    [  6: 0] HEX6_s1_readdata;
  wire    [  6: 0] HEX6_s1_readdata_from_sa;
  wire             HEX6_s1_reset_n;
  wire             HEX6_s1_write_n;
  wire    [  6: 0] HEX6_s1_writedata;
  wire    [  1: 0] HEX7_s1_address;
  wire             HEX7_s1_chipselect;
  wire    [  6: 0] HEX7_s1_readdata;
  wire    [  6: 0] HEX7_s1_readdata_from_sa;
  wire             HEX7_s1_reset_n;
  wire             HEX7_s1_write_n;
  wire    [  6: 0] HEX7_s1_writedata;
  wire    [  1: 0] KEY_s1_address;
  wire             KEY_s1_chipselect;
  wire             KEY_s1_irq;
  wire             KEY_s1_irq_from_sa;
  wire    [  3: 0] KEY_s1_readdata;
  wire    [  3: 0] KEY_s1_readdata_from_sa;
  wire             KEY_s1_reset_n;
  wire             KEY_s1_write_n;
  wire    [  3: 0] KEY_s1_writedata;
  wire             LCD_E_from_the_lcd_0;
  wire             LCD_RS_from_the_lcd_0;
  wire             LCD_RW_from_the_lcd_0;
  wire    [  7: 0] LCD_data_to_and_from_the_lcd_0;
  wire    [  1: 0] LEDG_s1_address;
  wire             LEDG_s1_chipselect;
  wire    [  7: 0] LEDG_s1_readdata;
  wire    [  7: 0] LEDG_s1_readdata_from_sa;
  wire             LEDG_s1_reset_n;
  wire             LEDG_s1_write_n;
  wire    [  7: 0] LEDG_s1_writedata;
  wire    [ 17: 0] address_to_the_static_ram_0;
  wire    [  1: 0] byte_enable_to_the_static_ram_0;
  wire             chip_select_to_the_static_ram_0;
  wire             clk_0_reset_n;
  wire    [ 19: 0] cpu_0_data_master_address;
  wire    [ 19: 0] cpu_0_data_master_address_to_slave;
  wire    [  3: 0] cpu_0_data_master_byteenable;
  wire    [  1: 0] cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0;
  wire    [  1: 0] cpu_0_data_master_dbs_address;
  wire    [ 15: 0] cpu_0_data_master_dbs_write_16;
  wire             cpu_0_data_master_debugaccess;
  wire             cpu_0_data_master_granted_HEX0_s1;
  wire             cpu_0_data_master_granted_HEX1_s1;
  wire             cpu_0_data_master_granted_HEX2_s1;
  wire             cpu_0_data_master_granted_HEX3_s1;
  wire             cpu_0_data_master_granted_HEX4_s1;
  wire             cpu_0_data_master_granted_HEX5_s1;
  wire             cpu_0_data_master_granted_HEX6_s1;
  wire             cpu_0_data_master_granted_HEX7_s1;
  wire             cpu_0_data_master_granted_KEY_s1;
  wire             cpu_0_data_master_granted_LEDG_s1;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_granted_lcd_0_control_slave;
  wire             cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_data_master_granted_timer_0_s1;
  wire    [ 31: 0] cpu_0_data_master_irq;
  wire    [  1: 0] cpu_0_data_master_latency_counter;
  wire             cpu_0_data_master_qualified_request_HEX0_s1;
  wire             cpu_0_data_master_qualified_request_HEX1_s1;
  wire             cpu_0_data_master_qualified_request_HEX2_s1;
  wire             cpu_0_data_master_qualified_request_HEX3_s1;
  wire             cpu_0_data_master_qualified_request_HEX4_s1;
  wire             cpu_0_data_master_qualified_request_HEX5_s1;
  wire             cpu_0_data_master_qualified_request_HEX6_s1;
  wire             cpu_0_data_master_qualified_request_HEX7_s1;
  wire             cpu_0_data_master_qualified_request_KEY_s1;
  wire             cpu_0_data_master_qualified_request_LEDG_s1;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_qualified_request_lcd_0_control_slave;
  wire             cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_data_master_qualified_request_timer_0_s1;
  wire             cpu_0_data_master_read;
  wire             cpu_0_data_master_read_data_valid_HEX0_s1;
  wire             cpu_0_data_master_read_data_valid_HEX1_s1;
  wire             cpu_0_data_master_read_data_valid_HEX2_s1;
  wire             cpu_0_data_master_read_data_valid_HEX3_s1;
  wire             cpu_0_data_master_read_data_valid_HEX4_s1;
  wire             cpu_0_data_master_read_data_valid_HEX5_s1;
  wire             cpu_0_data_master_read_data_valid_HEX6_s1;
  wire             cpu_0_data_master_read_data_valid_HEX7_s1;
  wire             cpu_0_data_master_read_data_valid_KEY_s1;
  wire             cpu_0_data_master_read_data_valid_LEDG_s1;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_read_data_valid_lcd_0_control_slave;
  wire             cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_data_master_read_data_valid_timer_0_s1;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_readdatavalid;
  wire             cpu_0_data_master_requests_HEX0_s1;
  wire             cpu_0_data_master_requests_HEX1_s1;
  wire             cpu_0_data_master_requests_HEX2_s1;
  wire             cpu_0_data_master_requests_HEX3_s1;
  wire             cpu_0_data_master_requests_HEX4_s1;
  wire             cpu_0_data_master_requests_HEX5_s1;
  wire             cpu_0_data_master_requests_HEX6_s1;
  wire             cpu_0_data_master_requests_HEX7_s1;
  wire             cpu_0_data_master_requests_KEY_s1;
  wire             cpu_0_data_master_requests_LEDG_s1;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_requests_lcd_0_control_slave;
  wire             cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_data_master_requests_timer_0_s1;
  wire             cpu_0_data_master_waitrequest;
  wire             cpu_0_data_master_write;
  wire    [ 31: 0] cpu_0_data_master_writedata;
  wire    [ 19: 0] cpu_0_instruction_master_address;
  wire    [ 19: 0] cpu_0_instruction_master_address_to_slave;
  wire    [  1: 0] cpu_0_instruction_master_dbs_address;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0;
  wire    [  1: 0] cpu_0_instruction_master_latency_counter;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_instruction_master_read;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_readdatavalid;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0;
  wire             cpu_0_instruction_master_waitrequest;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  wire             cpu_0_jtag_debug_module_reset_n;
  wire             cpu_0_jtag_debug_module_resetrequest;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  wire             d1_HEX0_s1_end_xfer;
  wire             d1_HEX1_s1_end_xfer;
  wire             d1_HEX2_s1_end_xfer;
  wire             d1_HEX3_s1_end_xfer;
  wire             d1_HEX4_s1_end_xfer;
  wire             d1_HEX5_s1_end_xfer;
  wire             d1_HEX6_s1_end_xfer;
  wire             d1_HEX7_s1_end_xfer;
  wire             d1_KEY_s1_end_xfer;
  wire             d1_LEDG_s1_end_xfer;
  wire             d1_cpu_0_jtag_debug_module_end_xfer;
  wire             d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  wire             d1_lcd_0_control_slave_end_xfer;
  wire             d1_timer_0_s1_end_xfer;
  wire             d1_tri_state_bridge_0_avalon_slave_end_xfer;
  wire    [ 15: 0] data_to_and_from_the_static_ram_0;
  wire    [ 15: 0] incoming_data_to_and_from_the_static_ram_0;
  wire             jtag_uart_0_avalon_jtag_slave_address;
  wire             jtag_uart_0_avalon_jtag_slave_chipselect;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_irq;
  wire             jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_reset_n;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  wire    [  1: 0] lcd_0_control_slave_address;
  wire             lcd_0_control_slave_begintransfer;
  wire             lcd_0_control_slave_read;
  wire    [  7: 0] lcd_0_control_slave_readdata;
  wire    [  7: 0] lcd_0_control_slave_readdata_from_sa;
  wire             lcd_0_control_slave_wait_counter_eq_0;
  wire             lcd_0_control_slave_write;
  wire    [  7: 0] lcd_0_control_slave_writedata;
  wire    [  6: 0] out_port_from_the_HEX0;
  wire    [  6: 0] out_port_from_the_HEX1;
  wire    [  6: 0] out_port_from_the_HEX2;
  wire    [  6: 0] out_port_from_the_HEX3;
  wire    [  6: 0] out_port_from_the_HEX4;
  wire    [  6: 0] out_port_from_the_HEX5;
  wire    [  6: 0] out_port_from_the_HEX6;
  wire    [  6: 0] out_port_from_the_HEX7;
  wire    [  7: 0] out_port_from_the_LEDG;
  wire             read_n_to_the_static_ram_0;
  wire             reset_n_sources;
  wire    [  2: 0] timer_0_s1_address;
  wire             timer_0_s1_chipselect;
  wire             timer_0_s1_irq;
  wire             timer_0_s1_irq_from_sa;
  wire    [ 15: 0] timer_0_s1_readdata;
  wire    [ 15: 0] timer_0_s1_readdata_from_sa;
  wire             timer_0_s1_reset_n;
  wire             timer_0_s1_write_n;
  wire    [ 15: 0] timer_0_s1_writedata;
  wire             write_n_to_the_static_ram_0;
  HEX0_s1_arbitrator the_HEX0_s1
    (
      .HEX0_s1_address                             (HEX0_s1_address),
      .HEX0_s1_chipselect                          (HEX0_s1_chipselect),
      .HEX0_s1_readdata                            (HEX0_s1_readdata),
      .HEX0_s1_readdata_from_sa                    (HEX0_s1_readdata_from_sa),
      .HEX0_s1_reset_n                             (HEX0_s1_reset_n),
      .HEX0_s1_write_n                             (HEX0_s1_write_n),
      .HEX0_s1_writedata                           (HEX0_s1_writedata),
      .clk                                         (clk_0),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX0_s1           (cpu_0_data_master_granted_HEX0_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX0_s1 (cpu_0_data_master_qualified_request_HEX0_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX0_s1   (cpu_0_data_master_read_data_valid_HEX0_s1),
      .cpu_0_data_master_requests_HEX0_s1          (cpu_0_data_master_requests_HEX0_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX0_s1_end_xfer                         (d1_HEX0_s1_end_xfer),
      .reset_n                                     (clk_0_reset_n)
    );

  HEX0 the_HEX0
    (
      .address    (HEX0_s1_address),
      .chipselect (HEX0_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_HEX0),
      .readdata   (HEX0_s1_readdata),
      .reset_n    (HEX0_s1_reset_n),
      .write_n    (HEX0_s1_write_n),
      .writedata  (HEX0_s1_writedata)
    );

  HEX1_s1_arbitrator the_HEX1_s1
    (
      .HEX1_s1_address                             (HEX1_s1_address),
      .HEX1_s1_chipselect                          (HEX1_s1_chipselect),
      .HEX1_s1_readdata                            (HEX1_s1_readdata),
      .HEX1_s1_readdata_from_sa                    (HEX1_s1_readdata_from_sa),
      .HEX1_s1_reset_n                             (HEX1_s1_reset_n),
      .HEX1_s1_write_n                             (HEX1_s1_write_n),
      .HEX1_s1_writedata                           (HEX1_s1_writedata),
      .clk                                         (clk_0),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX1_s1           (cpu_0_data_master_granted_HEX1_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX1_s1 (cpu_0_data_master_qualified_request_HEX1_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX1_s1   (cpu_0_data_master_read_data_valid_HEX1_s1),
      .cpu_0_data_master_requests_HEX1_s1          (cpu_0_data_master_requests_HEX1_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX1_s1_end_xfer                         (d1_HEX1_s1_end_xfer),
      .reset_n                                     (clk_0_reset_n)
    );

  HEX1 the_HEX1
    (
      .address    (HEX1_s1_address),
      .chipselect (HEX1_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_HEX1),
      .readdata   (HEX1_s1_readdata),
      .reset_n    (HEX1_s1_reset_n),
      .write_n    (HEX1_s1_write_n),
      .writedata  (HEX1_s1_writedata)
    );

  HEX2_s1_arbitrator the_HEX2_s1
    (
      .HEX2_s1_address                             (HEX2_s1_address),
      .HEX2_s1_chipselect                          (HEX2_s1_chipselect),
      .HEX2_s1_readdata                            (HEX2_s1_readdata),
      .HEX2_s1_readdata_from_sa                    (HEX2_s1_readdata_from_sa),
      .HEX2_s1_reset_n                             (HEX2_s1_reset_n),
      .HEX2_s1_write_n                             (HEX2_s1_write_n),
      .HEX2_s1_writedata                           (HEX2_s1_writedata),
      .clk                                         (clk_0),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX2_s1           (cpu_0_data_master_granted_HEX2_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX2_s1 (cpu_0_data_master_qualified_request_HEX2_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX2_s1   (cpu_0_data_master_read_data_valid_HEX2_s1),
      .cpu_0_data_master_requests_HEX2_s1          (cpu_0_data_master_requests_HEX2_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX2_s1_end_xfer                         (d1_HEX2_s1_end_xfer),
      .reset_n                                     (clk_0_reset_n)
    );

  HEX2 the_HEX2
    (
      .address    (HEX2_s1_address),
      .chipselect (HEX2_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_HEX2),
      .readdata   (HEX2_s1_readdata),
      .reset_n    (HEX2_s1_reset_n),
      .write_n    (HEX2_s1_write_n),
      .writedata  (HEX2_s1_writedata)
    );

  HEX3_s1_arbitrator the_HEX3_s1
    (
      .HEX3_s1_address                             (HEX3_s1_address),
      .HEX3_s1_chipselect                          (HEX3_s1_chipselect),
      .HEX3_s1_readdata                            (HEX3_s1_readdata),
      .HEX3_s1_readdata_from_sa                    (HEX3_s1_readdata_from_sa),
      .HEX3_s1_reset_n                             (HEX3_s1_reset_n),
      .HEX3_s1_write_n                             (HEX3_s1_write_n),
      .HEX3_s1_writedata                           (HEX3_s1_writedata),
      .clk                                         (clk_0),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX3_s1           (cpu_0_data_master_granted_HEX3_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX3_s1 (cpu_0_data_master_qualified_request_HEX3_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX3_s1   (cpu_0_data_master_read_data_valid_HEX3_s1),
      .cpu_0_data_master_requests_HEX3_s1          (cpu_0_data_master_requests_HEX3_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX3_s1_end_xfer                         (d1_HEX3_s1_end_xfer),
      .reset_n                                     (clk_0_reset_n)
    );

  HEX3 the_HEX3
    (
      .address    (HEX3_s1_address),
      .chipselect (HEX3_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_HEX3),
      .readdata   (HEX3_s1_readdata),
      .reset_n    (HEX3_s1_reset_n),
      .write_n    (HEX3_s1_write_n),
      .writedata  (HEX3_s1_writedata)
    );

  HEX4_s1_arbitrator the_HEX4_s1
    (
      .HEX4_s1_address                             (HEX4_s1_address),
      .HEX4_s1_chipselect                          (HEX4_s1_chipselect),
      .HEX4_s1_readdata                            (HEX4_s1_readdata),
      .HEX4_s1_readdata_from_sa                    (HEX4_s1_readdata_from_sa),
      .HEX4_s1_reset_n                             (HEX4_s1_reset_n),
      .HEX4_s1_write_n                             (HEX4_s1_write_n),
      .HEX4_s1_writedata                           (HEX4_s1_writedata),
      .clk                                         (clk_0),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX4_s1           (cpu_0_data_master_granted_HEX4_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX4_s1 (cpu_0_data_master_qualified_request_HEX4_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX4_s1   (cpu_0_data_master_read_data_valid_HEX4_s1),
      .cpu_0_data_master_requests_HEX4_s1          (cpu_0_data_master_requests_HEX4_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX4_s1_end_xfer                         (d1_HEX4_s1_end_xfer),
      .reset_n                                     (clk_0_reset_n)
    );

  HEX4 the_HEX4
    (
      .address    (HEX4_s1_address),
      .chipselect (HEX4_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_HEX4),
      .readdata   (HEX4_s1_readdata),
      .reset_n    (HEX4_s1_reset_n),
      .write_n    (HEX4_s1_write_n),
      .writedata  (HEX4_s1_writedata)
    );

  HEX5_s1_arbitrator the_HEX5_s1
    (
      .HEX5_s1_address                             (HEX5_s1_address),
      .HEX5_s1_chipselect                          (HEX5_s1_chipselect),
      .HEX5_s1_readdata                            (HEX5_s1_readdata),
      .HEX5_s1_readdata_from_sa                    (HEX5_s1_readdata_from_sa),
      .HEX5_s1_reset_n                             (HEX5_s1_reset_n),
      .HEX5_s1_write_n                             (HEX5_s1_write_n),
      .HEX5_s1_writedata                           (HEX5_s1_writedata),
      .clk                                         (clk_0),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX5_s1           (cpu_0_data_master_granted_HEX5_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX5_s1 (cpu_0_data_master_qualified_request_HEX5_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX5_s1   (cpu_0_data_master_read_data_valid_HEX5_s1),
      .cpu_0_data_master_requests_HEX5_s1          (cpu_0_data_master_requests_HEX5_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX5_s1_end_xfer                         (d1_HEX5_s1_end_xfer),
      .reset_n                                     (clk_0_reset_n)
    );

  HEX5 the_HEX5
    (
      .address    (HEX5_s1_address),
      .chipselect (HEX5_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_HEX5),
      .readdata   (HEX5_s1_readdata),
      .reset_n    (HEX5_s1_reset_n),
      .write_n    (HEX5_s1_write_n),
      .writedata  (HEX5_s1_writedata)
    );

  HEX6_s1_arbitrator the_HEX6_s1
    (
      .HEX6_s1_address                             (HEX6_s1_address),
      .HEX6_s1_chipselect                          (HEX6_s1_chipselect),
      .HEX6_s1_readdata                            (HEX6_s1_readdata),
      .HEX6_s1_readdata_from_sa                    (HEX6_s1_readdata_from_sa),
      .HEX6_s1_reset_n                             (HEX6_s1_reset_n),
      .HEX6_s1_write_n                             (HEX6_s1_write_n),
      .HEX6_s1_writedata                           (HEX6_s1_writedata),
      .clk                                         (clk_0),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX6_s1           (cpu_0_data_master_granted_HEX6_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX6_s1 (cpu_0_data_master_qualified_request_HEX6_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX6_s1   (cpu_0_data_master_read_data_valid_HEX6_s1),
      .cpu_0_data_master_requests_HEX6_s1          (cpu_0_data_master_requests_HEX6_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX6_s1_end_xfer                         (d1_HEX6_s1_end_xfer),
      .reset_n                                     (clk_0_reset_n)
    );

  HEX6 the_HEX6
    (
      .address    (HEX6_s1_address),
      .chipselect (HEX6_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_HEX6),
      .readdata   (HEX6_s1_readdata),
      .reset_n    (HEX6_s1_reset_n),
      .write_n    (HEX6_s1_write_n),
      .writedata  (HEX6_s1_writedata)
    );

  HEX7_s1_arbitrator the_HEX7_s1
    (
      .HEX7_s1_address                             (HEX7_s1_address),
      .HEX7_s1_chipselect                          (HEX7_s1_chipselect),
      .HEX7_s1_readdata                            (HEX7_s1_readdata),
      .HEX7_s1_readdata_from_sa                    (HEX7_s1_readdata_from_sa),
      .HEX7_s1_reset_n                             (HEX7_s1_reset_n),
      .HEX7_s1_write_n                             (HEX7_s1_write_n),
      .HEX7_s1_writedata                           (HEX7_s1_writedata),
      .clk                                         (clk_0),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX7_s1           (cpu_0_data_master_granted_HEX7_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX7_s1 (cpu_0_data_master_qualified_request_HEX7_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX7_s1   (cpu_0_data_master_read_data_valid_HEX7_s1),
      .cpu_0_data_master_requests_HEX7_s1          (cpu_0_data_master_requests_HEX7_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX7_s1_end_xfer                         (d1_HEX7_s1_end_xfer),
      .reset_n                                     (clk_0_reset_n)
    );

  HEX7 the_HEX7
    (
      .address    (HEX7_s1_address),
      .chipselect (HEX7_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_HEX7),
      .readdata   (HEX7_s1_readdata),
      .reset_n    (HEX7_s1_reset_n),
      .write_n    (HEX7_s1_write_n),
      .writedata  (HEX7_s1_writedata)
    );

  KEY_s1_arbitrator the_KEY_s1
    (
      .KEY_s1_address                             (KEY_s1_address),
      .KEY_s1_chipselect                          (KEY_s1_chipselect),
      .KEY_s1_irq                                 (KEY_s1_irq),
      .KEY_s1_irq_from_sa                         (KEY_s1_irq_from_sa),
      .KEY_s1_readdata                            (KEY_s1_readdata),
      .KEY_s1_readdata_from_sa                    (KEY_s1_readdata_from_sa),
      .KEY_s1_reset_n                             (KEY_s1_reset_n),
      .KEY_s1_write_n                             (KEY_s1_write_n),
      .KEY_s1_writedata                           (KEY_s1_writedata),
      .clk                                        (clk_0),
      .cpu_0_data_master_address_to_slave         (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_KEY_s1           (cpu_0_data_master_granted_KEY_s1),
      .cpu_0_data_master_latency_counter          (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_KEY_s1 (cpu_0_data_master_qualified_request_KEY_s1),
      .cpu_0_data_master_read                     (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_KEY_s1   (cpu_0_data_master_read_data_valid_KEY_s1),
      .cpu_0_data_master_requests_KEY_s1          (cpu_0_data_master_requests_KEY_s1),
      .cpu_0_data_master_write                    (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                (cpu_0_data_master_writedata),
      .d1_KEY_s1_end_xfer                         (d1_KEY_s1_end_xfer),
      .reset_n                                    (clk_0_reset_n)
    );

  KEY the_KEY
    (
      .address    (KEY_s1_address),
      .chipselect (KEY_s1_chipselect),
      .clk        (clk_0),
      .in_port    (in_port_to_the_KEY),
      .irq        (KEY_s1_irq),
      .readdata   (KEY_s1_readdata),
      .reset_n    (KEY_s1_reset_n),
      .write_n    (KEY_s1_write_n),
      .writedata  (KEY_s1_writedata)
    );

  LEDG_s1_arbitrator the_LEDG_s1
    (
      .LEDG_s1_address                             (LEDG_s1_address),
      .LEDG_s1_chipselect                          (LEDG_s1_chipselect),
      .LEDG_s1_readdata                            (LEDG_s1_readdata),
      .LEDG_s1_readdata_from_sa                    (LEDG_s1_readdata_from_sa),
      .LEDG_s1_reset_n                             (LEDG_s1_reset_n),
      .LEDG_s1_write_n                             (LEDG_s1_write_n),
      .LEDG_s1_writedata                           (LEDG_s1_writedata),
      .clk                                         (clk_0),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_LEDG_s1           (cpu_0_data_master_granted_LEDG_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_LEDG_s1 (cpu_0_data_master_qualified_request_LEDG_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_LEDG_s1   (cpu_0_data_master_read_data_valid_LEDG_s1),
      .cpu_0_data_master_requests_LEDG_s1          (cpu_0_data_master_requests_LEDG_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_LEDG_s1_end_xfer                         (d1_LEDG_s1_end_xfer),
      .reset_n                                     (clk_0_reset_n)
    );

  LEDG the_LEDG
    (
      .address    (LEDG_s1_address),
      .chipselect (LEDG_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_LEDG),
      .readdata   (LEDG_s1_readdata),
      .reset_n    (LEDG_s1_reset_n),
      .write_n    (LEDG_s1_write_n),
      .writedata  (LEDG_s1_writedata)
    );

  cpu_0_jtag_debug_module_arbitrator the_cpu_0_jtag_debug_module
    (
      .clk                                                                (clk_0),
      .cpu_0_data_master_address_to_slave                                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                       (cpu_0_data_master_byteenable),
      .cpu_0_data_master_debugaccess                                      (cpu_0_data_master_debugaccess),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                  (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_latency_counter                                  (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module        (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read                                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module          (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                 (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_write                                            (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                        (cpu_0_data_master_writedata),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module           (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_latency_counter                           (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module   (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module          (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_jtag_debug_module_address                                    (cpu_0_jtag_debug_module_address),
      .cpu_0_jtag_debug_module_begintransfer                              (cpu_0_jtag_debug_module_begintransfer),
      .cpu_0_jtag_debug_module_byteenable                                 (cpu_0_jtag_debug_module_byteenable),
      .cpu_0_jtag_debug_module_chipselect                                 (cpu_0_jtag_debug_module_chipselect),
      .cpu_0_jtag_debug_module_debugaccess                                (cpu_0_jtag_debug_module_debugaccess),
      .cpu_0_jtag_debug_module_readdata                                   (cpu_0_jtag_debug_module_readdata),
      .cpu_0_jtag_debug_module_readdata_from_sa                           (cpu_0_jtag_debug_module_readdata_from_sa),
      .cpu_0_jtag_debug_module_reset_n                                    (cpu_0_jtag_debug_module_reset_n),
      .cpu_0_jtag_debug_module_resetrequest                               (cpu_0_jtag_debug_module_resetrequest),
      .cpu_0_jtag_debug_module_resetrequest_from_sa                       (cpu_0_jtag_debug_module_resetrequest_from_sa),
      .cpu_0_jtag_debug_module_write                                      (cpu_0_jtag_debug_module_write),
      .cpu_0_jtag_debug_module_writedata                                  (cpu_0_jtag_debug_module_writedata),
      .d1_cpu_0_jtag_debug_module_end_xfer                                (d1_cpu_0_jtag_debug_module_end_xfer),
      .reset_n                                                            (clk_0_reset_n)
    );

  cpu_0_data_master_arbitrator the_cpu_0_data_master
    (
      .HEX0_s1_readdata_from_sa                                                 (HEX0_s1_readdata_from_sa),
      .HEX1_s1_readdata_from_sa                                                 (HEX1_s1_readdata_from_sa),
      .HEX2_s1_readdata_from_sa                                                 (HEX2_s1_readdata_from_sa),
      .HEX3_s1_readdata_from_sa                                                 (HEX3_s1_readdata_from_sa),
      .HEX4_s1_readdata_from_sa                                                 (HEX4_s1_readdata_from_sa),
      .HEX5_s1_readdata_from_sa                                                 (HEX5_s1_readdata_from_sa),
      .HEX6_s1_readdata_from_sa                                                 (HEX6_s1_readdata_from_sa),
      .HEX7_s1_readdata_from_sa                                                 (HEX7_s1_readdata_from_sa),
      .KEY_s1_irq_from_sa                                                       (KEY_s1_irq_from_sa),
      .KEY_s1_readdata_from_sa                                                  (KEY_s1_readdata_from_sa),
      .LEDG_s1_readdata_from_sa                                                 (LEDG_s1_readdata_from_sa),
      .clk                                                                      (clk_0),
      .cpu_0_data_master_address                                                (cpu_0_data_master_address),
      .cpu_0_data_master_address_to_slave                                       (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                             (cpu_0_data_master_byteenable),
      .cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0        (cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_data_master_dbs_address                                            (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_16                                           (cpu_0_data_master_dbs_write_16),
      .cpu_0_data_master_granted_HEX0_s1                                        (cpu_0_data_master_granted_HEX0_s1),
      .cpu_0_data_master_granted_HEX1_s1                                        (cpu_0_data_master_granted_HEX1_s1),
      .cpu_0_data_master_granted_HEX2_s1                                        (cpu_0_data_master_granted_HEX2_s1),
      .cpu_0_data_master_granted_HEX3_s1                                        (cpu_0_data_master_granted_HEX3_s1),
      .cpu_0_data_master_granted_HEX4_s1                                        (cpu_0_data_master_granted_HEX4_s1),
      .cpu_0_data_master_granted_HEX5_s1                                        (cpu_0_data_master_granted_HEX5_s1),
      .cpu_0_data_master_granted_HEX6_s1                                        (cpu_0_data_master_granted_HEX6_s1),
      .cpu_0_data_master_granted_HEX7_s1                                        (cpu_0_data_master_granted_HEX7_s1),
      .cpu_0_data_master_granted_KEY_s1                                         (cpu_0_data_master_granted_KEY_s1),
      .cpu_0_data_master_granted_LEDG_s1                                        (cpu_0_data_master_granted_LEDG_s1),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                        (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave                  (cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_granted_lcd_0_control_slave                            (cpu_0_data_master_granted_lcd_0_control_slave),
      .cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0           (cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_data_master_granted_timer_0_s1                                     (cpu_0_data_master_granted_timer_0_s1),
      .cpu_0_data_master_irq                                                    (cpu_0_data_master_irq),
      .cpu_0_data_master_latency_counter                                        (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX0_s1                              (cpu_0_data_master_qualified_request_HEX0_s1),
      .cpu_0_data_master_qualified_request_HEX1_s1                              (cpu_0_data_master_qualified_request_HEX1_s1),
      .cpu_0_data_master_qualified_request_HEX2_s1                              (cpu_0_data_master_qualified_request_HEX2_s1),
      .cpu_0_data_master_qualified_request_HEX3_s1                              (cpu_0_data_master_qualified_request_HEX3_s1),
      .cpu_0_data_master_qualified_request_HEX4_s1                              (cpu_0_data_master_qualified_request_HEX4_s1),
      .cpu_0_data_master_qualified_request_HEX5_s1                              (cpu_0_data_master_qualified_request_HEX5_s1),
      .cpu_0_data_master_qualified_request_HEX6_s1                              (cpu_0_data_master_qualified_request_HEX6_s1),
      .cpu_0_data_master_qualified_request_HEX7_s1                              (cpu_0_data_master_qualified_request_HEX7_s1),
      .cpu_0_data_master_qualified_request_KEY_s1                               (cpu_0_data_master_qualified_request_KEY_s1),
      .cpu_0_data_master_qualified_request_LEDG_s1                              (cpu_0_data_master_qualified_request_LEDG_s1),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module              (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave        (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_qualified_request_lcd_0_control_slave                  (cpu_0_data_master_qualified_request_lcd_0_control_slave),
      .cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0 (cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_data_master_qualified_request_timer_0_s1                           (cpu_0_data_master_qualified_request_timer_0_s1),
      .cpu_0_data_master_read                                                   (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX0_s1                                (cpu_0_data_master_read_data_valid_HEX0_s1),
      .cpu_0_data_master_read_data_valid_HEX1_s1                                (cpu_0_data_master_read_data_valid_HEX1_s1),
      .cpu_0_data_master_read_data_valid_HEX2_s1                                (cpu_0_data_master_read_data_valid_HEX2_s1),
      .cpu_0_data_master_read_data_valid_HEX3_s1                                (cpu_0_data_master_read_data_valid_HEX3_s1),
      .cpu_0_data_master_read_data_valid_HEX4_s1                                (cpu_0_data_master_read_data_valid_HEX4_s1),
      .cpu_0_data_master_read_data_valid_HEX5_s1                                (cpu_0_data_master_read_data_valid_HEX5_s1),
      .cpu_0_data_master_read_data_valid_HEX6_s1                                (cpu_0_data_master_read_data_valid_HEX6_s1),
      .cpu_0_data_master_read_data_valid_HEX7_s1                                (cpu_0_data_master_read_data_valid_HEX7_s1),
      .cpu_0_data_master_read_data_valid_KEY_s1                                 (cpu_0_data_master_read_data_valid_KEY_s1),
      .cpu_0_data_master_read_data_valid_LEDG_s1                                (cpu_0_data_master_read_data_valid_LEDG_s1),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module                (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave          (cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_read_data_valid_lcd_0_control_slave                    (cpu_0_data_master_read_data_valid_lcd_0_control_slave),
      .cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0   (cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_data_master_read_data_valid_timer_0_s1                             (cpu_0_data_master_read_data_valid_timer_0_s1),
      .cpu_0_data_master_readdata                                               (cpu_0_data_master_readdata),
      .cpu_0_data_master_readdatavalid                                          (cpu_0_data_master_readdatavalid),
      .cpu_0_data_master_requests_HEX0_s1                                       (cpu_0_data_master_requests_HEX0_s1),
      .cpu_0_data_master_requests_HEX1_s1                                       (cpu_0_data_master_requests_HEX1_s1),
      .cpu_0_data_master_requests_HEX2_s1                                       (cpu_0_data_master_requests_HEX2_s1),
      .cpu_0_data_master_requests_HEX3_s1                                       (cpu_0_data_master_requests_HEX3_s1),
      .cpu_0_data_master_requests_HEX4_s1                                       (cpu_0_data_master_requests_HEX4_s1),
      .cpu_0_data_master_requests_HEX5_s1                                       (cpu_0_data_master_requests_HEX5_s1),
      .cpu_0_data_master_requests_HEX6_s1                                       (cpu_0_data_master_requests_HEX6_s1),
      .cpu_0_data_master_requests_HEX7_s1                                       (cpu_0_data_master_requests_HEX7_s1),
      .cpu_0_data_master_requests_KEY_s1                                        (cpu_0_data_master_requests_KEY_s1),
      .cpu_0_data_master_requests_LEDG_s1                                       (cpu_0_data_master_requests_LEDG_s1),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                       (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave                 (cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_requests_lcd_0_control_slave                           (cpu_0_data_master_requests_lcd_0_control_slave),
      .cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0          (cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_data_master_requests_timer_0_s1                                    (cpu_0_data_master_requests_timer_0_s1),
      .cpu_0_data_master_waitrequest                                            (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                                  (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                              (cpu_0_data_master_writedata),
      .cpu_0_jtag_debug_module_readdata_from_sa                                 (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_HEX0_s1_end_xfer                                                      (d1_HEX0_s1_end_xfer),
      .d1_HEX1_s1_end_xfer                                                      (d1_HEX1_s1_end_xfer),
      .d1_HEX2_s1_end_xfer                                                      (d1_HEX2_s1_end_xfer),
      .d1_HEX3_s1_end_xfer                                                      (d1_HEX3_s1_end_xfer),
      .d1_HEX4_s1_end_xfer                                                      (d1_HEX4_s1_end_xfer),
      .d1_HEX5_s1_end_xfer                                                      (d1_HEX5_s1_end_xfer),
      .d1_HEX6_s1_end_xfer                                                      (d1_HEX6_s1_end_xfer),
      .d1_HEX7_s1_end_xfer                                                      (d1_HEX7_s1_end_xfer),
      .d1_KEY_s1_end_xfer                                                       (d1_KEY_s1_end_xfer),
      .d1_LEDG_s1_end_xfer                                                      (d1_LEDG_s1_end_xfer),
      .d1_cpu_0_jtag_debug_module_end_xfer                                      (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_jtag_uart_0_avalon_jtag_slave_end_xfer                                (d1_jtag_uart_0_avalon_jtag_slave_end_xfer),
      .d1_lcd_0_control_slave_end_xfer                                          (d1_lcd_0_control_slave_end_xfer),
      .d1_timer_0_s1_end_xfer                                                   (d1_timer_0_s1_end_xfer),
      .d1_tri_state_bridge_0_avalon_slave_end_xfer                              (d1_tri_state_bridge_0_avalon_slave_end_xfer),
      .incoming_data_to_and_from_the_static_ram_0                               (incoming_data_to_and_from_the_static_ram_0),
      .jtag_uart_0_avalon_jtag_slave_irq_from_sa                                (jtag_uart_0_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_0_avalon_jtag_slave_readdata_from_sa                           (jtag_uart_0_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa                        (jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa),
      .lcd_0_control_slave_readdata_from_sa                                     (lcd_0_control_slave_readdata_from_sa),
      .lcd_0_control_slave_wait_counter_eq_0                                    (lcd_0_control_slave_wait_counter_eq_0),
      .reset_n                                                                  (clk_0_reset_n),
      .timer_0_s1_irq_from_sa                                                   (timer_0_s1_irq_from_sa),
      .timer_0_s1_readdata_from_sa                                              (timer_0_s1_readdata_from_sa)
    );

  cpu_0_instruction_master_arbitrator the_cpu_0_instruction_master
    (
      .clk                                                                             (clk_0),
      .cpu_0_instruction_master_address                                                (cpu_0_instruction_master_address),
      .cpu_0_instruction_master_address_to_slave                                       (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_dbs_address                                            (cpu_0_instruction_master_dbs_address),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module                        (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0           (cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_instruction_master_latency_counter                                        (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module              (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0 (cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_instruction_master_read                                                   (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module                (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0   (cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_instruction_master_readdata                                               (cpu_0_instruction_master_readdata),
      .cpu_0_instruction_master_readdatavalid                                          (cpu_0_instruction_master_readdatavalid),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module                       (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0          (cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_instruction_master_waitrequest                                            (cpu_0_instruction_master_waitrequest),
      .cpu_0_jtag_debug_module_readdata_from_sa                                        (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_cpu_0_jtag_debug_module_end_xfer                                             (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_tri_state_bridge_0_avalon_slave_end_xfer                                     (d1_tri_state_bridge_0_avalon_slave_end_xfer),
      .incoming_data_to_and_from_the_static_ram_0                                      (incoming_data_to_and_from_the_static_ram_0),
      .reset_n                                                                         (clk_0_reset_n)
    );

  cpu_0 the_cpu_0
    (
      .clk                                   (clk_0),
      .d_address                             (cpu_0_data_master_address),
      .d_byteenable                          (cpu_0_data_master_byteenable),
      .d_irq                                 (cpu_0_data_master_irq),
      .d_read                                (cpu_0_data_master_read),
      .d_readdata                            (cpu_0_data_master_readdata),
      .d_readdatavalid                       (cpu_0_data_master_readdatavalid),
      .d_waitrequest                         (cpu_0_data_master_waitrequest),
      .d_write                               (cpu_0_data_master_write),
      .d_writedata                           (cpu_0_data_master_writedata),
      .i_address                             (cpu_0_instruction_master_address),
      .i_read                                (cpu_0_instruction_master_read),
      .i_readdata                            (cpu_0_instruction_master_readdata),
      .i_readdatavalid                       (cpu_0_instruction_master_readdatavalid),
      .i_waitrequest                         (cpu_0_instruction_master_waitrequest),
      .jtag_debug_module_address             (cpu_0_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (cpu_0_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (cpu_0_jtag_debug_module_byteenable),
      .jtag_debug_module_debugaccess         (cpu_0_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (cpu_0_data_master_debugaccess),
      .jtag_debug_module_readdata            (cpu_0_jtag_debug_module_readdata),
      .jtag_debug_module_resetrequest        (cpu_0_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (cpu_0_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (cpu_0_jtag_debug_module_write),
      .jtag_debug_module_writedata           (cpu_0_jtag_debug_module_writedata),
      .reset_n                               (cpu_0_jtag_debug_module_reset_n)
    );

  jtag_uart_0_avalon_jtag_slave_arbitrator the_jtag_uart_0_avalon_jtag_slave
    (
      .clk                                                               (clk_0),
      .cpu_0_data_master_address_to_slave                                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave           (cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_latency_counter                                 (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_read                                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave   (cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave          (cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_write                                           (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                       (cpu_0_data_master_writedata),
      .d1_jtag_uart_0_avalon_jtag_slave_end_xfer                         (d1_jtag_uart_0_avalon_jtag_slave_end_xfer),
      .jtag_uart_0_avalon_jtag_slave_address                             (jtag_uart_0_avalon_jtag_slave_address),
      .jtag_uart_0_avalon_jtag_slave_chipselect                          (jtag_uart_0_avalon_jtag_slave_chipselect),
      .jtag_uart_0_avalon_jtag_slave_dataavailable                       (jtag_uart_0_avalon_jtag_slave_dataavailable),
      .jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa               (jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa),
      .jtag_uart_0_avalon_jtag_slave_irq                                 (jtag_uart_0_avalon_jtag_slave_irq),
      .jtag_uart_0_avalon_jtag_slave_irq_from_sa                         (jtag_uart_0_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_0_avalon_jtag_slave_read_n                              (jtag_uart_0_avalon_jtag_slave_read_n),
      .jtag_uart_0_avalon_jtag_slave_readdata                            (jtag_uart_0_avalon_jtag_slave_readdata),
      .jtag_uart_0_avalon_jtag_slave_readdata_from_sa                    (jtag_uart_0_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_readyfordata                        (jtag_uart_0_avalon_jtag_slave_readyfordata),
      .jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa                (jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_reset_n                             (jtag_uart_0_avalon_jtag_slave_reset_n),
      .jtag_uart_0_avalon_jtag_slave_waitrequest                         (jtag_uart_0_avalon_jtag_slave_waitrequest),
      .jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa                 (jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa),
      .jtag_uart_0_avalon_jtag_slave_write_n                             (jtag_uart_0_avalon_jtag_slave_write_n),
      .jtag_uart_0_avalon_jtag_slave_writedata                           (jtag_uart_0_avalon_jtag_slave_writedata),
      .reset_n                                                           (clk_0_reset_n)
    );

  jtag_uart_0 the_jtag_uart_0
    (
      .av_address     (jtag_uart_0_avalon_jtag_slave_address),
      .av_chipselect  (jtag_uart_0_avalon_jtag_slave_chipselect),
      .av_irq         (jtag_uart_0_avalon_jtag_slave_irq),
      .av_read_n      (jtag_uart_0_avalon_jtag_slave_read_n),
      .av_readdata    (jtag_uart_0_avalon_jtag_slave_readdata),
      .av_waitrequest (jtag_uart_0_avalon_jtag_slave_waitrequest),
      .av_write_n     (jtag_uart_0_avalon_jtag_slave_write_n),
      .av_writedata   (jtag_uart_0_avalon_jtag_slave_writedata),
      .clk            (clk_0),
      .dataavailable  (jtag_uart_0_avalon_jtag_slave_dataavailable),
      .readyfordata   (jtag_uart_0_avalon_jtag_slave_readyfordata),
      .rst_n          (jtag_uart_0_avalon_jtag_slave_reset_n)
    );

  lcd_0_control_slave_arbitrator the_lcd_0_control_slave
    (
      .clk                                                     (clk_0),
      .cpu_0_data_master_address_to_slave                      (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                            (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_lcd_0_control_slave           (cpu_0_data_master_granted_lcd_0_control_slave),
      .cpu_0_data_master_latency_counter                       (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_lcd_0_control_slave (cpu_0_data_master_qualified_request_lcd_0_control_slave),
      .cpu_0_data_master_read                                  (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_lcd_0_control_slave   (cpu_0_data_master_read_data_valid_lcd_0_control_slave),
      .cpu_0_data_master_requests_lcd_0_control_slave          (cpu_0_data_master_requests_lcd_0_control_slave),
      .cpu_0_data_master_write                                 (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                             (cpu_0_data_master_writedata),
      .d1_lcd_0_control_slave_end_xfer                         (d1_lcd_0_control_slave_end_xfer),
      .lcd_0_control_slave_address                             (lcd_0_control_slave_address),
      .lcd_0_control_slave_begintransfer                       (lcd_0_control_slave_begintransfer),
      .lcd_0_control_slave_read                                (lcd_0_control_slave_read),
      .lcd_0_control_slave_readdata                            (lcd_0_control_slave_readdata),
      .lcd_0_control_slave_readdata_from_sa                    (lcd_0_control_slave_readdata_from_sa),
      .lcd_0_control_slave_wait_counter_eq_0                   (lcd_0_control_slave_wait_counter_eq_0),
      .lcd_0_control_slave_write                               (lcd_0_control_slave_write),
      .lcd_0_control_slave_writedata                           (lcd_0_control_slave_writedata),
      .reset_n                                                 (clk_0_reset_n)
    );

  lcd_0 the_lcd_0
    (
      .LCD_E         (LCD_E_from_the_lcd_0),
      .LCD_RS        (LCD_RS_from_the_lcd_0),
      .LCD_RW        (LCD_RW_from_the_lcd_0),
      .LCD_data      (LCD_data_to_and_from_the_lcd_0),
      .address       (lcd_0_control_slave_address),
      .begintransfer (lcd_0_control_slave_begintransfer),
      .read          (lcd_0_control_slave_read),
      .readdata      (lcd_0_control_slave_readdata),
      .write         (lcd_0_control_slave_write),
      .writedata     (lcd_0_control_slave_writedata)
    );

  timer_0_s1_arbitrator the_timer_0_s1
    (
      .clk                                            (clk_0),
      .cpu_0_data_master_address_to_slave             (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_timer_0_s1           (cpu_0_data_master_granted_timer_0_s1),
      .cpu_0_data_master_latency_counter              (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_timer_0_s1 (cpu_0_data_master_qualified_request_timer_0_s1),
      .cpu_0_data_master_read                         (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_timer_0_s1   (cpu_0_data_master_read_data_valid_timer_0_s1),
      .cpu_0_data_master_requests_timer_0_s1          (cpu_0_data_master_requests_timer_0_s1),
      .cpu_0_data_master_write                        (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                    (cpu_0_data_master_writedata),
      .d1_timer_0_s1_end_xfer                         (d1_timer_0_s1_end_xfer),
      .reset_n                                        (clk_0_reset_n),
      .timer_0_s1_address                             (timer_0_s1_address),
      .timer_0_s1_chipselect                          (timer_0_s1_chipselect),
      .timer_0_s1_irq                                 (timer_0_s1_irq),
      .timer_0_s1_irq_from_sa                         (timer_0_s1_irq_from_sa),
      .timer_0_s1_readdata                            (timer_0_s1_readdata),
      .timer_0_s1_readdata_from_sa                    (timer_0_s1_readdata_from_sa),
      .timer_0_s1_reset_n                             (timer_0_s1_reset_n),
      .timer_0_s1_write_n                             (timer_0_s1_write_n),
      .timer_0_s1_writedata                           (timer_0_s1_writedata)
    );

  timer_0 the_timer_0
    (
      .address    (timer_0_s1_address),
      .chipselect (timer_0_s1_chipselect),
      .clk        (clk_0),
      .irq        (timer_0_s1_irq),
      .readdata   (timer_0_s1_readdata),
      .reset_n    (timer_0_s1_reset_n),
      .write_n    (timer_0_s1_write_n),
      .writedata  (timer_0_s1_writedata)
    );

  tri_state_bridge_0_avalon_slave_arbitrator the_tri_state_bridge_0_avalon_slave
    (
      .address_to_the_static_ram_0                                                     (address_to_the_static_ram_0),
      .byte_enable_to_the_static_ram_0                                                 (byte_enable_to_the_static_ram_0),
      .chip_select_to_the_static_ram_0                                                 (chip_select_to_the_static_ram_0),
      .clk                                                                             (clk_0),
      .cpu_0_data_master_address_to_slave                                              (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                                    (cpu_0_data_master_byteenable),
      .cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0               (cpu_0_data_master_byteenable_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_data_master_dbs_address                                                   (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_16                                                  (cpu_0_data_master_dbs_write_16),
      .cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0                  (cpu_0_data_master_granted_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_data_master_latency_counter                                               (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0        (cpu_0_data_master_qualified_request_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_data_master_read                                                          (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0          (cpu_0_data_master_read_data_valid_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0                 (cpu_0_data_master_requests_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_data_master_write                                                         (cpu_0_data_master_write),
      .cpu_0_instruction_master_address_to_slave                                       (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_dbs_address                                            (cpu_0_instruction_master_dbs_address),
      .cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0           (cpu_0_instruction_master_granted_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_instruction_master_latency_counter                                        (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0 (cpu_0_instruction_master_qualified_request_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_instruction_master_read                                                   (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0   (cpu_0_instruction_master_read_data_valid_static_ram_0_avalon_tristate_slave_0),
      .cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0          (cpu_0_instruction_master_requests_static_ram_0_avalon_tristate_slave_0),
      .d1_tri_state_bridge_0_avalon_slave_end_xfer                                     (d1_tri_state_bridge_0_avalon_slave_end_xfer),
      .data_to_and_from_the_static_ram_0                                               (data_to_and_from_the_static_ram_0),
      .incoming_data_to_and_from_the_static_ram_0                                      (incoming_data_to_and_from_the_static_ram_0),
      .read_n_to_the_static_ram_0                                                      (read_n_to_the_static_ram_0),
      .reset_n                                                                         (clk_0_reset_n),
      .write_n_to_the_static_ram_0                                                     (write_n_to_the_static_ram_0)
    );

  //reset is asserted asynchronously and deasserted synchronously
  RTSLab1CPU_reset_clk_0_domain_synch_module RTSLab1CPU_reset_clk_0_domain_synch
    (
      .clk      (clk_0),
      .data_in  (1'b1),
      .data_out (clk_0_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    cpu_0_jtag_debug_module_resetrequest_from_sa |
    cpu_0_jtag_debug_module_resetrequest_from_sa);


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "c:/altera/10.1/quartus/eda/sim_lib/altera_mf.v"
`include "c:/altera/10.1/quartus/eda/sim_lib/220model.v"
`include "c:/altera/10.1/quartus/eda/sim_lib/sgate.v"
`include "KEY.v"
`include "HEX6.v"
`include "lcd_0.v"
`include "timer_0.v"
`include "HEX5.v"
`include "HEX7.v"
`include "HEX1.v"
`include "cpu_0_test_bench.v"
`include "cpu_0_mult_cell.v"
`include "cpu_0_oci_test_bench.v"
`include "cpu_0_jtag_debug_module_tck.v"
`include "cpu_0_jtag_debug_module_sysclk.v"
`include "cpu_0_jtag_debug_module_wrapper.v"
`include "cpu_0.v"
`include "HEX4.v"
`include "HEX3.v"
`include "HEX2.v"
`include "LEDG.v"
`include "jtag_uart_0.v"
`include "HEX0.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire             LCD_E_from_the_lcd_0;
  wire             LCD_RS_from_the_lcd_0;
  wire             LCD_RW_from_the_lcd_0;
  wire    [  7: 0] LCD_data_to_and_from_the_lcd_0;
  wire    [ 17: 0] address_to_the_static_ram_0;
  wire    [  1: 0] byte_enable_to_the_static_ram_0;
  wire             chip_select_to_the_static_ram_0;
  wire             clk;
  reg              clk_0;
  wire    [ 15: 0] data_to_and_from_the_static_ram_0;
  wire    [  3: 0] in_port_to_the_KEY;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  wire    [  6: 0] out_port_from_the_HEX0;
  wire    [  6: 0] out_port_from_the_HEX1;
  wire    [  6: 0] out_port_from_the_HEX2;
  wire    [  6: 0] out_port_from_the_HEX3;
  wire    [  6: 0] out_port_from_the_HEX4;
  wire    [  6: 0] out_port_from_the_HEX5;
  wire    [  6: 0] out_port_from_the_HEX6;
  wire    [  6: 0] out_port_from_the_HEX7;
  wire    [  7: 0] out_port_from_the_LEDG;
  wire             read_n_to_the_static_ram_0;
  reg              reset_n;
  wire             write_n_to_the_static_ram_0;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  RTSLab1CPU DUT
    (
      .LCD_E_from_the_lcd_0              (LCD_E_from_the_lcd_0),
      .LCD_RS_from_the_lcd_0             (LCD_RS_from_the_lcd_0),
      .LCD_RW_from_the_lcd_0             (LCD_RW_from_the_lcd_0),
      .LCD_data_to_and_from_the_lcd_0    (LCD_data_to_and_from_the_lcd_0),
      .address_to_the_static_ram_0       (address_to_the_static_ram_0),
      .byte_enable_to_the_static_ram_0   (byte_enable_to_the_static_ram_0),
      .chip_select_to_the_static_ram_0   (chip_select_to_the_static_ram_0),
      .clk_0                             (clk_0),
      .data_to_and_from_the_static_ram_0 (data_to_and_from_the_static_ram_0),
      .in_port_to_the_KEY                (in_port_to_the_KEY),
      .out_port_from_the_HEX0            (out_port_from_the_HEX0),
      .out_port_from_the_HEX1            (out_port_from_the_HEX1),
      .out_port_from_the_HEX2            (out_port_from_the_HEX2),
      .out_port_from_the_HEX3            (out_port_from_the_HEX3),
      .out_port_from_the_HEX4            (out_port_from_the_HEX4),
      .out_port_from_the_HEX5            (out_port_from_the_HEX5),
      .out_port_from_the_HEX6            (out_port_from_the_HEX6),
      .out_port_from_the_HEX7            (out_port_from_the_HEX7),
      .out_port_from_the_LEDG            (out_port_from_the_LEDG),
      .read_n_to_the_static_ram_0        (read_n_to_the_static_ram_0),
      .reset_n                           (reset_n),
      .write_n_to_the_static_ram_0       (write_n_to_the_static_ram_0)
    );

  initial
    clk_0 = 1'b0;
  always
    #10 clk_0 <= ~clk_0;
  
  initial 
    begin
      reset_n <= 0;
      #200 reset_n <= 1;
    end

endmodule


//synthesis translate_on