onerror {quit -f}
vlib work
vlog -work work clock_div.vo
vlog -work work clock_div.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.clock_div_vlg_vec_tst
vcd file -direction clock_div.msim.vcd
vcd add -internal clock_div_vlg_vec_tst/*
vcd add -internal clock_div_vlg_vec_tst/i1/*
add wave /*
run -all
