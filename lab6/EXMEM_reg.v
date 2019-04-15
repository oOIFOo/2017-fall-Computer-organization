module EXMEM_reg( clk_i, rst_n  , memread_i , memread_o , memwrite_i , memwrite_o , branch_i , branch_o , zero_i , zero_o , memtoreg_i , memtoreg_o
, alu_i , alu_o , rt_i , rt_o , rd_addr_i , rd_addr_o , branch_data_i , branch_data_o , RegWrite_i , RegWrite_o , b_bubble_i);
     
//I/O ports
input           clk_i;
input	        rst_n;
 
//Internal Signals
input memread_i;
output memread_o;

input memwrite_i;
output memwrite_o;

input branch_i;
output branch_o;

input zero_i;
output zero_o;

input memtoreg_i;
output memtoreg_o;

input [31:0]alu_i;
output [31:0]alu_o;

input [31:0]rt_i;
output [31:0]rt_o;

input [4:0]rd_addr_i;
output [4:0]rd_addr_o;

input [31:0]branch_data_i;
output [31:0]branch_data_o;

input RegWrite_i;
output RegWrite_o;

input b_bubble_i;
//Internal Signals
reg [32-1:0] branch_data_o;
reg [4:0]rd_addr_o;
reg [31:0]rt_o;
reg [31:0]alu_o;
reg memtoreg_o;
reg branchtype_o;
reg branch_o;
reg memwrite_o;
reg memread_o;
reg RegWrite_o;
reg zero_o;

always @(posedge clk_i or negedge rst_n) begin
    if(~rst_n || b_bubble_i) begin
	    memread_o <= 0;
	    memwrite_o <= 0;
	    branch_o <= 0;
	    zero_o <= 0;
	    memtoreg_o <= 0;
	    alu_o <= 0;
	    rt_o <= 0;
	    rd_addr_o <= 0;
	    branch_data_o <= 0;
	    RegWrite_o <= 0;
	end
	else begin
	    memread_o <= memread_i;
	    memwrite_o <= memwrite_i;
	    branch_o <= branch_i;
	    zero_o <= zero_i;
	    memtoreg_o <= memtoreg_i;
	    alu_o <= alu_i;
	    rt_o <= rt_i;
	    rd_addr_o <= rd_addr_i;
	    branch_data_o <= branch_data_i;
	    RegWrite_o <= RegWrite_i;
	end
end

endmodule