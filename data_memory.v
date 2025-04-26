module data_memory(
    input [31:0] addr ,write_data,
    input wr_en , rd_en, clk, rst_n,
    output  [31:0] read_data
);

reg [31:0] mem [0:4095];//16kB
integer j;

assign read_data = (rd_en)? mem[addr[13:2]] : 32'b0; 

always @(posedge clk or negedge clk) begin
    if(~rst_n)begin
        for (j = 0; j < 4096; j = j + 1) begin
            mem[j] <= 32'b0;
        end
    end

    else begin
        if (wr_en)
        mem [addr[13:2]] = write_data;    
    end
       
end
    
endmodule