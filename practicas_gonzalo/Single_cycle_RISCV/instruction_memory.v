module instruction_memory #(parameter N = 32) (
    input [N-1:0] pc, // entrada del PC
    output reg [N-1:0] instruction // salida de la instrucción
);

    // memoria de instrucciones de 32 bits
    reg [N-1:0] IMEM [0:255]; // 256 instrucciones de 32 bits

    // inicialización de la memoria de instrucciones
    initial 
        begin
            $readmemh("instructions.txt", IMEM); // carga las instrucciones desde un archivo
        end

    // lectura de la instrucción en la dirección pc
    always @(*) 
        begin
            instruction = IMEM[pc >> 2]; // lee la instrucción en la dirección pc (dividida por 4)
        end

endmodule