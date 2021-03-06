#script for testing single channel
#created by Katherine Ding Aug 25 2016
#revision history:


#need to have altera_mf_ver before altera_mf 
vsim -L altera_mf_ver -L altera_mf rtl_work.single_channel

#add top level objects to wave viewer
#inputs
add wave -position end  sim:/single_channel/clk
add wave -position end  sim:/single_channel/reset
add wave -position end  sim:/single_channel/how_many
add wave -position end  sim:/single_channel/offset
add wave -position end  sim:/single_channel/adc_fast_clk
add wave -position end  sim:/single_channel/adc_frame
add wave -position end  sim:/single_channel/adc_data_p
add wave -position end  sim:/single_channel/adc_data_ready
add wave -position end  sim:/single_channel/trigger
add wave -position end  sim:/single_channel/read_request
#outputs
add wave -position end  sim:/single_channel/data_out
#internal
add wave -position end  sim:/single_channel/SIZE
add wave -position end  sim:/single_channel/WIDTH
add wave -position end  sim:/single_channel/RO_ENABLE
add wave -position end  sim:/single_channel/WR_ENABLE_LVDS
add wave -position end  sim:/single_channel/WR_ENABLE_SM
add wave -position end  sim:/single_channel/SYNTHESIZED_WIRE_0
add wave -position end  sim:/single_channel/RD_ADDR
add wave -position end  sim:/single_channel/cbdata
add wave -position end  sim:/single_channel/RO_DONE_n


#add channel_sm objects to wave viewer
#outputs
add wave -position end  sim:/single_channel/channel_sm/RO_ENABLE
add wave -position end  sim:/single_channel/channel_sm/WR_ENABLE
#inputs
add wave -position end  sim:/single_channel/channel_sm/DAVAIL
add wave -position end  sim:/single_channel/channel_sm/ROREQUEST
add wave -position end  sim:/single_channel/channel_sm/TRIGGER
add wave -position end  sim:/single_channel/channel_sm/RODONE_n
add wave -position end  sim:/single_channel/channel_sm/rst
#internal states
add wave -position end  sim:/single_channel/channel_sm/statename


#add lvds reciever objects to wave viewer
#inputs
add wave -position end  sim:/single_channel/receiver_inst/FRAME
add wave -position end  sim:/single_channel/receiver_inst/DATA
add wave -position end  sim:/single_channel/receiver_inst/RESET_n
#outputs
add wave -position end  sim:/single_channel/receiver_inst/CBDATA
add wave -position end  sim:/single_channel/receiver_inst/CBADDRESS
add wave -position end  sim:/single_channel/receiver_inst/WENABLE
#internal states
add wave -position end  sim:/single_channel/receiver_inst/doh
add wave -position end  sim:/single_channel/receiver_inst/dol
add wave -position end  sim:/single_channel/receiver_inst/lvds_sr
add wave -position end  sim:/single_channel/receiver_inst/LATCHFRAME
add wave -position end  sim:/single_channel/receiver_inst/LATCHFRAME1
add wave -position end  sim:/single_channel/receiver_inst/lvds_rx
add wave -position end  sim:/single_channel/receiver_inst/address
add wave -position end  sim:/single_channel/receiver_inst/cbdata_r
add wave -position end  sim:/single_channel/receiver_inst/statename


#add ringbuffer objects to wave viewer
#inputs
add wave -position end  sim:/single_channel/ringbuffer_inst0/ain
add wave -position end  sim:/single_channel/ringbuffer_inst0/din
#outputs
add wave -position end  sim:/single_channel/ringbuffer_inst0/dout
add wave -position end  sim:/single_channel/ringbuffer_inst0/aout



#SET UP WAVES

#set system clock: 50MHz => Set Period to be 18ns to work with adc_fast_clk
force -freeze sim:/single_channel/clk 1 0, 0 {9000 ps} -r 18ns

#drive reset for 5 clock cycles
force -drive sim:/single_channel/reset 1 10ns
force -drive sim:/single_channel/reset 0 110ns

#set how_many to 15, offset to 0
#how_many is not consistent with global setting 255
force -drive sim:/single_channel/how_many 00001111 0
force -drive sim:/single_channel/offset 00000000 0

#set up adc_frame according to Figure 6 in MAXIM19527 Datasheet
force -freeze sim:/single_channel/adc_frame 1 9.5ns, 0 {14000 ps} -r 18ns

#let adc_data be all ones for now - 
#delay must match (adc_frame delay + 8*18ns) = 8.5 clk cycle data latency
force -drive sim:/single_channel/adc_data_p 1 153.5ns

#set adc_fast_clock : 50 * 6 = 300 MHz => Approximate by period = 3ns
#delay is set according to Figure 6 in MAXIM19527 Datasheet
force -freeze sim:/single_channel/adc_fast_clk 1 1.25ns, 0 {2750 ps} -r 3ns


#============================DOUBIOUS ASSUMPTIONS====================================
#assume data_ready goes high the same time ADC starts giving data
force -drive sim:/single_channel/adc_data_ready 1 153.5ns

#assume trigger resets to 0 with reset driven high - timing align with reset signal
force -drive sim:/single_channel/trigger 0 18ns
#drive trigger high at 200ns for 1 clock period
force -drive sim:/single_channel/trigger 1 200ns
force -drive sim:/single_channel/trigger 0 218ns

#assume read_request resets to 0 with reset driven high - timing align with reset signal
force -drive sim:/single_channel/read_request 0 18ns
#drive trigger high at 230ns for 1 clock period
force -drive sim:/single_channel/read_request 1 230ns
force -drive sim:/single_channel/read_request 0 248ns



run 800ns