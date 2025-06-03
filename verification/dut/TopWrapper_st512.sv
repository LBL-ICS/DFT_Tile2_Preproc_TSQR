// st512 dummy wrapper
// for synthesis purposes only



module TopWrapper(
	input clk,
	input rst,

	);



        (* keep = "true" *) wire [15:0] tile_number = 16'h0000 ;
	(* keep = "true" *) wire [31:0] e_values =32'h00000000 ;
 	(* keep = "true" *) wire        ready_signal = 1'b1;
	(* keep = "true" *) wire [16383:0] input_vectors = 16384'd0 ;
	(* keep = "true" *) wire [2:0] dma_enb = 3'b000 ;
	(* keep = "true" *) wire [7:0] dma_addrb = 8'b00000000;
	(* keep = "true" *) wire [16383:0] doutb;
	(* keep = "true" *) wire        fi_signal;
	(* keep = "true" *) wire [15:0] mx_n;


	tsqr_st512_1c dut(
		.clk(clk),
		.rst(rst),
		.tile_no(tile_number),
		.e_upg(e_values),
		.e_ug(e_values),
		.e_pg(e_values),
		.pg_ready(ready_signal),
		.ug_ready(ready_signal),
		.e_pg_ready(ready_signal),
		.e_upg_ready(ready_signal),
		.e_ug_ready(ready_signal),
		.pg_i(input_vectors),
		.ug_i(input_vectors),
		.dma_mem_enb(dma_enb),
		.dma_mem_addrb(dma_addrb),
		.dma_mem_doutb(doutb),
		.mem0_fi_c_0(fi_signal),
		.mem1_fi_c_0(fi_signal),
		.tsqr_fi(fi_signal),
		.mx_cnt(mx_n)
		);


		endmodule

