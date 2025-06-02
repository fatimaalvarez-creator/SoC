module control_unit (
    input  wire        clk,
    input  wire [6:0]  op,
    input  wire [2:0]  funct3,
    input  wire        funct7_5,
    input  wire        op_5,
    input  wire        zero,

    output wire        mem_write,
    output wire        alu_src,
    output wire        reg_write,
    output wire [1:0]  result_src,
    output wire [1:0]  imm_src,
    output wire [2:0]  alu_control,
    output wire        PC_src
);

	// auxiliares
    wire        branch, jump;
    wire [1:0]  alu_op;

    // Instancia del decodificador principal
    main_decoder MD (
        .clk        (clk),
        .op         (op),
        .branch     (branch),
        .jump       (jump),
        .mem_write  (mem_write),
        .alu_src    (alu_src),
        .reg_write  (reg_write),
        .result_src (result_src),
        .imm_src    (imm_src),
        .alu_op     (alu_op)
    );

    // Instancia del decodificador de la ALU
    alu_decoder AD (
        .clk         (clk),
        .op_5        (op_5),
        .funct3      (funct3),
        .funct7_5    (funct7_5),
        .alu_op      (alu_op),
        .alu_control (alu_control)
    );

    // Selección del PC (si branch tomado o salto)
    assign PC_src = (branch && zero) || jump;

endmodule