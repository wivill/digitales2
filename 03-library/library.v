`timescale 1ns/1ps
`include "definitions.v"
//=============================================================================
//=============================================================================
module nand_cell (oNand, iA, iB);

output                        oNand;
input                         iA, iB;

nand #(16:23))(oNand,iA,iB);

endmodule // nand
//=============================================================================
//=============================================================================
module nor_cell (oNor, iA, iB);

output                        oNor;
input                         iA, iB;

nor G1 #(8:16)(oNor,iA,iB);

endmodule // nor
//=============================================================================
//=============================================================================
module not_cell (oNot, iA);

output                        oNot;
input                         iA;

not G1 #(3:10)(oNot,iA);

endmodule // not
//=============================================================================
//=============================================================================
module mux (oMux, iA, iB, iSel, iEnb);

output reg                    oMux;
input wire                        iA, iB, iSel, iEnb;

always @ ( * ) begin
  if (~iEnb) begin
    case (iSel)
      1'b0:
      begin
      #(13:25)  oMux <= iA;
      end
      1'b1:
      begin
      #(13:25)  oMux <= iB;
      end
      default:
      begin
        oMux <= 1'b0;
      end
    endcase
  end else begin
    #(16:23) oMux <= 1'b0;
  end
end

endmodule
//=============================================================================
//=============================================================================
module ffd (iClr, iPre, iClk, iD, oQ, oQn);
  output reg                oQ, oQn;
  input wire                iClr, iPre, iClk, iD;

  always @ ( posedge iClk ) begin
    if (~iClr) begin
      case ({iPre})
        1'b0:
        begin
          oQ <= 1'b0;
        end
        1'b1:
        begin
          oQ <= 1'b0;
        end
        default:
        begin
          oQ <= 1'b0;
        end
      endcase
    end else begin
      oQ <= 1'b0;
      oQn <= 1'b1;
    end
  end

endmodule // ffd

//=============================================================================
//=============================================================================
