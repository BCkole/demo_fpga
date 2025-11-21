-makelib ies_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../../ip/clk_vga/clk_vga_clk_wiz.v" \
  "../../../../../ip/clk_vga/clk_vga.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

