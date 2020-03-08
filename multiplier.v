//todo: 
//  -reconcile differences with the adders
//  -replace the n-bit adders with adders or proper size
//  -create actual test module

//2x2 multiplier
module mult2(out, in1, in2);
  input [1:0] in1, in2;
  output [3:0] out;
  wire[1:0] holdAnd1, holdAnd2, holdAnd3, holdCarry1;
  and and1(out[0], in1[0], in2[0]),
    and2(holdAnd1, in1[1], in2[0]),
    and3(holdAnd2, in1[0], in2[0]),
    and4(holdAnd3, in1[1], in2[1]);

  //sum needs to go to out[1], carry needs to go to hold
  halfAdder ha1(out[1], holdCarry1, holdAnd1, holdAnd2),
    //sum goes to out[2], carry goes to out[3]
    ha2(out[2], out[3], holdCarry1, holdAnd3);
endmodule

//4x4 multiplier
module mult4(in1, in2, out);
  input [3:0] in1, in2;
  output [7:0] out;
  wire[3:0] holdMult1, holdMult2, holdMult3, holdMult4; 
  wire[5:0] holdAdd1, holdAdd2, operand1, operand2, operand3;

  mult2 multi1(holdMult1, in2[3:2], in1[3:2]),
    multi2(holdMult2, in2[1:0], in1[3:2]),
    multi3(holdMult3, in2[3:2], in2[1:0]),
    multi4(holdMult4, in2[1:0], in2[1:0]);


  assign operand1 = {holdMult1,2'b0};
  assign operand2 = {2'b0, holdMult2};
  assign operand3 = {2'b0, holdMult4[3:2]}
  //need 6 bit adder here -step3
  add6 adder1(holdAdd1, operand1, operand2);

  //4 bit adder here -step7
  add4 adder2(holdAdd2, holdMult3, operand3);

  //adder of n size here
  addn adder3(out[7:2], holdAdd1, holdAdd2);
  assign out[1:0] = holdMult4[1:0];



endmodule


//8x8 multiplier
module mult8(in1, in2, out);
  input [7:0] in1, in2;
  output [15:0] out;
  wire[7:0] holdMult1, holdMult2, holdMult3, holdMult4; 
  wire[12:0] holdAdd1, holdAdd2, operand1, operand2, operand3;

  mult4 multi1(holdMult1, in2[7:4], in1[7:4]),
    multi2(holdMult2, in2[7:4], in1[3:0]),
    multi3(holdMult3, in2[3:0], in2[7:4]),
    multi4(holdMult4, in2[3:0], in2[3:0]);


  assign operand1 = {holdMult1,4'b0};
  assign operand2 = {4'b0, holdMult2};
  assign operand3 = {4'b0, holdMult4[7:4]}
  //need 12 bit adder here -step3
  add6 adder1(holdAdd1, operand1, operand2);

  //8 bit adder here -step7
  add4 adder2(holdAdd2, holdMult3, operand3);

  //adder of n size here
  addn adder3(out[15:4], holdAdd1, holdAdd2);
  assign out[3:0] = holdMult4[3:0];

endmodule



//16x16 multiplier
module mult16(in1, in2, out);
  input [15:0] in1, in2;
  output [31:0] out;
  wire[15:0] holdMult1, holdMult2, holdMult3, holdMult4; 
  wire[24:0] holdAdd1, holdAdd2, operand1, operand2, operand3;

  mult4 multi1(holdMult1, in2[15:8], in1[15:8]),
    multi2(holdMult2, in2[15:8], in1[7:0]),
    multi3(holdMult3, in2[7:0], in2[15:8]),
    multi4(holdMult4, in2[7:0], in2[7:0]);


  assign operand1 = {holdMult1,8'b0};
  assign operand2 = {8'b0, holdMult2};
  assign operand3 = {8'b0, holdMult4[15:8]}
  //need 12 bit adder here -step3
  add6 adder1(holdAdd1, operand1, operand2);

  //8 bit adder here -step7
  add4 adder2(holdAdd2, holdMult3, operand3);

  //adder of n size here
  addn adder3(out[31:8], holdAdd1, holdAdd2);
  assign out[7:0] = holdMult4[7:0];

endmodule


//16x16 multiplier test module
  //INCOMPLETE
module main;
reg[15:0] i = 16'hff;
wire[15:0] out ;
inv16 zap(i, out);
  initial 
    begin
    #10
      $display("Hello, World");
      $display("%h", i);
      $display("%h", out);
      $finish ;
    end

endmodule
