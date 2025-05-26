// módulo de control unit que implementa el main_decoder y alu_decoder

module control_unit(
    input clk,
    input zero,
    input [6:0] op,
    input [2:0] funct3,
    input funct7_5,

    output branch, jump, mem_write, alu_src, reg_write,
    output [1:0] result_src, imm_src,
    output [2:0] alu_control
);

// auxiliares
wire [1:0] alu_op;

// instacia de módulo de main decoder
main_decoder MAIN(  
    .clk(clk),
    .op(op),
    .branch(branch),
    .jump(jump),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .reg_write(reg_write),
    .result_src(result_src),
    .imm_src(imm_src),
    .alu_op(alu_op)
);

// instacia de módulo de alu decoder
alu_decoder ALU(
    .clk(clk),
    .op_5(op[5]),
    .funct3(funct3),
    .funct7_5(funct7_5),
    .alu_op(alu_op),
    .alu_control(alu_control)
);

endmodule