// this is a rewreite of lvdsreceiver.v
// from vhdl to verilog to deal with the
// problem of modelsim not allowing mixed
// vhdl/verilog designs in modelsim-ae for quartus II 13.1
// wittich 7/16
module lvds_receiver(
		     input wire FASTCLK,
		     input wire FRAME,
		     input wire  DATA,
		     input wire RESET_n,
		     input wire sysclk,
		     output wire [11:0] CBDATA,
		     output wire [7:0] CBADDRESS,
		     output wire WENABLE
		     );
   wire 			 	doh, dol;
   reg 	[11:0] 	lvds_sr;
   wire 			 	LATCHFRAME, LATCHFRAME1;
   wire 	[11:0] 	lvds_rx;
   reg 	[7:0] 	address;
	reg 	[11:0] 	cbdata_r;
	
	assign CBDATA = cbdata_r;

   // shift register
   always @(posedge FASTCLK) 
      lvds_sr <= { lvds_sr[9:0], doh, dol};

   // DDR input component; takes ADC input
   altddio_in	ALTDDIO_IN_component (
				      .aclr (1'b0),
				      .datain (DATA),
				      .inclock (FASTCLK),
				      .dataout_h (doh),
				      .dataout_l (dol),
				      .aset (1'b0),
				      .inclocken (1'b1),
				      .sclr (1'b0),
				      .sset (1'b0));
   defparam
     ALTDDIO_IN_component.intended_device_family = "Cyclone III",
     ALTDDIO_IN_component.invert_input_clocks = "OFF",
     ALTDDIO_IN_component.lpm_hint = "UNUSED",
     ALTDDIO_IN_component.lpm_type = "altddio_in",
     ALTDDIO_IN_component.power_up_high = "OFF",
     ALTDDIO_IN_component.width = 1;

   // state machine to decode the data from LVDS.
   // based on fizzim FSM file in src/other
   // lvsd_receiver_sm
   // start fizzim output

// Created by fizzim.pl version 5.10 on 2016:07:22 at 05:25:45 (www.fizzim.com)


  // state bits
  parameter 
  init       = 3'b000, // extra=00 WENABLE=0 
  latchdata  = 3'b001, // extra=00 WENABLE=1 
  wait4data  = 3'b010, // extra=01 WENABLE=0 
  wait4synch = 3'b100; // extra=10 WENABLE=0 

  reg [2:0] state;
  reg [2:0] nextstate;

  // comb always block
  always @* begin
    nextstate = 3'bxxx; // default to x because default_state_is_x is set
    case (state)
      init      : begin
        if (!FRAME) begin
          nextstate = wait4synch;
        end
        else begin
          nextstate = init;
        end
      end
      latchdata : begin
        begin
          nextstate = init;
        end
      end
      wait4data : begin
        begin
          nextstate = latchdata;
        end
      end
      wait4synch: begin
        if (FRAME) begin
          nextstate = wait4data;
        end
        else begin
          nextstate = wait4synch;
        end
      end
    endcase
  end

  // Assign reg'd outputs to state bits
  assign WENABLE = state[0];

  // sequential always block
  always @(posedge FASTCLK) begin
    if (!RESET_n)
      state <= init;
    else
      state <= nextstate;
  end

  // datapath sequential always block
  always @(posedge FASTCLK) begin
    if (!RESET_n) begin
      // Warning R18: No reset value set for datapath output address.   Assigning a reset value of 8'h00 based on value in reset state init 
      address <= 8'h00;
      // Warning R18: No reset value set for datapath output cbdata_r.   Assigning a reset value of 12'h000 based on value in reset state init 
      cbdata_r <= 12'h000;
    end
    else begin
      address <= 8'h00; // default
      cbdata_r <= 12'h000; // default
      case (nextstate)
        wait4data : begin
          address <= address + 8'h01;
          cbdata_r <= lvds_sr;
        end
      endcase
    end
  end

  // This code allows you to see state names in simulation
  `ifndef SYNTHESIS
  reg [79:0] statename;
  always @* begin
    case (state)
      init      :
        statename = "init";
      latchdata :
        statename = "latchdata";
      wait4data :
        statename = "wait4data";
      wait4synch:
        statename = "wait4synch";
      default   :
        statename = "XXXXXXXXXX";
    endcase
  end
  `endif


   // end fizzim
   

   
   endmodule