module Pipeline_CPU( clk_i, rst_n );
//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [31:0]instr_addr;
wire [31:0]instr_addr_back;
wire [31:0]instr_addr4_1;
wire [31:0]instr_addr4_2;
wire [31:0]instr_addr4_3;
wire [31:0]b_addr2;
wire [31:0]b_addr1;
wire [31:0]instr;
wire [31:0]instr_o;
wire [31:0]data;
wire [31:0]r_data1;
wire [31:0]r_data2;
wire [31:0]rs_data;
wire [31:0]rt_data;
wire [31:0]r_data2_write;
wire [31:0]w_data;
wire [31:0]write_data;
wire [31:0]s_data1;
wire [31:0]s_data2;
wire [31:0]rtoalu_data;
wire [31:0]aluresult_data0;
wire [31:0]aluresult_data1;
wire [31:0]aluresult_data2;
wire [31:0]aluresult_data3;
wire [31:0]shfit_data;
wire [31:0]z_data1;
wire [31:0]z_data2;
wire zero,jal_alu_src,notz;
wire jalsrc;
wire regdst1,regwrite1,alusrc1,memtoreg1,memwrite1,memread1,branch1,branch_type1;
wire regdst2,regwrite2,alusrc2,memtoreg2,memwrite2,memread2,branch2,branch_type2;
wire regwrite3,memtoreg3,memwrite3,memread3,branch3;
wire regwrite4,memtoreg4;
wire jump , pc_src;
wire [2:0]aluop1;
wire [2:0]aluop2;
wire [5:0]opcode1;
wire [4:0]rd_addr1;
wire [4:0]rd_addr2;
wire [4:0]rd_addr3;
wire [4:0]rd0;
wire [4:0]rd1;
wire [4:0]w_reg;
wire [3:0]alu_oper;
wire [1:0]furslt;
wire [4:0]shamt_reg;
wire [31:0]mem_data1;
wire [31:0]mem_data2;
wire [31:0]j_data;
wire [31:0]branch_data;
wire [31:0]branch_addr;
wire [31:0]pc_branch;
wire z,zero1,zero2,overflow;

Program_Counter PC(
        .clk_i(clk_i),      
	.rst_n(rst_n),     
	.pc_in_i(instr_addr_back),   
	.pc_out_o(instr_addr) 
	);

Mux2to1 #(.size(32)) pc_addr_src(
	.data0_i(instr_addr4_1),
        .data1_i(b_addr2),
        .select_i(pc_src),
        .data_o(instr_addr_back)
	);
	
Adder Adder1(
        .src1_i(instr_addr),     
	.src2_i(32'd4),
	.sum_o(instr_addr4_1)    
	);
	
Instr_Memory IM(
        .pc_addr_i(instr_addr),  
	.instr_o(instr_o)    
	);

IFID_reg reg1(
	.clk_i(clk_i), 
	.rst_n(rst_n), 
	.pc_addr_i(instr_addr4_1), 
	.pc_instr_i(instr_o), 
	.pc_instr_o(instr), 
	.pc_addr_o(instr_addr4_2)
	);

Reg_File RF(
        .clk_i(clk_i),      
	.rst_n(rst_n) ,     
        .RSaddr_i(instr[25:21]),  
        .RTaddr_i(instr[20:16]),  
        .Wrtaddr_i(rd_addr3),  
        .Wrtdata_i(w_data), 
        .RegWrite_i(regwrite4),
        .RSdata_o(rs_data) ,  
        .RTdata_o(rt_data)   
        );
	
Decoder Decoder(
        .instr_op_i(instr[31:26]), 
	.RegWrite_o(regwrite1), 
	.ALUOp_o(aluop1),   
	.ALUSrc_o(alusrc1),   
	.RegDst_o(regdst1),
	.jump_o(jump),
	.branch_o(branch1),
	.branchtype_o(branch_type1),
	.memwrite_o(memwrite1),
	.memread_o(memread1),
	.memtoreg_o(memtoreg1),
	.jal_o(jalsrc)
	);

Zero_Filled ZF(
        .data_i(instr[15:0]),
        .data_o(z_data1)
        );	

IDEX_reg reg2(
	.clk_i(clk_i), 
	.rst_n(rst_n), 
	.pc_addr_i(instr_addr4_2), 
	.pc_addr_o(instr_addr4_3), 
	.aluop_i(aluop1),
	.aluop_o(aluop2), 
	.alusrc_i(alusrc1), 
	.alusrc_o(alusrc2), 
	.regdst_i(regdst1), 
	.regdst_o(regdst2), 
	.memread_i(memread1), 
	.memread_o(memread2), 
	.memwrite_i(memwrite1), 
	.memwrite_o(memwrite2),
	.branch_i(branch1),
	.branch_o(branch2), 
	.branchtype_i(branch_type1), 
	.branchtype_o(branch_type2), 
	.memtoreg_i(memtoreg1), 
	.memtoreg_o(memtoreg2), 
	.rs_addr_i(instr[20:16]),
	.rs_addr_o(rd0), 
	.rt_addr_i(instr[15:11]), 
	.rt_addr_o(rd1),
	.rs_data_i(rs_data), 
	.rs_data_o(r_data1),
	.rt_data_i(rt_data), 
	.rt_data_o(r_data2), 
	.sign_data_i(s_data1), 
	.sign_data_o(s_data2), 
	.RegWrite_i(regwrite1), 
	.RegWrite_o(regwrite2),
	.opcode_i(instr[31:26]),
	.opcode_o(opcode1),
	.z_data_i(z_data1),
	.z_data_o(z_data2)
	);

ALU_Ctrl AC(
        .funct_i(s_data2[5:0]),   
        .ALUOp_i(aluop2),   
        .ALU_operation_o(alu_oper),
	.FURslt_o(furslt),
	.jalalu_o(jal_alu_src),
	.opcode(opcode1)
        );
	
Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(s_data1)
        );

Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(r_data2),
        .data1_i(s_data2),
        .select_i(alusrc2),
        .data_o(rtoalu_data)
        );	
		
