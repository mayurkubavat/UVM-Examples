# Transfer Type
radix define HTRANS {
2'b00 "IDLE",
2'b01 "BUSY",
2'b10 "NONSEQ",
2'b11 "SEQ",
-default hex
}

# Burst Mode
radix define HBURST {
3'b000 "SINGLE",
3'b001 "INCR",
3'b010 "WRAP4",
3'b011 "INCR4",
3'b100 "WRAP8",
3'b101 "INCR8",
3'b110 "WRAP16",
3'b111 "INCR16",
-default hex
}

# Read - Write
radix define HWRITE {
1'b0 "READ",
1'b1 "WRITE",
-default hex
}

# Response Type
radix define HRESP {
2'b00 "OKAY",
2'b01 "ERROR",
2'b10 "RETRY",
2'b11 "SPLIT",
-default hex
}

