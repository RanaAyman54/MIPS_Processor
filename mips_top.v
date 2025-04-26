module top(
    input clk,rst_n
);

wire [1:0] ALUOp;
wire RegDst ,Branch ,MemRead ,MemtoReg ,MemWrite ,ALUSrc ,RegWrite;
wire [31:0] instruction;
wire  [31:0] MemtoReg_mux,ALUSrc_mux;
wire  [31:0] rd_d1 , rd_d2;
wire [31:0] alu_to_data_mem , rd_data_mem;
wire zero_b,and_out_branch;
wire [3:0] opcode;
wire [31:0] current_instruction,next_instruction;
wire [31:0] sign_extend_out;
wire [31:0] shifted_left_out;
wire [31:0] alu_pc,alu_branch;
wire [4:0] RegDst_mux;


register_file reg_file (.rd_reg1(instruction[25:21]) ,.rd_reg2(instruction[20:16]) 
                        ,.wr_reg(RegDst_mux),.clk(clk),.rst_n(rst_n),.wr_data(MemtoReg_mux)
                        ,.reg_wr(RegWrite) ,.rd_data1(rd_d1) ,.rd_data2(rd_d2)
                        );


data_memory data_mem (.wr_en(MemWrite) , .rd_en(MemRead), .clk(clk)
                      , .rst_n(rst_n),.addr(alu_to_data_mem) 
                      ,.write_data(rd_d2),.read_data(rd_data_mem)
                      );


ALU alu (.r1(rd_d1) ,.r2(ALUSrc_mux),.op(opcode),.out(alu_to_data_mem),.zero(zero_b));


instruction_memory inst_memory (.read_addr(current_instruction)
                                ,.rst_n(rst_n), .instruction(instruction)
                               );


PC p_c (.clk(clk),.rst_n(rst_n),.next_inst(next_instruction),.inst(current_instruction));

control_unit ctrl_unit (.op(instruction[31:26]),.ALUOp(ALUOp),.RegDst(RegDst) ,.Branch(Branch) 
                        ,.MemRead(MemRead) ,.MemtoReg(MemtoReg) ,.MemWrite(MemWrite) 
                        ,.ALUSrc(ALUSrc) ,.RegWrite(RegWrite)
                       );


alu_control alu_ctrl (.inst_funct(instruction[5:0]),.ALUop(ALUOp),.control_lines(opcode));

mux RegDst_MUX (.in0(instruction[20:16]) , .in1(instruction[15:11]) 
                ,.sel(RegDst) ,.mux_out(RegDst_mux)
               );

mux ALUSrc_MUX (.in0(rd_d2) , .in1(sign_extend_out) ,.sel(ALUSrc) ,.mux_out(ALUSrc_mux));

mux MemtoReg_MUX (.in0(alu_to_data_mem) , .in1(rd_data_mem) ,.sel(MemtoReg) ,.mux_out(MemtoReg_mux));

mux Branch_MUX (.in0(alu_pc) , .in1(alu_branch) ,.sel(and_out_branch) ,.mux_out(next_instruction));

sign_extend s_extend (.in(instruction[15:0]),.out(sign_extend_out));

shift_left_2 sl2 (.in(sign_extend_out),.out(shifted_left_out));

and a (and_out_branch,Branch,zero_b);

ALU alu_pc_ (.r1(current_instruction) ,.r2(4),.op(4'b0010),.out(alu_pc));

ALU alu_branch_ (.r1(alu_pc) ,.r2(shifted_left_out),.op(4'b0010),.out(alu_branch));

    
endmodule