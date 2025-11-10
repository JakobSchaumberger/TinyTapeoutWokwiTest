// ============================================================
// tt_um_tinytone.v
// TinyTapeout Sound Generator
// Author: Jakob Schaumberger
// Last edited: 09.11.2025
// ============================================================

`include "StrobeGenerator.v"
`include "NotesRom.v"
`include "SequenceCounter.v"
`include "PwmModulator.v"

`default_nettype none
`ifndef __TT_UM_TINYTONE__
`define __TT_UM_TINYTONE__

module tt_um_tinytone
# (
    parameter [23:0] NOTE_DURATION = 24'd2400000   // Strobe period ~0.25s
)
(
    // inputs
    input wire clk,                     // input clock
    input wire ena,                     // input enable          
    input wire rst_n,                   // input reset_n (active low)
    input wire [7:0] ui_in,             // Dedicated inputs 
    input wire [7:0] uio_in,            // IOs: Input path

    // outputs
    output wire [7:0] uio_oe,           // IOs: Enable path (active high: 0=input, 1=output)
    output wire [7:0] uo_out,           // Dedicated outputs
    output wire [7:0] uio_out           // IOs: Output path

);

//wire rst = ~rst_n;
wire rst = 0;

wire sound_o;
wire strb;
wire [23:0] divider_value;
wire[5:0] note_index;

// assign outputs
assign uo_out  = {7'b0000000, sound_o};
assign uio_out = 0;                         // unused outputs
assign uio_oe  = 0;

// List all unused inputs to prevent warnings
wire _unused = &{ena, 1'b0};

// ------------------------------------------------------------
// Strobe generator
// ------------------------------------------------------------
StrbGenerator #(
    .BW(24)
) u_strbGen (
    .clk_i(clk),
    .rst_i(rst),
    .counter_maxVal(NOTE_DURATION),
    .strb_o(strb)
);

// ------------------------------------------------------------
// Notes ROM
// ------------------------------------------------------------
NotesRom #(
    .BW(16)
) u_notesRom (
    .note_index_i(note_index),
    .divider_value_o(divider_value)
);

// ------------------------------------------------------------
// Sequence counter
// ------------------------------------------------------------
SequenceCounter #(
    .BW(6),
    .SEQ_LEN(64)
) u_sequenceCounter (
    .clk_i(clk),
    .rst_i(rst),
    .strb_i(strb),
    .noteIndex_o(note_index)
);

// ------------------------------------------------------------
// PWM modulator
// ------------------------------------------------------------
PwmModulator #(
    .BW(16)
) u_pwmModulator (
    .clk_i(clk),
    .rst_i(rst),
    .period_i(divider_value),
    .dutyCycle_i(divider_value >> 1),

    .pwm_o(sound_o)
);

endmodule   // SoundGenerator

`endif
`default_nettype wire