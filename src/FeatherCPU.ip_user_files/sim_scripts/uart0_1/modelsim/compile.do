vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  \
"../../../../FeatherCPU.gen/sources_1/ip/uart0_1/uart_bmpg.v" \
"../../../../FeatherCPU.gen/sources_1/ip/uart0_1/upg.v" \
"../../../../FeatherCPU.gen/sources_1/ip/uart0_1/sim/uart0.v" \

vlog -work xil_defaultlib \
"glbl.v"

