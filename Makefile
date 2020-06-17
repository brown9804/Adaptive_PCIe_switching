#Verilog

# Making verilog makefile
# Makefile to simulate Verilog HDL designs under OSX.
###
######## belindabrownr@gmail.com
###


# 							Makefile logic:
# To create this file you need these files:
# $ @ replace left
# $ ^ right


#******************************************************************************
#													MARKS
#******************************************************************************
# 1. For mux 2:1 ---------- mux21
# 2. For demux 1:2  10 bits ---------- demux12
# 3. For demux 1:2 8 bits ---------- demux12_8
# 4. For fifo 8x10 ---------- fifo
# 5. For fifo 6x8 ---------- fifo6x8
# 6. For memory 8x10 ---------- memory
# 7. For memory 6x8 ---------- memory6x8
# 8. For trafic class clasification ---------- class
# 9. Routing port ---------- route

all:

#******************************************************************************
#										TARGETS
#******************************************************************************
### 						YOSYS 		use $make	y<mark>
# To generate the structural design of the
# behavioral design automatically through synthesis
#It is defined as a roughly RTL (Register Transfer Level)
#synthesizer that allows you to convert the HDL (Hardware
# Description Language) code into an electronic scheme.
# Coming to show the components connected to each other what
# is usually called RTL network list which is associated with
# the level of registry transfer. Considering that what it allows
# is to model a synchronous digital circuit in terms of digital signal
# flow (this being data) relating it to the hardware registers and the
# logical operations that are carried out in each signal.


### 						SED				use $make	r<mark>
# Replaces on the synthesized file the name module,
# because for making the stuctural decription we use the
# behavioral on yosys

#### 					 IVERILOG 		use $make v<mark>
# It is defined as an HDL (Hardware Description Language),
#  this being a modeled hardware language, that is, it allows
#  describing a simulation of digital circuits. It can be seen
# as the tool that allows to provide the specifications to carry
# out a physical component which is being modeled.
# 	Example of command:
# iverilog -o ./vvp/TestBench_21_2.vvp ./TestBenchAUTONST/TestBench_21_2.v
# Its automatic, because each time you are asked for a vvp
# you need one with con.v

### 					GTKWAVE   		use $make gtkwave<mark>
# We can define it as a visualization of simulation results
# where one of its advantages is that by means of a visualization
# of signal waves we can understand the problem when it
# is found by using the testbench.

#******************************************************************************
# Modify this part with your own folders paths.

DIAGRAMS_GENERATED = ./diagrams_generated/

LIB = ./lib/

LOG_TXT = ./log_txt/

SRC = ./src/
_MUX21 = mux2x1_behav.v
_DEMUX12 = demux1x2_behav.v
_DEMUX12_8 = demux1x2_8_behav.v
_FIFO = fifo.v
_FIFO6x8 = fifo_6x8.v
_MEMORY = memory.v
_MEMORY6x8 = memory_6x8.v
_CLASS = class.v
_ROUTING= routing.v



SYN = ./syn/
_SMUX21 = mux2x1_behav_syn.v
_SDEMUX12 = demux1x2_behav_syn.v
_SDEMUX12_8 = demux1x2_8_behav_syn.v
_SFIFO = fifo_syn.v
_SFIFO6x8 = fifo_6x8_syn.v
_SMEMORY = memory_syn.v
_SMEMORY6x8 = memory_6x8_syn.v
_SCLASS = class_syn.v
_SROUTING= routing_syn.v



TESTBENCHES = ./testbenches/
_TB_MUX21 =  tb_mux21.v
_TB_DEMUX12 = tb_demux12.v
_TB_DEMUX12_8 = tb_demux12_8.v
_TB_FIFO = tb_fifo.v
_TB_FIFO6x8 = tb_fifo_6x8.v
_TB_MEMORY = tb_memory.v
_TB_MEMORY6x8 = tb_memory_6x8.v
_TB_CLASS = tb_class.v
_TB_ROUTING= tb_routing.v



TESTERS = ./testers/
_T_MUX21 = t_mux21.v
_T_DEMUX12 = t_demux12.v
_T_DEMUX12_8 = t_demux12_8.v
_T_FIFO = t_fifo.v
_T_FIFO6x8 = t_fifo_6x8.v
_T_MEMORY = t_memory.v
_T_MEMORY6x8 = t_memory_6x8.v
_T_CLASS = t_class.v
_T_ROUTING= t_routing.v




