`include"definitions.v"
module registro_tb();

// Ancho de palabra del registro
  parameter  WIDTH = 4;

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

// Instancia del registro para un ancho de palabra de 4 bits
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
      D = 4'b1101;
      MODO = `LOAD;
      S_IN = 1'b0;
      DIR = 0;
      repeat(6) @(posedge CLK);
      // Desplazamiento izquierda
      S_IN = 1'b0;
      DIR = 0;
      MODO = `PUSH;
      repeat(6) @(posedge CLK);
      // Desplazamiento derecha
      S_IN = 1'b1;
      DIR = 1;
      MODO = `PUSH;
      repeat(6) @(posedge CLK);
      // Refrescar dato
      D = 4'b1010;
      MODO = `LOAD;
      repeat(6) @(posedge CLK);
      // Desplazamiento circular izquierda
      DIR = 0;
      MODO = `CYCLE;
      repeat(6) @(posedge CLK);
      // Refrescar dato
      D = 4'b0110;
      MODO = `LOAD;
      repeat(6) @(posedge CLK);
      // Desplazamiento circular derecha
      DIR = 1;
      MODO = `CYCLE;
      repeat(6) @(posedge CLK);
      $finish;
    end

    initial
        $monitor("At time %t, Q = %h (%0d), S_OUT = %h (%0d)",
                 $time, Q, Q, S_OUT, S_OUT);

    initial begin
        $dumpfile ("registro.vcd");
        $dumpvars(1, registro_tb);
    end

endmodule
