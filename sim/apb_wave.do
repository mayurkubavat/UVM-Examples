onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /top/apb_intf/PCLK
add wave -noupdate -expand -group MDRV_CB -radix hexadecimal /top/apb_intf/mdrv_cb/PRESETn
add wave -noupdate -expand -group MDRV_CB -radix hexadecimal /top/apb_intf/mdrv_cb/PSLVERR
add wave -noupdate -expand -group MDRV_CB -radix hexadecimal /top/apb_intf/mdrv_cb/PRDATA
add wave -noupdate -expand -group MDRV_CB -radix hexadecimal /top/apb_intf/mdrv_cb/PREADY
add wave -noupdate -expand -group MDRV_CB -radix hexadecimal /top/apb_intf/mdrv_cb/PENABLE__o
add wave -noupdate -expand -group MDRV_CB -radix hexadecimal /top/apb_intf/mdrv_cb/PENABLE
add wave -noupdate -expand -group MDRV_CB -radix hexadecimal /top/apb_intf/mdrv_cb/PWRITE
add wave -noupdate -expand -group MDRV_CB -radix hexadecimal /top/apb_intf/mdrv_cb/PPROT
add wave -noupdate -expand -group MDRV_CB -radix hexadecimal /top/apb_intf/mdrv_cb/PSTRB
add wave -noupdate -expand -group MDRV_CB -radix hexadecimal /top/apb_intf/mdrv_cb/PWDATA
add wave -noupdate -expand -group MDRV_CB -radix hexadecimal /top/apb_intf/mdrv_cb/PADDR
add wave -noupdate -expand -group MDRV_CB -radix hexadecimal /top/apb_intf/mdrv_cb/mdrv_cb_event
add wave -noupdate -expand -group MMON_CB -radix hexadecimal /top/apb_intf/mmon_cb/PRESETn
add wave -noupdate -expand -group MMON_CB -radix hexadecimal /top/apb_intf/mmon_cb/PSLVERR
add wave -noupdate -expand -group MMON_CB -radix hexadecimal /top/apb_intf/mmon_cb/PRDATA
add wave -noupdate -expand -group MMON_CB -radix hexadecimal /top/apb_intf/mmon_cb/PREADY
add wave -noupdate -expand -group MMON_CB -radix hexadecimal /top/apb_intf/mmon_cb/PENABLE
add wave -noupdate -expand -group MMON_CB -radix hexadecimal /top/apb_intf/mmon_cb/PWRITE
add wave -noupdate -expand -group MMON_CB -radix hexadecimal /top/apb_intf/mmon_cb/PPROT
add wave -noupdate -expand -group MMON_CB -radix hexadecimal /top/apb_intf/mmon_cb/PSTRB
add wave -noupdate -expand -group MMON_CB -radix hexadecimal /top/apb_intf/mmon_cb/PWDATA
add wave -noupdate -expand -group MMON_CB -radix hexadecimal /top/apb_intf/mmon_cb/PADDR
add wave -noupdate -expand -group MMON_CB -radix hexadecimal /top/apb_intf/mmon_cb/mmon_cb_event
add wave -noupdate -expand -group SDRV_CB -radix hexadecimal /top/apb_intf/sdrv_cb/PSLVERR
add wave -noupdate -expand -group SDRV_CB -radix hexadecimal /top/apb_intf/sdrv_cb/PRDATA
add wave -noupdate -expand -group SDRV_CB -radix hexadecimal /top/apb_intf/sdrv_cb/PREADY__o
add wave -noupdate -expand -group SDRV_CB -radix hexadecimal /top/apb_intf/sdrv_cb/PREADY
add wave -noupdate -expand -group SDRV_CB -radix hexadecimal /top/apb_intf/sdrv_cb/PRESETn
add wave -noupdate -expand -group SDRV_CB -radix hexadecimal /top/apb_intf/sdrv_cb/PENABLE
add wave -noupdate -expand -group SDRV_CB -radix hexadecimal /top/apb_intf/sdrv_cb/PWRITE
add wave -noupdate -expand -group SDRV_CB -radix hexadecimal /top/apb_intf/sdrv_cb/PPROT
add wave -noupdate -expand -group SDRV_CB -radix hexadecimal /top/apb_intf/sdrv_cb/PSTRB
add wave -noupdate -expand -group SDRV_CB -radix hexadecimal /top/apb_intf/sdrv_cb/PWDATA
add wave -noupdate -expand -group SDRV_CB -radix hexadecimal /top/apb_intf/sdrv_cb/PADDR
add wave -noupdate -expand -group SDRV_CB -radix hexadecimal /top/apb_intf/sdrv_cb/sdrv_cb_event
add wave -noupdate -expand -group SMON_CB -radix hexadecimal /top/apb_intf/smon_cb/PRESETn
add wave -noupdate -expand -group SMON_CB -radix hexadecimal /top/apb_intf/smon_cb/PSLVERR
add wave -noupdate -expand -group SMON_CB -radix hexadecimal /top/apb_intf/smon_cb/PRDATA
add wave -noupdate -expand -group SMON_CB -radix hexadecimal /top/apb_intf/smon_cb/PREADY
add wave -noupdate -expand -group SMON_CB -radix hexadecimal /top/apb_intf/smon_cb/PENABLE
add wave -noupdate -expand -group SMON_CB -radix hexadecimal /top/apb_intf/smon_cb/PWRITE
add wave -noupdate -expand -group SMON_CB -radix hexadecimal /top/apb_intf/smon_cb/PPROT
add wave -noupdate -expand -group SMON_CB -radix hexadecimal /top/apb_intf/smon_cb/PSTRB
add wave -noupdate -expand -group SMON_CB -radix hexadecimal /top/apb_intf/smon_cb/PWDATA
add wave -noupdate -expand -group SMON_CB -radix hexadecimal /top/apb_intf/smon_cb/PADDR
add wave -noupdate -expand -group SMON_CB -radix hexadecimal /top/apb_intf/smon_cb/smon_cb_event
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1994 ns} 0}
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
WaveRestoreZoom {0 ns} {2688 ns}
