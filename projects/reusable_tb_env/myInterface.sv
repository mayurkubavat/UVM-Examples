interface myInterface(input bit clock);

   bit sum;
   bit carry;
   bit [2:0] inp;

   clocking drvCb@(posedge clock);
      output inp;
   endclocking

   clocking monCb@(posedge clock);
      input inp;

      input sum;
      input carry;
   endclocking

endinterface
