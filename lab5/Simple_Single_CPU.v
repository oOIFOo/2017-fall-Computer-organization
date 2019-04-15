module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [31:0]instr_addr;
wire [31:0] instr_addr4;
wire [31:0]instr;
wire [31:0]data;
wire [31:0]r_data1;
wire [31:0]r_data2;
wire [31:0]w_data;
wire [31:0]write_data;
wire [31:0]z_data;
wire [31:0]s_data;
wire [31:0]rtoalu_data;
wire [31:0]aluresult_data;
wire [31:0]tomem;
wire [31:0]shfit_data;
wire regdst,regwrite,alusrc,memtoreg,zero,jal_alu_src,notz;
wire memwrite,memread,branch,branch_type,pcsrc,jalsrc;
wire jump;
wire [2:0]aluop;
wire [4:0]w_reg;
wire [4:0]wregdata;
wire [3:0]alu_oper;
wire [1:0]furslt;
wire [4:0]shamt_reg;
wire [31:0]mem_data;
wire [31:0]to_mem_data;
wire [31:0]j_data;
wire [31:0]branch_data;
wire [31:0]branch_addr;
wire [31:0]pc_branch;
wire [31:0]instr_addr_back;
wire [31:0]jump_data;
wire [31:0]instr_addr_back_tmp;
wire z,overflow;
//modules
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(instr_addr_back) ,   
	    .pc_out_o(instr_addr) 
	    );
	
Adder Adder1(
        .src1_i(instr_addr),     
	    .src2_i(32'd4),
	    .sum_o(instr_addr4)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(instr_addr),  
	    .instr_o(instr)    
	    );

Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
        .select_i(regdst),
        .data_o(w_reg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(instr[25:21]) ,  
        .RTaddr_i(instr[20:16]) ,  
        .RDaddr_i(wregdata) ,  
        .RDdata_i(write_data)  , 
        .RegWrite_i(regwrite),
        .RSdata_o(r_data1) ,  
        .RTdata_o(r_data2)   
        );
	
Decoder Decoder(
        .instr_op_i(instr[31:26]), 
	.RegWrite_o(regwrite), 
	.ALUOp_o(aluop),   
	.ALUSrc_o(alusrc),   
	.RegDst_o(regdst),
	.jump_o(jump),
	.branch_o(branch),
	.branchtype_o(branch_type),
	.memwrite_o(memwrite),
	.memread_o(memread),
	.memtoreg_o(memtoreg),
	.jal_o(jalsrc)
		);

ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(aluop),   
        .ALU_operation_o(alu_oper),
	.FURslt_o(furslt),
	.jalalu_o(jal_alu_src),
	.opcode(instr[31:26])
        );
	
Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(s_data)
        );

Zero_Filled ZF(
        .data_i(instr[15:0]),
        .data_o(z_data)
        );
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(r_data2),
        .data1_i(s_data),
        .select_i(alusrc),
        .data_o(rtoalu_data)
        );	
		
ALU ALU(
		.aluSrc1(r_data1),
	    .aluSrc2(rtoalu_data),
	    .ALU_operation_i(alu_oper),
		.result(aluresult_data),
		.zero(z),
		.overflow(overflow),
		.bonous(instr[5:0]),
		.opcode(instr[31:26])
	    );
		
Shifter shifter( 
		.result(shfit_data), 
		.leftRight(alu_oper[0]),
		.shamt(instr[10:6]),
		.sftSrc(rtoalu_data) 
		);
		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(aluresult_data),
        .data1_i(shfit_data),
	.data2_i(z_data),
        .select_i(furslt),
        .data_o(tomem)
        );	

Data_Memory DM(
	.clk_i(clk_i),
	.addr_i(tomem),
	.data_i(r_data2),
	.MemRead_i(memread),
	.MemWrite_i(memwrite),
	.data_o(mem_data)
	);
Mux2to1 #(.size(32)) memory_src2Src(
        .data0_i(tomem),
        .data1_i(mem_data),
        .select_i(memtoreg),
        .data_o(w_data)
        );	
Shifter j_shifter( 
		.result(j_data), 
		.leftRight(32'd1),
		.shamt(32'd2),
		.sftSrc(instr[25:0]) 
		);
Shifter branch_shifter( 
		.result(branch_data), 
		.leftRight(32'd1),
		.shamt(32'd2),
		.sftSrc(s_data) 
		);
Mux2to1 #(.size(32)) branch_src2Src(
        .data0_i(instr_addr4),
        .data1_i(branch_addr),
        .select_i(pcsrc),
        .data_o(pc_branch)
        );
Mux2to1 #(.size(32)) jump_src2Src(
        .data0_i(pc_branch),
        .data1_i(jump_data),
        .select_i(jump),
        .data_o(instr_addr_back_tmp)
        );
Mux2to1 #(.size(32)) jr_src2Src(
        .data0_i(instr_addr_back_tmp),
        .data1_i(r_data1),
        .select_i(jal_alu_src),
        .data_o(instr_addr_back)
        );
Mux2to1 #(.size(1)) zero_src2Src(
        .data0_i(z),
        .data1_i(notz),
        .select_i(branch_type),
        .data_o(zero)
        );
Adder Adder2(
        .src1_i(instr_addr4),     
	    .src2_i(branch_data),
	    .sum_o(branch_addr)    
	    );
Mux2to1 #(.size(5))jal_src1(
	.data0_i(w_reg),
        .data1_i(32'd31),
        .select_i(jalsrc),
        .data_o(wregdata)
);
Mux2to1 #(.size(32))jal_src2(
	.data0_i(w_data),
        .data1_i(instr_addr4),
        .select_i(jalsrc),
        .data_o(write_data)
);

Mux2to1 #(.size(32))jr_src1(
	.data0_i(tomem),
        .data1_i(32'd31),
        .select_i(jal_alu_src),
        .data_o(to_mem_data)
);
assign jump_data[27:0] = j_data[27:0];
assign jump_data[31:28] = instr_addr4[31:28]; 
assign notz = (z != 1);
and(pcsrc,branch,zero);
endmodule



