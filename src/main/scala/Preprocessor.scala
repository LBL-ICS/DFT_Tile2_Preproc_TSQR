package Preprocessor

import chisel3.{util, _}
import FP_Modules.FPUnits._
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

class preprocessor( bw: Int, streaming_width:Int, ram_depth: Int) extends Module {

  // bw is 64 and streaming width is 512
  override def desiredName = s"tile2"

  val io = IO(new Bundle(){

//  val clk = Input(Clock())
//  val rst = Input(Bool())
  val tile2_mem0_fi = Input(Bool())
  val tile2_mem1_fi = Input(Bool())
  val tile2_tsqr_en = Output(Bool())
  val in_valid = Input(Bool())
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
  val tile2_tr_mem_ena = Output(Bool())
  val tile2_tr_mem_wea = Output(UInt((bw * streaming_width/4).W))
  val tile2_tr_mem_addra = Output(UInt((bw.W)))
  val tile2_tr_mem_dina = Output(UInt((bw * streaming_width).W))
  val tile2_d0_mem_ena = Output(Bool())
  val tile2_d0_mem_wea = Output(UInt((bw * streaming_width/4).W))
  val tile2_d0_mem_addra = Output(UInt((bw.W)))
  val tile2_d0_mem_dina = Output(UInt((bw * streaming_width).W))
  val tile2_d1_mem_ena = Output(Bool())
  val tile2_d1_mem_wea = Output(UInt((bw * streaming_width/4).W))
  val tile2_d1_mem_addra = Output(UInt((bw.W)))
  val tile2_d1_mem_dina = Output(UInt((bw * streaming_width).W))
  val tsqr_fi = Input(Bool())


})


  val VECTOR_LAT = 105
//   io.tile2_tr_mem_ena := 0.U
//   io.tile2_tr_mem_wea := 0.U
//   io.tile2_tr_mem_addra := 0.U
//   io.tile2_tr_mem_dina := 0.U

