/*
WNG240 noise generator 
Oscar Steila 2023 
Test bench -
it generates nsteps noise output
noise_sig is the computed sum of the 16 dac_sig outputs 
in the WNG240 it is done with 16 equal resistors of 800 Ohm
the provability density function is stored in noise_distribution.txt file
*/
`timescale 10ns/1ns
module lfsr_noise_tb;

reg clk_sig;
wire [15:0] dac_sig;
integer noise_sig;
integer prob[16:0];
integer i;
integer nclks_sig;
integer output_file;
integer nsteps;

initial
begin
clk_sig = 0;
noise_sig = 0;
nclks_sig = 0;
nsteps = 500000;

for (i=0; i< 17;i=i+1) begin
	prob[i] = 0;
	end
end

initial
begin
 output_file = $fopen("noise_distribution.txt","w");
end

always
begin
#10 clk_sig = !clk_sig;

noise_sig = dac_sig[0] +dac_sig[1] +dac_sig[2] +dac_sig[3] 
			 + dac_sig[4] +dac_sig[5] +dac_sig[6] +dac_sig[7]
			 + dac_sig[8] +dac_sig[9] +dac_sig[10] +dac_sig[11]
			 + dac_sig[12] +dac_sig[13] +dac_sig[14] +dac_sig[15];

for (i=0; i< 17;i=i+1) begin
	if (noise_sig == i) begin prob[i] = prob[i] +1; end			 
	end			 	 
			 
if (clk_sig == 1)
	begin
	nclks_sig = nclks_sig + 1;
	if (nclks_sig > nsteps) 
		begin
		for (i=0; i< 17;i=i+1) begin
		 $fdisplay(output_file,"%3d  %10d ",i ,prob[i]);
		 end
		 $fclose(output_file);
		 $stop; 
		end
	end
end

lfsr_noise lfsr_noise_inst
(
	.sclk(clk_sig) ,	// input  sclk_sig
	.dac(dac_sig) 	   // output [15:0] dac_sig
);

endmodule
