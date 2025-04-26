module PC(
    input clk,rst_n,
    input [31:0] next_inst,
    output reg [31:0] inst
);

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
    inst <= 32'b0;
    else
    inst <= next_inst;   
end
    
endmodule