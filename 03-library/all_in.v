`timescale 1ns/1ps
`include "library.v"
module test_bench ();

  wire Nand, Nor, Not, Mux, Qn, Qp;
  reg oA, oB, oD, oClk, oEnb, oClr, oSel, oPre;

  nand_cell nand00
  (
    .oNand(Nand),
    .iA(oA),
    .iB(oB)
  );

  nor_cell nor00
  (
    .oNor(Nor),
    .iA(oA),
    .iB(oB)
  );

  not_cell not00
  (
    .oNot(Not),
    .iA(oA)
  );

  mux mux00
  (
    .oMux(Mux),
    .iA(oA),
    .iB(oB),
    .iSel(oSel),
    .iEnb(oEnb)
  );

  ffd ffd00
  (
    .iClr(oClr),
    .iPre(oPre),
    .iClk(oClk),
    .iD(oD),
    .oQp(Qp),
    .oQn(Qn)
  );


  // Pruebas sincrónicas
  // Reloj
  initial begin
    oClk = 1'b0;
    oEnb = 1'b1;
    oClr = 1'b0;
    oSel = 1'b0;
    oPre = 1'b0;
    repeat(4) #35 oClk = ~oClk;
    oEnb = 1'b0;
    oClr = 1'b1;
    oPre = 1'b1;
    forever #35 oClk = ~oClk;
  end

  initial begin
    @(negedge oEnb);
    oSel = 1'b1;
    oD = 1'b1;
    oA = 1'b0;
    oB = 1'b0;
    repeat(3) @(posedge oClk);
    oSel = 1'b0;
    oD = 1'b0;
    oA = 1'b0;
    oB = 1'b1;
    repeat(3) @(posedge oClk);
    oSel = 1'b0;
    oD = 1'b1;
    oA = 1'b1;
    oB = 1'b0;
    repeat(3) @(posedge oClk);
    oSel = 1'b1;
    oD = 1'b0;
    oA = 1'b1;
    oB = 1'b1;
    repeat(3) @(posedge oClk);
    oSel = 1'b0;
    oD = 1'b1;
    oA = 1'b0;
    oB = 1'b0;
    repeat(3) @(posedge oClk);
    oSel = 1'b1;
    oD = 1'b0;
    oA = 1'b0;
    oB = 1'b1;
    repeat(3) @(posedge oClk);
    oSel = 1'b0;
    oD = 1'b0;
    oA = 1'b1;
    oB = 1'b0;
    repeat(3) @(posedge oClk);
    oSel = 1'b1;
    oD = 1'b1;
    oA = 1'b1;
    oB = 1'b1;
    repeat(3) @(posedge oClk);
    $finish;
  end

  initial begin
    $dumpfile ("library.vcd");
  //    $dumpvars(1, library_tb);
    $dumpvars;
  end

endmodule // test_bench
