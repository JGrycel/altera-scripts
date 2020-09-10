transcript on

set syn_dir ../../quartus/simulation/modelsim
set sim_dir ../../sim

# Check tb name given
if {![info exists ::env(TB)]} {
  puts "Testbench name env variable TB not set"
  exit
}

# Create synthesis sim library
if {[file exists syn_work]} {
  vdel -lib syn_work -all
}
vlib syn_work
vmap work syn_work

# Compile verilog output file
set files [glob -directory $syn_dir -- "*.vo"]
foreach file $files {
  vlog -vlog01compat -work syn_work $file
}

# Compile testbench file
set tb_name $env(TB)
vlog -vlog01compat -work syn_work $sim_dir/$tb_name.v

# Run simulation
vsim -L altera_ver -L cyclonev_ver syn_work.$tb_name
log -r /*
run -all

exit