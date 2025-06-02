module instruction_memory #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32
)(
    input  [DATA_WIDTH-1:0] pc_address,        // Dirección del PC en bytes
    output reg [DATA_WIDTH-1:0] instruction    // Instrucción de 32 bits
);

    // Memoria de instrucciones (256 palabras)
    reg [DATA_WIDTH-1:0] IMEM [0:(1<<ADDR_WIDTH)-1];

    // Inicialización: llenar con ceros y luego cargar instrucciones
    integer i;
    initial begin
        for (i = 0; i < (1<<ADDR_WIDTH); i = i + 1)
            IMEM[i] = 32'b0;
        $readmemh("instructions.hex", IMEM); // Asegúrate que exista este archivo
    end

    // Lectura de instrucción (acceso por palabra, alineado a 4 bytes)
    always @(*) begin
        if (pc_address[9:2] < (1<<ADDR_WIDTH))
            instruction = IMEM[pc_address[9:2]];
        else
            instruction = 32'b0; // fuera de rango
    end

endmodule
