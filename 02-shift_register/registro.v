`include "definitions.v"

module registro #(parameter WIDTH = 4)
(
output  reg   [WIDTH-1 : 0] Q,
output  reg                 S_OUT,

input   wire  [WIDTH-1 : 0] D,
input   wire  [1 : 0]       MODO,
input   wire                CLK, ENB, DIR, S_IN, ITER
);

always @ (posedge CLK) begin
  if (~ENB) begin
    Q <= Q;
  end else begin

    case (MODO)
      `PUSH:
      begin
        if (DIR == 0) begin
          S_OUT <= Q[WIDTH - 1];
          Q <= {Q[WIDTH - 2 : 0], S_IN};
        end else begin
          S_OUT <= Q[0];
          Q <= {S_IN, Q[WIDTH - 1 : 1]};
        end
      end
    //------------------------------------------------------
      `CYCLE:
      begin
        if (DIR == 0) begin
          if (ITER == 0) begin
            S_OUT <= 0;
            Q[WIDTH - 1 : 0] <= {Q[WIDTH - 2 : 0], Q[WIDTH - 1]};
          end else begin
            S_OUT <= Q[WIDTH - 1];
            Q[WIDTH - 1 : 0] <= {Q[WIDTH - 2 : 0], S_IN};
          end
        end else begin
          if (ITER == 0) begin
            S_OUT <= 0;
            Q[WIDTH - 1 : 0] <= {Q[0], Q[WIDTH - 1 : 1]};
          end else begin

          end
        end
      end
    //------------------------------------------------------
      `LOAD:
      begin
        Q[WIDTH - 1 : 0] <= D[WIDTH - 1 : 0];
        S_OUT <= 0;
      end
    //------------------------------------------------------
      default:
      begin
        Q[WIDTH - 1 : 0] <= D[WIDTH - 1 : 0];
        S_OUT <= 0;
      end
    //------------------------------------------------------
    endcase

  end //end else


end //end always

endmodule
