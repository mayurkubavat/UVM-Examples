interface apb_if(input PCLK);
  logic PRESETn;

  logic [31:0] PADDR;
  logic [31:0] PWDATA;
  logic [31:0] PRDATA;
  logic [2:0]  PPROT;
  logic [3:0]  PSTRB;
  logic        PWRITE;
  logic        PENABLE;
  logic        PREADY;
  logic        PSLVERR;

  clocking mdrv_cb @(posedge PCLK);
    default input #1 output #0;
    output  PADDR;
    output  PWDATA;
    output  PSTRB;
    output  PPROT;
    output  PWRITE;
    inout   PENABLE;
    input   PREADY;
    input   PRDATA;
    input   PSLVERR;
  endclocking

  clocking mmon_cb @(posedge PCLK);
    default input #1 output #0;
    input PADDR;
    input PWDATA;
    input PSTRB;
    input PPROT;
    input PWRITE;
    input PENABLE;
    input PREADY;
    input PRDATA;
    input PSLVERR;
  endclocking

  clocking sdrv_cb @(posedge PCLK);
    default input #1 output #0;
    input  PADDR;
    input  PWDATA;
    input  PSTRB;
    input  PPROT;
    input  PWRITE;
    input  PENABLE;
    inout  PREADY;
    output PRDATA;
    output PSLVERR;
  endclocking

  clocking smon_cb @(posedge PCLK);
    default input #1 output #0;
    input PADDR;
    input PWDATA;
    input PSTRB;
    input PPROT;
    input PWRITE;
    input PENABLE;
    input PREADY;
    input PRDATA;
    input PSLVERR;
  endclocking

  modport MDRV_MP(clocking mdrv_cb, input PRESETn);
  modport MMON_MP(clocking mmon_cb, input PRESETn);
  modport SDRV_MP(clocking sdrv_cb, input PRESETn);
  modport SMON_MP(clocking smon_cb, input PRESETn);

endinterface: apb_if

