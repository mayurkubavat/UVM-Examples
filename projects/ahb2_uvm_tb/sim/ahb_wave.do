onerror {resume}
radix define HTRANS {
    "2'b00" "IDLE",
    "2'b01" "BUSY",
    "2'b10" "NONSEQ",
    "2'b11" "SEQ",
    -default hexadecimal
}
radix define HBURST {
    "3'b000" "SINGLE",
    "3'b001" "INCR",
    "3'b010" "WRAP4",
    "3'b011" "INCR4",
    "3'b100" "WRAP8",
    "3'b101" "INCR8",
    "3'b110" "WRAP16",
    "3'b111" "INCR16",
    -default hexadecimal
}
radix define HWRITE {
    "1'b0" "READ",
    "1'b1" "WRITE",
    -default hexadecimal
}
radix define HRESP {
    "2'b00" "OKAY",
    "2'b01" "ERROR",
    "2'b10" "RETRY",
    "2'b11" "SPLIT",
    -default hexadecimal
}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /top/intf/HCLK
add wave -noupdate -radix hexadecimal /top/intf/HRESETn
add wave -noupdate -radix hexadecimal /top/intf/HREADY
add wave -noupdate -radix HTRANS /top/intf/HTRANS
add wave -noupdate -radix HBURST /top/intf/HBURST
add wave -noupdate -radix hexadecimal /top/intf/HSIZE
add wave -noupdate -radix HWRITE /top/intf/HWRITE
add wave -noupdate -radix hexadecimal /top/intf/HADDR
add wave -noupdate -radix hexadecimal /top/intf/HWDATA
add wave -noupdate -radix hexadecimal /top/intf/HRDATA
add wave -noupdate -radix HRESP /top/intf/HRESP
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1355 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {4967 ns}
