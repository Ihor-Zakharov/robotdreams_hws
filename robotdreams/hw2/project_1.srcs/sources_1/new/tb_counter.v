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
        
        #4;
        
        rst = 1;
        @(posedge clk); #1;
        rst = 0;

        load=1; data_in=4'd10;
        
        @(posedge clk); #1;
        
        load = 0;
      
        check_count(4'd10, "1");
            
         en = 1; up_down = 1;
         
         @(posedge clk); #1;
         @(posedge clk); #1;
         @(posedge clk); #1;
         
         
        check_count(4'd13, "2");
            
            
         @(posedge clk); #1;
         @(posedge clk); #1;
         @(posedge clk); #1;
        
        check_count(4'd0, "3");
            
         en = 0;
         
         @(posedge clk); #1;
         @(posedge clk); #1;
         
         check_count(4'd0, "4");
            
        en = 1; up_down = 0;
        
        @(posedge clk); #1;
        
        check_count(4'd15, "5");
            
        load=1; data_in=4'd5; en=1; up_down=1;
        @(posedge clk); #1;
        
        check_count(4'd5, "6");
            
        $finish;
             
    end
    
    task automatic check_count(
        input [3:0] expected,
        input [8*30-1:0] name
    );
        if (count === expected)
            $display("PASS: %0s", name);
        else 
            $display("FAIL: %0s", name);
    endtask

endmodule
