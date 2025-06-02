transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/alvar/Documents/quartus/SoC/Singlecycle {C:/Users/alvar/Documents/quartus/SoC/Singlecycle/single_cycle_RISCV.v}
vlog -vlog01compat -work work +incdir+C:/Users/alvar/Documents/quartus/SoC/Singlecycle {C:/Users/alvar/Documents/quartus/SoC/Singlecycle/control_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/alvar/Documents/quartus/SoC/Singlecycle {C:/Users/alvar/Documents/quartus/SoC/Singlecycle/register_file.v}
vlog -vlog01compat -work work +incdir+C:/Users/alvar/Documents/quartus/SoC/Singlecycle {C:/Users/alvar/Documents/quartus/SoC/Singlecycle/extend.v}
vlog -vlog01compat -work work +incdir+C:/Users/alvar/Documents/quartus/SoC/Singlecycle {C:/Users/alvar/Documents/quartus/SoC/Singlecycle/data_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/alvar/Documents/quartus/SoC/Singlecycle {C:/Users/alvar/Documents/quartus/SoC/Singlecycle/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/alvar/Documents/quartus/SoC/Singlecycle {C:/Users/alvar/Documents/quartus/SoC/Singlecycle/main_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/alvar/Documents/quartus/SoC/Singlecycle {C:/Users/alvar/Documents/quartus/SoC/Singlecycle/alu_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/alvar/Documents/quartus/SoC/Singlecycle {C:/Users/alvar/Documents/quartus/SoC/Singlecycle/instruction_memory.v}

vlog -vlog01compat -work work +incdir+C:/Users/alvar/Documents/quartus/SoC/Singlecycle {C:/Users/alvar/Documents/quartus/SoC/Singlecycle/single_cycle_RISCV_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  single_cycle_RISCV_tb

add wave *
view structure
view signals
run -all
