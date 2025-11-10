// ============================================================
// tt_um_tinytone.v
// Tiny Tapeout SKY 25b, tt-tinytone
// Description: 
//      Generates a PWM audio output from a sequence of 
//      64 notes. 
//      Plays the 'Super Mario Bros.' theme song on a piezo 
//      buzzer.
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

wire rst = ~rst_n;

wire sound_o;
wire strb;
wire [15:0] dividerValue;
wire [5:0]  noteIndex;

// assign outputs
assign uo_out  = {7'b0000000, sound_o};
assign uio_out = 0;                         // unused outputs
assign uio_oe  = 0;

// List all unused inputs to prevent warnings
wire _unused = &{1'b0, ui_in, uio_in, ena};

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
    .noteIndex_i(noteIndex),
    .dividerValue_o(dividerValue)
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
    .noteIndex_o(noteIndex)
);

// ------------------------------------------------------------
// PWM modulator
// ------------------------------------------------------------
PwmModulator #(
    .BW(16)
) u_pwmModulator (
    .clk_i(clk),
    .rst_i(rst),
    .period_i(dividerValue),
    .dutyCycle_i(dividerValue >> 1),

    .pwm_o(sound_o)
);

endmodule   // SoundGenerator

`endif
`default_nettype wire
