onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+ins_mem  -L xpm -L blk_mem_gen_v8_4_5 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ins_mem xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {ins_mem.udo}

run 1000ns

endsim

quit -force
