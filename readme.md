# Altera FPGA Scripts
## Jacob T. Grycel

This repo contains a suite of scripts for working with Altera FPGA
projects. The main makefile supports setting up a new workspace, creating a
Quartus Prime project, design compilation, and running/viewing
pre/post-synthesis Modelsim simulations.

### Notes
- You must fill in the location of your altera install in the `INSTALL` variable. This should point to `/some/path/intelFPGA_lite/20.1`. Manually remove the automatic error message code after filling in the `INSTALL` variable.  
- All HDL source files must be placed in the `src` folder of generated workspaces
- All testbench fiels must be placed in the `sim` folder of generated workspaces
- Testbenches should have a `$stop` command in them so that simulation ends.  
- Testbenches should have \``timescale 1ps/1ps` to be compatible with quartus post-synthesis simulations.


### Variable Requirements
- `PROJECT` needed for all targets  
- `TOP` needed for `project` target  
- `TB` needed for `rtl_sim`,`syn_sim` targets


### Usage

When inside this repo in a command line, use the following targets:

`make dir PROJECT=name`  
- Creates a workspace structure alongside `altera_scripts`. Replace the 'name'  

`make project PROJECT=name TOP=topname`  
- Creates a Quartus project in the workspace `quartus` folder  
- Use `TOP` to specify the top level module name. Default is <project_name>_top  
- If another time after creating the project, this will update all synthesis file

`make build PROJECT=name`  
- Runs synthesis on the design

`make rtl_sim PROJECT=name TB=tbname`  
- Runs simulation on RTL description  
- Use `TB` to specify the testbench name. Default is <project_name>_top_tb


`make syn_sim PROJECT=name TB=tbname`  
- Same functionality as `rtl_sim`, but for post-synthesis sim

`make simview_rtl PROJECT=name`  
- Opens waveform and simulation data from previous RTL simulation

`make simview_syn PROJECT=name`
- Same funcionality as `simview_rtl`, but for post-synthesis sim