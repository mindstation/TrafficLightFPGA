module tri_light_svetofor (	//Этот модуль описывает логику имитации трехцветного светофора.
 //A usual tricolor traffic light. Inverter logic, 1 is off.
		input wire time_signal,
		input wire reset,
		output wire red,
		output wire yellow,
		output wire green		
		);
	//Блок параметров - аналог констант в Verilog. Описываются временные интервалы
	//каждого из режимов работы светофора, для проверок в блоке always.
	parameter green_time = 8'd26 * 8'd2,
	red_time = 8'd84 * 8'd2,
	yellow_time = 8'd3 * 8'd2,
	blnk_time = 8'd4 * 8'd2,
	tril_time = green_time + blnk_time + red_time + yellow_time * 8'd2;
	
	reg [7:0] timer; 	//Счетчик сигналов времени.
							//A time keeper for this module.
	reg [2:0] sel_color; //Регистр выбора цвета светофора. 0 бит - красный, 1 бит - желтый, 2 бит - зеленый.
								//Активный сигнал для светодиодов - ноль.
								//A output selector: 0 bit - red, 1 bit - yellow, 2 bit - green. A zero level is active.
	
	//Соединение выходных проводов модуля с соотвествующими битами регистра выбора цвета.
	//Операция assign должна выполняться всегда и поэтому не может размещаться в поведенческом блоке always.
	assign red = sel_color[0];
	assign yellow = sel_color[1];
	assign green = sel_color[2];
	
	//Поведенческий блок always, выполняется по сигналам (по умолчанию - фронт) перечисленным в скобках.
	//Только здесь возможно использование ветвлений и циклов verilog.
	always @(posedge time_signal or negedge reset)
	begin
		//Здесь в операциях с регистрами используется неблокирующее присваивание "<=".
		//Эти операции не выполняются в месте использования, а откладываются до конца блока always.
		//Зато в конце блока они выполняются все разом, одновременно. Абсолютно ПАРАЛЛЕЛЬНО.
		if (!reset) //Если нажата кнопка сброса (активный сигнал - ноль), то...
			begin
				timer <= 8'd0;
				sel_color <= 3'b110; //Произвести установку регистров в начальное состояние.
											//Работа светофора начинается с красного сигнала. Активный сигнал - ноль.
			end
		else //Иначе, вход сброса не в нулевом состоянии (там единица, z или вообще неопределенное состояние).
			begin //Ниже идет логика работы светофора.				
				if (timer < tril_time)	//Если значение счетчика не добралось до конца одного цикла работы светофора... 
											//Increment and
					timer <= timer + 8'd1; //Увеличить его еще на единицу.
				else
					timer <= 8'd0; 	//Иначе начать отсчет заново.
											//reset timer.
			
				if (timer <= red_time) //Если значение таймера лежит в интервале работы красного света.
											//A red color time.
					sel_color <= 3'b110; //Включить красный (активный - ноль), а желтый и зеленый отключить.
							
				//A yellow color time.
				if (timer > red_time && timer <= red_time + yellow_time) //Желтый свет - переход от красного к зеленому.
					sel_color <= 3'b100; //Горят два светодиода.
		
				//A green color time.
				if (timer > red_time + yellow_time && timer <= red_time + yellow_time + green_time) //Зеленый свет.
					sel_color <= 3'b011; //Горит один светодиод, красный и желтый выключены.
				
				//Окончание работы зеленого света.
				//На протяжении этого интервала зеленый сигнал мигает с частотой сигнала времени.
				if (timer > red_time + yellow_time + green_time && timer <= red_time + yellow_time + green_time + blnk_time)
					if (sel_color == 3'b011)//A green blinking.
						sel_color <= 3'b111; //Выключить зеленый.
					else
						sel_color <= 3'b011; //Включить зеленый.
		
				//A yellow color time.
				//End of sequence. Next - timer reset.
				//Переход от зеленого сигнала к красному. Конец цикла работы светофора.
				//Дальше будет сброс таймера и все заново.
				if	(timer > red_time + yellow_time + green_time + blnk_time)
					sel_color <= 3'b101; //Горит один светодиод - желтый. 
			end
		
	end	
		
endmodule