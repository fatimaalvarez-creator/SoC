module single_cycle_RISCV(
    input clk
);

// ----- ADDERS -----
// registros auxiliares para los adders
wire [31:0] PC_target;
wire [31:0] PC_plus_4;
reg [31:0] PC;
wire [31:0] imm_ext;
// declaración de los adders
assign PC_target = PC + imm_ext;
assign PC_plus_4 = PC + 4;

// ----- MULTIPLEXOR 1 -----
// registro auxiliar para el multiplexor 1
wire [1:0] PC_src;
wire [31:0] PC_next = PC_src[0] ? PC_target : PC_plus_4;


// ----- Inicialización del PC -----
always @(posedge clk)
    PC <= PC_next; 


// ----- INSTRUCTION MEMORY -----
// registros auxiliares del instruction memory
wire [31:0] instruction;
// instanciación de la instruction memory
instruction_memory IM(
    .pc(PC),
    .instruction(instruction)
);


// ----- REGISTER FILE -----
// registros axiliares del register file
wire [31:0] result;    
wire [31:0] reg_write;    
wire [31:0] src_A;
wire [31:0] RD2;
// instanciación del register file
register_file RF(
    .clk(clk),
    .A1(instruction[19:15]),
    .A2(instruction[24:20]),
    .A3(instruction[11:7]),
    .WD3(result),
    .WE3(reg_write),
    .RD1(src_A),
    .RD2(RD2)
);

// ----- MULTIPLEXOR 2 -----
// registros axiliar para el multiplexor 2
wire alu_src;
wire [31:0] ALU_src_B = alu_src ? imm_ext : RD2;
// ----- EXTEND -----
// instanciación del extend
extend EXT(
    .extend_in(instruction[31:7]),
    .imm_src(imm_src),
    .imm_ext(imm_ext)
);


// ----- ALU -----
// registros axiliares para la ALU
wire [2:0] alu_control;
wire [31:0] alu_result;
wire zero;
// instanciación de la ALU
alu ALU(
    .src_A(src_A),
    .src_B(ALU_src_B),
    .alu_control(alu_control),
    .alu_result(alu_result),
    .zero(zero)
);


// ----- DATA MEMORY -----
// registros axiliares de la data memory
wire mem_write;
wire [31:0] read_data;

// instanciación de la data memory
data_memory DM(
    .clk(clk),
    .address(alu_result),
    .WD(RD2),
    .WE(mem_write),
    .RD(read_data)
);

// ----- MULTIPLEXOR 3 -----
// registros axiliares del multiplexor 3
wire [1:0] result_src;
// instanciación del multiplexor 3
assign result = result_src[1] ? read_data : alu_result;

// ----- CONTROL UNIT  -----
// registros axiliares del control unit
wire branch;
wire jump;
//wire [1:0] imm_src;
// instanciación del control unit
control_unit CU(
    .clk(clk),
    .zero(zero),
    .op(instruction[6:0]),
    .funct3(instruction[14:12]),
    .funct7_5(instruction[30]),
    .branch(branch),
    .jump(jump),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .reg_write(reg_write),
    .result_src(result_src),
    .imm_src(imm_src),
    .alu_control(alu_control)
);

// asignacion para el PC_src
assign PC_src = {jump, branch & zero}; // PC_src[1]=jump, PC_src[0]=branch & zero


// ----- MAIN DECODER -----
// registros axiliares del main decoder
wire [6:0] op = instruction[6:0];
wire alu_op;

// instanciación del main decoder
main_decoder MD(
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

endmodule