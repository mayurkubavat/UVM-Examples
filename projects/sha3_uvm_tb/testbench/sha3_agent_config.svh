class sha3_agent_config;

   uvm_active_passive_enum is_active;

   function new (uvm_active_passive_enum is_active);
      this.is_active = is_active;
   endfunction : new

   function uvm_active_passive_enum get_is_active();
      return is_active;
   endfunction : get_is_active
   
endclass : sha3_agent_config
