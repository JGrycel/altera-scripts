transcript on

set src_dir ../../src
set sim_dir ../../sim

# Check tb name given
if {![info exists ::env(TB)]} {
  puts "Testbench name env variable TB not set"
  exit
}

# Create RTL sim library
if {[file exists rtl_work]} {
  vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

# Compile all verilog source files
set files [glob -directory $src_dir -- "*.v"]
foreach file $files {
  vlog -vlog01compat -work rtl_work $file
}

# Compile testbench file
set tb_name $env(TB)
vlog -vlog01compat -work rtl_work $sim_dir/$tb_name.v

# Run simulation
vsim rtl_work.$tb_name
log -r /*
run -all

exit