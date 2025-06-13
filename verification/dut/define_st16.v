//*********************************************************************************************//
//---------------- Parameterized Design on TSQR----------------------------------------------////
//---------------- Author: Xiaokun Yang  ----------------------------------------------------////
//---------------- Lawrence Berkeley Lab ----------------------------------------------------////
//---------------- Date: 6/14/2023 ----------------------------------------------------------//// 
//----- Step 1: Select the TSQR core number (signle-, dual, quad-cores)----------------------////
//----- Step 2: Select the streaing width of the householder (16, 32, 64, 128, 256) ---------////
//----- Step 3: Select the MOF of FP operators (100MHz or 400 MHz for FPGA evaluation) ------////
//----- Step 4: Select the simulation or FPGA implemenation ---------------------------------////
//*********************************************************************************************//
`define ST16_RANDOM_TEST_32X8 

// **************************************************
// -------------------------------------------------- 
// -----Parameterizable Multi-core Desgin ----------- 
// -----1. Please select the number of cores
// -------------------------------------------------- 
`define SINGLE_CORE

// -------------------------------------------------- 
// -----End Configuration
// -------------------------------------------------- 
// **************************************************
`ifdef SINGLE_CORE
  `define SINGLE_CORE_INT
`endif

`ifdef SINGLE_CORE
  `define MEM_NO 3
`endif

// **************************************************
// -------------------------------------------------- 
// -----Parameterizable Streaming Width of HH-------- 
// -----2. Please select the Streaming Width of HH
// -------------------------------------------------- 
`define ST_WIDTH_16

// -------------------------------------------------- 
// -----End Configuration
// -------------------------------------------------- 
// **************************************************

`ifdef ST_WIDTH_16
  `define ST_WIDTH_INF_16
`endif

`define CNT_WIDTH      16 

`ifdef ST_WIDTH_16
  `define RAM_ADDR_WIDTH 4   
  `define RAM_WIDTH      512           //2x64
  `define RAM_WEA_WIDTH  64            //128/8
  `define RAM_DEPTH      8 
  `define MATRIX_WIDTH   8  
  `define MATRIX_HEIGHT  16  
`endif

`ifdef ST_WIDTH_16
  `define WEA2    `RAM_WEA_WIDTH'hffff
  `define WEA1    `RAM_WEA_WIDTH'h00ff
`endif
  

