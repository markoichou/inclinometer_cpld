module conunter_fm(
	input clk,
	input en,
	input clr,
	input rst_n,
	output reg [31:0] q = 32'd0
);

always @ (posedge clr or negedge rst_n or posedge clk)
	begin
		if(clr || !rst_n)
			begin
				q[31:0]<=0;
			end
		else
			begin
				if(en)
					begin
						q[31:0]<=q[31:0]+1'b1;
					end
				else
					begin
						q[31:0]<=q[31:0];
					end
			end		
	end

endmodule
