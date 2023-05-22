vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  \
"../../../../FeatherCPU.gen/sources_1/ip/uart0/uart_bmpg.v" \
"../../../../FeatherCPU.gen/sources_1/ip/uart0/upg.v" \
"../../../../FeatherCPU.gen/sources_1/ip/uart0/sim/uart0.v" \

vlog -work xil_defaultlib \
"glbl.v"

