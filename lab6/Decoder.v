module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o ,jump_o,branch_o,branchtype_o,memwrite_o,memread_o,memtoreg_o,jal_o);
     
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output			RegDst_o;
output  jump_o;
output  branch_o;
output  branchtype_o;
output  memwrite_o;
output  memread_o;
output  memtoreg_o;
output  jal_o;
//Internal Signals
wire	[3-1:0] ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire			RegDst_o;

//Main function
/*your code here*/
wire r,lw,sw,beq,i,j,bne,lui,blt,bnez,bgez,jal;
assign r = (~instr_op_i[0] && ~instr_op_i[1] && ~instr_op_i[2] && ~instr_op_i[3] && ~instr_op_i[4] && ~instr_op_i[5]);
assign i = (~instr_op_i[0] && ~instr_op_i[1] && ~instr_op_i[2] && instr_op_i[3] && ~instr_op_i[4] && ~instr_op_i[5]);
assign lui = (instr_op_i[0] && instr_op_i[1] && instr_op_i[2] && instr_op_i[3] && ~instr_op_i[4] && ~instr_op_i[5]);
assign lw = (instr_op_i[0] && instr_op_i[1] && ~instr_op_i[2] && ~instr_op_i[3] && ~instr_op_i[4] && instr_op_i[5]);
assign sw = (instr_op_i[0] && instr_op_i[1] && ~instr_op_i[2] && instr_op_i[3] && ~instr_op_i[4] && instr_op_i[5]);
assign beq = (~instr_op_i[0] && ~instr_op_i[1] && instr_op_i[2] && ~instr_op_i[3] && ~instr_op_i[4] && ~instr_op_i[5]);
assign bne = (instr_op_i[0] && ~instr_op_i[1] && instr_op_i[2] && ~instr_op_i[3] && ~instr_op_i[4] && ~instr_op_i[5]);
assign j = (~instr_op_i[0] && instr_op_i[1] && ~instr_op_i[2] && ~instr_op_i[3] && ~instr_op_i[4] && ~instr_op_i[5]);
assign blt = (~instr_op_i[0] && instr_op_i[1] && instr_op_i[2] && ~instr_op_i[3] && ~instr_op_i[4] && ~instr_op_i[5]);
assign bnez = (instr_op_i[0] && ~instr_op_i[1] && instr_op_i[2] && ~instr_op_i[3] && ~instr_op_i[4] && ~instr_op_i[5]);
assign bgez = (instr_op_i[0] && ~instr_op_i[1] && ~instr_op_i[2] && ~instr_op_i[3] && ~instr_op_i[4] && ~instr_op_i[5]);
assign jal = (instr_op_i[0] && instr_op_i[1] && ~instr_op_i[2] && ~instr_op_i[3] && ~instr_op_i[4] && ~instr_op_i[5]);


assign RegWrite_o = (r || i || lui || lw || jal);
assign ALUOp_o[0] = lui || beq || blt;
assign ALUOp_o[1] = r || bne || blt;
assign ALUOp_o[2] = lui || i || bne || blt || j;
assign ALUSrc_o = i || lw || sw;
assign RegDst_o = r;
assign memread_o = lw || r;
assign memwrite_o = sw;
assign memtoreg_o = lw || sw;
assign branch_o = beq || bne || bnez || bgez;
assign branchtype_o = bne;
assign jump_o = j || jal;
assign jal_o = jal;
endmodule
