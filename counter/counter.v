module counter(out, iclk, ireset);

    parameter WIDTH = 8;

    output [WIDTH-1 : 0] out;
    input                iclk, ireset;

    reg [WIDTH-1 : 0]    out;
    wire                 iclk, ireset;

    always @(posedge iclk)
        out <= out + 1;

    always @(ireset)
        if (ireset)
            /*assign*/ out = 0;
        /*else
            deassign out;*/

endmodule
