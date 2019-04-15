module Shifter( result, leftRight, shamt, sftSrc  );
    
  output wire[31:0] result;

  input wire leftRight;
  input wire[4:0] shamt;
  input wire[31:0] sftSrc ;
  
  /*your code here*/ 
wire [31:0]right,left;
wire counter;
assign right = sftSrc>>shamt;
assign left = sftSrc<<shamt;
assign result = (leftRight == 1)? left:right;
endmodule