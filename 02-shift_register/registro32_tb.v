`include"definitions.v"
module registro32_tb();

// Ancho de palabra del registro
  parameter  WIDTH = 32;

// Entradas del módulo registro
    reg ENB;
    reg DIR;
    reg S_IN;
    reg [1 : 0]          MODO;
    reg [WIDTH - 1 : 0]  D;
    reg CLK;
// Salidas del módulo registro
    wire [WIDTH - 1 : 0] Q;
    wire                 S_OUT;

// Aditivos para interconexión de módulos
    wire [7 : 1]         S_OUT_IN;

// Instancia del registro para un ancho de palabra de 4 bits
    registro #(4) r0
    (
      .Q(Q[3:0]),
      .S_OUT(S_OUT_IN[1]),
      .D(D[3:0]),
      .MODO(MODO),
      .CLK(CLK),
      .ENB(ENB),
      .DIR(DIR),
      .S_IN(S_IN)
      );

    registro #(4) r1
    (
      .Q(Q[7:4]),
      .S_OUT(S_OUT_IN[2]),
      .D(D[7:4]),
      .MODO(MODO),
      .CLK(CLK),
      .ENB(ENB),
      .DIR(DIR),
      .S_IN(S_OUT_IN[1])
      );

    registro #(4) r2
    (
      .Q(Q[11:8]),
      .S_OUT(S_OUT_IN[3]),
      .D(D[11:8]),
      .MODO(MODO),
      .CLK(CLK),
      .ENB(ENB),
      .DIR(DIR),
      .S_IN(S_OUT_IN[2])
      );

    registro #(4) r3
    (
      .Q(Q[15:12]),
      .S_OUT(S_OUT_IN[4]),
      .D(D[15:12]),
      .MODO(MODO),
      .CLK(CLK),
      .ENB(ENB),
      .DIR(DIR),
      .S_IN(S_OUT_IN[3])
      );

    registro #(4) r4
    (
      .Q(Q[19:16]),
      .S_OUT(S_OUT_IN[5]),
      .D(D[19:16]),
      .MODO(MODO),
      .CLK(CLK),
      .ENB(ENB),
      .DIR(DIR),
      .S_IN(S_OUT_IN[4])
      );

    registro #(4) r5
    (
      .Q(Q[23:20]),
      .S_OUT(S_OUT_IN[6]),
      .D(D[23:20]),
      .MODO(MODO),
      .CLK(CLK),
      .ENB(ENB),
      .DIR(DIR),
      .S_IN(S_OUT_IN[5])
      );

    registro #(4) r6
    (
      .Q(Q[27:24]),
      .S_OUT(S_OUT_IN[7]),
      .D(D[27:24]),
      .MODO(MODO),
      .CLK(CLK),
      .ENB(ENB),
      .DIR(DIR),
      .S_IN(S_OUT_IN[6])
      );

    registro #(4) r7
    (
      .Q(Q[WIDTH - 1: 28]),
      .S_OUT(S_OUT),
      .D(D[WIDTH - 1: 28]),
      .MODO(MODO),
      .CLK(CLK),
      .ENB(ENB),
      .DIR(DIR),
      .S_IN(S_OUT_IN[7])
      );

// Pruebas sincrónicas
// Reloj
    initial begin
      CLK = 1'b0;
      ENB = 1'b0;
      repeat(4) #5 CLK = ~CLK;
      ENB = 1'b1;
      forever #5 CLK = ~CLK;
    end

    initial begin
      // Carga de datos
      @(posedge ENB);
      D = 32'b11011101110111011101110111011101;
      MODO = `LOAD;
      S_IN = 1'b0;
      DIR = 0;
      repeat(15) @(posedge CLK);
      // Desplazamiento izquierda
      S_IN = 1'b0;
      DIR = 0;
      MODO = `PUSH;
      repeat(35) @(posedge CLK);
      // Desplazamiento derecha
      S_IN = 1'b1;
      DIR = 1;
      MODO = `PUSH;
      repeat(35) @(posedge CLK);
      // Refrescar dato
      D = 32'b10101010101010101010101010101010;
      MODO = `LOAD;
      repeat(3) @(posedge CLK);
      // Desplazamiento circular izquierda
      DIR = 0;
      MODO = `CYCLE;
      repeat(35) @(posedge CLK);
      // Refrescar dato
      D = 32'b01100110011001100110011001100110;
      MODO = `LOAD;
      repeat(3) @(posedge CLK);
      // Desplazamiento circular derecha
      DIR = 1;
      MODO = `CYCLE;
      repeat(35) @(posedge CLK);
      $finish;
    end

    initial
        $monitor("At time %t, Q = %h (%0d), S_OUT = %h (%0d)",
                 $time, Q, Q, S_OUT, S_OUT);

    initial begin
        $dumpfile ("registro32.vcd");
        $dumpvars(1, registro32_tb);
    end

endmodule
