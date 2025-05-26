// módulo de alu decoder

module alu_decoder(
	input clk,
	input op_5,
	input [2:0] funct3,
	input funct7_5, 
	input [1:0] alu_op,
	output reg [2:0] alu_control
);

always @(posedge clk)
	begin
		case(alu_op)
			// caso ALUop = 00, lw, sw
			2'b00:
				begin
					alu_control = 3'b000;
				end
				
			// caso ALUop = 01, beq
			2'b01:
				begin
					alu_control = 3'b001;
				end
				
			// caso ALUop = 10, R-type
			2'b10:
				begin
					case(funct3)
						// caso funct3 = 000
						3'b000:
							begin
								// caso op_5, funct7_5 = 11, sub 	
								if({op_5, funct7_5} == 2'b11)
									alu_control = 3'b001;
								// caso op_5, funct7_5 = 00, 01, 10, add
								else
									alu_control = 3'b000;	
							end
						
						// caso funct3 = 010, slt
						3'b010:
							begin
								alu_control = 3'b101;
							end
				
						// caso funct3 = 110, or
						3'b110:
							begin
								alu_control = 3'b011;
							end
						
						// caso funct3 = 111, and
						3'b111:
							begin
								alu_control = 3'b010;
							end

						// caso funct3 = 100, multiplexor
						3'b111:
							begin
								alu_control = 3'b110;
							end	
							
						default: 
							alu_control = 3'bXXX;	
					
					endcase
					
				end
					
				default: 
					alu_control = 3'bXXX;
				
		endcase
		
	end

endmodule