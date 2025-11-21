onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ram_next_opt

do {wave.do}

view wave
view structure
view signals

do {ram_next.udo}

run -all

quit -force
