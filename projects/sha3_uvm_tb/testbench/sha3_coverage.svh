class sha3_coverage extends uvm_subscriber #(sequence_item);
	`uvm_component_utils(sha3_coverage)

	
	sequence_item item_h;
	sequence_item write_item_h;
	
	covergroup sha3_cov;
	option.per_instance = 1;
		RST: coverpoint write_item_h.reset {bins r[] = {0, 1};}
		IN: coverpoint write_item_h.in {option.auto_bin_max = 40;}
		IN_RDY: coverpoint write_item_h.in_ready {bins ir[] = {0, 1};}
		IS_LST: coverpoint write_item_h.is_last {bins il[] = {0, 1};}
		BYT_NUM: coverpoint write_item_h.byte_num {bins bn[] = {0, 1};}
		BUF_FUL: coverpoint item_h.buffer_full {bins bf[] = {0, 1};}
		OUT: coverpoint item_h.out {option.auto_bin_max = 40;}
		OUT_RDY: coverpoint item_h.out_ready {bins ordy[] = {0, 1};}
	endgroup: sha3_cov
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
		item_h = new();
		write_item_h = new();
		sha3_cov = new();
	endfunction: new
	
	function void write(sequence_item t);
		write_item_h.reset = t.reset;
		write_item_h.in = t.in;
		write_item_h.in_ready = t.in_ready;
		write_item_h.is_last = t.is_last;
		write_item_h.byte_num = t.byte_num;
		item_h.buffer_full = t.buffer_full;
		item_h.out = t.out;
		item_h.out_ready = t.out_ready;
		
		sha3_cov.sample();
	endfunction: write
	
endclass: sha3_coverage