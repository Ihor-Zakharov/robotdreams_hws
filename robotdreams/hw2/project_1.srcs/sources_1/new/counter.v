`timescale 1ns / 1ps

module counter (
    input wire clk,
    input wire rst,
    input wire load,
    input wire [3:0] data_in,
    input wire en,
    input wire up_down,
    output reg [3:0] count 
);
	always @(posedge clk or posedge rst) begin
		if (rst)
            count <= 0;
        else if (load)
            count <= data_in;
        else if (en) 
            count <= up_down ? count + 1 : count - 1;

      
		
	end    
endmodule
