// ============================================================
// EnvelopeGenerator.v
// Simple Attack-Decay envelope for PWM notes
// Last edited: 09.10.2025
// Author: Jakob Schaumberger
// ============================================================

`default_nettype none
`ifndef __ENVELOPE_GEN__
`define __ENVELOPE_GEN__

module EnvelopeGenerator
#(
    parameter BW        = 16,        // Width of PWM counter
    parameter ENV_WIDTH = 6,         // Width of envelope counter
    parameter RAMP_STEPS = 16        // Number of steps in ramp
)
(
    input  wire          clk_i,
    input  wire          rst_i,
    input  wire          note_on_i,    // High when new note starts
    input  wire [BW-1:0] duty_i,       // Raw PWM value (divider or amplitude)

    output reg  [BW-1:0] duty_o        // PWM duty shaped by ramp
);

reg [ENV_WIDTH-1:0] env_counter;
reg note_active;

localparam ENV_MAX = {ENV_WIDTH{1'b1}};

always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        env_counter <= 0;
        note_active <= 0;
        duty_o     <= 0;
    end else begin
        if (note_on_i) begin
            // Start new note
            env_counter <= 0;
            note_active <= 1;
        end else if (note_active) begin
            // Ramp up envelope
            if (env_counter < ENV_MAX) begin
                env_counter <= env_counter + 1'b1;
            end else begin
                // Ramp finished
                note_active <= 0;
            end
        end

        // Scale PWM duty by envelope
        duty_o <= (duty_i * env_counter) >> ENV_WIDTH;
    end
end

endmodule // EnvelopeGenerator

`endif
`default_nettype wire