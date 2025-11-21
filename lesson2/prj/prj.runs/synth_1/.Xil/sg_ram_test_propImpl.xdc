set_property SRC_FILE_INFO {cfile:d:/Users/Administrator/Desktop/FILE/lesson/Num0/lesson16/ip/clk_global/clk_global.xdc rfile:../../../../ip/clk_global/clk_global.xdc id:1 order:EARLY scoped_inst:u1_clk_global/inst} [current_design]
set_property SRC_FILE_INFO {cfile:D:/Users/Administrator/Desktop/FILE/lesson/Num0/lesson16/xdc/xdc.xdc rfile:../../../../xdc/xdc.xdc id:2} [current_design]
current_instance u1_clk_global/inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.2
current_instance
set_property src_info {type:XDC file:2 line:2 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AC28 [get_ports sys_clk]
