module alu(
    input [31:0] src_A,              // primer operando
    input [31:0] src_B,              // segundo operando 
    input [2:0] alu_control,         // operación de la ALU
    output reg [31:0] alu_result,    // salida de la ALU
    output reg zero                  // bandera de cero
);

always @(*) begin
    case (alu_control)
        3'b000: alu_result = src_A + src_B;                          // ADD
        3'b001: alu_result = src_A - src_B;                          // SUB
        3'b010: alu_result = src_A & src_B;                          // AND
        3'b011: alu_result = src_A | src_B;                          // OR
        3'b101: alu_result = ($signed(src_A) < $signed(src_B)) ? 32'd1 : 32'd0; // SLT con signo
        default: alu_result = 32'b0;                                 // Caso por defecto
    endcase

    // Establece la bandera zero si el resultado es cero
    zero = (alu_result == 32'b0) ? 1'b1 : 1'b0;
end

endmodule
