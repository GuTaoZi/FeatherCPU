vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu  \
"../../../../project_2.gen/sources_1/ip/uart1/uart_bmpg.v" \
"../../../../project_2.gen/sources_1/ip/uart1/upg.v" \
"../../../../project_2.gen/sources_1/ip/uart1/sim/uart1.v" \


vlog -work xil_defaultlib \
"glbl.v"

