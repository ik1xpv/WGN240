/*
WNG240 noise generator 
Oscar Steila 2023 
It uses 8 lfsr of different lengh with a combining network with 16 output
An analog dac out uses 16 equal resistor of 800 Ohm
The output impedance results  50 Ohm = 800/16
The out is AC coupled via a capacitor 10uF // 100nF // 10nF // 1nF // 100pF. 
LFSR taps: see Xilinx XAPP 210 Linear Feedback Shift Registers in Virtex Devices, v 1.0 (8/99)

The EPM240 board sclk oscillator is 50MHz 

*/

module lfsr_noise (
	input 		sclk,
	output reg  [15:0] dac   // 22 uniform output
); 
	wire [1:0] o0;
	wire [1:0] o1;
	wire [1:0] o2;
	wire [1:0] o3;
	wire [1:0] o4;
	wire [1:0] o5;
	wire [1:0] o6;
	wire [1:0] o7;
	
	lfsr_f2 #(.MSB(21),.TAP2(19),.INIT('h1A5555))   lsf0(sclk, o0);
	lfsr_f2 #(.MSB(33),.TAP2(20),.INIT('h2E7520)) 	lsf1(sclk, o1); 
	lfsr_f2 #(.MSB(31),.TAP2(28),.INIT('h7520))   	lsf2(sclk, o2);	
	lfsr_f2 #(.MSB(29),.TAP2(27),.INIT('h15A5A))  	lsf3(sclk, o3);
	lfsr_f2 #(.MSB(28),.TAP2(25),.INIT('h334441)) 	lsf4(sclk, o4);
	lfsr_f2 #(.MSB(25),.TAP2(22),.INIT('h0A55A))  	lsf5(sclk, o5);	
	lfsr_f2 #(.MSB(23),.TAP2(18),.INIT('h10501))  	lsf6(sclk, o6); 
	lfsr_f2 #(.MSB(20),.TAP2(17),.INIT('h1AF95))  	lsf7(sclk, o7); 	
	
	always @ (posedge sclk) begin
	
		dac[0] = o1[0]^o2[1];
		dac[1] = o2[0]~^o3[1];
		dac[2] = o3[0]^o4[1];
		dac[3] = o4[0]^o5[1];
		dac[4] = o5[0]~^o6[1];
		dac[5] = o6[0]^o7[1];
		dac[6] = o7[0]^o0[1];
		dac[7] = o0[0]~^o1[1];
		dac[8] = o1[1]^o2[0];
		dac[9] = o2[1]~^o3[0];
		dac[10] = o3[1]~^o4[0];
		dac[11] = o4[1]^o5[0];
		dac[12] = o5[1]^o3[0];
		dac[13] = o6[1]~^o7[0]; 
		dac[14] = o7[1]^o5[0];
		dac[15] = o0[1]~^o6[0];
		
	end
endmodule

