module ALU( aluSrc1, aluSrc2, ALU_operation_i, result, zero, overflow ,bonous);

//I/O ports 
input	[32-1:0] aluSrc1;
input	[32-1:0] aluSrc2;
input	 [4-1:0] ALU_operation_i;
input   [5:0] bonous;

output	[32-1:0] result;
output			 zero;
output			 overflow;

//Internal Signals
wire			 zero;
wire			 overflow;
wire	[32-1:0] result;
wire invertA,invertB;
wire [31:0] bonous_result;
wire [31:0] tmp_result;

wire carry[32:0];
wire tmp1,tmp2,a_o,b_o,set,set_,trash;
wire [1:0] operation;
wire [31:0]right,left;
//Main function
/*your code here*/
assign operation = ALU_operation_i[1:0];
assign invertA = ALU_operation_i[3];
assign invertB = ALU_operation_i[2];
assign right = aluSrc2>>aluSrc1;
assign left = aluSrc2<<aluSrc1;
assign bonous_result = (bonous == 4) ? left : right;
assign result = (bonous == 6'd4 || bonous == 6'd6) ? bonous_result : tmp_result;

ALU_1bit ALU0(tmp_result[0],carry[0],aluSrc1[0],aluSrc2[0],invertA,invertB,operation,invertB,set);
ALU_1bit ALU1(tmp_result[1],carry[1],aluSrc1[1],aluSrc2[1],invertA,invertB,operation,carry[0],0);
ALU_1bit ALU2(tmp_result[2],carry[2],aluSrc1[2],aluSrc2[2],invertA,invertB,operation,carry[1],0);
ALU_1bit ALU3(tmp_result[3],carry[3],aluSrc1[3],aluSrc2[3],invertA,invertB,operation,carry[2],0);
ALU_1bit ALU4(tmp_result[4],carry[4],aluSrc1[4],aluSrc2[4],invertA,invertB,operation,carry[3],0);
ALU_1bit ALU5(tmp_result[5],carry[5],aluSrc1[5],aluSrc2[5],invertA,invertB,operation,carry[4],0);
ALU_1bit ALU6(tmp_result[6],carry[6],aluSrc1[6],aluSrc2[6],invertA,invertB,operation,carry[5],0);
ALU_1bit ALU7(tmp_result[7],carry[7],aluSrc1[7],aluSrc2[7],invertA,invertB,operation,carry[6],0);
ALU_1bit ALU8(tmp_result[8],carry[8],aluSrc1[8],aluSrc2[8],invertA,invertB,operation,carry[7],0);
ALU_1bit ALU9(tmp_result[9],carry[9],aluSrc1[9],aluSrc2[9],invertA,invertB,operation,carry[8],0);
ALU_1bit ALU10(tmp_result[10],carry[10],aluSrc1[10],aluSrc2[10],invertA,invertB,operation,carry[9],0);
ALU_1bit ALU11(tmp_result[11],carry[11],aluSrc1[11],aluSrc2[11],invertA,invertB,operation,carry[10],0);
ALU_1bit ALU12(tmp_result[12],carry[12],aluSrc1[12],aluSrc2[12],invertA,invertB,operation,carry[11],0);
ALU_1bit ALU13(tmp_result[13],carry[13],aluSrc1[13],aluSrc2[13],invertA,invertB,operation,carry[12],0);
ALU_1bit ALU14(tmp_result[14],carry[14],aluSrc1[14],aluSrc2[14],invertA,invertB,operation,carry[13],0);
ALU_1bit ALU15(tmp_result[15],carry[15],aluSrc1[15],aluSrc2[15],invertA,invertB,operation,carry[14],0);
ALU_1bit ALU16(tmp_result[16],carry[16],aluSrc1[16],aluSrc2[16],invertA,invertB,operation,carry[15],0);
ALU_1bit ALU17(tmp_result[17],carry[17],aluSrc1[17],aluSrc2[17],invertA,invertB,operation,carry[16],0);
ALU_1bit ALU18(tmp_result[18],carry[18],aluSrc1[18],aluSrc2[18],invertA,invertB,operation,carry[17],0);
ALU_1bit ALU19(tmp_result[19],carry[19],aluSrc1[19],aluSrc2[19],invertA,invertB,operation,carry[18],0);
ALU_1bit ALU20(tmp_result[20],carry[20],aluSrc1[20],aluSrc2[20],invertA,invertB,operation,carry[19],0);
ALU_1bit ALU21(tmp_result[21],carry[21],aluSrc1[21],aluSrc2[21],invertA,invertB,operation,carry[20],0);
ALU_1bit ALU22(tmp_result[22],carry[22],aluSrc1[22],aluSrc2[22],invertA,invertB,operation,carry[21],0);
ALU_1bit ALU23(tmp_result[23],carry[23],aluSrc1[23],aluSrc2[23],invertA,invertB,operation,carry[22],0);
ALU_1bit ALU24(tmp_result[24],carry[24],aluSrc1[24],aluSrc2[24],invertA,invertB,operation,carry[23],0);
ALU_1bit ALU25(tmp_result[25],carry[25],aluSrc1[25],aluSrc2[25],invertA,invertB,operation,carry[24],0);
ALU_1bit ALU26(tmp_result[26],carry[26],aluSrc1[26],aluSrc2[26],invertA,invertB,operation,carry[25],0);
ALU_1bit ALU27(tmp_result[27],carry[27],aluSrc1[27],aluSrc2[27],invertA,invertB,operation,carry[26],0);
ALU_1bit ALU28(tmp_result[28],carry[28],aluSrc1[28],aluSrc2[28],invertA,invertB,operation,carry[27],0);
ALU_1bit ALU29(tmp_result[29],carry[29],aluSrc1[29],aluSrc2[29],invertA,invertB,operation,carry[28],0);
ALU_1bit ALU30(tmp_result[30],carry[30],aluSrc1[30],aluSrc2[30],invertA,invertB,operation,carry[29],0);
ALU_1bit ALU31(tmp_result[31],carry[31],aluSrc1[31],aluSrc2[31],invertA,invertB,operation,carry[30],0);

and overflow1(tmp1,a_o,b_o,~(result[31]));
nor overflow2(tmp2,a_o,b_o,~(result[31]));
or overflow3(overflow,tmp1,tmp2);

assign zero = (tmp_result == 0)? 1:0;

Full_adder f1(set,trash,carry[30],aluSrc1[31],~aluSrc2[31]);

endmodule
