vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv "+incdir+../../../ipstatic" \
"E:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"E:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"E:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../ipstatic" \
"../../../../FeatherCPU.gen/sources_1/ip/upg_clk_wiz/upg_clk_wiz_clk_wiz.v" \
"../../../../FeatherCPU.gen/sources_1/ip/upg_clk_wiz/upg_clk_wiz.v" \

vlog -work xil_defaultlib \
"glbl.v"

