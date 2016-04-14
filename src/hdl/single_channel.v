`timescale 1ns / 1ps
`default_nettype none
  //////////////////////////////////////////////////////////////////////////////////
// Company: 
  // Engineer: 
  // 
  // Create Date: 03/11/2016 11:31:57 AM
  // Design Name: 
  // Module Name: single_channel
  // Project Name: 
  // Target Devices: 
  // Tool Versions: 
  // Description: 
  // 
  // Dependencies: 
  // 
  // Revision:
  // Revision 0.01 - File Created
  // Additional Comments:
  // 
  //////////////////////////////////////////////////////////////////////////////////


  module single_channel
    #(parameter SIZE=8, WIDTH=16)
   (
    input wire CLK,
    input wire RESET,
    input wire DAVAIL,
    input wire TRIGGER,
    input wire [WIDTH-1:0] adcdata_p,
    output wire [WIDTH-1:0] DOUT,
    input wire [SIZE-1:0]  howmany,
    input wire [SIZE-1:0]  offset,
    input wire           rd_request
    );
   
   wire 		 RO_ENABLE;
   wire 		 WR_ENABLE;
   wire [SIZE-1:0] 	 SYNTHESIZED_WIRE_0;
   wire 		 SYNTHESIZED_WIRE_1;
   wire [SIZE-1:0] 	 RD_ADDR;

   
   ringbuffer	ringbuffer_inst0(
				 .clk(CLK),
				 .wr_en(WR_ENABLE),
				 .rd_en(RO_ENABLE),
				 .rst(RESET),
				 .ain(SYNTHESIZED_WIRE_0),
				 .din(adcdata_p),
				 .aout(RD_ADDR),
				 .dout(DOUT));
   defparam    ringbuffer_inst0.SIZE = SIZE;
   defparam    ringbuffer_inst0.WIDTH = WIDTH;
   
   wire 		 RO_DONE_n;
   
   SM1    channel_sm(
		     .DAVAIL(DAVAIL),
		     .ROREQUEST(rd_request),
		     .TRIGGER(TRIGGER),
		     .clk(CLK),
		     .rst(RESET),
		     .RO_ENABLE(RO_ENABLE),
		     .WR_ENABLE(WR_ENABLE),
		     .RODONE_n(RO_DONE_n));
   defparam    channel_sm.ADC_RUNNING = 3'b010;
   defparam    channel_sm.IDLE = 3'b000;
   defparam    channel_sm.READOUT = 3'b001;
   defparam    channel_sm.TRIGGERED = 3'b100;
   
   
   addr_cntrl    ch_addrctrl(
			     .rd_request(RO_ENABLE),
			     .clk(CLK),
			     .rst(RESET),
			     .ain(RD_ADDR),
			     .howmany_i(howmany),
			     .offset_i(offset),
			     .address(SYNTHESIZED_WIRE_0),
			     .ro_done_n(RO_DONE_n));
   defparam    ch_addrctrl.SIZE = SIZE;
   
   
endmodule
