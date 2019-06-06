# PicoBlaze & Seven-Segment
Read 8-bit input, split into two numbers ([7:4], [3:0]), add them and output result with PicoBlaze
Display 8-bit result as decimal in seven-segment with verilog code

===============================================================================

kcpsm6.v ---> source code implemented PicoBlaze, Xilinx provide

seg7_prog.v -> instruction memory that store instruction PicoBlaze need to execute led_top.v --> top module for the project

top_module.v --> top module for the project

bcd_display.v ---> module for displaying add result output by PicoBlaze

number_decoder.v ---> translate 8-bit input as decimal

seg7_decoder.v   ---> translate a number into 8-bit data to light seven-segment

tb_top_module.v ---> testbench to test previous code with simulation tool

Nexys3_master.ucf ---> files connect your design I/O into board source. Needed when generating bit file

seg7_prog.psm ---> assembly code to implement specific function

===============================================================================

More information refers to
