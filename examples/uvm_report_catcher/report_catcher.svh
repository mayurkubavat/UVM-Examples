class report_catcher extends uvm_report_catcher;

   local string demoted_messages[$];

   function new(string name);
      super.new(name);
   endfunction


   function action_e catch();

      /* 
      if(get_severity() == UVM_ERROR && get_id() == "MYENV")
         set_severity(UVM_INFO);
      */

      if(get_severity() == UVM_ERROR)
      begin
         string my_message = get_message();

         foreach(demoted_messages[msg])
         begin
            if(uvm_re_match(demoted_messages[msg], my_message) == 0)
            begin
               $display("Changing severity of message [%s]", my_message);
               set_severity(UVM_INFO);
            end
         end
      end

      return THROW;
   endfunction


   // Store messages to be demoted in regex/ full string
   function void demote_message(string d_message);
      demoted_messages.push_back(d_message);
   endfunction

endclass

