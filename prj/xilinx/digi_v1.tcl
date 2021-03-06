# # run this from top of the GIT project

# Vivado (TM) v2014.4 (64-bit)
#
# test1.tcl: Tcl script for re-creating project 'project_1'
#
# Generated by Vivado on Thu Apr 14 10:15:36 EDT 2016
# IP Build 1070531 on Tue Nov 18 01:10:18 MST 2014
#
# This file contains the Vivado Tcl commands for re-creating the project to the state*
# when this script was generated. In order to re-create the project, please source this
# file in the Vivado Tcl Shell.
#
# * Note that the runs in the created project will be configured the same way as the
#   original project, however they will not be launched automatically. To regenerate the
#   run results please launch the synthesis/implementation runs as needed.
#
#*****************************************************************************************
# NOTE: In order to use this script for source control purposes, please make sure that the
#       following files are added to the source control system:-
#
# 1. This project restoration tcl script (test1.tcl) that was generated.
#
# 2. The following source(s) files that were local or imported into the original project.
#    (Please see the '$orig_proj_dir' and '$origin_dir' variable setting below at the start of the script)
#
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/sources_1/imports/xilinx_v1/SM2.v"
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/sources_1/imports/xilinx_v1/ringbuffer.v"
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/sources_1/imports/xilinx_v1/addr_cntrl.v"
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/sources_1/imports/xilinx_v1/SM_chro.v"
#
# 3. The following remote source files that were added to the original project:-
#
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/sources_1/new/digi.v"
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/sources_1/new/single_channel.v"
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/sources_1/new/digi_many.v"
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/sources_1/new/enc.v"
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/sources_1/new/memory.v"
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/sources_1/new/demux.v"
#    "/home/wittich/maaps_daq/xilinx_v1/bc_counter.v"
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/sources_1/ip/fifo/fifo.xci"
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/constrs_1/new/digi.xdc"
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/project_1.srcs/sim_1/new/digi_bench.v"
#    "/home/wittich/maaps_daq/xilinx_v1/project_1/digi_bench_behav.wcfg"
#
#*****************************************************************************************

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Set the directory path for the original project from where this script was exported
#set orig_proj_dir "[file normalize "$origin_dir/maaps_daq/xilinx_v1/project_1"]"

# Create project
create_project project_1 ./project_1

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [get_projects project_1]
set_property "board_part" "xilinx.com:vc709:part0:1.5" $obj
set_property "default_lib" "xil_defaultlib" $obj
set_property "simulator_language" "Mixed" $obj
set_property "source_mgmt_mode" "DisplayOnly" $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/src/hdl/digi.v"]"\
 "[file normalize "$origin_dir/src/hdl/single_channel.v"]"\
 "[file normalize "$origin_dir/src/hdl/digi_many.v"]"\
 "[file normalize "$origin_dir/src/hdl/enc.v"]"\
 "[file normalize "$origin_dir/src/hdl/memory.v"]"\
 "[file normalize "$origin_dir/src/hdl/demux.v"]"\
 "[file normalize "$origin_dir/src/hdl/bc_counter.v"]"\
 "[file normalize "$origin_dir/src/hdl/SM2.v"]"\
 "[file normalize "$origin_dir/src/hdl/ringbuffer.v"]"\
 "[file normalize "$origin_dir/src/hdl/addr_cntrl.v"]"\
 "[file normalize "$origin_dir/src/hdl/SM_chro.v"]"\
]
add_files -norecurse -fileset $obj $files


# Set 'sources_1' fileset file properties for remote files
# None

# Set 'sources_1' fileset file properties for local files
# None

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property "top" "digi_many" $obj

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/prj/xilinx/ip/fifo/fifo.xci"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$origin_dir/prj/xilinx/ip/fifo/fifo.xci"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
if { ![get_property "is_locked" $file_obj] } {
  set_property "synth_checkpoint_mode" "Singular" $file_obj
}


# Set 'sources_1' fileset file properties for local files
# None

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/prj/xilinx/digi.xdc"]"
set file_added [add_files -norecurse -fileset $obj $file]
set file "$origin_dir/prj/xilinx/digi.xdc"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property "file_type" "XDC" $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]
set_property "target_constrs_file" "$origin_dir/prj/xilinx/digi.xdc" $obj

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
set files [list \
 "[file normalize "$origin_dir/src/sim/digi_bench.v"]"\
 "[file normalize "$origin_dir/src/sim/digi_bench_many.v"]"\
 "[file normalize "$origin_dir/src/sim/digi_bench_behav.wcfg"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_1' fileset file properties for remote files
# None

# Set 'sim_1' fileset file properties for local files
# None

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property "top" "digi_bench" $obj
set_property "xsim.view" "$origin_dir/src/sim/digi_bench_behav.wcfg" $obj

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
  create_run -name synth_1 -part xc7vx690tffg1761-2 -flow {Vivado Synthesis 2014} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2014" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property "needs_refresh" "1" $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
  create_run -name impl_1 -part xc7vx690tffg1761-2 -flow {Vivado Implementation 2014} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2014" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property "needs_refresh" "1" $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:project_1"
