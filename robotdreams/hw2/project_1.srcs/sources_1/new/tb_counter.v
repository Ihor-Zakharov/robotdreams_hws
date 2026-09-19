`timescale 1ns / 1ps          

module tb_counter;            

    reg  clk, rst, load, en, up_down;
    reg  [3:0] data_in;
    wire [3:0] count;

    counter dut (
      .clk(clk),
      .rst(rst),
      .load(load),
      .data_in(data_in),
      .en(en),
      .up_down(up_down),
      .count(count)
    );

    initial begin
      clk = 0;
      forever #5 clk = ~clk;
    end
    
    initial begin
        rst=0; load=0; en=0; up_down=0; data_in=0;
        
        rst = 1;
        @(posedge clk);
        rst = 0;

        load=1; data_in=4'd10;
        
        @(posedge clk); #1;
        
        load = 0;
      
        if (count === 4'd10)
            $display("PASS 1");
        else 
            $display("FAIL 1");
            
  
             
    end

endmodule
