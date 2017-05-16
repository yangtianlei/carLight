module carLight(clk,switch,ledRGB,ledDigit,ledWater);
//defination
input clk;
input [1:0] switch;
output [2:0]ledRGB;
output [17:0]ledDigit;
output [7:0]ledWater;
reg [1:0]rSwitch;
reg [7:0]temp;
reg clkNew=0;
reg [22:0]cntClk=0;
reg [20:0]rom[3:0];
reg [7:0] romWater[3:0];
initial begin
rom[0]=21'b100100100_100100100_001;
rom[1]=21'b000000100_111100100_101;
rom[2]=21'b100111100_000000100_011;
rom[3]=21'b011011000_011011000_111;
romWater[0]=8'b11111111;
romWater[1]=8'b11110111;
romWater[2]=8'b11101111;
romWater[3]=8'b11100111;
end
parameter clkDivision=1<<22;
//operate 
//clock Division
always@(negedge clk)begin
	cntClk=cntClk+1;
	clkNew=cntClk>clkDivision>>1?1:0;
end
always@( negedge clkNew)begin
	case(switch)
	0:begin
	temp=romWater[0];
	temp[3:0]={temp[0],temp[3:1]};
	temp[7:4]={temp[6:4],temp[7]};
	romWater[0]=temp;end
	1:begin
	temp=romWater[1];
	temp[3:0]={temp[0],temp[3:1]};
	temp[7:4]={temp[6:4],temp[7]};
	romWater[1]=temp;end
	2:begin
	temp=romWater[2];
	temp[3:0]={temp[0],temp[3:1]};
	temp[7:4]={temp[6:4],temp[7]};
	romWater[2]=temp;end
	3:begin 
	temp=romWater[3];
	temp[3:0]={temp[0],temp[3:1]};
	temp[7:4]={temp[6:4],temp[7]};
	romWater[3]=temp;end
	endcase
	end 

//assign
assign ledDigit=rom[switch][20:3];
assign ledRGB[2]=rom[switch][2]|clkNew;
assign ledRGB[1]=rom[switch][1]|clkNew;
assign ledRGB[0]=rom[switch][0]|clkNew;
assign ledWater=romWater[switch];
endmodule
