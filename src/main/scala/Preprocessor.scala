package Preprocessor

import chisel3.{util, _}

import chisel3.{util, _}
import FPPackageMario.FP_Modules.FPUnits._
import chisel3.stage.ChiselGeneratorAnnotation
import circt.stage.{ChiselStage, FirtoolOption}
import chisel3.util._
import chisel3.util.{ShiftRegister, log2Ceil}
//    _________ columns
// sw|
//   |
//   |
//   |
//

class preprocessor( bw: Int, streaming_width:Int, ram_depth: Int, cols: Int) extends Module {

  // bw is 64 and streaming width is 512
  override def desiredName = s"tile2"

  val io = IO(new Bundle(){

    //  val clk = Input(Clock())
    //  val rst = Input(Bool())
    val tile2_mem0_fi = Input(Bool())
    val tile2_mem1_fi = Input(Bool())
    val tile2_tsqr_en = Output(Bool())
    val tile2_en = Input(Bool())
    val tile2_e_upg = Input(UInt((bw/2).W))
    val tile2_e_ug = Input(UInt((bw/2).W))
    val tile2_e_pg = Input(UInt((bw/2).W))
    val tile2_pg_ready = Input(Bool())
    val tile2_ug_ready = Input(Bool())
    val tile2_e_pg_ready = Input(Bool())
    val tile2_e_upg_ready = Input(Bool())
    val tile2_e_ug_ready = Input(Bool())
    val tile2_pg_i = Input(UInt((bw * streaming_width).W))
    val tile2_ug_i = Input(UInt((bw * streaming_width).W))
    val out_ug = Output(UInt((bw * streaming_width).W))
    // val ram_wea = Output(UInt((bw * streaming_width/4).W))
    //  val clock_out = Output(Clock())
    //val out_addra = Output(UInt(((log2Ceil(streaming_width)-1)).W))
    val tile2_mem_ena = Output(UInt(3.W))
    val tile2_mem_wea = Output(UInt((bw * streaming_width/4).W))
    val tile2_mem_addra = Output(UInt((bw.W)))
    val tile2_mem_dina = Output(UInt((bw * streaming_width).W))

    val tsqr_fi = Input(Bool())


  })


  val VECTOR_LAT = 93+4
  //   io.tile2_tr_mem_ena := 0.U
  //   io.tile2_tr_mem_wea := 0.U
  //   io.tile2_tr_mem_addra := 0.U
  //   io.tile2_tr_mem_dina := 0.U


  val pg_in_shifted = ShiftRegister(io.tile2_pg_i, VECTOR_LAT, io.tile2_en)
  val ug_in_shifted = ShiftRegister(io.tile2_ug_i, VECTOR_LAT, io.tile2_en)

  val e_upg = io.tile2_e_upg + (1 << 23).asUInt

  val adder = Module(new FP_add(bw/2, 1))
  adder.io.in_en := io.tile2_en
  adder.io.in_valid := (io.tile2_e_pg_ready && io.tile2_e_ug_ready)
  adder.io.in_a := io.tile2_e_ug
  adder.io.in_b := (io.tile2_e_pg.asSInt^(0x80000000.asSInt)).asUInt//double check this
  val divider = Module(new FP_div(bw/2,15))
  divider.io.in_en :=io.tile2_en
  divider.io.in_valid:=(adder.io.out_valid&&io.tile2_e_upg_ready)

  divider.io.in_a:= e_upg


  divider.io.in_b:=adder.io.out_s
  val atan = Module(new FP_atan(bw/2,30))
  val cos = Module(new FP_cos(bw/2,20))
  atan.io.in_en:=io.tile2_en
  atan.io.in_valid:=divider.io.out_valid
  atan.io.in_tan:=divider.io.out_s
  val theta = (atan.io.out_atan) - (1 << 23).asUInt
  cos.io.in_en:=io.tile2_en
  cos.io.in_valid:=atan.io.out_valid
  cos.io.in_angle:= theta
  val sin_reg = RegInit(0x00000000.U)
  val cos_reg = RegInit(0x00000000.U)
  sin_reg := cos.io.out_sin
  cos_reg := cos.io.out_cos



  val axpy = Module(new doublex_axpy(bw/2, streaming_width)).io
  axpy.in_scalar_1:= sin_reg
  axpy.in_scalar_2:= cos_reg


