// Jakob Schaumberger
// 10.10.2025
// Clock Divider


`default_nettype none
`ifndef __PWM_Gen__
`define __PWM_Gen__

module clock_divider 
# (
    parameter BW = 8
)(
    // inputs
    input wire clk_i ,                       // input clk from board
    input wire rst_i,                        // reset
    input wire [BW-1:0] counter_maxVal,      // max Counter Value

    // outputs
    output clk_o                        // output clock
);

// counter value
reg [BW-1:0] counterVal;
reg [BW-1:0] next_counterVal;

reg clk;
reg next_clk;

// register process
always @(posedge clk_i or posedge rst_i) begin  
    if (rst_i == 1'b1) begin
        counterVal <= {BW{1'b0}};;       // reset the counter value
        clk <= 1'b0;      
    end else begin
        counterVal <= next_counterVal;
        clk <= next_clk;
    end
end

// combinatorial process
always @(*) begin
    next_counterVal = counterVal;
    next_clk        = clk;

    if (counterVal >= counter_maxVal) begin
        next_counterVal = {BW{1'b0}};
        next_clk = ~clk;                         // toggle output clock
    end else begin
        next_counterVal = next_counterVal + 1'b1;
    end
end

assign clk_o = clk;

endmodule // clock_divider

`endif
`default_nettype wire