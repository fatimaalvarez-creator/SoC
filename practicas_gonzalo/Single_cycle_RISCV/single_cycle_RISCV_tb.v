`timescale 1ns/1ps

module single_cycle_RISCV_tb;

    reg clk;
    reg rst;

    // Instancia del DUT (Device Under Test)
    single_cycle_RISCV top (
        .clk(clk),
        .rst(rst)
    );

    // Generador de reloj: periodo de 10ns (frecuencia de 100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Inicialización
        clk = 0;
        rst = 1;

        // Esperar al menos un ciclo con reset activo
        #20;
        rst = 0;

        // Correr la simulación durante varios ciclos
        #500;

        // Terminar simulación
        $finish;
    end

    // Dump para herramientas como GTKWave o ModelSim
    initial begin
        $dumpfile("single_cycle_RISCV_tb.vcd"); // Solo necesario para Icarus/GTKWave
        $dumpvars(0, single_cycle_RISCV_tb);
    end

endmodule
