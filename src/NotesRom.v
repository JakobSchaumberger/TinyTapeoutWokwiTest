// ============================================================
// NotesRom.v
// Notes for playing the 'Super Mario Theme'
// Last edited: 09.11.2025
// Author: Jakob Schaumberger
// ============================================================


`default_nettype none
`ifndef __NOTES_ROM__
`define __NOTES_ROM__

module NotesRom
# (
    parameter BW = 16
)(
    input wire [5:0]    note_index_i,       // 64 possible notes
    output reg [BW-1:0] divider_value_o
);

always @(*) begin
    case(note_index_i)
        6'd0:  divider_value_o = 24'd9097;   // E5
        6'd1:  divider_value_o = 24'd9097;   // E5
        6'd2:  divider_value_o = 24'd0;      // rest
        6'd3:  divider_value_o = 24'd9097;   // E5
        6'd4:  divider_value_o = 24'd0;
        6'd5:  divider_value_o = 24'd11465;  // C5
        6'd6:  divider_value_o = 24'd9097;   // E5
        6'd7:  divider_value_o = 24'd0;
        6'd8:  divider_value_o = 24'd7648;   // G5
        6'd9:  divider_value_o = 24'd0;
        6'd10: divider_value_o = 24'd0;
        6'd11: divider_value_o = 24'd15306;  // G4
        6'd12: divider_value_o = 24'd0;
        6'd13: divider_value_o = 24'd0;
        6'd14: divider_value_o = 24'd11465;  // C5
        6'd15: divider_value_o = 24'd15306;  // G4
        6'd16: divider_value_o = 24'd18196;  // E4
        6'd17: divider_value_o = 24'd0;
        6'd18: divider_value_o = 24'd0;
        6'd19: divider_value_o = 24'd13636;  // A4
        6'd20: divider_value_o = 24'd12151;  // B4
        6'd21: divider_value_o = 24'd12873;  // Bb4
        6'd22: divider_value_o = 24'd13636;  // A4
        6'd23: divider_value_o = 24'd0;
        6'd24: divider_value_o = 24'd15306;  // G4
        6'd25: divider_value_o = 24'd9097;   // E5
        6'd26: divider_value_o = 24'd7648;   // G5
        6'd27: divider_value_o = 24'd6818;   // A5
        6'd28: divider_value_o = 24'd0;
        6'd29: divider_value_o = 24'd8591;   // F5
        6'd30: divider_value_o = 24'd7648;   // G5
        6'd31: divider_value_o = 24'd0;
        6'd32: divider_value_o = 24'd9097;   // E5
        6'd33: divider_value_o = 24'd0;
        6'd34: divider_value_o = 24'd11465;  // C5
        6'd35: divider_value_o = 24'd10213;  // D5
        6'd36: divider_value_o = 24'd12151;  // B4
        6'd37: divider_value_o = 24'd0;
        6'd38: divider_value_o = 24'd0;
        6'd39: divider_value_o = 24'd11465;  // C5
        6'd40: divider_value_o = 24'd15306;  // G4
        6'd41: divider_value_o = 24'd18196;  // E4
        6'd42: divider_value_o = 24'd13636;  // A4
        6'd43: divider_value_o = 24'd0;
        6'd44: divider_value_o = 24'd13636;  // A4
        6'd45: divider_value_o = 24'd13636;  // A4
        6'd46: divider_value_o = 24'd0;
        6'd47: divider_value_o = 24'd15306;  // G4
        6'd48: divider_value_o = 24'd0;
        6'd49: divider_value_o = 24'd0;
        6'd50: divider_value_o = 24'd9097;   // E5
        6'd51: divider_value_o = 24'd11465;  // C5
        6'd52: divider_value_o = 24'd12151;  // B4
        6'd53: divider_value_o = 24'd13636;  // A4
        6'd54: divider_value_o = 24'd15306;  // G4
        6'd55: divider_value_o = 24'd7648;   // G5
        6'd56: divider_value_o = 24'd9097;   // E5
        6'd57: divider_value_o = 24'd0;
        6'd58: divider_value_o = 24'd11465;  // C5
        6'd59: divider_value_o = 24'd12151;  // B4
        6'd60: divider_value_o = 24'd13636;  // A4
        6'd61: divider_value_o = 24'd15306;  // G4
        6'd62: divider_value_o = 24'd0;
        6'd63: divider_value_o = 24'd0;

        default: divider_value_o = 24'd0;
    endcase
end

endmodule   // NotesRom

`endif
`default_nettype wire