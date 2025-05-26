module data_memory(
    input clk, // reloj
    input WE, // habilitador de escritura
    input [31:0] address, // dirección de la memoria
    input [31:0] WD, // dato a escribir
    output reg [31:0] RD // dato leído
);

    // memoria de datos de 32 bits
    reg [31:0] data_MEM [10000:0]; // 10,000 palabras de 32 bits

    // lectura de la memoria en la dirección address
    always @(posedge clk)
        begin
            if (WE == 1) // si el habilitador de escritura está activo
                data_MEM[address] <= WD; // escribe el dato WD en la dirección address
            else
                RD <= data_MEM[address]; // lee el dato en la dirección address
        end 


endmodule