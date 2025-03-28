//**************************************************************************************//
//---------------- Testbench for Tile2 -----------------------------------------------////
//---------------- Author: Xiaokun Yang  ---------------------------------------------////
//---------------- Lawrence Berkeley Lab ---------------------------------------------////
//---------------- Date: 03/07/2025 --------------------------------------------------//// 
//------ Version 1: Testbench for Tile2  ---------------------------------------------////
//------ Date: 03/07/2025 ------------------------------------------------------------////
//*************************************************************************************//
//----- test bench: dft with tile 2                                                    //
//**************************************************************************************//
`define ERROR_THRESHOLD 5
`include "../dut/define.sv"

module tb_tile2();

//========= Preprocessing interface ===========//
reg clock, reset;
reg io_tile2_en, io_tile2_ug_ready, io_tile2_pg_ready;
reg [127:0] io_tile2_ug_i, io_tile2_pg_i;
reg [31:0] io_tile2_e_upg, io_tile2_e_ug, io_tile2_e_pg;
reg io_tile2_e_upg_ready, io_tile2_e_ug_ready, io_tile2_e_pg_ready;
reg io_in_valid;
reg io_tile2_mem0_fi, io_tile2_mem1_fi;
wire io_tile2_tsqr_en;

//========= SRAM interface ===========//
wire io_tile2_tr_mem_ena, io_tile2_tr_mem_wea;
wire [31:0] io_tile2_tr_mem_addra, io_tile2_tr_mem_dina;
wire io_tile2_tr_mem_enb;
wire [31:0] io_tile2_tr_mem_addrb;
reg [31:0] io_tile2_tr_mem_doutb;

wire io_tile2_d0_mem_ena, io_tile2_d0_mem_wea;
wire [31:0] io_tile2_d0_mem_addra, io_tile2_d0_mem_dina;
wire io_tile2_d0_mem_enb;
wire [31:0] io_tile2_d0_mem_addrb;
reg [31:0] io_tile2_d0_mem_doutb;

wire io_tile2_d1_mem_ena, io_tile2_d1_mem_wea;
wire [31:0] io_tile2_d1_mem_addra, io_tile2_d1_mem_dina;
wire io_tile2_d1_mem_enb;
wire [31:0] io_tile2_d1_mem_addrb;
reg [31:0] io_tile2_d1_mem_doutb;
reg [31:0] clock_count;
wire io_out_ug;
reg io_tsqr_fi;

//---------------------------------------------------------
//--- Golden model and memory initialization
//---------------------------------------------------------
reg [127:0] ug_ram [1:0];
reg [127:0] pg_ram [1:0];
reg [31:0] e_ug_ram [1:0], e_upg_ram [1:0], e_pg_ram [1:0];

initial begin
    $display("=== The TILE2 Starts! (%d ns) ====", $time);
`ifdef TILE2_2X2
    $display("Initializing memory in TILE2_2X2 (%d ns)", $time);
    $readmemh("../golden/tile2_4x2/ug_ieee754.txt", ug_ram);
    $readmemh("../golden/tile2_4x2/pg_ieee754.txt", pg_ram);
    $readmemh("../golden/tile2_4x2/e_ug_ieee754.txt", e_ug_ram);
    $readmemh("../golden/tile2_4x2/e_upg_ieee754.txt", e_upg_ram);
    $readmemh("../golden/tile2_4x2/e_pg_ieee754.txt", e_pg_ram);
`endif
end

//---------------------------------------------------------
//--- Instantiation of tile2 module
//---------------------------------------------------------
tile2 u_tile2 (
    .clock(clock),
    .reset(reset),
    .io_tile2_en(io_tile2_en),
    .io_tile2_ug_ready(io_tile2_ug_ready),
    .io_tile2_ug_i(io_tile2_ug_i),
    .io_tile2_pg_ready(io_tile2_pg_ready),
    .io_tile2_pg_i(io_tile2_pg_i),
    .io_tile2_e_upg(io_tile2_e_upg),
    .io_tile2_e_ug(io_tile2_e_ug),
    .io_tile2_e_pg(io_tile2_e_pg),
    .io_tile2_e_upg_ready(io_tile2_e_upg_ready),
    .io_tile2_e_ug_ready(io_tile2_e_ug_ready),
    .io_tile2_e_pg_ready(io_tile2_e_pg_ready),
    .io_in_valid(io_in_valid),
    .io_tile2_mem0_fi(io_tile2_mem0_fi),
    .io_tile2_mem1_fi(io_tile2_mem1_fi),
    .io_tile2_tsqr_en(io_tile2_tsqr_en),
    .io_tile2_tr_mem_ena(io_tile2_tr_mem_ena),
    .io_tile2_tr_mem_wea(io_tile2_tr_mem_wea),
    .io_tile2_tr_mem_addra(io_tile2_tr_mem_addra),
    .io_tile2_tr_mem_dina(io_tile2_tr_mem_dina),
    .io_tile2_d0_mem_ena(io_tile2_d0_mem_ena),
    .io_tile2_d0_mem_wea(io_tile2_d0_mem_wea),
    .io_tile2_d0_mem_addra(io_tile2_d0_mem_addra),
    .io_tile2_d0_mem_dina(io_tile2_d0_mem_dina),
    .io_tile2_d1_mem_ena(io_tile2_d1_mem_ena),
    .io_tile2_d1_mem_wea(io_tile2_d1_mem_wea),
    .io_tile2_d1_mem_addra(io_tile2_d1_mem_addra),
    .io_tile2_d1_mem_dina(io_tile2_d1_mem_dina),
    .io_tsqr_fi(io_tsqr_fi),
    .io_out_ug(io_out_ug)
);

