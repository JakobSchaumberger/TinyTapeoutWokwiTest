// ============================================================
// SoundGenerator.v
// TinyTapeout Sound Generator
// Author: Jakob Schaumberger
// Last edited: 14.10.2025
// ============================================================

`include "StrobeGenerator.v"
`include "NotesRom.v"
`include "SequenceCounter.v"
`include "PwmModulator.v"

`default_nettype none
`ifndef __SOUND_GENERATOR__
`define __SOUND_GENERATOR__

module SoundGenerator
# (
    parameter [7:0]  BW     = 24,           // Bit witdh for counters
    parameter [23:0] FS     = 24'd125,      // PWM-Period value (~20kHz)
    parameter [23:0] FS_MAX = 24'd2400000   // Strobe period ~0.25s
)
(
    // inputs
    input wire clk_i,                       // input clock
    input wire en_i,                        // input enable          
    input wire rst_n_i,                     // input reset_n (active low)
    input wire [7:0] switches_i,            // inputs connected to switches
    input wire [7:0] inputs_i,              // inputs connected to Pin-Header

    // outputs
    output wire [7:0] display_o,            // outputs connect to 7-segment-display
    output wire [7:0] outputs_o             // outputs connected to Pin-Header

);

//wire rst = ~rst_n_i;
wire rst = 0;

wire sound_o;
wire strb;
wire [23:0] divider_value;
wire[5:0] note_index;

// assign outputs
assign outputs_o = {7'b0000000, sound_o};
assign display_o = 8'b00000000;             // unused outputs

StrbGenerator #(
    .BW(24)
) u_strbGen (
    .clk_i(clk_i),
    .rst_i(rst),
    .counter_maxVal(FS_MAX),
    .strb_o(strb)
);

NotesRom #(
    .BW(16)
) u_notesRom (
    .note_index_i(note_index),
    .divider_value_o(divider_value)
);

SequenceCounter #(
    .BW(6),
    .SEQ_LEN(64)
) u_sequenceCounter (
    .clk_i(clk_i),
    .rst_i(rst),
    .strb_i(strb),
    .noteIndex_o(note_index)
);

PwmModulator #(
    .BW(24)
) u_pwmModulator (
    .clk_i(clk_i),
    .rst_i(rst),
    .period_i(divider_value),
    .dutyCycle_i(divider_value>>1),

    .pwm_o(sound_o)
);

endmodule   // SoundGenerator

`endif
`default_nettype wire