_VCD_MUX21 = mux21.vcd
_VCD_DEMUX12 = demux12.vcd
_VCD_DEMUX12_8 = demux12_8.vcd
_VCD_FIFO = fifo.vcd
_VCD_FIFO6x8 = fifo6x8.vcd
_VCD_MEMORY = memory.vcd
_VCD_MEMORY6x8 = memory6x8.vcd
_VCD_CLASS = class.vcd
_VCD_ROUTING= routing.vcd




OVVP = ./vvp/
_VVP_MUX21 = mux21.vvp
_VVP_DEMUX12 = demux12.vvp
_VVP_DEMUX12_8 = demux12_8.vvp
_VVP_FIFO = fifo.vvp
_VVP_FIFO6x8 = fifo6x8.vvp
_VVP_MEMORY = memory.vvp
_VVP_MEMORY6x8 = memory6x8.vvp
_VVP_CLASS = class.vvp
_VVP_ROUTING= routing.vvp



YOSYS = ./yosys/
_Y_MUX21 = mux21_y.ys
_Y_DEMUX12 = demux12_y.ys
_Y_DEMUX12_8 = demux12_8_y.ys
_Y_FIFO = fifo_y.ys
_Y_FIFO6x8 = fifo_6x8_y.ys
_Y_MEMORY = memory_y.ys
_Y_MEMORY6x8 = memory_6x8_y.ys
_Y_CLASS = class_y.ys
_Y_ROUTING= routing_y.ys


#******************************************************************************

# # IVERILOG
# %.vvp: %.v
# 	iverilog -o $@ $^


#******************************************************************************
#### 														MUX 		2:1
#******************************************************************************

ymux21:
	yosys $(YOSYS)$(_Y_MUX21)

rmux21:
	sed -i ' s/mux21/mux21_syn/g' $(SYN)$(_SMUX21)

vmux21:
	iverilog -o $(OVVP)$(_VVP_MUX21) $(TESTBENCHES)$(_TB_MUX21)
	vvp $(OVVP)$(_VVP_MUX21) > $(LOG_TXT)$(_VVP_MUX21)_log.txt

#target phony
.PHONY: gtkwavemux21
gtkwavemux21:
	/Applications/gtkwave.app/Contents/Resources/bin/gtkwave $(_VCD_MUX21)


#******************************************************************************
#### 									 DEMUX 				1:2				10 bits
#******************************************************************************

ydemux12:
	yosys $(YOSYS)$(_Y_DEMUX12)

rdemux12:
	sed -i 's/demux12/demux12_syn/g' $(SYN)$(_SDEMUX12)

vdemux12:
	iverilog -o $(OVVP)$(_VVP_DEMUX12) $(TESTBENCHES)$(_TB_DEMUX12)
	vvp $(OVVP)$(_VVP_DEMUX12) > $(LOG_TXT)$(_VVP_DEMUX12)_log.txt

#target phony
.PHONY: gtkwavedemux12
gtkwavedemux12:
	/Applications/gtkwave.app/Contents/Resources/bin/gtkwave $(_VCD_DEMUX12)

#******************************************************************************
#### 									 DEMUX 				1:2 				8 bits
#******************************************************************************

ydemux12_8:
	yosys $(YOSYS)$(_Y_DEMUX12_8)

rdemux12_8:
	sed -i 's/demux12_8/demux12_8_syn/g' $(SYN)$(_SDEMUX12_8)

vdemux12_8:
	iverilog -o $(OVVP)$(_VVP_DEMUX12_8) $(TESTBENCHES)$(_TB_DEMUX12_8)
	vvp $(OVVP)$(_VVP_DEMUX12_8) > $(LOG_TXT)$(_VVP_DEMUX12_8)_log.txt

#target phony
.PHONY: gtkwavedemux12_8
gtkwavedemux12_8:
	/Applications/gtkwave.app/Contents/Resources/bin/gtkwave $(_VCD_DEMUX12_8)



#******************************************************************************
#### 									 FIFO 		8x10
#******************************************************************************
yfifo:
	yosys $(YOSYS)$(_Y_FIFO)

rfifo:
	sed -i 's/fifo/fifo_syn/g; ' $(SYN)$(_SFIFO)

vfifo:
	iverilog -o $(OVVP)$(_VVP_FIFO) $(TESTBENCHES)$(_TB_FIFO)
	vvp $(OVVP)$(_VVP_FIFO) > $(LOG_TXT)$(_VVP_FIFO)_log.txt

#target phony
.PHONY: gtkwavefifo
gtkwavefifo:
	/Applications/gtkwave.app/Contents/Resources/bin/gtkwave $(_VCD_FIFO)

