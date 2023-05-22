-makelib xcelium_lib/xpm -sv \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../FeatherCPU.gen/sources_1/ip/uart0/uart_bmpg.v" \
  "../../../../FeatherCPU.gen/sources_1/ip/uart0/upg.v" \
  "../../../../FeatherCPU.gen/sources_1/ip/uart0/sim/uart0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

