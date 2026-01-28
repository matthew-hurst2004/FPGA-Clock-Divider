`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Matt Hurst
// 
// Create Date: 01/27/2026 12:41:39 PM
// Module Name: divider.v
// Project Name: Configurable clock divider (TESTBENCH)
// Description:  Testbench for configurable clock divider. Goes through a standard
//               startup sequence and pulses a clock source into the DUT. Defaults
//               to using 50 MHz frequency, but can be changed by changing the
//               pulse delays. The dividing factor can also be changed in the
//               clock_divider instantiation.
//
// Revision 1.0
// 
//////////////////////////////////////////////////////////////////////////////////


module divider_tb();

reg  clk_inp;   // Clock sent to the DUT
reg  rst;       // Reset sent to the DUT
reg  en;        // Enable line to DUT
wire clk_out;   // Clock coming from the DUT
wire [5:0] debug_counter; // Count rising edges of the clock source

reg tb_clock_enable = 0;

clock_divider divider(
    .rst(rst),
    .clk_inp(clk_inp),
    .clk_out(clk_out),
    .config_div(16),
    .en(en),
    .counter_store_debug(debug_counter)
);

initial
begin
clk_inp = 0;
en = 0;
rst = 1;
#5;
rst = 0; // After this, the config_div can be cleared (pulsing reset stores the value in a register)
#10;
en = 1;
#5;
tb_clock_enable = 1;
#1000 $finish;
end

always @(posedge tb_clock_enable) begin
    forever #10 clk_inp = ~clk_inp;  // clock toggling starts only after enable
end

endmodule
