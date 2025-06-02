onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider TB
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/clk
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/rst
add wave -noupdate -divider PC
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/PC_plus_4
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/PC
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/PC_next
add wave -noupdate -divider {INSTRUCTION MEMORY}
add wave -noupdate -radix hexadecimal /single_cycle_RISCV_tb/top/instruction
add wave -noupdate -divider {REGISTER FILE}
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/result
add wave -noupdate -divider EXTENDER
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/imm_src
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/imm_ext
add wave -noupdate -divider ALU
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/src_A
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/ALU_src_B
add wave -noupdate -divider {DATA MEMORY}
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/read_data
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/RD2
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/alu_result
add wave -noupdate -divider {CONTROL UNIT}
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/zero
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/result_src
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/reg_write
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/PC_src
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/mem_write
add wave -noupdate -radix hexadecimal /single_cycle_RISCV_tb/top/instruction
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/imm_src
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/alu_src
add wave -noupdate -radix unsigned /single_cycle_RISCV_tb/top/alu_control
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {46038 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 328
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {112640 ps}
