`timescale 1ns / 100ps

module single_cycle_RISCV_tb();

    reg clk;
	 
	 
	 // instancia del single cycle RISCV
	single_cycle_RISCV SCR(
		.clk(clk)
	);		

    // generador de reloj: período 10ns (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("Simulación iniciada...");

        // monitoreo en consola de señales clave
        $monitor("Time: %0t | PC: %h | Instruction: %h | ALUResult: %h | RegWrite: %b | MemRead: %b | MemWrite: %b | Branch: %b",
                 $time,
                 SCR.PC,
                 SCR.instruction,
                 SCR.alu_result,
                 SCR.reg_write,
                 SCR.mem_write,          
                 SCR.branch
                );

        // iempo de simulación
        #1000;

        $display("Simulación terminada.");
        $finish;
    end

endmodule
