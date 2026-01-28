`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Matt Hurst
// 
// Create Date: 01/27/2026 12:41:39 PM
// Module Name: divider.v
// Project Name: Configurable clock divider
// Description:  Configurable clock divider to accept a clock signal and divide it
//               by 2, 4, 8, 16, or 32. The divider is counter-driven.
//
// Inputs:
//  - clk_inp:      Original clock signal
//  - rst:          Reset signal (must be pulsed high to get hardware in known state)
//  - en:           Enable pin must be held high for divider to operate.
//  - config_div:   7-bit wide input to give the division factor
// Outputs:
//  - clk_out:             Divided clock signal.
//  - counter_store_debug: Debug counter to show number of original clock rising
//                         edges in current iteration.
// Revision 1.0
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_divider(
    input clk_inp,
    output reg clk_out,
    input rst,
    input en,
    input [6:0] config_div,            // 7 bits wide to accept up to /64
    output [5:0] counter_store_debug   // 6 bits wide to count up to 32 (need to count up to max divide value (64) / 2 = 32)
    );
    
reg [6:0] config_div_store;
reg [5:0] counter_store;

assign counter_store_debug = counter_store;

always @(posedge clk_inp or posedge rst)
begin
    if (rst)
    begin
        clk_out <= 0;
        config_div_store <= config_div >> 1; // Divide by 2 to get number of rising edges before clock output
                                             // Could leave as is, and track total edges, but this was simpler
        counter_store <= 0;
    end
    else if (en)
    begin
        if (counter_store == (config_div_store - 1))
        begin
            clk_out <= ~clk_out;
            counter_store <= 0;
        end
        else
        begin
            counter_store <= counter_store + 1;
        end
    end
end

endmodule
