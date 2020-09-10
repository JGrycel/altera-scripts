# !!REMOVE ME AFTER UPDATING INSTALL VARIABLE!! #
## BEGIN ##
$(error INSTALL variable not set)
## END ##

INSTALL = REPLACE_ME

QUARTUS = $(INSTALL)/quartus/bin/quartus_sh
MODELSIM = $(INSTALL)/modelsim_ase/linux/vsim

# Must define project
ifndef PROJECT
$(error PROJECT is not set)
endif

# Default TOP is <PROJECT>_top
ifndef TOP
	TOP = "$(PROJECT)_top"
endif

# Default TB is <PROJECT>_top_tb
ifndef TB
	TB = "$(PROJECT)_top_tb"
endif

# Export variables for tools
export PROJECT
export TOP
export TB


default:
	echo "Provide a target"

# Create directories for new project
dir:
	if [ ! -d ../$(PROJECT) ]; then \
		mkdir ../$(PROJECT); \
		mkdir ../$(PROJECT)/modelsim; \
		mkdir ../$(PROJECT)/modelsim/rtl; \
		mkdir ../$(PROJECT)/modelsim/syn; \
		mkdir ../$(PROJECT)/quartus; \
		mkdir ../$(PROJECT)/sim; \
		mkdir ../$(PROJECT)/src; \
	else echo "Directories already setup"; \
	fi

# Create or update project
project:
	if [ -d "../$(PROJECT)" ]; then \
		cd ../$(PROJECT)/quartus; \
		$(QUARTUS) --script=../../altera-scripts/project.tcl; \
	else echo "Directories not set up"; \
	fi

# Compile RTL project
build:
	if [ ! -d ../$(PROJECT) ]; then \
		echo "Directories not set up"; \
	elif [ ! -f ../$(PROJECT)/quartus/$(PROJECT).qpf ]; then \
		echo "Project does not exist"; \
	else \
		export BUILD=1; \
		cd ../$(PROJECT)/quartus; \
		$(QUARTUS) --script=../../altera-scripts/project.tcl; \
	fi

# Behavioral simulation
rtl_sim:
	cd ../$(PROJECT)/modelsim/rtl; \
	$(MODELSIM) -c -do ../../../altera-scripts/rtl_sim.do

# Post-synthesis simulation
syn_sim:
	cd ../$(PROJECT)/modelsim/syn; \
	$(MODELSIM) -c -do ../../../altera-scripts/syn_sim.do

# View behavioral waveform
simview_rtl:
	cd ../$(PROJECT)/modelsim/rtl; \
	$(MODELSIM) -view vsim.wlf

# View post-synthesis waveform
simview_syn:
	cd ../$(PROJECT)/modelsim/syn; \
	$(MODELSIM) -view vsim.wlf