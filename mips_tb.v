module mips_tb;

reg clk,rst_n;

top DUT (.clk(clk),.rst_n(rst_n));

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst_n=0;
    @(negedge clk);
    rst_n=1;
    
    //add values to $s1 and $s2
    DUT.reg_file.reg_file[17] = 5;
    DUT.reg_file.reg_file[18] = 8;
    //add values to $s3
    DUT.reg_file.reg_file[19] = 4;
    //add values to $t1
    DUT.reg_file.reg_file[9] = 14;
    //add values to $s4
    DUT.reg_file.reg_file[20] = 2;
    //add values to $s5
    DUT.reg_file.reg_file[21] = 2;

    
    //add $t0 , $s1 , $s2
    DUT.inst_memory.inst_mem[0] = 32'b000000_10001_10010_01000_00000_100000;
    //lw $t0 ,4 ($s3)
    DUT.inst_memory.inst_mem[1] = 32'b100011_10011_01000_0000000000000100;
    //sw $t1 , 0 ($s2)
    DUT.inst_memory.inst_mem[2] = 32'b101011_10010_01001_0000000000000000;
    //beq %s4, $s5 , 1
    DUT.inst_memory.inst_mem[3] = 32'b000100_10100_10101_0000000000000001;
    //add $t0 , $s1 , $s2
    DUT.inst_memory.inst_mem[4] = 32'b000000_10001_10010_01000_00000_100000;
    //sub %t0, $s4 ,$s3
    DUT.inst_memory.inst_mem[5] = 32'b000000_10100_10011_01000_00000_100010;

    //store values to data memory
    DUT.data_mem.mem[0] = 11;
    DUT.data_mem.mem[1] = 15;
    DUT.data_mem.mem[2] = 20;
    DUT.data_mem.mem[3] = 40;
    DUT.data_mem.mem[4] = 30;
    DUT.data_mem.mem[5] = 50;


   
    @(posedge clk);
    @(posedge clk);
    $display("time=%t $t0 = %d",$time,DUT.reg_file.reg_file[8]);//13
    @(posedge clk);
    @(posedge clk);
    $display("time=%t $t0 = %d",$time,DUT.reg_file.reg_file[8]);//20
    @(posedge clk);
    @(posedge clk);
    $display("time=%t data memory[2] = %d",$time,DUT.data_mem.mem[2]);//14
    @(posedge clk);
    @(posedge clk);
    $display("time=%t $t0 = %d",$time,DUT.reg_file.reg_file[8]);//-2


  $stop;

end
    
endmodule