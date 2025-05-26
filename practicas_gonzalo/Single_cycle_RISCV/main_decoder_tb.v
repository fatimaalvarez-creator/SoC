// módulo de test para el main_decoder
module main_decoder_tb;
    // entradas
    reg clk;
    reg [6:0] op;
    
    // salidas
    wire branch, jump, mem_write, alu_src, reg_write;
    wire [1:0] result_src, imm_src, alu_op;
    
    // instacia del módulo a testear
    main_decoder DUT(
        .clk(clk),
        .op(op),
        .branch(branch),
        .jump(jump),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .result_src(result_src),
        .imm_src(imm_src),
        .alu_op(alu_op)
    );
    
    always        
        #1 clk = ~clk;

    initial 
        begin
        clk = 0;
        #10;
        op = 7'b0000000; // default
        #10;
        op = 7'b0000011; // lw
        #10;
        op = 7'b0100011; // sw
        #10;
        op = 7'b0000101; // default
        #10;
        op = 7'b0110011; // R-type
        #10;
        op = 7'b1100011; // beq
        #10;
        op = 7'b1101111; // jal
        #10;
        op = 7'b1100111; // jalr
        #10;
        end
        
endmodule