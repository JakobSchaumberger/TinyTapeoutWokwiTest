// ============================================================
// NotesRom.v
// Notes for playing the 'Super Mario Theme'
// Last edited: 14.10.2025
// Author: Jakob Schaumberger
// ============================================================


`default_nettype none
`ifndef __NOTES_ROM__
`define __NOTES_ROM__

module NotesRom
# (
    parameter BW = 16
)(
    input wire [5:0]    note_index_i,       // 16 possible notes
    output reg [BW-1:0] divider_value_o
);

// combinatorial logic
always @(*) begin
    case(note_index_i)
    //     // 4'd0: divider_value_o = 16'd9105;       // E5
    //     // 4'd1: divider_value_o = 16'd11472;      // C5
    //     // 4'd2: divider_value_o = 16'd7658;       // G5
    //     // 4'd3: divider_value_o = 16'd15306;      // G4
    //     // 4'd4: divider_value_o = 16'd18200;      // E4
    //     // 4'd5: divider_value_o = 16'd13636;      // A4
    //     // 4'd6: divider_value_o = 16'd12151;      // B4
    //     // 4'd7: divider_value_o = 16'd12874;      // A#4
    //     // 4'd8: divider_value_o = 16'd11474;      // C6
    //     // 4'd9: divider_value_o = 16'd9105;       // E5 (extension)
    //     // 4'd10: divider_value_o = 16'd7658;      // G5
    //     // 4'd11: divider_value_o = 16'd6820;      // A5
    //     // 4'd12: divider_value_o = 16'd7644;      // F5
    //     // 4'd13: divider_value_o = 16'd7658;      // G5
    //     // 4'd14: divider_value_o = 16'd9105;      // E5
    //     // 4'd15: divider_value_o = 16'd0;         // no tone

    //     // default: divider_value_o = 16'd0;       // no tone

         // Phrase 1
        6'd0:  divider_value_o = 16'd12100; // E4
        6'd1:  divider_value_o = 16'd12100; // E4
        6'd2:  divider_value_o = 16'd14400; // G4
        6'd3:  divider_value_o = 16'd14400; // G4
        6'd4:  divider_value_o = 16'd10800; // D4
        6'd5:  divider_value_o = 16'd10800; // D4
        6'd6:  divider_value_o = 16'd12100; // E4
        6'd7:  divider_value_o = 16'd12100; // E4
        6'd8:  divider_value_o = 16'd14400; // G4
        6'd9:  divider_value_o = 16'd14400; // G4
        6'd10: divider_value_o = 16'd10800; // D4
        6'd11: divider_value_o = 16'd10800; // D4
        6'd12: divider_value_o = 16'd9600;  // C4
        6'd13: divider_value_o = 16'd9600;  // C4
        6'd14: divider_value_o = 16'd12100; // E4
        6'd15: divider_value_o = 16'd12100; // E4

        // Phrase 2
        6'd16: divider_value_o = 16'd14400; // G4
        6'd17: divider_value_o = 16'd14400; // G4
        6'd18: divider_value_o = 16'd10800; // D4
        6'd19: divider_value_o = 16'd10800; // D4
        6'd20: divider_value_o = 16'd12100; // E4
        6'd21: divider_value_o = 16'd12100; // E4
        6'd22: divider_value_o = 16'd14400; // G4
        6'd23: divider_value_o = 16'd14400; // G4
        6'd24: divider_value_o = 16'd10800; // D4
        6'd25: divider_value_o = 16'd10800; // D4
        6'd26: divider_value_o = 16'd9600;  // C4
        6'd27: divider_value_o = 16'd9600;  // C4
        6'd28: divider_value_o = 16'd12100; // E4
        6'd29: divider_value_o = 16'd12100; // E4
        6'd30: divider_value_o = 16'd14400; // G4
        6'd31: divider_value_o = 16'd14400; // G4

        // Phrase 3
        6'd32: divider_value_o = 16'd10800; // D4
        6'd33: divider_value_o = 16'd10800; // D4
        6'd34: divider_value_o = 16'd12100; // E4
        6'd35: divider_value_o = 16'd12100; // E4
        6'd36: divider_value_o = 16'd14400; // G4
        6'd37: divider_value_o = 16'd14400; // G4
        6'd38: divider_value_o = 16'd10800; // D4
        6'd39: divider_value_o = 16'd10800; // D4
        6'd40: divider_value_o = 16'd12100; // E4
        6'd41: divider_value_o = 16'd12100; // E4
        6'd42: divider_value_o = 16'd14400; // G4
        6'd43: divider_value_o = 16'd14400; // G4
        6'd44: divider_value_o = 16'd10800; // D4
        6'd45: divider_value_o = 16'd10800; // D4
        6'd46: divider_value_o = 16'd9600;  // C4
        6'd47: divider_value_o = 16'd9600;  // C4

        // Phrase 4
        6'd48: divider_value_o = 16'd12100; // E4
        6'd49: divider_value_o = 16'd12100; // E4
        6'd50: divider_value_o = 16'd14400; // G4
        6'd51: divider_value_o = 16'd14400; // G4
        6'd52: divider_value_o = 16'd10800; // D4
        6'd53: divider_value_o = 16'd10800; // D4
        6'd54: divider_value_o = 16'd0;     // Silence
        6'd55: divider_value_o = 16'd0;     // Silence
        6'd56: divider_value_o = 16'd0;     // Silence
        6'd57: divider_value_o = 16'd0;     // Silence
        6'd58: divider_value_o = 16'd0;     // Silence
        6'd59: divider_value_o = 16'd0;     // Silence
        6'd60: divider_value_o = 16'd0;     // Silence
        6'd61: divider_value_o = 16'd0;     // Silence
        6'd62: divider_value_o = 16'd0;     // Silence
        6'd63: divider_value_o = 16'd0;     // Silence

        default: divider_value_o = 16'd0;
    endcase
end

endmodule   // NotesRom

`endif
`default_nettype wire