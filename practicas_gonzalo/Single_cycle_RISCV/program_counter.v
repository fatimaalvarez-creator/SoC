module program_counter  #( parameter N = 32 ) (
    input clk, // reloj
    input [N-1:0] pc_next, // entrada del PC
    output reg [N-1:0] pc // salida del PC
);

    // Siempre que hay un flanco de subida del reloj, actualiza el PC
    always @(posedge clk) 
        begin
            pc <= pc_next;
        end 

endmodule