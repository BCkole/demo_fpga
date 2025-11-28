############## clock define##################
create_clock -period 5.000 [get_ports sys_clk_p]
set_property PACKAGE_PIN AK17 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports sys_clk_p]

##############uart define###########################
set_property IOSTANDARD LVCMOS18 [get_ports uart_rxd]
set_property PACKAGE_PIN AJ11 [get_ports uart_rxd]

set_property IOSTANDARD LVCMOS18 [get_ports uart_txd]
set_property PACKAGE_PIN AM9 [get_ports uart_txd]
