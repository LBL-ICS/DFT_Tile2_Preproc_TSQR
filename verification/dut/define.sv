//*********************************************************************************************//
//---------------- Parameterized Design on TSQR----------------------------------------------////
//---------------- Author: Xiaokun Yang  ----------------------------------------------------////
//---------------- Lawrence Berkeley Lab ----------------------------------------------------////
//---------------- Date: 3/12/2025 ----------------------------------------------------------//// 
//----- Common 
//----- Step 1: Select the TSQR core number (signle-, dual-, quad-, eight-cores)-------------////
//*********************************************************************************************//

// **************************************************
// -------------------------------------------------- 
// -----Parameterizable Streaming Width ------------- 
// -----1. Please select the Streaming Width --------
// -------------------------------------------------- 
`define ST_WIDTH_2
`define MAX_NO 2 
`define ROW_NO 2

`define SUB_DELAY   10
`define DIV_DELAY   10
`define ART_DELAY   10
`define SIN_DELAY   10
`define COS_DELAY   10

`define PP_DELAY `SUB_DELAY+`DIV_DELAY+`ART_DELAY+`SIN_DELAY+`COS_DELAY
// -------------------------------------------------- 
// -----End Configuration
// -------------------------------------------------- 
// **************************************************

`define SW 2
`define DW 64

`ifdef ST_WIDTH_2
  `define ST_WIDTH_INF_2
  `define ST 2
`elsif ST_WIDTH_4
  `define ST_WIDTH_INF_2
  `define ST_WIDTH_INF_4
  `define ST 4
`endif

`ifdef ST_WIDTH_2
  //`define RAM_DEPTH      ((`ROW_NO*`ROW_NO*8)/16) //ram size
  //`define RAM_ADDR_WIDTH $clog2(`RAM_DEPTH))      //address width
  //`define RAM_ADDR_WIDTH 1                          //address width
  //`define RAM_WIDTH      (`ST*`DW)                  //ram width by bits
  //`define RAM_WEA_WIDTH  (`RAM_WIDTH/8)            //ram width by byte
  `define RAM_DEPTH      2                          //ram size
  `define RAM_ADDR_WIDTH 1                          //address width:1
  `define RAM_WIDTH      128                  //ram width by bits:2*64
  `define RAM_WEA_WIDTH  16            //ram width by byte:128/8=16
`endif

