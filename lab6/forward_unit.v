module forward_unit(rs_i , rt_i , ex_mem_rd_i , mem_wb_rd_i , ex_mem_regwrite_i , mem_wb_regwrite_i , forwarda_o , forwardb_o);
input [4:0]rs_i;
input [4:0]rt_i;
input [4:0]ex_mem_rd_i;
input [4:0]mem_wb_rd_i;
input mem_wb_regwrite_i;
input ex_mem_regwrite_i;

output [1:0]forwarda_o;
output [1:0]forwardb_o;

reg [1:0]forwarda_o;
reg [1:0]forwardb_o;

always@(*)begin
	if(ex_mem_rd_i != 0 && ex_mem_regwrite_i == 1 && ex_mem_rd_i == rs_i) forwarda_o = 2;
	else if(mem_wb_rd_i != 0 && mem_wb_regwrite_i == 1 && mem_wb_rd_i == rs_i) forwarda_o = 1;
	else forwarda_o = 0;

	if(ex_mem_rd_i != 0 && ex_mem_regwrite_i == 1 && ex_mem_rd_i == rt_i) forwardb_o = 2;
	else if(mem_wb_rd_i != 0 && mem_wb_regwrite_i == 1 && mem_wb_rd_i == rt_i) forwardb_o = 1;
	else forwardb_o = 0;
end
endmodule