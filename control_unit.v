module control_unit(
    input [5:0] op,
    output reg [1:0] ALUOp,
    output reg RegDst ,Branch ,MemRead ,MemtoReg ,MemWrite ,ALUSrc ,RegWrite
);

always @(*) begin
    case(op)
    6'b000000 : begin//R-format
        RegDst = 1;
        Branch = 0;
        MemRead = 0;
        MemtoReg = 0;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 1;
        ALUOp = 2'b10;

    end
    6'b000100 : begin//I-format beq
        RegDst = 1'bx;
        Branch = 1;
        MemRead = 0;
        MemtoReg = 1'bx;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 0;
        ALUOp = 2'b01;
    end
    6'b100011 : begin////I-format lw
        RegDst = 0;
        Branch = 0;
        MemRead = 1;
        MemtoReg = 1;
        MemWrite = 0;
        ALUSrc = 1;
        RegWrite = 1;
        ALUOp = 2'b00;
    end
    6'b101011 : begin////I-format sw
        RegDst = 1'bx;
        Branch = 0;
        MemRead = 0;
        MemtoReg = 1'bx;
        MemWrite = 1;
        ALUSrc = 1;
        RegWrite = 0;
        ALUOp = 2'b00;
    end
    default   : begin
        RegDst = 0;
        Branch = 0;
        MemRead = 0;
        MemtoReg = 0;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 0;
        ALUOp = 0;
    end
    endcase
    
end
    
endmodule