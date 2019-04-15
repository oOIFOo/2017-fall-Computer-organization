module MEMWB_reg( clk_i, rst_n, dm_i, dm_o , alu_i , alu_o , memtoreg_i , memtoreg_o , rd_addr_i , rd_addr_o , RegWrite_i , RegWrite_o);
     
//I/O ports
input           clk_i;
input	        rst_n;

input  [32-1:0] dm_i;
output [32-1:0] dm_o;

input  [32-1:0] alu_i;
output [32-1:0] alu_o;

input  memtoreg_i;
output memtoreg_o;

input  [4:0] rd_addr_i;
output [4:0] rd_addr_o;

input  RegWrite_i;
output RegWrite_o;
 
//Internal Signals
reg    [32-1:0] dm_o;
reg    [32-1:0] alu_o;
reg memtoreg_o;
reg RegWrite_o;
reg [4:0] rd_addr_o;

//Main function
always @(posedge clk_i or negedge rst_n) begin
    if(~rst_n) begin
	        dm_o <= 0;
	        alu_o <= 0;
		memtoreg_o <= 0;
		rd_addr_o <= 0;
		RegWrite_o <= 0;
	end
	else begin
	    dm_o <= dm_i;
	    alu_o <= alu_i;
	    memtoreg_o <= memtoreg_i;
	    rd_addr_o <= rd_addr_i;
	    RegWrite_o <= RegWrite_i;
	end
end

endmodule