//---------------------------------------------------------------------
//------- Clock generation
//---------------------------------------------------------------------
always #5 clock = ~clock;
always #10 clock_count = clock_count+1;




//---------------------------------------------------------------------
//------- Testbench logic
//---------------------------------------------------------------------
integer i, j;
initial begin
    reset = 1'b1;
    clock = 1'b0;
    clock_count = 32'd0;
    io_tile2_en = 1'b1;
    io_in_valid = 1'b1;
    io_tile2_e_ug_ready = 1'b0;
    io_tile2_e_pg_ready = 1'b0;
    io_tile2_e_upg_ready = 1'b0;
    io_tile2_ug_ready = 1'b0;
    io_tile2_pg_ready = 1'b0;
    io_tsqr_fi = 1'b0;
    io_tile2_e_ug = 32'h0;
    io_tile2_e_pg = 32'h0;
    io_tile2_e_upg = 32'h0; 
    io_tile2_ug_i = 128'h0;
    io_tile2_pg_i = 128'h0;
    #100;
    reset = 1'b0;
    #16;
    #20;

    for (i = 0; i < 2; i = i + 1) begin
        io_tile2_e_ug = 32'h40400000;
        io_tile2_e_pg = 32'h40800000;
       io_tile2_e_upg = 32'h40000000; 
        io_tile2_e_ug_ready = 1'b1;
        io_tile2_e_pg_ready = 1'b1;
        io_tile2_e_upg_ready = 1'b1;
        @(posedge clock);
       // io_tile2_e_ug_ready = 1'b0;
       // io_tile2_e_pg_ready = 1'b0;
       // io_tile2_e_upg_ready = 1'b0;
        repeat (93) @(posedge clock);

     //   for (j = 0; j < 2; j = j + 1) begin
            io_tile2_ug_ready = 1'b1;
            io_tile2_pg_ready = 1'b1;
            io_tile2_ug_i = 128'h3FA2551D41EBC8E1418E474A41DBAF03;
            io_tile2_pg_i = 128'h41EA12A740292947C239071CC1F6BD53;
            @(posedge clock);
    //    end
    //
    	 io_tile2_pg_i = 128'hC03E5C21C22ED273C03E5C21C22ED273;
         io_tile2_ug_i = 128'h41052B264237176B41052B264237176B;
	@(posedge clock);
 	io_tile2_pg_i = 128'hC03E5C21C22ED273C03E5C21C22ED273;
         io_tile2_ug_i = 128'h41052B264237176B41052B264237176B;
	@(posedge clock);
	 io_tile2_pg_i = 128'hC03E5C21C22ED273C03E5C21C22ED273;
         io_tile2_ug_i = 128'h41052B264237176B41052B264237176B;
	@(posedge clock);

/////////////////////////////////////
	 io_tile2_ug_i = 128'h40400000404000004040000040400000;
         io_tile2_pg_i = 128'h40000000400000004000000040000000;
	@(posedge clock);

	 io_tile2_pg_i = 128'h40400000404000004040000040400000;
         io_tile2_ug_i = 128'h40000000400000004000000040000000;
	@(posedge clock);

         io_tile2_ug_i = 128'h40400000404000004040000040400000;
         io_tile2_pg_i = 128'h40000000400000004000000040000000;
	@(posedge clock);

	 io_tile2_pg_i = 128'h40400000404000004040000040400000;
         io_tile2_ug_i = 128'h40000000400000004000000040000000;
	@(posedge clock);
//////////////////////////////////////////////
//
	 io_tile2_mem0_fi = 1'b1;
   	
	 io_tile2_ug_i = 128'h40400000404000004040000040400000;
         io_tile2_pg_i = 128'h40000000400000004000000040000000;
	@(posedge clock);

	 io_tile2_pg_i = 128'h40400000404000004040000040400000;
         io_tile2_ug_i = 128'h40000000400000004000000040000000;
	@(posedge clock);
	
	 
	 


         io_tile2_ug_i = 128'h40400000404000004040000040400000;
         io_tile2_pg_i = 128'h40000000400000004000000040000000;
	@(posedge clock);

//	io_tile2_mem0_fi = 1'b0;

	 io_tile2_pg_i = 128'h40400000404000004040000040400000;
         io_tile2_ug_i = 128'h40000000400000004000000040000000;
	// io_tile2_mem0_fi = 1'b1;
		
//	@(posedge clock);
	@(posedge clock);




////////////////////////////////////////////////////////

	// io_tile2_mem0_fi = 1'b1;
//	 @ (posedge clock);
	 io_tile2_mem0_fi = 1'b0;
   	io_tile2_mem1_fi  = 1'b1;	
	 io_tile2_ug_i = 128'h40400000404000004040000040400000;
         io_tile2_pg_i = 128'h40000000400000004000000040000000;
	@(posedge clock);

	 io_tile2_pg_i = 128'h40400000404000004040000040400000;
         io_tile2_ug_i = 128'h40000000400000004000000040000000;
	@(posedge clock);

         io_tile2_ug_i = 128'h40400000404000004040000040400000;
         io_tile2_pg_i = 128'h40000000400000004000000040000000;
	@(posedge clock);
	
	io_tile2_mem1_fi  = 1'b0;	
	 io_tile2_pg_i = 128'h40400000404000004040000040400000;
         io_tile2_ug_i = 128'h40000000400000004000000040000000;
	@(posedge clock);

        io_tile2_ug_ready = 1'b0;
        io_tile2_pg_ready = 1'b0;
	

    end
end

endmodule

