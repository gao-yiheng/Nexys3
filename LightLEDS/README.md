# PicoBlaze_LED
Get started with PicoBlaze running on Xilinx Spartan-6 (Nexys3 FPGA board) to light LEDs

===============================================================================

kcpsm6.v ---> source code implemented PicoBlaze, Xilinx provide

led_prog.v -> instruction memory that store instruction PicoBlaze need to execute led_top.v --> top module for the project

led_tb.v ---> testbench to test previous code with simulation tool

Nexys3_master.ucf ---> files connect your design I/O into board source. Needed when generating bit file

led_prog.psm ---> assembly code to implement specific function

===============================================================================

More information refers to 
