module register_file(
    input [4:0] rd_reg1 ,rd_reg2 ,wr_reg,
    input  [31:0] wr_data,
    input clk,rst_n,
    input reg_wr ,
    output  [31:0] rd_data1 ,rd_data2 
);

reg signed [31:0] reg_file [31:0];
integer i;

assign rd_data1 = (rd_reg1!=0)? reg_file[rd_reg1] : 0;
assign rd_data2 = (rd_reg2!=0)? reg_file[rd_reg2] : 0;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin

         for (i = 0; i < 32; i = i + 1) begin
                reg_file[i] <= 32'b0;
            end

    end
    else begin

    if(reg_wr && wr_reg !=0)
    reg_file[wr_reg] <= wr_data;   
    end  

end
    
endmodule