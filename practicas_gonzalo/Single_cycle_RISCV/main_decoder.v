// módulo del main_decoder 

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

// casos para los tipos de opcode que tiene cada instrucción
always @(posedge clk)
	begin
		case(op)
			// type I -> lw
			7'b0000011:
				begin 
					reg_write = 1'b1;
					imm_src = 2'b00;
					alu_src = 1'b1;
					mem_write = 1'b0;
					result_src = 2'b01;
					branch = 1'b0;
					alu_op = 2'b00;
					jump = 1'b0;
				end
			
			// type S -> sw
			7'b0100011:
				begin
					reg_write = 1'b0;
					imm_src = 2'b01;
					alu_src = 1'b1;
					mem_write = 1'b0;
					result_src = 2'bXX;
					branch = 1'b0;
					alu_op = 2'b00;
					jump = 1'b0;
				end
			
			// type R 
			 7'b0110011:
				begin
					reg_write = 1'b1;
					imm_src = 2'bXX;
					alu_src = 1'b0;
					mem_write = 1'b0;
					result_src = 2'b00;
					branch = 1'b0;
					alu_op = 2'b10;
					jump = 1'b0;
				end
				
			// type B -> beq
			7'b1100011:
				begin
					reg_write = 1'b0;
					imm_src = 2'b10;
					alu_src = 1'b0;
					mem_write = 1'b0;
					result_src = 2'bXX;
					branch = 1'b1;
					alu_op = 2'b01;
					jump = 1'b0;
				end
				
			// type I 
			7'b0010011:
				begin
					reg_write = 1'b0;
					imm_src = 2'b10;
					alu_src = 1'b0;
					mem_write = 1'b0;
					result_src = 2'bXX;
					branch = 1'b1;
					alu_op = 2'b01;
					jump = 1'b0;
				end
				
			// type J -> jal
			7'b1101111:
				begin
					reg_write = 1'b1;
					imm_src = 2'b11;
					alu_src = 1'bX;
					mem_write = 1'b0;
					result_src = 2'b10;
					branch = 1'b0;
					alu_op = 2'bXX;
					jump = 1'b1;
				end	
			
			// caso de default
			default:
                begin
                    reg_write = 1'b0;
                    imm_src = 2'b00;
                    alu_src = 1'b0;
                    mem_write = 1'b0;
                    result_src = 2'b00;
                    branch = 1'b0;
                    alu_op = 2'b00;
                    jump = 1'b0;
                end
			
		endcase
	end
endmodule