#******************************************************************************
#### 									 FIFO 		6x8
#******************************************************************************
yfifo6x8:
	yosys $(YOSYS)$(_Y_FIFO)

rfifo6x8:
	sed -i 's/fifo_6x8/fifo_6x8_syn/g; s/memory_6x8/memory_6x8_syn/g' $(SYN)$(_SFIFO)

vfifo6x8:
	iverilog -o $(OVVP)$(_VVP_FIFO6x8) $(TESTBENCHES)$(_TB_FIFO6x8)
	vvp $(OVVP)$(_VVP_FIFO6x8) > $(LOG_TXT)$(_VVP_FIFO6x8)_log.txt

#target phony
.PHONY: gtkwavefifo6x8
gtkwavefifo6x8:
	/Applications/gtkwave.app/Contents/Resources/bin/gtkwave $(_VCD_FIFO6x8)


#******************************************************************************
#### 									 MEMORY 8x10
#******************************************************************************
ymemory:
	yosys $(YOSYS)$(_Y_MEMORY)

rmemory:
	sed -i 's/memory/memory_syn/g' $(SYN)$(_SMEMORY)

vmemory:
	iverilog -o $(OVVP)$(_VVP_MEMORY) $(TESTBENCHES)$(_TB_MEMORY)
	vvp $(OVVP)$(_VVP_MEMORY) > $(LOG_TXT)$(_VVP_MEMORY)_log.txt

#target phony
.PHONY: gtkwavememory
gtkwavememory:
	/Applications/gtkwave.app/Contents/Resources/bin/gtkwave $(_VCD_MEMORY)

#******************************************************************************
#### 									 MEMORY 6x8
#******************************************************************************
ymemory6x8:
	yosys $(YOSYS)$(_Y_MEMORY6x8)

rmemory6x8:
	sed -i 's/memory6x8/memory6x8_syn/g' $(SYN)$(_SMEMORY6x8)

vmemory6x8:
	iverilog -o $(OVVP)$(_VVP_MEMORY6x8) $(TESTBENCHES)$(_TB_MEMORY6x8)
	vvp $(OVVP)$(_VVP_MEMORY6x8) > $(LOG_TXT)$(_VVP_MEMORY6x8)_log.txt

#target phony
.PHONY: gtkwavememory6x8
gtkwavememory6x8:
	/Applications/gtkwave.app/Contents/Resources/bin/gtkwave $(_VCD_MEMORY6x8)

#******************************************************************************
#### 									 CLASS
#******************************************************************************
yclass:
	yosys $(YOSYS)$(_Y_CLASS)

rclass:
	sed -i 's/class/class_syn/g; s/fifo/fifo_syn/g; s/demux12/demux12_syn/g; s/memory/memory_syn/g' $(SYN)$(_SCLASS)

vclass:
	iverilog -o $(OVVP)$(_VVP_CLASS) $(TESTBENCHES)$(_TB_CLASS)
	vvp $(OVVP)$(_VVP_CLASS) > $(LOG_TXT)$(_VVP_CLASS)_log.txt

#target phony
.PHONY: gtkwaveclass
gtkwaveclass:
	/Applications/gtkwave.app/Contents/Resources/bin/gtkwave $(_VCD_CLASS)

#******************************************************************************
#### 									 ROUTING
#******************************************************************************
yroute:
	yosys $(YOSYS)$(_Y_ROUTING)

rroute:
	sed -i 's/route/route_syn/g; s/fifo_6x8/fifo_6x8_syn/g; s/demux12_8/demux12_8_syn/g; s/mux21/mux21_syn/g; s/memory_6x8/memory_6x8_syn/g' $(SYN)$(_SROUTING)

vroute:
	iverilog -o $(OVVP)$(_VVP_ROUTING) $(TESTBENCHES)$(_TB_ROUTING)
	vvp $(OVVP)$(_VVP_ROUTING) > $(LOG_TXT)$(_VVP_ROUTING)_log.txt

#target phony
.PHONY: gtkwaveroute
gtkwaveroute:
	/Applications/gtkwave.app/Contents/Resources/bin/gtkwave $(_VCD_ROUTING)




#******************************************************************************
############ CLEAN FOR ALL
#******************************************************************************


.PHONY: clean
clean:
	rm -rf $(OVVP)*.vvp *.vcd $(LOG_TXT)*_log.txt $(SYN)*syn.v $(DIAGRAMS_GENERATED)*.dot $(DIAGRAMS_GENERATED)*.ps