  for(i <-0 until streaming_width) {
    axpy.in_complex_1(i).Re := pg_in_shifted(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))(bw - 1, bw / 2)
    axpy.in_complex_1(i).Im := pg_in_shifted(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))((bw / 2) - 1, 0)
    axpy.in_complex_2(i).Re := ug_in_shifted(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))(bw - 1, bw / 2)
    axpy.in_complex_2(i).Im := ug_in_shifted(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))((bw / 2) - 1, 0)


  }



  val new_ug = Wire(Vec(streaming_width, UInt(bw.W)))
  for(i <- 0 until streaming_width){
    new_ug(i) := Cat(axpy.out_axpy(i).Re, axpy.out_axpy(i).Im)
  }
  io.out_ug:= Cat(new_ug)


  val controller = Module(new pp_controller(bw, streaming_width, cols) )


  val latency = 98
  val shift_reg = RegInit(VecInit.fill(latency)(0.U(bw.W)))
  shift_reg(0) := io.tile2_ug_ready
  for(i <- 1 until latency){
    shift_reg(i) := shift_reg(i-1)
  }



  controller.io.in_valid:= shift_reg((latency-1))
 // controller.io.in_valid:= RegNext(io.tile2_ug_ready)
  controller.io.ug_in := io.out_ug
  controller.io.mem0_fi := io.tile2_mem0_fi
  controller.io.mem1_fi := io.tile2_mem1_fi
  controller.io.tsqr_fi := io.tsqr_fi
  //outputs
  io.tile2_mem_addra:= controller.io.DMA_addra
  io.tile2_mem_ena := controller.io.DMA_ena
  io.tile2_mem_wea := controller.io.DMA_wea
  io.tile2_mem_dina := controller.io.DMA_dina




  io.tile2_tsqr_en:= controller.io.tsqr_en


}

class doublex_axpy(bw: Int, streaming_width:Int) extends Module{

  val io = IO {
    new Bundle() {
      val in_complex_1 = Input(Vec((streaming_width), new ComplexNum(bw)))
      val in_complex_2 = Input(Vec((streaming_width), new ComplexNum(bw)))
      val in_scalar_1 = Input(UInt((bw).W))
      val in_scalar_2 = Input(UInt((bw).W))
      val out_axpy = Output(Vec((streaming_width), new ComplexNum(bw)))
      val valid_out = Output(Bool())
    }
  }

  val multiply_layer_1_Re = for(i <- 0 until streaming_width)yield{
    val multiply_1_Re = Module(new FP_mult(bw,1)).io
    multiply_1_Re.in_en := true.B
    multiply_1_Re.in_valid := true.B
    multiply_1_Re
  }
  val multiply_layer_1_Im = for(i <- 0 until streaming_width)yield{
    val multiply_1_Im = Module(new FP_mult(bw,1)).io
    multiply_1_Im.in_en := true.B
    multiply_1_Im.in_valid := true.B
    multiply_1_Im
  }
  val multiply_layer_2_Re = for(i <- 0 until streaming_width)yield{
    val multiply_2_Re = Module(new FP_mult(bw,1)).io
    multiply_2_Re.in_en := true.B
    multiply_2_Re.in_valid := true.B

    multiply_2_Re
  }
  val multiply_layer_2_Im = for(i <- 0 until streaming_width)yield{
    val multiply_2_Im = Module(new FP_mult(bw,1)).io
    multiply_2_Im.in_en := true.B
    multiply_2_Im.in_valid := true.B

    multiply_2_Im
  }

  val adder_layer_Re = for (i <- 0 until streaming_width) yield {
    val adder_Re = Module(new FP_add(bw,1)).io
    adder_Re.in_en := true.B
    adder_Re.in_valid:= true.B
    adder_Re
  }

  val adder_layer_Im = for (i <- 0 until streaming_width) yield {
    val adder_Im = Module(new FP_add(bw,1)).io
    adder_Im.in_en := true.B
    adder_Im.in_valid:= true.B

    adder_Im
  }

  for(i <- 0 until streaming_width){
    multiply_layer_1_Re(i).in_a := io.in_complex_1(i).Re
    multiply_layer_1_Re(i).in_b := io.in_scalar_1
    multiply_layer_1_Im(i).in_a := io.in_complex_1(i).Im
    multiply_layer_1_Im(i).in_b := io.in_scalar_1
    multiply_layer_2_Re(i).in_a := io.in_complex_2(i).Re
    multiply_layer_2_Re(i).in_b := io.in_scalar_2
    multiply_layer_2_Im(i).in_a := io.in_complex_2(i).Im
    multiply_layer_2_Im(i).in_b := io.in_scalar_2
    adder_layer_Re(i).in_a :=  multiply_layer_1_Re(i).out_s
    adder_layer_Re(i).in_b := multiply_layer_2_Re(i).out_s
    adder_layer_Im(i).in_a :=  multiply_layer_1_Im(i).out_s
    adder_layer_Im(i).in_b := multiply_layer_2_Im(i).out_s
    //io.out_s(i) := adder_layer_Re(i).out_s(((bw/2)-1),0)##adder_layer_Im(i).out_s(((bw/2)-1),0)
    io.out_axpy(i).Re := adder_layer_Re(i).out_s
    io.out_axpy(i).Im := adder_layer_Im(i).out_s

    io.valid_out := adder_layer_Re.map(_.out_valid).reduce(_ && _)
  }
}


class ComplexNum(bw: Int) extends Bundle{
  val Re = UInt(bw.W)
  val Im = UInt(bw.W)
}

