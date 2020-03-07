
//16bit inverter  
module inv16(A,B);
    
  input [15:0] A;
  output [15:0] B;
  //-- Assign the inverse of the input, to the output
  assign B = ~A;
   
endmodule

//16 bit inverter test module
module main;
reg[15:0] i = 16'hff;
wire[15:0] out ;
inv zap(i, out);
  initial 
    begin
    #10
      $display("Hello, World");
      $display("%h", i);
      $display("%h", out);
      $finish ;
    end

endmodule
