module single_cycle_RISCV #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)(
    input clk,
    input rst
);

    // ==================== REGISTROS Y WIRES ====================
    reg [DATA_WIDTH-1:0] PC;
    wire [DATA_WIDTH-1:0] PC_plus_4, PC_target, PC_next;
    wire [DATA_WIDTH-1:0] instruction;
    wire [DATA_WIDTH-1:0] imm_ext;
    wire [DATA_WIDTH-1:0] src_A, RD2, ALU_src_B;
    wire [DATA_WIDTH-1:0] alu_result;
    wire [DATA_WIDTH-1:0] read_data, result;

    wire [1:0] result_src;
    wire [1:0] imm_src;
    wire [2:0] alu_control;
    wire zero; // Señal 'zero' de la ALU
    wire mem_write, alu_src, reg_write;

    // AHORA USAMOS PC_src directamente desde la unidad de control
    wire PC_src; 

    // ==================== PC LOGIC ====================
    assign PC_plus_4 = PC + 4;
    assign PC_target = PC + imm_ext; // Asumiendo que imm_ext ya maneja el offset correcto para branch/jump

    // La lógica para determinar el siguiente PC se simplifica usando PC_src
    assign PC_next = PC_src ? PC_target : PC_plus_4;


    // ==================== PROGRAM COUNTER ====================
    always @(posedge clk or posedge rst) begin
        if (rst)
            PC <= 0;
        else
            PC <= PC_next;
    end

    // ==================== INSTRUCTION MEMORY ====================
    // Nota: El módulo instruction_memory debe existir y tener las entradas/salidas correctas.
    instruction_memory IM (
        .pc_address(PC),
        .instruction(instruction)
    );

    // ==================== REGISTER FILE ====================
    // Nota: El módulo register_file debe existir y tener las entradas/salidas correctas.
    register_file RF (
        .clk(clk),
        .A1(instruction[19:15]), // rs1
        .A2(instruction[24:20]), // rs2
        .A3(instruction[11:7]),  // rd
        .WD3(result),
        .WE3(reg_write),
        .RD1(src_A),
        .RD2(RD2)
    );

    // ==================== EXTENDER DE INMEDIATOS ====================
    // Nota: El módulo extend debe existir y tener las entradas/salidas correctas.
    extend EXT (
        .extend_in(instruction[31:7]),
        .imm_src(imm_src),
        .imm_ext(imm_ext)
    );

    // ==================== ALU ====================
    assign ALU_src_B = alu_src ? imm_ext : RD2;

    // Nota: El módulo alu debe existir y tener las entradas/salidas correctas.
    alu ALU (
        .src_A(src_A),
        .src_B(ALU_src_B),
        .alu_control(alu_control),
        .alu_result(alu_result),
        .zero(zero)
    );

    // ==================== DATA MEMORY ====================
    // Nota: El módulo data_memory debe existir y tener las entradas/salidas correctas.
    data_memory DM (
        .clk(clk),
        .address(alu_result), // La dirección de memoria es el resultado de la ALU
        .WD(RD2),             // Datos a escribir (del segundo registro leído)
        .WE(mem_write),
        .RD(read_data)
    );

    // ==================== MUX RESULTADOS ====================
    // Determina qué valor se escribirá de vuelta en el banco de registros
    assign result = (result_src == 2'b00) ? alu_result :    // Desde la ALU
                    (result_src == 2'b01) ? read_data :     // Desde la memoria de datos
                    (result_src == 2'b10) ? PC_plus_4 :     // Para instrucciones JAL/JALR (dirección de retorno)
                    32'b0; // Valor por defecto, debería ser inalcanzable con la lógica correcta

    // ==================== UNIDAD DE CONTROL ====================
    // Conectamos la salida PC_src de tu control_unit
    control_unit CU (
        .clk(clk),
        .zero(zero),
        .op(instruction[6:0]),   // Opcode
        .funct3(instruction[14:12]), // Funct3
        .funct7_5(instruction[30]), // Bit 30 para diferenciar ciertas instrucciones
        .op_5(instruction[5]),   // op_5 para el alu_decoder, asumiendo instruction[5]
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .result_src(result_src),
        .imm_src(imm_src),
        .alu_control(alu_control),
        .PC_src(PC_src)      // AHORA CONECTADO
    );

endmodule