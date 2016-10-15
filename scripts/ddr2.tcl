set design_name ddr2_controller ;
set clk_period 2.0;
set posedge 0.0;
set negedge [expr $clk_period * 0.5];

analyze -f verilog ./design/SSTL18DDR2.v;
analyze -f verilog ./design/SSTL18DDR2DIFF.v;
analyze -f verilog ./design/SSTL18DDR2INTERFACE.v;
analyze -f verilog ./design/FIFO.v;
analyze -f verilog ./design/ddr2_init_engine.v;

read_verilog ./design/ddr2_controller.v > ./report/read.report;

current_design $design_name ;

get_libs;

set_dont_use gscl45nm/DFFPOSX1;

# If you have multiple instances of the same module,
# use this so that DesignCompiler optimizea each instance separately
uniquify ;

# Linking your design into the cells in standard cell libraries.
# This command checks whether your design can be compiled
# with the target libraries specified in the .synopsys_dc.setup file.
link ;