class pp_controller(bw: Int, streaming_width:Int, columns: Int) extends Module {
  val io = IO {
    new Bundle() {
      val in_valid = Input(Bool())
      val mem0_fi = Input(Bool())
      val mem1_fi = Input(Bool())
      val tsqr_fi = Input(Bool())
      val ug_in = Input(UInt((bw * streaming_width).W))
      val DMA_addra = Output(UInt(((log2Ceil(streaming_width))).W))
      val DMA_ena = Output(UInt(3.W))
      val DMA_wea = Output(UInt((bw*streaming_width/4).W))
      val DMA_dina = Output(UInt((streaming_width*bw).W))
      val tsqr_en = Output(Bool())


    }
  }

  io.DMA_ena := 0.U(3.W)
  io.DMA_wea := 0.U
  io.DMA_addra := 0.U
  io.DMA_dina := io.ug_in
  io.tsqr_en := 0.U



  val first_round = RegInit(false.B)
  val second_round = RegInit(false.B)
  val third_round = RegInit(false.B)
  val d0_cycle = RegInit(false.B)
  val d1_cycle = RegInit(false.B)
  val addr_counter = RegInit(0.U(bw.W))
  io.DMA_wea:= Fill(bw*streaming_width/4, 1.U) // set wea to ffff always


  val tr_trigger = RegInit(false.B)

  when(io.in_valid && !tr_trigger) { // this ensures first round is set once only
    first_round := true.B
    tr_trigger := true.B
  }

  val tsqr_en_reg = RegInit(false.B) // stop tsqr_en when tsqr_fi is detected
  io.tsqr_en := tsqr_en_reg
  when(io.tsqr_fi){
    tsqr_en_reg := false.B
  }


  // after detecting mem0 or mem1 shift by two ccs to allow the dma to feed pg and ug and allow  pp to compute new ug value
  val mem0_flag = RegInit(false.B)
  val mem1_flag = RegInit(false.B)
  val mem0_flag_initial = RegInit(false.B)
  val mem1_flag_initial = RegInit(false.B)
  when(io.mem0_fi) {
    mem0_flag := true.B  // latch the mem0 flag to a reg
    //mem0_flag := RegNext(RegNext(mem0_flag_initial, init = false.B), init = false.B)
  }
  when(io.mem1_fi) {
    mem1_flag := true.B  // latch mem1 to a reg
    //mem1_flag := RegNext(RegNext(mem1_flag_initial, init = false.B), init = false.B)
  }


  val mem0_delayed = ShiftRegister(mem0_flag,98 )
  val mem1_delayed = ShiftRegister(mem1_flag,98 )

  // 2 means tri buffer
  // 4 means dmx0 buffer
  // 1 means dmx1 buffer
  // var dma_ena_reg = RegInit(2.U(3.W))// init value of dma_ena

  var dma_addra_reg = RegInit(0.U(log2Ceil(streaming_width).W))
  io.DMA_addra := dma_addra_reg


  when(first_round) { // executed once, it should fill tri

    io.DMA_ena := 4.U(3.W)
    dma_addra_reg := dma_addra_reg + 1.U

    when(dma_addra_reg === (columns - 1).U) {
      first_round := false.B
      second_round := true.B
      dma_addra_reg := 0.U
    }.otherwise {
      dma_addra_reg := dma_addra_reg + 1.U
    }
  }.elsewhen(second_round) { // filling dmx1 buffer

    io.DMA_ena := 2.U(3.W)
    dma_addra_reg := dma_addra_reg + 1.U

    when(dma_addra_reg === (columns - 1).U) {
      second_round := false.B
      third_round := true.B
      dma_addra_reg := 0.U
      tsqr_en_reg := true.B
    }.otherwise {
      dma_addra_reg := dma_addra_reg + 1.U
    }
  }.elsewhen(d0_cycle && mem0_delayed && io.in_valid) {


    io.DMA_ena := 2.U(3.W)// to fill dmx0 ena should be 100
    dma_addra_reg := dma_addra_reg + 1.U

    when(dma_addra_reg === (columns - 1).U) {

      d0_cycle := false.B
      d1_cycle := true.B
      dma_addra_reg := 0.U
      mem0_flag := false.B
      mem0_delayed := false.B

    }.otherwise {
      dma_addra_reg := dma_addra_reg + 1.U
    }
  }.elsewhen(d1_cycle && mem1_delayed && io.in_valid) {

    io.DMA_ena := 1.U(3.W) // to fill dmx1 ena should be 001
    dma_addra_reg := dma_addra_reg + 1.U
    when(dma_addra_reg === (columns - 1).U) {

      d1_cycle := false.B
      d0_cycle := true.B
      dma_addra_reg := 0.U
      mem1_flag := false.B
      mem1_delayed := false.B
    }.otherwise {
      dma_addra_reg := dma_addra_reg + 1.U
    }
  }.elsewhen(third_round) {

    io.DMA_ena := 1.U(3.W) // to fill dmx1 ena should be 001
    dma_addra_reg := dma_addra_reg + 1.U

    when(dma_addra_reg === (columns - 1).U) {
      d0_cycle := true.B
      third_round := false.B
      dma_addra_reg := 0.U

    }.otherwise {
      dma_addra_reg := dma_addra_reg + 1.U
    }
  }.otherwise{

    io.DMA_ena := 0.U(3.W)

  }
}
