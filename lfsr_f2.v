// Fibonacci LFSR with 2 feedback terms 
// and two outputs 
module lfsr_f2 #(parameter MSB=15,
				 parameter TAP2=14,
				 parameter INIT=1) ( 
	input clk,
	output reg[1:0] nout			
);
	reg	[MSB-1:0]out;
	initial	out = INIT;
always @ (posedge clk) begin
	begin
		out[MSB-1:1] <= out[MSB-2:0];
		out[0] <= (out[TAP2-1] ~^ out[MSB-1]); 
		nout[0] = out[0];	
		nout[1] = out[MSB-1];
	end
end
endmodule
