vlib work
vlib riviera

vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -sv2k12 \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../FeatherCPU.gen/sources_1/ip/uart0/uart_bmpg.v" \
"../../../../FeatherCPU.gen/sources_1/ip/uart0/upg.v" \
"../../../../FeatherCPU.gen/sources_1/ip/uart0/sim/uart0.v" \

vlog -work xil_defaultlib \
"glbl.v"

