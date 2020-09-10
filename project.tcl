# Copyright (C) 2020  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and any partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details, at
# https://fpgasoftware.intel.com/eula.

# Quartus Prime: Generate Tcl File for Project
# File: hw1.tcl
# Generated on: Thu Sep 10 01:23:34 2020

# Load Quartus Prime Tcl Project package
package require ::quartus::project
package require ::quartus::flow


# Check that arguments were provided
if {![info exists ::env(PROJECT)]} {
  puts "Project name env variable PROJECT not set"
  exit
}
if {![info exists ::env(TOP)]} {
  puts "Top level name env variable TOP not set"
  exit
}
set prj_name $env(PROJECT)
set top_name $env(TOP)


# Close the current project
if {[is_project_open]} {
	project_close
}

# Create if doesn't exist; otherwise open
if {[project_exists $prj_name]} {
	project_open -revision $top_name $prj_name
} else {
	project_new -revision $top_name $prj_name
}

# Make assignments
set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CEBA4F23C7
set_global_assignment -name ORIGINAL_QUARTUS_VERSION 20.1.0
set_global_assignment -name PROJECT_CREATION_TIME_DATE "01:23:14  SEPTEMBER 10, 2020"
set_global_assignment -name LAST_QUARTUS_VERSION "20.1.0 Lite Edition"
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
set_global_assignment -name BOARD "DE0-CV Development Board"
set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (Verilog)"
set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
set_global_assignment -name EDA_GENERATE_FUNCTIONAL_NETLIST OFF -section_id eda_board_design_timing
set_global_assignment -name EDA_GENERATE_FUNCTIONAL_NETLIST OFF -section_id eda_board_design_symbol
set_global_assignment -name EDA_GENERATE_FUNCTIONAL_NETLIST OFF -section_id eda_board_design_signal_integrity
set_global_assignment -name EDA_GENERATE_FUNCTIONAL_NETLIST OFF -section_id eda_board_design_boundary_scan

# Add Verilog source files
set src_dir ../src
set files [glob -directory $src_dir -- "*.v"]
foreach file $files {
	set_global_assignment -name VERILOG_FILE $src_dir/$file
}

# Commit assignments
export_assignments

# Compile if instructed to
if {[info exists ::env(TOP)]} {
  execute_flow -compile
}

# Close project
project_close