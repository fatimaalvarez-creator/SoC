// módulo de alu decoder
module alu_decoder(
    input clk,                   
    input op_5,
    input [2:0] funct3,
    input funct7_5,
    input [1:0] alu_op,
    output reg [2:0] alu_control
);

// lógica combinacional
always @(*) begin
    case (alu_op)
        2'b00: begin
            // lw, sw => suma
            alu_control = 3'b000;
        end

        2'b01: begin
            // beq => resta
            alu_control = 3'b001;
        end

        2'b10: begin
            // R-type o I-type ALU
            case (funct3)
                3'b000: begin
                    // ADD o SUB según op_5 y funct7_5
                    if ({op_5, funct7_5} == 2'b11)
                        alu_control = 3'b001; // SUB
                    else
                        alu_control = 3'b000; // ADD
                end
                3'b010: alu_control = 3'b101; // SLT
                3'b110: alu_control = 3'b011; // OR
                3'b111: alu_control = 3'b010; // AND
                default: alu_control = 3'bxxx; // indefinido
            endcase
        end

        default: alu_control = 3'bxxx; // indefinido
    endcase
end

endmodule
