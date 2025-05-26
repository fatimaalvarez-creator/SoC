module alu(
    input [31:0] src_A, // primer operando
    input [31:0] src_B, // segundo operando 
    input [2:0] alu_control, // operación de la ALU
    output reg [31:0] alu_result, // salida de la ALU
    output reg zero // bandera de cero
);

always @(*) 
    begin
        case (alu_control)
            3'b000: alu_result = src_A + src_B; // ADD
            3'b001: alu_result = src_A - src_B; // SUB
            3'b010: alu_result = src_A & src_B; // AND
            3'b110: alu_result = src_A | src_B; // OR
            3'b111: alu_result = (src_A < src_B) ? 1 : 0; // SLT (set on less than)
            default: alu_result = 32'b0; // default case
        endcase

        if(alu_result == 0) // si el resultado es negativo
            zero = 1; // establece la bandera de cero
        else
            zero = 0; // no es negativo
    end

endmodule