module instruction_memory(
    input [31:0] read_addr,
    input rst_n,
    output [31:0] instruction    
);

reg [31:0] inst_mem [0:1023];//4kB
integer j;

assign instruction = inst_mem[read_addr[11:2]];

always @(negedge rst_n) begin
    if (~rst_n) begin
        for (j = 0; j < 1024; j = j + 1) begin
            inst_mem[j] <= 32'b0;
        end
    end    
end
    
endmodule