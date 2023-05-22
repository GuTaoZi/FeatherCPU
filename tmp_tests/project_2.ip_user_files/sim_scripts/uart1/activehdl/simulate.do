onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+uart1  -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.uart1 xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {uart1.udo}

run 1000ns

endsim

quit -force