  val ready_pg_in = ShiftRegister(io.in_valid, VECTOR_LAT, io.tile2_tsqr_en)
  val ready_ug_in = ShiftRegister(io.in_valid, VECTOR_LAT, io.tile2_tsqr_en)


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
    axpy.in_complex_1(i).Re := io.tile2_pg_i(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))(bw - 1, bw / 2)
    axpy.in_complex_1(i).Im := io.tile2_pg_i(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))((bw / 2) - 1, 0)
    axpy.in_complex_2(i).Re := io.tile2_ug_i(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))(bw - 1, bw / 2)
    axpy.in_complex_2(i).Im := io.tile2_ug_i(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))((bw / 2) - 1, 0)


  }




  val ug_reg = Reg(Vec((streaming_width), UInt(width = bw.W)))



  val new_ug = Wire(Vec(streaming_width, UInt(bw.W)))
  for(i <- 0 until streaming_width){
        new_ug(i) := Cat(axpy.out_axpy(i).Re, axpy.out_axpy(i).Im)
      }
  io.out_ug:= Cat(new_ug)


  val controller = Module(new pp_controller(bw, streaming_width, streaming_width*2) )


  val latency = 99
  val shift_reg = RegInit(VecInit.fill(latency)(0.U(bw.W)))
  shift_reg(0) := io.in_valid
  for(i <- 1 until latency){
    shift_reg(i) := shift_reg(i-1)
  }

  controller.io.in_valid:= shift_reg((latency) - 1)
  controller.io.ug_in := io.out_ug
  controller.io.mem0_fi := io.tile2_mem0_fi
  controller.io.mem1_fi := io.tile2_mem1_fi
  controller.io.tsqr_fi := io.tsqr_fi
  //outputs
  io.tile2_tr_mem_ena:= controller.io.in_en_tr
  io.tile2_d0_mem_ena:= controller.io.in_en_d0
  io.tile2_d1_mem_ena:= controller.io.in_en_d1

  io.tile2_tr_mem_addra:= controller.io.addra_tr
  io.tile2_d0_mem_addra:= controller.io.addra_d0
  io.tile2_d1_mem_addra:= controller.io.addra_d1

  io.tile2_tr_mem_wea := controller.io.wea_tr
  io.tile2_d0_mem_wea := controller.io.wea_d0
  io.tile2_d1_mem_wea := controller.io.wea_d1

  io.tile2_tr_mem_dina:= controller.io.dina_tr
  io.tile2_d0_mem_dina:= controller.io.dina_d0
  io.tile2_d1_mem_dina:= controller.io.dina_d1

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
      val in_en_tr = Output(Bool())
      val in_en_d0 = Output(Bool())
      val in_en_d1 = Output(Bool())
      val ug_in = Input(UInt((bw * streaming_width).W))
      val addra_tr = Output(UInt(bw.W))
      val wea_tr = Output(UInt((bw * streaming_width/4).W))
      val wea_d0 = Output(UInt((bw * streaming_width/4).W))
      val wea_d1 = Output(UInt((bw * streaming_width/4).W))
      val dina_tr = Output(UInt((bw * streaming_width).W))
      val dina_d0 = Output(UInt((bw * streaming_width).W))
      val addra_d0 = Output(UInt(bw.W))
      val dina_d1 = Output(UInt((bw * streaming_width).W))
      val addra_d1 = Output(UInt(bw.W))
      val tsqr_en = Output(Bool())
      val mem0_fi = Input(Bool())
      val mem1_fi = Input(Bool())
      val tsqr_fi = Input(Bool())

    }
  }

  io.in_en_tr := 0.U
  io.in_en_d0 := 0.U
  io.in_en_d1 := 0.U

  io.addra_tr := 0.U
  io.addra_d0 := 0.U
  io.addra_d1 := 0.U


  io.wea_tr := 0.U
  io.wea_d0 := 0.U
  io.wea_d1 := 0.U
  io.dina_tr := 0.U
  io.dina_d0 := 0.U
  io.dina_d1 := 0.U
  io.tsqr_en := 0.U


  val first_cycle_tr = RegInit(false.B)
  val first_cycle_d0 = RegInit(false.B)
  val first_cycle_d1 = RegInit(false.B)
  val d0_cycle = RegInit(false.B)
  val d1_cycle = RegInit(false.B)
  val addr_counter = RegInit(0.U(bw.W))
  val cycle_counter = RegInit(0.U((bw.W)))
  io.wea_tr:= Fill(bw*streaming_width/4, 1.U)
  io.wea_d1:= Fill(bw*streaming_width/4, 1.U)
  io.wea_d0:= Fill(bw*streaming_width/4, 1.U)

  val tr_trigger = RegInit(false.B)

  when(io.in_valid && !tr_trigger) {
    first_cycle_tr := true.B
    tr_trigger := true.B  //
  }

  val tsqr_en_reg = RegInit(false.B)
  io.tsqr_en := tsqr_en_reg
  when(io.tsqr_fi){

    tsqr_en_reg := false.B

  }



  val mem0_flag = RegInit(false.B)
  val mem1_flag = RegInit(false.B)
  when(io.mem0_fi) {
    mem0_flag := true.B  //
  }

  when(io.mem1_fi) {
    mem1_flag := true.B  //
  }



  when(first_cycle_tr) {
    io.in_en_tr := true.B
    io.addra_tr := addr_counter
    io.dina_tr := io.ug_in
    addr_counter := addr_counter + 1.U
    when(addr_counter === (columns - 1).U) {
      first_cycle_tr := false.B
      first_cycle_d0 := true.B
      addr_counter := 0.U
    }.otherwise {
      addr_counter := addr_counter + 1.U
    }
  }.elsewhen(first_cycle_d1) {
    io.in_en_d1 := true.B
    io.addra_d1 := addr_counter
    io.dina_d1 := io.ug_in
    addr_counter := addr_counter + 1.U
    when(addr_counter === (columns - 1).U) {
      first_cycle_d1 := false.B
      d0_cycle := true.B
      addr_counter := 0.U
    }.otherwise {
      addr_counter := addr_counter + 1.U
    }
  }.elsewhen(d0_cycle&& mem0_flag) {


    when(cycle_counter < (columns).U) {
      io.in_en_d0 := true.B
      io.addra_d0 := addr_counter
      io.dina_d0 := io.ug_in
      addr_counter := addr_counter + 1.U
      cycle_counter := cycle_counter + 1.U
    }.otherwise {
      d0_cycle := false.B
      d1_cycle := true.B
      addr_counter := 0.U
      cycle_counter := 0.U
      mem0_flag := false.B
    }
  }.elsewhen(d1_cycle && mem1_flag) {



    when(cycle_counter < (columns).U) {
      io.in_en_d1 := true.B
      io.addra_d1 := addr_counter
      io.dina_d1 := io.ug_in
      addr_counter := addr_counter + 1.U
      cycle_counter := cycle_counter + 1.U
    }.otherwise {
      d1_cycle := false.B
      d0_cycle := true.B
      addr_counter := 0.U
      cycle_counter := 0.U
      mem1_flag:= false.B
    }

  }.elsewhen(first_cycle_d0) {
    io.in_en_d0 := true.B
    io.addra_d0 := addr_counter
    io.dina_d0 := io.ug_in
    addr_counter := addr_counter + 1.U
    when(addr_counter === (columns - 1).U) {
      first_cycle_d0 := false.B
      first_cycle_d1 := true.B
      tsqr_en_reg := true.B
      addr_counter := 0.U
    }.otherwise {
      addr_counter := addr_counter + 1.U
    }
}
}







