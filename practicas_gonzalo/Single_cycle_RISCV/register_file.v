module register_file(
    input clk, // reloj
    input WE3, // habilitador de escritura
    input [4:0] A1, // dirección del registro 1 
    input [4:0] A2, // dirección del registro 2
    input [4:0] A3, // dirección del registro 3 (escritura)
    input [31:0] WD3, // dato a escribir
    output reg [31:0] RD1, // dato del registro 1
    output reg [31:0] RD2 // dato del registro 2
);

// registro de 32 bits
reg [31:0] REG_MEM [0:31]; // 32 bits de 32 registros

// lectura de los registros RD1 y RD2
always @(*) 
    begin
        RD1 = REG_MEM[A1]; // dato del registro 1
        RD2 = REG_MEM[A2]; // dato del registro 2
    end    

// escritura en el registro 3
// siempre que hay un flanco de subida del reloj, se escribe en el registro A3
always @(posedge clk) 
    begin
        if (WE3 == 1) // si el habilitador de escritura está activo
            REG_MEM[A3] <= WD3; // escribe el dato WD3 en el registro A3
    end

endmodule