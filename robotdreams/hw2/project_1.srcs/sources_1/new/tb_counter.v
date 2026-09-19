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
        @(posedge clk); #1;
        rst = 0;

        load=1; data_in=4'd10;
        
        @(posedge clk); #1;
        
        load = 0;
      
        if (count === 4'd10)
            $display("PASS 1");
        else 
            $display("FAIL 1");
            
         en = 1; up_down = 1;
         
         @(posedge clk); #1;
         @(posedge clk); #1;
         @(posedge clk); #1;
         
         
        if (count === 4'd13)
            $display("PASS 2");
        else 
            $display("FAIL 2");
            
            
         @(posedge clk); #1;
         @(posedge clk); #1;
         @(posedge clk); #1;
        
        if (count === 0)
            $display("PASS 3");
        else 
            $display("FAIL 3");
            
         en = 0;
         
         @(posedge clk); #1;
         @(posedge clk); #1;
         
         if (count === 0)
            $display("PASS 4");
        else 
            $display("FAIL 4");
            
        en = 1; up_down = 0;
        
        @(posedge clk); #1;
        
        if (count === 4'd15)
            $display("PASS 5");
        else 
            $display("FAIL 5");
            
        load=1; data_in=4'd5; en=1; up_down=1;
        @(posedge clk); #1;
        
        if (count === 4'd5)
            $display("PASS 6");
        else 
            $display("FAIL 6");
            
        $finish;
             
    end
    
    task automatic check_count(
        input [3:0] expected,
        input [810-1:0] name
    );
        if (count === expected)
            $display("PASS %s", name);
        else 
            $display("FAIL %s", name);
    endtask

endmodule
