/*
	Description: Sequence Item in UVM environment.
	Author: Mayur Kubavat
	Date: 26 Feb 2015
	Purpose:
	-> Extends uvm_sequence_item base class,
	-> Defies variable items to make transactions.
*/

class sequence_item extends uvm_sequence_item;
   `uvm_object_utils(sequence_item)

   function new(string name = "");
      super.new(name);
   endfunction: new
   
   logic reset;
   logic [31:0] in;
   logic 	in_ready;
   logic 	is_last;
   logic [1:0] 	byte_num;
   logic 	buffer_full;
   logic [511:0] out;
   logic 	 out_ready;
   
	bit [31:0]golden_message[11] = {"The ","quic","k br","own ","fox ","jump","s ov","er t","he l","azy ","dog "};
	
	rand int i;
	constraint i_range {
			i inside {[0:10]};
	}

endclass: sequence_item
