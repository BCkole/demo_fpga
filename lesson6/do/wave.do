onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -label sim:/tb/Group1 -group {Region: sim:/tb} -radix unsigned /tb/clk
add wave -noupdate -expand -label sim:/tb/Group1 -group {Region: sim:/tb} -radix unsigned /tb/rst_n
add wave -noupdate -expand -label sim:/tb/Group1 -group {Region: sim:/tb} -radix unsigned /tb/outfile
add wave -noupdate -expand -label sim:/tb/Group1 -group {Region: sim:/tb} -radix unsigned /tb/vs
add wave -noupdate -expand -label sim:/tb/Group1 -group {Region: sim:/tb} -radix unsigned /tb/de
add wave -noupdate -expand -label sim:/tb/Group1 -group {Region: sim:/tb} -radix hexadecimal /tb/data
add wave -noupdate -expand -label sim:/tb/Group1 -group {Region: sim:/tb} -radix unsigned /tb/vs_r
add wave -noupdate -expand -label sim:/glbl/Group1 -group {Region: sim:/glbl} -radix unsigned /glbl/GSR
add wave -noupdate -expand -label sim:/tb/u1_img_gen/Group1 -group {Region: sim:/tb/u1_img_gen} -radix unsigned /tb/u1_img_gen/clk
add wave -noupdate -expand -label sim:/tb/u1_img_gen/Group1 -group {Region: sim:/tb/u1_img_gen} -radix unsigned /tb/u1_img_gen/rst_n
add wave -noupdate -expand -label sim:/tb/u1_img_gen/Group1 -group {Region: sim:/tb/u1_img_gen} -radix unsigned /tb/u1_img_gen/vs
add wave -noupdate -expand -label sim:/tb/u1_img_gen/Group1 -group {Region: sim:/tb/u1_img_gen} -radix unsigned /tb/u1_img_gen/de
add wave -noupdate -expand -label sim:/tb/u1_img_gen/Group1 -group {Region: sim:/tb/u1_img_gen} -radix hexadecimal /tb/u1_img_gen/data
add wave -noupdate -expand -label sim:/tb/u1_img_gen/Group1 -group {Region: sim:/tb/u1_img_gen} -radix unsigned /tb/u1_img_gen/i
add wave -noupdate -expand -label sim:/tb/u1_img_gen/Group1 -group {Region: sim:/tb/u1_img_gen} -radix unsigned /tb/u1_img_gen/hcnt
add wave -noupdate -expand -label sim:/tb/u1_img_gen/Group1 -group {Region: sim:/tb/u1_img_gen} -radix unsigned /tb/u1_img_gen/vcnt
add wave -noupdate -expand -label sim:/tb/u1_img_gen/Group1 -group {Region: sim:/tb/u1_img_gen} -radix unsigned /tb/u1_img_gen/h_de
add wave -noupdate -expand -label sim:/tb/u1_img_gen/Group1 -group {Region: sim:/tb/u1_img_gen} -radix unsigned /tb/u1_img_gen/v_de
add wave -noupdate -expand -label sim:/tb/u1_img_gen/Group1 -group {Region: sim:/tb/u1_img_gen} -radix unsigned /tb/u1_img_gen/index_de
add wave -noupdate -expand -label sim:/tb/u1_img_gen/Group1 -group {Region: sim:/tb/u1_img_gen} -radix unsigned /tb/u1_img_gen/index
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {4200017446 ps} {4200035924 ps}
