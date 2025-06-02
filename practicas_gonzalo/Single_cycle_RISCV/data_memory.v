module data_memory #(parameter DATA_WIDTH = 32)(
    input clk,                   // Reloj
    input WE,                    // Habilitador de escritura (Write Enable)
    input [DATA_WIDTH-1:0] address,        // Dirección de la memoria
    input [DATA_WIDTH-1:0] WD,             // Dato a escribir (Write Data)
    output [DATA_WIDTH-1:0] RD             // Dato leído (Read Data) - lectura combinacional
);

    // Memoria de datos: 1024 palabras de 32 bits
    reg [DATA_WIDTH-1:0] data_MEM [1023:0];

    // Inicializar la memoria en cero
    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            data_MEM[i] = 32'h00000000;
        end
    end

    // Lectura combinacional: lectura inmediata, sin reloj
    assign RD = data_MEM[address[9:0]]; // solo se usan los 10 bits menos significativos

    // Escritura sincrónica: solo en flanco de subida del reloj si WE está activo
    always @(posedge clk) begin
        if (WE) begin
            data_MEM[address[9:0]] <= WD;
        end
    end

endmodule
