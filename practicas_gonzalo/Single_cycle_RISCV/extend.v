module extend(
    input [31:7] extend_in, // instrucción que proviene del op, funct3, funct7_5
    input [1:0] imm_src, // fuente de inmediato
    output reg [31:0] imm_ext // inmediato extendido
);

    // registro auxiliar
    reg [11:0] aux_extend;


    // se utiliza un bloque para la lógica combinacional
    always @(*) 
        begin
            case (imm_src)
                // I-type -> lw, addi, slti, sltiu, xori, ori, andi
                0: 
                    imm_ext = extend_in[31:20];
                // S-type -> sw
                1: 
                    imm_ext = {extend_in[31:25], extend_in[11:7]};
                // B-type -> beq, bne, blt, bge, bltu, bgeu
                2: 
                    imm_ext = {extend_in[31], extend_in[7], extend_in[30:25], extend_in[11:8]}; 
                // J-type -> jal, jalr
                3: 
                    imm_ext = {extend_in[31], extend_in[19:12], extend_in[20], extend_in[30:21]};
            endcase

        // extendemos el inmediato a 32 bits
            imm_ext = {{20{aux_extend[11]}}, aux_extend}; 
            // 20 bits de sign, 12 bits de dato

        // para el caso J-type
            if (imm_src == 3)
                imm_ext = {{11{extend_in[31]}}, extend_in[31], extend_in[19:12], extend_in[20], extend_in[30:21]};
            else 
                 imm_ext = {{20{aux_extend[11]}}, aux_extend}; 
                 
        end

endmodule