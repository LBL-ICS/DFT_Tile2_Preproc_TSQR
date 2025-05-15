//*********************************************************************************************// 
//----------------   TSQR Testbench (Scala golden model)-------------------------------------//// 
//---------------- Author: Xiaokun Yang  ----------------------------------------------------//// 
//---------------- Lawrence Berkeley Lab ----------------------------------------------------//// 
//---------------- Date: 6/13/2023  ---------------------------------------------------------//// 
//----- Version 1: TSQR MC Testbench---------------------------------------------------------//// 
//----- Date: 6/13/2023 ---------------------------------------------------------------------//// 
//-------------------------------------------------------------------------------------------//// 
//*********************************************************************************************// 
//----- This testbench support verification to the multi-core TSQR designs                     //
//----- with streaming width of 16                                                             // 
//*********************************************************************************************// 
`define ERROR_THRESHOLD 5  //5% error tolerace

//--------------------------------------------------------- 
//--- test cases  
//--------------------------------------------------------- 
`ifdef ST512_RANDOM_TEST_512X256
  `define TILE_NO 2
`endif


module tsqr_mc_st512_tb();
//---------------------------------------------------------
//--- wire and reg declaration 
//---------------------------------------------------------
reg                         clk        ;
reg                         rst        ;
reg                         tsqr_en    ;
reg  [`CNT_WIDTH - 1:0]     tile_no    ;

`ifdef SINGLE_CORE_INT
wire                        mem0_fi_c_0 ;
wire                        mem1_fi_c_0 ;
`endif //SINGLE_CORE_INT
wire                        tsqr_fi    ; 
reg  [31:0]                 e_upg;
reg  [31:0]                 e_ug;
reg  [31:0]                 e_pg;

reg [`RAM_WIDTH-1:0]          pg_i;
reg [`RAM_WIDTH-1:0]          ug_i;
reg                         e_upg_ready;
reg                         e_pg_ready;
reg                         e_ug_ready;
reg                         pg_ready;
reg                         ug_ready;
reg  [15:0]                 mx_cnt;

reg  [`MEM_NO-1:0]          dma_mem_enb  ;
reg  [`RAM_ADDR_WIDTH-1:0]  dma_mem_addrb;
wire [`RAM_WIDTH-1:0]       dma_mem_doutb;
//---------------------------------------------------------
//--- golden model and input file 
//---------------------------------------------------------
reg [`MATRIX_WIDTH*64-1:0]  tri_ram[0:`MATRIX_WIDTH-1]   ; //For the matlab tsqr function, only the upper triangle (8*8) is stored. 
reg [`TILE_NO*`MATRIX_WIDTH*64-1:0] pg_ram[0:`MATRIX_WIDTH-1] ;
reg [`TILE_NO*`MATRIX_WIDTH*64-1:0] ug_ram[0:`MATRIX_WIDTH-1] ;
reg [31:0] e_upg_ram[0:`MATRIX_WIDTH-1];
reg [31:0] e_pg_ram[0:`MATRIX_WIDTH-1];
reg [31:0] e_ug_ram[0:`MATRIX_WIDTH-1];


initial begin
$display("=== The maxix factoriation Starts! (%d ns) ====", $time);
`ifdef SINGLE_CORE
  `ifdef ST512_RANDOM_TEST_512X256
     $display("Initilize The Memory in ST512_RANDOM_TEST_512X256 (%d ns) in Single-core Design",$time);
     $readmemh("../golden/sc_st512_random_test_512x256/ug_ieee754.txt" , ug_ram);
     $readmemh("../golden/sc_st512_random_test_512x256/pg_ieee754.txt" , pg_ram);
     $readmemh("../golden/sc_st512_random_test_512x256/e_ug_ieee754.txt" , e_ug_ram);
     $readmemh("../golden/sc_st512_random_test_512x256/e_pg_ieee754.txt" , e_pg_ram);
     $readmemh("../golden/sc_st512_random_test_512x256/e_upg_ieee754.txt" , e_upg_ram);

     $readmemh("../golden/sc_st512_random_test_512x256/tri_ieee754.txt" , tri_ram);

  `endif
`endif
end

//---------------------------------------------------------
//--- Initialize and Load Memory -------------------------- 
//--- Single-core Test Cases ------------------------------ 
//---------------------------------------------------------
//`include "load_mem.sv"

//---------------------------------------------------------
//--- Instantiation 
//---------------------------------------------------------
tsqr_st512_1c u_tsqr_st512_1c (.clk        (clk          ),
                   .rst            (rst          ),
	           .tile_no        (tile_no      ),
		   .e_upg             (e_upg),
		   .e_pg              (e_pg),
		   .e_ug              (e_ug),
		   .pg_ready          (pg_ready),
		   .ug_ready          (ug_ready),
		   .e_pg_ready        (e_pg_ready),
		   .e_upg_ready       (e_upg_ready),
		  . e_ug_ready        (e_ug_ready),
		   .pg_i              (pg_i),
		   .ug_i              (ug_i),
                   .dma_mem_enb  (dma_mem_enb  ),
                   .dma_mem_addrb(dma_mem_addrb),
                   .dma_mem_doutb(dma_mem_doutb),
`ifdef SINGLE_CORE_INT
	           .mem0_fi_c_0   (mem0_fi_c_0   ),
                   .mem1_fi_c_0   (mem1_fi_c_0   ),
`endif //SINGLE_CORE_INT
                   .tsqr_fi      (tsqr_fi      ),
	            .mx_cnt      (mx_cnt       ));

//---------------------------------------------------------------------
//------- BFM
//---------------------------------------------------------------------
integer i, j;
always #5 clk = ~clk;
initial begin
   rst           = 1'b1;
   clk           = 1'b0;
   tile_no       = `TILE_NO;
   dma_mem_enb   = 1'b0               ;
   dma_mem_addrb = `RAM_ADDR_WIDTH'h0 ;
   e_upg         = 32'h0 ;
   e_pg          = 32'h0 ;
   e_ug          = 32'h0 ;
   pg_ready      = 1'b0  ;
   ug_ready      = 1'b0  ;
   e_pg_ready    = 1'b0  ;
   e_ug_ready    = 1'b0  ;
   e_upg_ready   = 1'b0  ;
   pg_i          = 16384'h0;
   ug_i          = 16384'h0;

   #100;
   rst     = 1'b0;
   #16; 

  // e_ug  = 32'h40400000;
  // e_pg  = 32'h40800000;
 //  e_upg = 32'h40000000; 
   //================================================================================//
   //=========  1 -- 3 -- 5 | -- 7 -- | -- 9  -- | -- 11 ============================//
   //=========  2 -- 4 -- 6 | -- 8 -- | -- 10 -- | -- 12 ============================//
   //---------------------mem0_fi---mem1_fi-----mem0_fi---mem1_fi/tsqr_fi/tile2_fi---//
   //================================================================================//
     for(i=0; i<`MATRIX_WIDTH;i=i+1) begin
       e_ug_ready  = 1'b1;
       e_pg_ready  = 1'b1;
       e_upg_ready = 1'b1;
       ug_ready    = 1'b1;
       pg_ready    = 1'b1;
       ug_i = ug_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-0)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-1)*64];
       pg_i = pg_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-0)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-1)*64];
       e_ug  = e_ug_ram[i][31:0];
       e_pg  =  e_pg_ram[i][31:0];
       e_upg = e_upg_ram[i][31:0]; 
       @(posedge clk);
     end
     for(i=0; i<`MATRIX_WIDTH;i=i+1) begin
       ug_i = ug_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-1)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-2)*64];
       pg_i = pg_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-1)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-2)*64];
       e_ug_ready  = 1'b0;
       e_pg_ready  = 1'b0;
       e_upg_ready = 1'b0;

       @(posedge clk);
     end


  //   for(i=0; i<`MATRIX_WIDTH;i=i+1) begin
  //     ug_i = ug_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-2)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-3)*64];
  //     pg_i = pg_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-2)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-3)*64];
     //  e_ug  = e_ug_ram[i][31:0];
     //  e_pg  =  e_pg_ram[i][31:0];
     //  e_upg = e_upg_ram[i][31:0]; 
    //   @(posedge clk);
  //   end

       ug_ready    = 1'b0;
       pg_ready    = 1'b0;
       //ug_i = 128'h41100000400000003F80000040000000;
       //pg_i = 128'hC0400000C0000000C0E00000C0000000;
       //@(posedge clk);
       //ug_i =128'h40800000411000004000000040800000;
       //pg_i =128'h3BF800000C0000000C1100000C0C00000;
       //@(posedge clk);
       //ug_i = 128'h410000003F8000004080000040A00000;
       //pg_i = 128'hC0A00000C1000000C0800000BF800000;
       //@(posedge clk);
       //ug_i =128'h404000003F80000040E0000041000000;
       //pg_i =128'hC0A00000C0800000C0400000C0000000;
       //@(posedge clk);
       //ug_i = 128'h400000004100000040A0000040E00000;
       //pg_i = 128'hC0A00000C0000000C0000000C0E00000;
       //@(posedge clk);
       //ug_i =128'h4040000040C000003F80000040000000;
       //pg_i =128'hC1000000C0800000BF800000C1100000;
       //@(posedge clk);

     wait(mem0_fi_c_0);
     @(posedge clk);
     for(i=0; i<`MATRIX_WIDTH;i=i+1) begin
     //  e_ug_ready  = 1'b1;
     //  e_pg_ready  = 1'b1;
     //  e_upg_ready = 1'b1;
       ug_ready    = 1'b1;
       pg_ready    = 1'b1;
       ug_i = ug_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-3)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-4)*64];
       pg_i = pg_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-3)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-4)*64];
       @(posedge clk);
     end
      // e_ug_ready  = 1'b0;
      // e_pg_ready  = 1'b0;
      // e_upg_ready = 1'b0;
       ug_ready    = 1'b0;
       pg_ready    = 1'b0;
       //ug_i = 128'h3F800000404000004000000040C00000;
       //pg_i = 128'hC1100000C0800000C0000000C1000000;
       //@(posedge clk);
       // ug_i =128'h41100000410000004080000040400000;
       // pg_i =128'hC0000000C0400000BF800000C0C00000;
       //@(posedge clk);

//     wait(mem1_fi_c_0);
//     @(posedge clk);
//     for(i=0; i<`MATRIX_WIDTH;i=i+1) begin
//       ug_ready    = 1'b1;
//       pg_ready    = 1'b1;
//       ug_i = ug_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-4)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-5)*64];
//       pg_i = pg_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-4)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-5)*64];
//       @(posedge clk);
//     end
//       ug_ready    = 1'b0;
//       pg_ready    = 1'b0;
    
     wait(mem0_fi_c_0);
     @(posedge clk);
     for(i=0; i<`MATRIX_WIDTH;i=i+1) begin
    //   e_ug_ready  = 1'b1;
     //  e_pg_ready  = 1'b1;
    //   e_upg_ready = 1'b1;
       ug_ready    = 1'b1;
       pg_ready    = 1'b1;
       ug_i = ug_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-5)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-6)*64];
       pg_i = pg_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-5)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-6)*64];
       @(posedge clk);
     end
    //   e_ug_ready  = 1'b0;
    //   e_pg_ready  = 1'b0;
    //   e_upg_ready = 1'b0;
       ug_ready    = 1'b0;
       pg_ready    = 1'b0;
end


//---------------------------------------------------------------------
//------- Monitor -----------------------------------------------------
//---------------------------------------------------------------------
integer col_index;

`include "tb_func.sv"

reg [`MATRIX_WIDTH*64-1:0] gol_col;
reg [`MATRIX_WIDTH*64-1:0] dut_col;
real error_percent;

`include "error_percent_declare.sv"

reg wr_fi;
always @(posedge clk) begin
  if(rst) begin
    wr_fi<=1'b0;
  end else begin
    wr_fi<=tsqr_fi;
  end
end

integer tri_report; 
integer tri_report_ieee754; 

// -------------------------------------------
// --Monitor: Simulation Log -----------------
// -------------------------------------------
initial begin
  wait(~rst);
  forever begin
    @(negedge clk);

    if(wr_fi) begin 
    // ********************************
    // ---------- open report ---------
    // ********************************
`ifdef ST512_RANDOM_TEST_512X256
  `ifdef SINGLE_CORE
      tri_report=$fopen("../sim/sc_st512_random_test_512x256/tri_report.log", "w");
      tri_report_ieee754=$fopen("../sim/sc_st512_random_test_512x256/tri_report_ieee754.log", "w");
      $fwrite(tri_report, "==========================================\n");
      $fwrite(tri_report, "Single-core Simulation\n"                    );
      $fwrite(tri_report, "Test case: ST512_RANDOM_TEST_512X256\n"        );
      $fwrite(tri_report, "==========================================\n");
  `endif
`endif

    // ********************************
    // ---------- write report --------
    // ********************************
    for(col_index=0; col_index<`MATRIX_WIDTH;) begin
      gol_col=tri_ram[col_index];
      dut_col=u_tsqr_st512_1c.hh_core.simple_dual_19_2.ram_ext.Memory[col_index];
      `include "error_percent_abs_cal_tri.sv"
      `include "comp_abs_tri.sv"
      `include "comp_tri_ieee754.sv"
      col_index=col_index+1;
    end

    // ********************************
    // ---------- close report --------
    // ********************************
      $fclose(tri_report);
      $fclose(tri_report_ieee754);
      $display("=== The maxix factoriation result is compared! Please check the report! ===");
      #1000;
      $stop; 
    end // if(write_fi)
  end //for loop
end //initial begin-end

endmodule
