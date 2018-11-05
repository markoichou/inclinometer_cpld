module data_rw(
	output reg [10:0] out_num,
	input[31:0] f0_num,
	input[31:0] fx_num,
	input ready,
	input read_clk,
	input rst_n
);

	reg [2:0] shift_rd = 3'd0;
	reg [63:0] out_buffer = 64'd0;

	always @ (posedge ready)
	begin
		out_buffer[63:0]<={fx_num[31:0], f0_num[31:0]};
		//out_buffer[63:0]<=64'h12345678abcdef09;
	end	
	
	//initial shift_rd[2:0]<=3'b000;
	
	always @ (posedge read_clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				shift_rd <= 3'd0;
				out_num <= 11'd0;
			end
		else
			begin
				if(ready)
					begin
						shift_rd[2:0]<=shift_rd[2:0]+1'b1;
						case (shift_rd[2:0])		
							3'b000:out_num<={shift_rd[2:0],out_buffer[7:0]};
							3'b001:out_num<={shift_rd[2:0],out_buffer[15:8]};
							3'b010:out_num<={shift_rd[2:0],out_buffer[23:16]};
							3'b011:out_num<={shift_rd[2:0],out_buffer[31:24]};
							3'b100:out_num<={shift_rd[2:0],out_buffer[39:32]};
							3'b101:out_num<={shift_rd[2:0],out_buffer[47:40]};
							3'b110:out_num<={shift_rd[2:0],out_buffer[55:48]};
							3'b111:out_num<={shift_rd[2:0],out_buffer[63:56]};
							default:shift_rd[2:0]<=3'b111;
						endcase			
					end
				else
					begin
						out_num<=11'd0;
						shift_rd<=3'd0;
					end
			end	
	end	




endmodule