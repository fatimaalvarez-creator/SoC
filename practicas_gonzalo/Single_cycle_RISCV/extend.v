module extend #(
    parameter IN_WIDTH = 25,
    parameter OUT_WIDTH = 32
)(
    input  wire [IN_WIDTH-1:0] extend_in,  // instruction[31:7]
    input  wire [1:0] imm_src,             // 00: I-type, 01: S-type, 10: B-type, 11: J
    output reg  [OUT_WIDTH-1:0] imm_ext
);

always @(*) begin
    case (imm_src)
        2'b00: begin // I-type (LW, ADDI)
            imm_ext = {{20{extend_in[24]}}, extend_in[24:13]};  // bits 31:20
        end
        2'b01: begin // S-type (SW)
            imm_ext = {{20{extend_in[24]}}, extend_in[24:18], extend_in[4:0]};  // bits 31:25 | 11:7
        end
        2'b10: begin // B-type (BEQ)
            imm_ext = {{19{extend_in[24]}}, extend_in[0], extend_in[23:18], extend_in[4:1], 1'b0}; // bits 31 | 7 | 30:25 | 11:8 | 0
        end
        2'b11: begin // J-type (JAL)
            imm_ext = {{11{extend_in[24]}}, extend_in[12:5], extend_in[13], extend_in[23:14], 1'b0}; // JAL: 31 | 19:12 | 20 | 30:21 | 0
        end
        default: begin
            imm_ext = 32'b0;
        end
    endcase
end

endmodule
