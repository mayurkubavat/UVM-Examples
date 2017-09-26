module full_adder(output sum, carry, input [2:0] inp);
   
   assign{carry, sum} = inp[2] + inp[1] + inp[0];

endmodule
