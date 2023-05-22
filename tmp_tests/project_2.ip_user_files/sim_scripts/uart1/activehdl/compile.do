vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../project_2.gen/sources_1/ip/uart1/uart_bmpg.v" \
"../../../../project_2.gen/sources_1/ip/uart1/upg.v" \
"../../../../project_2.gen/sources_1/ip/uart1/sim/uart1.v" \


vlog -work xil_defaultlib \
"glbl.v"