class preprocessor2( bw: Int, streaming_width:Int, ram_depth: Int) extends Module {

  // bw is 64 and streaming width is 512

  val io = IO(new Bundle(){


    val in_valid = Input(Bool())
    val in_en = Input(Bool())
    val e_upg = Input(UInt((bw/2).W))
    val e_ug = Input(UInt((bw/2).W))
    val e_pg = Input(UInt((bw/2).W))

    val in_pg = Input(UInt((bw).W))
    val in_ug = Input(UInt((bw).W))
    val out_ug = Output(UInt((bw).W))
    // val ram_wea = Output(UInt((bw * streaming_width/4).W))
    //  val clock_out = Output(Clock())
    //val out_addra = Output(UInt(((log2Ceil(streaming_width)-1)).W))




  })





  val e_upg = io.e_upg + (1 << 23).asUInt
  // val e_upg_Im = io.e_upg((bw/2-1),0) << 1
  //  val e_ug_Re = io.e_ug(bw-1,bw/2)
  //  val e_ug_Im = io.e_ug((bw/2-1),0)
  //  val e_pg_Re = io.e_pg(bw-1,bw/2)
  //  val e_pg_Im = io.e_pg((bw/2-1),0)

  val adder = Module(new FP_add(bw/2, 1))
  adder.io.in_en := true.B
  adder.io.in_valid := true.B
  adder.io.in_a := io.e_ug
  adder.io.in_b := (io.e_pg.asSInt^(0x80000000.asSInt)).asUInt//double check this
  val divider = Module(new FP_div(bw/2,15))
  divider.io.in_en :=true.B
  divider.io.in_valid:=true.B
  divider.io.in_a:=e_upg
  divider.io.in_b:=adder.io.out_s
  val atan = Module(new FP_atan(bw/2,32))
  val cos = Module(new FP_cos(bw/2,20))
  atan.io.in_en:=true.B
  atan.io.in_valid:=true.B
  atan.io.in_tan:=divider.io.out_s
  val theta = (atan.io.out_atan) - (1 << 23).asUInt
  cos.io.in_en:=true.B
  cos.io.in_valid:=true.B
  cos.io.in_angle:= theta
  io.out_ug:= cos.io.out_sin
//  val axpy = Module(new doublex_axpy(bw/2, streaming_width)).io
//
//  for(i <-0 until streaming_width){
//    axpy.in_complex_1(i).Re := io.tile2_pg_i(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))(bw-1,bw/2)
//    axpy.in_complex_1(i).Im := io.tile2_pg_i(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))((bw/2)-1,0)
//    axpy.in_complex_2(i).Re := io.tile2_ug_i(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))(bw-1,bw/2)
//    axpy.in_complex_2(i).Im := io.tile2_ug_i(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))((bw/2)-1,0)
//  }
//  axpy.in_scalar_1:= cos.io.out_sin
//  axpy.in_scalar_2:= cos.io.out_cos
//
//
//
//  val ug_reg = Reg(Vec((streaming_width), UInt(width = bw.W)))
//
//  val new_ug = Wire(Vec(streaming_width, UInt(bw.W)))
//  for(i <- 0 until streaming_width){
//    new_ug(i) := Cat(axpy.out_axpy(i).Re, axpy.out_axpy(i).Im)
//  }
//  io.out_ug:= Cat(new_ug.reverse)



}


object tile2 extends App {
  (new ChiselStage).execute(
    Array("--target", "systemverilog", "--target-dir", "verification/dut" ),
    Seq(ChiselGeneratorAnnotation(() => new preprocessor(64, 2,32)))
  )
}

object pp_ctrl extends App {
  (new ChiselStage).execute(
    Array("--target", "systemverilog", "--target-dir", "verification/dut/axpy" ),
    Seq(ChiselGeneratorAnnotation(() => new pp_controller(32, 4, 4)))
  )
}
object preprocessor extends App {
  (new ChiselStage).execute(
    Array("--target", "systemverilog", "--target-dir", "verification/dut" ),
    Seq(ChiselGeneratorAnnotation(() => new preprocessor2(64, 2,32)))
  )
}