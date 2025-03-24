//**************************************************************************************//
//---------------- DFT Top -----------------------------------------------------------////
//---------------- Author: Xiaokun Yang  ---------------------------------------------////
//---------------- Lawrence Berkeley Lab ---------------------------------------------////
//---------------- Date: 5/15/2024  --------------------------------------------------//// 
//------ Version 1: DFT Top with tile1   ---------------------------------------------////
//------ Date: 5/15/2024 -------------------------------------------------------------////
//*************************************************************************************//
//----- tile 1 integration                                                             //
//*********************************************************************************************//
`include "define.v"
module dft  (input                            clk                  ,
             input                            rst                  ,
             input                            dft_en               ,
             input                            tile1_ug_ready       ,
	     input     [`ST*`DW-1:0]          tile1_ug_i           ,
	     input     [`ST*`DW-1:0]          tile1_ugh_i          ,
	     input     [`ST*`DW-1:0]          tile1_pg_i_old       ,
	     output                           tile1_pg_i_old_ready ,
	     input     [`ST*`DW/2-1:0]        tile1_prec           ,
	     output                           tile1_prec_ready     ,
	     input     [`SW-1:0]              tile1_rr0_old        ,
	     output                           tile1_rr0_old_ready  ,
	     output    [`DW/2-1:0]            tile1_rr0            ,
	     output                           tile1_rr0_vld        ,
	     output    [`DW/2-1:0]            tile1_E_ug           ,
	     output                           tile1_E_ug_vld       ,
             input                            tile3_pg_i_old_ready ,
             input     [`ST*`DW-1:0]          tile3_pg_i_old       ,
             input                            tile3_pgh_i_old_ready,
             input     [`ST*`DW-1:0]          tile3_pgh_i_old      ,
             input                            tile3_ug_i_old_ready ,
             input     [`ST*`DW-1:0]          tile3_ug_i_old       ,
             output                           tile3_ugh_i_old_ready,
             input     [`ST*`DW-1:0]          tile3_ugh_i_old      ,
             output                           tile3_E_ug_ready     ,
             input     [`DW/2-1:0]            tile3_E_ug_old       ,


	     //========= below are the DMA interface ===========//
             output                           tile1_mem_ena   ,
             output     [`RAM_WEA_WIDTH-1:0]  tile1_mem_wea   ,
             output reg [`RAM_ADDR_WIDTH-1:0] tile1_mem_addra ,
             output     [`RAM_WIDTH-1:0]      tile1_mem_dina  ,
             output                           tile1_mem_enb   ,     
             output     [`RAM_ADDR_WIDTH-1:0] tile1_mem_addrb ,
             input      [`RAM_WIDTH-1:0]      tile1_mem_doutb , 
             output                           tile3_mem_ena   ,
             output     [`RAM_WEA_WIDTH-1:0]  tile3_mem_wea   ,
             output reg [`RAM_ADDR_WIDTH-1:0] tile3_mem_addra ,
             output     [`RAM_WIDTH-1:0]      tile3_mem_dina  ,
             output                           tile3_mem_enb   ,       
             output     [`RAM_ADDR_WIDTH-1:0] tile3_mem_addrb ,
             input      [`RAM_WIDTH-1:0]      tile3_mem_doutb );

// tile cnt design
reg        tile1_en; 
reg        tile2_en; //made tile2_en reg
reg        tile3_en; //made tile3_en reg
reg        tile4_en; //made tile4_en reg
reg        tile5_en; //made tile5_en reg
wire       tile1_fi; 
wire       tile2_fi=0;
wire       tile3_fi=0;
wire       tile4_fi=0;
wire       tile5_fi=0;

reg  [2:0] tile_cnt ;
wire       tile_fi = tile1_fi | tile2_fi | tile3_fi | tile4_fi | tile5_fi;
wire [2:0] nxt_tile_cnt = tile_cnt==3'h4 ? 3'h0 : 
	                                tile_fi ? tile_cnt+3'h1 : tile_cnt;
always @(posedge clk, posedge rst) begin
  if(rst) begin 
    tile_cnt <= 3'h0        ;
  end else begin
    tile_cnt <= nxt_tile_cnt;
  end
end

// tile en design
wire nxt_tile2_en;
wire nxt_tile3_en;
wire nxt_tile4_en;
wire nxt_tile5_en;
wire nxt_tile1_en = tile1_fi ? 1'b0 : 
                dft_en&(~|tile_cnt) ? 1'b1 : tile1_en;	
always @(posedge clk, posedge rst) begin
  if(rst) begin 
    tile1_en <= 1'b0        ;
    tile2_en <= 1'b0        ;
    tile3_en <= 1'b0        ;
    tile4_en <= 1'b0        ;
    tile5_en <= 1'b0        ;
  end else begin
    tile1_en <= nxt_tile1_en;
    tile2_en <= nxt_tile2_en;
    tile3_en <= nxt_tile3_en;
    tile4_en <= nxt_tile4_en;
    tile5_en <= nxt_tile5_en;
  end
end

wire     [`ST*`DW-1:0]         tile1_pg_i      ;
wire                           tile1_pg_i_vld  ;
tile1 u_tile1(.clk           (clk                ),
              .rst           (rst                ),
              .en            (tile1_en           ),
              .ug_ready      (tile1_ug_ready     ),
	      .ug_i          (tile1_ug_i         ),
	      .ugh_i         (tile1_ugh_i        ),
	      .pg_i_old      (tile1_pg_i_old     ),
	      .pg_i_old_ready  (tile1_pg_i_old_ready ),
	      .prec          (tile1_prec         ),
	      .prec_ready    (tile1_prec_ready   ),
	      .rr0_old       (tile1_rr0_old      ),
	      .rr0_old_ready (tile1_rr0_old_ready),
	      .pg_i          (tile1_pg_i         ),
	      .pg_i_vld      (tile1_pg_i_vld     ),
	      .rr0           (tile1_rr0          ),
	      .rr0_vld       (tile1_rr0_vld      ),
	      .E_ug          (tile1_E_ug         ),
	      .E_ug_vld      (tile1_E_ug_vld     ),
              .fi            (tile1_fi           ));

assign tile1_mem_ena = tile1_pg_i_vld    ;
assign tile1_mem_wea = ~`RAM_WEA_WIDTH'h0;
assign tile1_mem_dina = tile1_pg_i       ; 
wire [`RAM_ADDR_WIDTH-1:0] nxt_tile1_mem_addra = tile1_fi ? `RAM_ADDR_WIDTH'h0 :
	                                                         tile1_mem_ena ? tile1_mem_addra+`RAM_ADDR_WIDTH'h1 : tile1_mem_addra; 
always @(posedge clk, posedge rst) begin
  if(rst) begin 
    tile1_mem_addra<=`RAM_ADDR_WIDTH'h0 ;
  end else begin
    tile1_mem_addra<=nxt_tile1_mem_addra;
  end
end

//wire [`RAM_ADDR_WIDTH-1:0] nxt_addrb = addrb==`RAM_DEPTH ? `RAM_ADDR_WIDTH'h0 :
//	                                                                  enb ? addrb+`RAM_ADDR_WIDTH'h1 : addrb; 
//always @(posedge clk, posedge rst) begin
//  if(rst) begin 
//    addrb<=`RAM_ADDR_WIDTH'h0;
//  end else begin
//    addrb<=nxt_addrb         ;
//  end
//end
endmodule
