module IDEX_reg (clk_i, rst_n, pc_addr_i , pc_addr_o , aluop_i, aluop_o , alusrc_i, alusrc_o , regdst_i , regdst_o , memread_i , memread_o , memwrite_i , memwrite_o
, branch_i , branch_o , branchtype_i , branchtype_o , memtoreg_i , memtoreg_o , rs_addr_i , rs_addr_o , rt_addr_i , rt_addr_o
, rs_data_i , rs_data_o , rt_data_i , rt_data_o , sign_data_i , sign_data_o , RegWrite_i , RegWrite_o , opcode_i , opcode_o , z_data_i , z_data_o);

input           clk_i;
input	        rst_n;

input [31:0]pc_addr_i;
output [31:0]pc_addr_o;

input [2:0] aluop_i;
output [2:0] aluop_o;

input alusrc_i;
output alusrc_o;

input regdst_i;
output regdst_o;

input memread_i;
output memread_o;

input memwrite_i;
output memwrite_o;

input branch_i;
output branch_o;

input branchtype_i;
output branchtype_o;

input memtoreg_i;
output memtoreg_o;

input [4:0]rs_addr_i;
output [4:0]rs_addr_o;

input [4:0]rt_addr_i;
output [4:0]rt_addr_o;

input [31:0]rs_data_i;
output [31:0]rs_data_o;

input [31:0]rt_data_i;
output [31:0]rt_data_o;

input [31:0]sign_data_i;
output [31:0]sign_data_o;

input RegWrite_i;
output RegWrite_o;

input [5:0]opcode_i;
output [5:0]opcode_o;

input [31:0]z_data_i;
output [31:0]z_data_o;
 
//Internal Signals
reg [32-1:0] pc_addr_o;
reg [2:0] aluop_o;
reg alusrc_o;
reg regdst_o;
reg memread_o;
reg memwrite_o;
reg branch_o;
reg branchtype_o;
reg memtoreg_o;
reg [4:0]rs_addr_o;
reg [4:0]rt_addr_o;
reg [31:0]rs_data_o;
reg [31:0]rt_data_o;
reg [31:0]sign_data_o;
reg RegWrite_o;
reg [5:0]opcode_o;
reg [31:0]z_data_o;
//Main function
always @(posedge clk_i or negedge rst_n) begin
    	if(~rst_n) begin
	    pc_addr_o <= 0;
	    aluop_o <= 0;
	    alusrc_o <= 0;
	    regdst_o <= 0;
	    memread_o <= 0;
	    memwrite_o <= 0;
	    branch_o <= 0;
	    branchtype_o <= 0;
	    memtoreg_o <= 0;
	    rs_addr_o <= 0;
	    rt_addr_o <= 0;
	    rs_data_o <= 0;
	    rt_data_o <= 0;
	    sign_data_o <= 0;
	    RegWrite_o <= 0;
	    opcode_o <= 0;
	    z_data_o <= 0;
	end
	else begin
	    pc_addr_o <= pc_addr_i;
	    alusrc_o <= alusrc_i;
   	    regdst_o <= regdst_i;
	    memread_o <= memread_i;
	    memwrite_o <= memwrite_i;
	    branch_o <= branch_i;
	    branchtype_o <= branchtype_i;
	    memtoreg_o <= memtoreg_i;
	    pc_addr_o <= pc_addr_i;
	    rs_addr_o <= rs_addr_i;
	    rt_addr_o <= rt_addr_i;
	    rs_data_o <= rs_data_i;
	    rt_data_o <= rt_data_i;
	    sign_data_o <= sign_data_i;
	    RegWrite_o <= RegWrite_i;
	    opcode_o <= opcode_i;
 	    aluop_o <= aluop_i;
	    z_data_o <= z_data_i;
	end
end

endmodule