module alu_control(
    input [5:0] inst_funct,
    input [1:0] ALUop,
    output reg [3:0] control_lines
);

always @(*) begin

    case(ALUop)
    2'b00 : control_lines = 4'b0010;//add for lw and sw
    2'b01 : control_lines = 4'b0110;//sub for branch
    2'b10 : begin
        if (inst_funct == 6'b100000) begin
            control_lines = 4'b0010;//add
        end
        else if (inst_funct == 6'b100010) begin
            control_lines = 4'b0110;//sub
        end
        else if (inst_funct == 6'b100100) begin
            control_lines = 4'b0000;//and
        end
        else if (inst_funct == 6'b100101) begin
            control_lines = 4'b0001;//or
        end
        else if (inst_funct == 6'b101010) begin
            control_lines = 4'b0111;//slt
        end
        else begin
            control_lines = 4'b0000;
        end
        end
    default : control_lines = 4'b0000;
    endcase
    
end
    
endmodule