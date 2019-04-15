module IFID_reg (clk_i, rst_n, pc_addr_i , pc_instr_i , pc_instr_o, pc_addr_o , lw_bubble_i , b_bubble_i);

input           clk_i;
input	        rst_n;
input lw_bubble_i;
input b_bubble_i;
input  [32-1:0] pc_addr_i;
input  [32-1:0] pc_instr_i;
output [32-1:0] pc_addr_o;
output [32-1:0] pc_instr_o;
 
//Internal Signals
reg    [32-1:0] pc_addr_o;
reg [32-1:0] pc_instr_o;

//Main function
always @(posedge clk_i or negedge rst_n) begin
    	if(~rst_n || b_bubble_i) begin
	    pc_addr_o <= 0;
	    pc_instr_o <=0;
	end
	else if(!lw_bubble_i)begin
	    pc_addr_o <= pc_addr_i;
	    pc_instr_o <= pc_instr_i;
	end
end

endmodule