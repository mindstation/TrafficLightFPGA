module time_signal ( //This module make a signal with half-second period of time.
		input wire clk,
		input wire reset,
		output wire time_out
		);
	
	reg [24:0] clk_number; //Clock counter, Waveshare CoreEP4CE10 have 50MHz global clk. Need just half.
	reg [0:0] sec_kp; //A signal keeper.
	
	always @(posedge clk)
	begin
		if (!reset)
		begin
			clk_number <= 25'd0;
			sec_kp <= 1'd0;
		end
	
		if (clk_number <= 25'd25000000) //Equal or +1? No care. Synthsizer is smart.
			clk_number <= clk_number + 25'd1;
		else
			clk_number <= 25'd0;
	
		if (clk_number > 25'd12500000) 
			sec_kp <= 1'd1;
		else
			sec_kp <= 1'd0;
			
	end
	
	assign time_out = sec_kp;
	
endmodule