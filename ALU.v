module ALU  (
    input signed [31:0] r1 ,r2,
    input  [3:0]op,
    output reg signed [31:0] out,
    output reg zero
    );

    always @(*) begin
        case (op)
        4'b0000 : out = r1 & r2;
        4'b0001 : out = r1 | r2;
        4'b0010 : out = r1 + r2;
        4'b0110 : out = r1 - r2;
        4'b0111 : out = (r1<r2)? 1 : 0;  
        default : out = 0;  
        endcase
        zero = (|out)? 0 : 1;
    end
    
endmodule