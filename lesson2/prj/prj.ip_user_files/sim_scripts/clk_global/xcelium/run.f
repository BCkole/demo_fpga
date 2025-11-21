-makelib xcelium_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../../ip/clk_global/clk_global_clk_wiz.v" \
  "../../../../../ip/clk_global/clk_global.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

