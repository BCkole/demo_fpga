vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ipstatic" \
"../../../../../ip/clk_global/clk_global_clk_wiz.v" \
"../../../../../ip/clk_global/clk_global.v" \


vlog -work xil_defaultlib \
"glbl.v"

