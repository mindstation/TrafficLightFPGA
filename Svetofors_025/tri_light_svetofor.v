module tri_light_svetofor ( //Блок управления тремя светдиодами. Для каждого светодиода определен
//свой временной интервал свечения. Подобно светофору.
		//A three LEDs control module. The each LED have a special lighting time.
//Like a usual three color stoplight.
		input wire time_signal,
		input wire reset,
		output wire red,
		output wire yellow,
		output wire green		
		);
		
//Параметры - количество тактов. Такт - пол секунды. Секунда - два такта.
	//Для удобства время задается как произведение на два.
	parameter green_time = 8'd26 * 8'd2,
	red_time = 8'd84 * 8'd2,
	yellow_time = 8'd3 * 8'd2,
	blnk_time = 8'd4 * 8'd2,
//Общая продолжительность работы 
	tril_time = green_time + blnk_time + red_time + yellow_time * 8'd2;
	
	reg [7:0] timer; //A time keeper for this module.
	reg [2:0] sel_color; //A output selector: 0 bit - red, 1 bit - yellow, 2 bit - green
	
	always @(posedge time_signal or negedge reset)
	begin
		if (!reset)
		begin
			timer = 8'd0;
			sel_color = 3'b110;
		end
		else
		begin
			if (timer < tril_time) //Increment and
				timer = timer + 8'd1;
			else
				timer = 8'd0; //reset timer.
			
			if (timer <= red_time) //A red color time.
				sel_color = 3'b110;
							
			//A yellow color time.
			if (timer > red_time && timer <= red_time + yellow_time)
				sel_color = 3'b100;
		
			//A green color time.
			if (timer > red_time + yellow_time && timer <= red_time + yellow_time + green_time)
				sel_color = 3'b011;
			
			if (timer > red_time + yellow_time + green_time && timer <= red_time + yellow_time + green_time + blnk_time)
				if (sel_color == 3'b011) //A green blinking.
					sel_color = 3'b111;
				else
					sel_color = 3'b011;
		
			//A yellow color time.
			if	(timer > red_time + yellow_time + green_time + blnk_time) //End of sequence. Next - timer reset.
				sel_color = 3'b101;
		end
		
	end
	
	assign red = sel_color[0];
	assign yellow = sel_color[1];
	assign green = sel_color[2];
		
endmodule