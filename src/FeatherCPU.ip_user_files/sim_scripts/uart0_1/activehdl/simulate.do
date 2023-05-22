onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+uart0  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.uart0 xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {uart0.udo}

run 1000ns

endsim

quit -force
