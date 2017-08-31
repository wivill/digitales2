//`include "counter.v"
module counter_tb;

    reg ireset = 0;
    initial begin

        # 17 ireset = 1;
        # 11 ireset = 0;
        # 29 ireset = 1;
        # 11 ireset = 0;
        # 100 $finish;
    end

    reg iclk = 0;
    always #5 iclk = !iclk;

    wire [7:0] ovalue;
    counter c1 (ovalue, iclk, ireset);

    initial
        $monitor("At time %t, ovalue = %h (%0d)",
                 $time, ovalue, ovalue);

    initial begin
        $dumpfile ("counter.vcd"); 
        $dumpvars(1, counter_tb); 
    end

endmodule
