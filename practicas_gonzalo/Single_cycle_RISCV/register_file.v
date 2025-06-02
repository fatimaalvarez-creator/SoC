module register_file #(parameter DATA_WIDTH = 32) (
    input clk,                     // reloj
    input WE3,                     // habilitador de escritura
    input [4:0] A1,                // dirección registro fuente 1 (rs1)
    input [4:0] A2,                // dirección registro fuente 2 (rs2)
    input [4:0] A3,                // dirección registro destino (rd)
    input [DATA_WIDTH-1:0] WD3,   // dato a escribir
    output reg [DATA_WIDTH-1:0] RD1,  // dato leído registro 1
    output reg [DATA_WIDTH-1:0] RD2   // dato leído registro 2
);

    // Declaración de 32 registros de DATA_WIDTH bits
    reg [DATA_WIDTH-1:0] REG [31:0];

    // Inicialización de registros a cero
    integer i;
    initial 
	 begin
        for (i = 0; i < 32; i = i + 1) 
		  begin
            REG[i] = 32'b0;
        end
    end

    // Lectura combinacional, registro 0 siempre devuelve 0
    always @(*) begin
        RD1 = (A1 == 5'b0) ? 32'b0 : REG[A1];
        RD2 = (A2 == 5'b0) ? 32'b0 : REG[A2];
    end

    // Escritura secuencial en flanco de subida del reloj, excepto registro 0
    always @(posedge clk) 
	 begin
        if (WE3 && (A3 != 5'b0)) 
		  begin
            REG[A3] <= WD3;
        end
    end

endmodule
