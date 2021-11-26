module top (
    input logic clk,
	input logic rst,
	output logic rt1, 
	output logic rt8,
	output logic rdy1,
	output logic rdy3,
	output logic rdy4,
	output logic rdy5,
	output logic rdy6,
	output logic rdy9,
	output logic start1,
	output logic start4,
	output logic start5,
	output logic start7,
	output logic start9,
	output logic er2,
	output logic er3,
	output logic er5,
	output logic er6,
	output logic endd1,
	output logic endd5,
	output logic endd6,
	output logic endd7,
	output logic stop5,
	output logic stop6,
	output logic status_valid7,
	output logic instartsv7,
	output logic enable8,
	output logic interrupt9,
	output logic ack10,
	output logic req10
) ;
	z1 my_module
	  (
	   .clk(clk),
	   .rst(rst),
	   .rt1(rt1), 
	   .rt8(rt8),
	   .rdy1(rdy1),
	   .rdy3(rdy3),
	   .rdy4(rdy4),
	   .rdy5(rdy5),
	   .rdy6(rdy6),
	   .rdy9(rdy9),
	   .start1(start1),
	   .start4(start4),
	   .start5(start5),
	   .start7(start7),
	   .start9(start9),
	   .er2(er2),
	   .er3(er3),
	   .er5(er5),
	   .er6(er6),
	   .endd1(endd1),
	   .endd5(endd5),
	   .endd6(endd6),
	   .endd7(endd7),
	   .stop5(stop5),
	   .stop6(stop6),
	   .status_valid7(status_valid7),
	   .instartsv7(instartsv7),
	   .enable8(enable8),
	   .interrupt9(interrupt9),
	   .ack10(ack10),
	   .req10(req10)
	   
	   );

	property p1;
		@(posedge clk) (!rdy1 && !start1 && !endd1) throughout !rt1[->1];
	endproperty

	assert property (p1);

endmodule