ALU ALU(
	.aluSrc1(r_data1),
	.aluSrc2(rtoalu_data),
	.ALU_operation_i(alu_oper),
	.result(aluresult_data0),
	.zero(z),
	.overflow(overflow),
	.bonous(instr[5:0]),
	.opcode(opcode1)
	);

Shifter branch_shifter( 
	.result(branch_data), 
	.leftRight(32'd1),
	.shamt(32'd2),
	.sftSrc(s_data2) 
	);

Adder Adder2(
        .src1_i(instr_addr4_3),     
	.src2_i(branch_data),
	.sum_o(b_addr1)    
	);

Mux2to1 #(.size(5)) rd_src(
	.data0_i(rd0),
        .data1_i(rd1),
        .select_i(regdst2),
        .data_o(rd_addr1)
	);

Mux2to1 #(.size(1)) zero_src2Src(
        .data0_i(z),
        .data1_i(~z),
        .select_i(branch_type2),
        .data_o(zero1)
        );

Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(aluresult_data0),
        .data1_i(shfit_data),
	.data2_i(z_data2),
        .select_i(furslt),
        .data_o(aluresult_data1)
        );	

Shifter shifter( 
	.result(shfit_data), 
	.leftRight(alu_oper[0]),
	.shamt(s_data2[10:6]),
	.sftSrc(rtoalu_data) 
	);

EXMEM_reg reg3(
	.clk_i(clk_i), 
	.rst_n(rst_n), 
	.memread_i(memread2), 
	.memread_o(memread3), 
	.memwrite_i(memwrite2), 
	.memwrite_o(memwrite3), 
	.branch_i(branch2), 
	.branch_o(branch3), 
	.zero_i(zero1), 
	.zero_o(zero2), 
	.memtoreg_i(memtoreg2), 
	.memtoreg_o(memtoreg3),
	.alu_i(aluresult_data1), 
	.alu_o(aluresult_data2), 
	.rt_i(r_data2), 
	.rt_o(r_data2_write), 
	.rd_addr_i(rd_addr1), 
	.rd_addr_o(rd_addr2), 
	.branch_data_i(b_addr1), 
	.branch_data_o(b_addr2), 
	.RegWrite_i(regwrite2), 
	.RegWrite_o(regwrite3)
	);

Data_Memory DM(
	.clk_i(clk_i),
	.addr_i(aluresult_data2),
	.data_i(r_data2_write),
	.MemRead_i(memread3),
	.MemWrite_i(memwrite3),
	.data_o(mem_data1)
	);

MEMWB_reg reg4(
	.clk_i(clk_i), 
	.rst_n(rst_n), 
	.dm_i(mem_data1), 
	.dm_o(mem_data2), 
	.alu_i(aluresult_data2), 
	.alu_o(aluresult_data3), 
	.memtoreg_i(memtoreg3), 
	.memtoreg_o(memtoreg4), 
	.rd_addr_i(rd_addr2), 
	.rd_addr_o(rd_addr3), 
	.RegWrite_i(regwrite3), 
	.RegWrite_o(regwrite4)
	);

Mux2to1 #(.size(32)) memory_src2Src(
        .data0_i(aluresult_data3),
        .data1_i(mem_data2),
        .select_i(memtoreg4),
        .data_o(w_data)
        );	

and(pc_src,branch3,zero2);
endmodule