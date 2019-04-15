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
wire [31:0]z_data;
wire [31:0]s_data;
wire [31:0]rtoalu_data;
wire [31:0]aluresult_data;
wire [31:0]shfit_data;
wire regdst,regwrite,alusrc;
wire [2:0]aluop;
wire [4:0]w_reg;
wire [3:0]alu_oper;
wire [1:0]furslt;
wire [4:0]shamt_reg;
wire z,overflow;
//modules
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(instr_addr4) ,   
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
        .RDaddr_i(w_reg) ,  
        .RDdata_i(w_data)  , 
        .RegWrite_i(regwrite),
        .RSdata_o(r_data1) ,  
        .RTdata_o(r_data2)   
        );
	
Decoder Decoder(
        .instr_op_i(instr[31:26]), 
	    .RegWrite_o(regwrite), 
	    .ALUOp_o(aluop),   
	    .ALUSrc_o(alusrc),   
	    .RegDst_o(regdst)   
		);

ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(aluop),   
        .ALU_operation_o(alu_oper),
		.FURslt_o(furslt)
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
		.bonous(instr[5:0])
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
        .data_o(w_data)
        );	

endmodule



