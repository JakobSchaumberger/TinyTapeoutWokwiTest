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
    parameter BW = 24,               // Width of PWM counter
    parameter ENV_WIDTH = 8,         // Width of envelope counter
    parameter ATTACK_RATE = 8'd200,  // Smaller = faster attack
    parameter RELEASE_RATE = 8'd100  // Smaller = faster release
)
(
    input  wire          clk_i,
    input  wire          rst_i,
    input  wire          note_on_i,    // High when new note is active
    input  wire [BW-1:0] duty_i,       // Raw PWM amplitude or divider

    output reg  [BW-1:0] duty_o        // Envelope-shaped PWM amplitude
);

reg [ENV_WIDTH-1:0] env_level;  
reg [7:0] rate_cnt;              

// combinatorial signals
reg [ENV_WIDTH-1:0] next_env_level;
reg [7:0] next_rate_cnt;
reg [BW-1:0]      next_duty_o;

localparam ENV_MAX = {ENV_WIDTH{1'b1}};

// combinatorial process
always @(*) begin
    // default assignments
    next_env_level = env_level;
    next_rate_cnt  = rate_cnt;
    next_duty_o    = (duty_i * env_level) >> ENV_WIDTH;

    // envelope timing
    if (note_on_i) begin
        // Attack phase
        if (rate_cnt >= ATTACK_RATE) begin
            next_rate_cnt = 0;
            if (env_level < ENV_MAX)
                next_env_level = env_level + 1'b1;
        end else begin
            next_rate_cnt = rate_cnt + 1'b1;
        end
    end else begin
        // Release phase
        if (rate_cnt >= RELEASE_RATE) begin
            next_rate_cnt = 0;
            if (env_level > 0)
                next_env_level = env_level - 1'b1;
        end else begin
            next_rate_cnt = rate_cnt + 1'b1;
        end
    end
end

// register process
always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        env_level <= 0;
        rate_cnt  <= 0;
        duty_o    <= 0;
    end else begin
        env_level <= next_env_level;
        rate_cnt  <= next_rate_cnt;
        duty_o    <= next_duty_o;
    end
end

endmodule // EnvelopeGenerator

`endif
`default_nettype wire