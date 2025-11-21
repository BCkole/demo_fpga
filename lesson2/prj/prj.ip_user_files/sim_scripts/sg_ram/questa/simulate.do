onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib sg_ram_opt

do {wave.do}

view wave
view structure
view signals

do {sg_ram.udo}

run -all

quit -force
