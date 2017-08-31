`include"definitions.v"
module registro32v2_tb();

// Ancho de palabra del registro
  parameter  WIDTH = 32;

// Entradas del módulo registro
    reg ENB;
    reg DIR;
    reg S_IN;
    reg [1 : 0]         MODO;
    reg [WIDTH - 1 : 0] D;
    reg CLK;
// Salidas del módulo registro
    wire [WIDTH - 1 : 0] Q;
    wire                 S_OUT;

// Instancia del registro para un ancho de palabra de 32 bits
    registro #(WIDTH) r0
    (
      .Q(Q),
      .S_OUT(S_OUT),
      .D(D),
      .MODO(MODO),
      .CLK(CLK),
      .ENB(ENB),
      .DIR(DIR),
      .S_IN(S_IN)
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
      D = 32'b11110000100111011111000010011101;
      MODO = `LOAD;
      S_IN = 1'b0;
      DIR = 0;
      repeat(6) @(posedge CLK);
      // Desplazamiento izquierda
      S_IN = 1'b0;
      DIR = 0;
      MODO = `PUSH;
      repeat(34) @(posedge CLK);
      // Desplazamiento derecha
      S_IN = 1'b1;
      DIR = 1;
      MODO = `PUSH;
      repeat(34) @(posedge CLK);
      // Refrescar dato
      D = 32'b10000010111110010101000001011111;
      MODO = `LOAD;
      repeat(6) @(posedge CLK);
      // Desplazamiento circular izquierda
      DIR = 0;
      MODO = `CYCLE;
      repeat(34) @(posedge CLK);
      // Refrescar dato
      D = 32'b11001010110101101111000010011101;
      MODO = `LOAD;
      repeat(6) @(posedge CLK);
      // Desplazamiento circular derecha
      DIR = 1;
      MODO = `CYCLE;
      repeat(34) @(posedge CLK);
      $finish;
    end

    initial
        $monitor("At time %t, Q = %h (%0d), S_OUT = %h (%0d)",
                 $time, Q, Q, S_OUT, S_OUT);

    initial begin
        $dumpfile ("registro32v2.vcd");
        $dumpvars(1, registro32v2_tb);
    end

endmodule
