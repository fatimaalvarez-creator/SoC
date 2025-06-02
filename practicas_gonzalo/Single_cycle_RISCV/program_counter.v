module program_counter #(parameter DATA_WIDTH = 32) (
    input clk,                 // Señal de reloj
    input rst,                 // Señal de reset asincrónico
    input [DATA_WIDTH-1:0] pc_next,     // Valor siguiente del PC
    output reg [DATA_WIDTH-1:0] pc      // Valor actual del PC
);

    // En flanco positivo de clk o rst, actualizar el PC
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 0;           // Reiniciar PC a cero
        else
            pc <= pc_next;     // Cargar nuevo valor de PC
    end

endmodule
