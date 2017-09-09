`timescale 1ns/1ps
`include "definitions.v"
//=============================================================================
//=============================================================================
module nand_cell (oNand, iA, iB);

  output                        oNand;
  input                         iA, iB;

  nand #(27) G1(oNand,iA,iB);

  specify
    specparam t_rise = 6;
    specparam t_fall = 6;

    (iA => oNand) = (t_rise, t_fall);
    (iB => oNand) = (t_rise, t_fall);
  endspecify


endmodule // nand
//=============================================================================
//=============================================================================
module nor_cell (oNor, iA, iB);

  output                        oNor;
  input                         iA, iB;

  nor #(27) G1(oNor,iA,iB);

  specify
    specparam t_rise = 6;
    specparam t_fall = 6;

    (iA => oNor) = (t_rise, t_fall);
    (iB => oNor) = (t_rise, t_fall);
  endspecify


endmodule // nor
//=============================================================================
//=============================================================================
module not_cell (oNot, iA);

  output                        oNot;
  input                         iA;

  not #(24) G1(oNot,iA);

  specify
    specparam t_rise = 6;
    specparam t_fall = 6;

    (iA => oNor) = (t_rise, t_fall);
  endspecify

endmodule // not
//=============================================================================
//=============================================================================
module mux (oMux, iA, iB, iSel, iEnb);

  output reg                    oMux;
  input wire                        iA, iB, iSel, iEnb;

  specify
    specparam t_rise = 6;
    specparam t_fall = 6;

    (iA => oMux) = (t_rise, t_fall);
    (iB => oMux) = (t_rise, t_fall);
    (iSel => oMux) = (t_rise, t_fall);
    (iEnb => oMux) = (t_rise, t_fall);
  endspecify

  always @ ( * ) begin
    if (~iEnb) begin
      case (iSel)
        1'b0:
        begin
          #(23) oMux <= iA;
        end
        1'b1:
        begin
          #(23) oMux <= iB;
        end
        default:
        begin
          #(23) oMux <= 1'b0;
        end
      endcase
    end else begin
      #(23) oMux <= 1'b0;
    end
  end

endmodule
//=============================================================================
//=============================================================================
module ffd (iClr, iPre, iClk, iD, oQ, oQn);

  output reg                oQ, oQn;
  input wire                iClr, iPre, iClk, iD;

  always @ ( posedge iClk ) begin
    if (iClr) begin
      case ({iPre})
        1'b0:
        begin
          #(20) oQ <= 1'b0;
          #(20) oQn <= 1'b1;
        end
        1'b1:
        begin
          #(20) oQ <= iD;
          #(20) oQn <= ~iD;
        end
        default:
        begin
          #(20) oQ <= oQ;
          #(20) oQn <= oQn;
        end
      endcase
    end else begin
      #(20) oQ <= 1'b0;
      #(20) oQn <= 1'b1;
    end
  end

  specify
    specparam t_rise = 6;
    specparam t_fall = 6;
    specparam t_setup$iD$iCLK = 25;
    specparam t_hold$iD$iCLK = 25;

    
  endspecify

endmodule // ffd

//=============================================================================
//=============================================================================
