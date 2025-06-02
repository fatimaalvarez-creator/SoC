module main_decoder(
	input clk,
	input [6:0] op,
	output reg branch,
				jump,
				mem_write,
				alu_src,
				reg_write,
	output reg [1:0] result_src,
						imm_src,
						alu_op
);

// Decodificación sincronizada por flanco de subida de reloj
always @(posedge clk) begin
	// Valores por defecto (NOP / seguro)
    reg_write   = 0;
    imm_src     = 2'b00;
    alu_src     = 0;
    mem_write   = 0;
    result_src  = 2'b00;
    branch      = 0;
    alu_op      = 2'b00;
    jump        = 0;

	case(op)
		// type I -> lw
		7'b0000011: begin
			reg_write   = 1;
			imm_src     = 2'b00; // I-type
			alu_src     = 1;
			mem_write   = 0;
			result_src  = 2'b01; // de memoria
			branch      = 0;
			alu_op      = 2'b00; // suma
			jump        = 0;
		end

		// type S -> sw
		7'b0100011: begin
			reg_write   = 0;
			imm_src     = 2'b01; // S-type
			alu_src     = 1;
			mem_write   = 1; 
			result_src  = 2'b00; // no se usa, pero se asigna un valor válido
			branch      = 0;
			alu_op      = 2'b00; // suma
			jump        = 0;
		end

		// type R -> operaciones aritméticas
		7'b0110011: begin
			reg_write   = 1;
			imm_src     = 2'b00; // no se usa, pero se asigna algo válido
			alu_src     = 0;
			mem_write   = 0;
			result_src  = 2'b00; // resultado ALU
			branch      = 0;
			alu_op      = 2'b10; // se define por funct3/funct7
			jump        = 0;
		end

		// type B -> beq
		7'b1100011: begin
			reg_write   = 0;
			imm_src     = 2'b10; // B-type
			alu_src     = 0;
			mem_write   = 0;
			result_src  = 2'b00; // no se usa
			branch      = 1;
			alu_op      = 2'b01; // resta
			jump        = 0;
		end

		// type I -> addi, etc.
		7'b0010011: begin
			reg_write   = 1;
			imm_src     = 2'b00; // I-type
			alu_src     = 1;
			mem_write   = 0;
			result_src  = 2'b00; // resultado ALU
			branch      = 0;
			alu_op      = 2'b10; // depende de funct
			jump        = 0;
		end

		// type J -> jal
		7'b1101111: begin
			reg_write   = 1;
			imm_src     = 2'b11; // J-type
			alu_src     = 0;      // no se usa, pero se asigna algo válido
			mem_write   = 0;
			result_src  = 2'b10; // PC + 4
			branch      = 0;
			alu_op      = 2'b00; // no se usa
			jump        = 1;
		end

		// default 
		default: begin
			reg_write   = 0;
			imm_src     = 2'b00;
			alu_src     = 0;
			mem_write   = 0;
			result_src  = 2'b00;
			branch      = 0;
			alu_op      = 2'b00;
			jump        = 0;
		end
	endcase
end

endmodule
