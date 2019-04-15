module Shifter( result, leftRight, shamt, sftSrc );

//I/O ports 
output	[32-1:0] result;

input			leftRight;
input	[5-1:0] shamt;
input	[32-1:0] sftSrc ;

//Internal Signals
wire	[32-1:0] result;
  
//Main function
/*your code here*/
wire [31:0]right,left;
wire counter;
assign right = sftSrc>>shamt;
assign left = sftSrc<<shamt;
assign result = (leftRight == 1)? left:right;

endmodule