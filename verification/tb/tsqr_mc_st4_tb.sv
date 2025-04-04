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
`ifdef ST4_RANDOM_TEST_4X2
  `define TILE_NO 2 
  `define TILE_NO_2 
`elsif ST4_RANDOM_TEST_6X2
  `define TILE_NO 3 
  `define TILE_NO_3 
`endif

module tsqr_mc_st4_tb();
//---------------------------------------------------------
//--- wire and reg declaration 
//---------------------------------------------------------
reg                         clk        ;
reg                         rst        ;
reg                         tsqr_en    ;
reg  [`CNT_WIDTH - 1:0]       tile_no    ;

`ifdef SINGLE_CORE_INT
wire                        mem0_fi_c_0 ;
wire                        mem1_fi_c_0 ;
`endif //SINGLE_CORE_INT
wire                        tsqr_fi    ; 
reg  [`MEM_NO-1:0]          dma_mem_ena  ;
reg  [`RAM_WEA_WIDTH-1:0]   dma_mem_wea  ;
reg  [`RAM_ADDR_WIDTH-1:0]  dma_mem_addra;
reg  [`RAM_WIDTH-1:0]       dma_mem_dina ;
reg  [`MEM_NO-1:0]          dma_mem_enb  ;
reg  [`RAM_ADDR_WIDTH-1:0]  dma_mem_addrb;
wire [`RAM_WIDTH-1:0]       dma_mem_doutb;

//---------------------------------------------------------
//--- golden model and input file 
//---------------------------------------------------------
reg [`MATRIX_WIDTH*64-1:0]  tri_ram[0:`MATRIX_WIDTH-1]   ; //For the matlab tsqr function, only the upper triangle (8*8) is stored. 
reg [`TILE_NO*`MATRIX_WIDTH*64-1:0] dmx_ram[0:`MATRIX_WIDTH-1] ;


initial begin
$display("=== The maxix factoriation Starts! (%d ns) ====", $time);
`ifdef SINGLE_CORE
  `ifdef ST4_RANDOM_TEST_4X2
     $display("Initilize The Memory in ST4_RANDOM_TEST_4X2 (%d ns) in Single-core Design",$time);
     $readmemh("../golden/sc_st4_random_test_4x2/dmx_ieee754.txt" , dmx_ram);
     $readmemh("../golden/sc_st4_random_test_4x2/tri_ieee754.txt" , tri_ram);
   `elsif ST4_RANDOM_TEST_6X2
     $display("Initilize The Memory in ST4_RANDOM_TEST_6X2 (%d ns) in Single-core Design",$time);
     $readmemh("../golden/sc_st4_random_test_6x2/dmx_ieee754.txt" , dmx_ram);
     $readmemh("../golden/sc_st4_random_test_6x2/tri_ieee754.txt" , tri_ram);
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
tsqr_st4_c1 u_tsqr_mc (.clk        (clk          ),
                   .rst        (rst          ),
	           .tsqr_en      (tsqr_en      ),
	           .tile_no      (tile_no      ),
                   .dma_mem_ena  (dma_mem_ena  ),
                   .dma_mem_wea  (dma_mem_wea  ),
                   .dma_mem_addra(dma_mem_addra),
                   .dma_mem_dina (dma_mem_dina ),
                   .dma_mem_enb  (dma_mem_enb  ),
                   .dma_mem_addrb(dma_mem_addrb),
                   .dma_mem_doutb(dma_mem_doutb),
`ifdef SINGLE_CORE_INT
	           .mem0_fi_c_0   (mem0_fi_c_0   ),
                   .mem1_fi_c_0   (mem1_fi_c_0   ),
`endif //SINGLE_CORE_INT
                   .tsqr_fi      (tsqr_fi      ));

//---------------------------------------------------------------------
//------- BFM
//---------------------------------------------------------------------
integer i;
always #5 clk = ~clk;
initial begin
   rst     = 1'b1;
   clk     = 1'b0;
   tsqr_en = 1'b0;
   tile_no = `TILE_NO;
   dma_mem_ena   = `MEM_NO'h0             ;
`ifdef ST_WIDTH_4
   dma_mem_wea   = `WEA2   ;
`endif
   dma_mem_addra = `RAM_ADDR_WIDTH'h0 ;
   dma_mem_dina  = `RAM_WIDTH'h0      ;
   dma_mem_enb   = 1'b0               ;
   dma_mem_addrb = `RAM_ADDR_WIDTH'h0 ;
   #100;
   rst     = 1'b0;
   #16; 
    for(i=0; i<`MATRIX_WIDTH;) begin
      dma_mem_addra = i;
      dma_mem_ena = `MEM_NO'b100;
      dma_mem_dina = dmx_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-0)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-1)*64];
      #10
      
      dma_mem_ena = `MEM_NO'b010;
      dma_mem_dina=dmx_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-1)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-2)*64];
      #10;
`ifdef TILE_NO_3 
      dma_mem_ena = `MEM_NO'b001;
      dma_mem_dina=dmx_ram[i][`MATRIX_WIDTH*(`TILE_NO-0-2)*64-1:`MATRIX_WIDTH*(`TILE_NO-0-3)*64];
      #10;
`endif
      i=i+1;
    end
    dma_mem_ena = `MEM_NO'b000;
    tsqr_en = 1'b1;
   
   wait(tsqr_fi);
   @(posedge clk); 
   tsqr_en = 1'b0;
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
`ifdef ST4_RANDOM_TEST_4X2
  tri_report=$fopen("../sim/sc_st4_random_test_4x2/tri_report.log", "w");
  tri_report_ieee754=$fopen("../sim/sc_st4_random_test_4x2/tri_report_ieee754.log", "w");
  $fwrite(tri_report, "==========================================\n");
  $fwrite(tri_report, "Single-core Simulation\n"                    );
  $fwrite(tri_report, "Test case: ST4_RANDOM_TEST_4X2\n"        );
  $fwrite(tri_report, "==========================================\n");
`elsif ST4_RANDOM_TEST_6X2
  tri_report=$fopen("../sim/sc_st4_random_test_6x2/tri_report.log", "w");
  tri_report_ieee754=$fopen("../sim/sc_st4_random_test_6x2/tri_report_ieee754.log", "w");
  $fwrite(tri_report, "==========================================\n");
  $fwrite(tri_report, "Single-core Simulation\n"                    );
  $fwrite(tri_report, "Test case: ST4_RANDOM_TEST_6X2\n"        );
  $fwrite(tri_report, "==========================================\n");
`endif

      // ********************************
      // ---------- write report --------
      // ********************************
      for(col_index=0; col_index<`MATRIX_WIDTH;) begin
        gol_col=tri_ram[col_index];
        dut_col=u_tsqr_mc.hh_core.simple_dual_19_2.ram[col_index];
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
