package Preprocessor

import Binary_Modules.BinaryDesigns.{LZC_name, cordic, divider_name, full_adder_name, full_subtractor_name, multiplier_name}
import chisel3.{util, _}
import chisel3.{util, _}
import FPPackageMario.FP_Modules.FPUnits._
import FPPackageMario.FP_Modules.FormatConvert.convert_string_to_IEEE_754
import chisel3.stage.ChiselGeneratorAnnotation
import circt.stage.{ChiselStage, FirtoolOption}
import chisel3.util._
import chisel3.util.{ShiftRegister, log2Ceil}

import java.io.PrintWriter

//    _________ columns
// sw|
//   |
//   |
//   |
//

object tile2 extends App {
  (new ChiselStage).execute(
    Array("--target", "systemverilog", "--target-dir", "verification/dut" ),
    Seq(ChiselGeneratorAnnotation(() => new preprocessor(77,64, 2,32,2)))
  )
}

class preprocessor( name:Int, bw: Int, streaming_width:Int, ram_depth: Int, cols: Int) extends Module {

  // bw is 64 and streaming width is 512
  override def desiredName = s"pp"

  val io = IO(new Bundle(){

    //  val clk = Input(Clock())
    //  val rst = Input(Bool())
    val pp_mem0_fi = Input(Bool())
    val pp_mem1_fi = Input(Bool())
    val pp_tsqr_en = Output(Bool())
    val pp_en = Input(Bool())
    val pp_e_upg = Input(UInt((bw/2).W))
    val pp_e_ug = Input(UInt((bw/2).W))
    val pp_e_pg = Input(UInt((bw/2).W))
    val pp_pg_ready = Input(Bool())
    val pp_ug_ready = Input(Bool())
    val pp_e_pg_ready = Input(Bool())
    val pp_e_upg_ready = Input(Bool())
    val pp_e_ug_ready = Input(Bool())
    val pp_pg_i = Input(UInt((bw * streaming_width).W))
    val pp_ug_i = Input(UInt((bw * streaming_width).W))
    val out_ug = Output(UInt((bw * streaming_width).W))
    // val ram_wea = Output(UInt((bw * streaming_width/4).W))
    //  val clock_out = Output(Clock())
    //val out_addra = Output(UInt(((log2Ceil(streaming_width)-1)).W))
    val pp_mem_ena = Output(UInt(3.W))
    val pp_mem_wea = Output(UInt((bw * streaming_width/4).W))
    val pp_mem_addra = Output(UInt((bw.W)))
    val pp_mem_dina = Output(UInt((bw * streaming_width).W))

    val tsqr_fi = Input(Bool())


  })





  val e_upg = ShiftRegister((io.pp_e_upg + (1 << 23).asUInt),13) // 13 is latency of adder
  dontTouch(e_upg)
  val adder = Module(new FP_add_name(bw/2, 13,name))
  adder.io.in_en := io.pp_en
  adder.io.in_valid := true.B
  adder.io.in_a := io.pp_e_ug
  adder.io.in_b := (io.pp_e_pg.asSInt^(0x80000000.asSInt)).asUInt//double check this
  val divider = Module(new FP_div_name(bw/2,15,name))

  divider.io.in_en :=io.pp_en
  divider.io.in_valid:=true.B
  divider.io.in_a:= e_upg
  divider.io.in_b:=adder.io.out_s
  val atan = Module(new FP_atan_name(bw/2,30,name))
  val cos = Module(new FP_cos_name(bw/2,20,name))
  atan.io.in_en:=io.pp_en
  atan.io.in_valid:=true.B
  atan.io.in_tan:=divider.io.out_s
  val theta = (atan.io.out_atan) - (1 << 23).asUInt
  cos.io.in_en:=io.pp_en
  cos.io.in_valid:=true.B
  cos.io.in_angle:= theta


  val sin_reg = RegInit(VecInit(Seq.fill(cols)(0.U(32.W))))
  val cos_reg = RegInit(VecInit(Seq.fill(cols)(0.U(32.W))))
  val sin_perm = Wire(UInt(32.W))
  val cos_perm = Wire(UInt(32.W))
  sin_perm := 0.U
  cos_perm := 0.U
  dontTouch(cos_perm)
  dontTouch(sin_perm)
  val writeIndex = RegInit(0.U(log2Ceil(cols).W))
  val writeDone = RegInit(false.B)
  val cos_out_valid =  ShiftRegister(io.pp_e_upg_ready, 93+12, io.pp_en)
  when(cos_out_valid && !writeDone) {
    sin_reg(writeIndex) := cos.io.out_sin
    cos_reg(writeIndex) := cos.io.out_cos
    writeIndex := writeIndex + 1.U
    when(writeIndex === (cols - 1).U) {
      writeDone := true.B
    }
  }

  val axpy = Module(new doublex_axpy(bw/2, streaming_width,name)).io
  val shifted_input = RegInit(true.B)
  val non_shifted_input = RegInit(false.B)
  dontTouch(shifted_input)
  dontTouch(non_shifted_input)
  val shiftCycles = 3*cols
  val shiftCount = RegInit(0.U(bw.W))


  val index = RegInit(0.U(log2Ceil(cols).W))
  dontTouch(index)
  when(shifted_input){

    val VECTOR_LAT = 93+4+12
    val pg_in_shifted = ShiftRegister(io.pp_pg_i, VECTOR_LAT, io.pp_en)
    val ug_in_shifted = ShiftRegister(io.pp_ug_i, VECTOR_LAT, io.pp_en)
    val pg_in_ready_shifted = ShiftRegister(io.pp_pg_ready, VECTOR_LAT, io.pp_en)

    when(pg_in_ready_shifted) {
      index := Mux(index === (cols-1).U, 0.U, index + 1.U)
      sin_perm := sin_reg(index)
      cos_perm := cos_reg(index)

    }
    axpy.in_scalar_1 := sin_perm
    axpy.in_scalar_2 := cos_perm
    for(i <-0 until streaming_width) {
      axpy.in_complex_1(i).Re := pg_in_shifted(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))(bw - 1, bw / 2)
      axpy.in_complex_1(i).Im := pg_in_shifted(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))((bw / 2) - 1, 0)
      axpy.in_complex_2(i).Re := ug_in_shifted(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))(bw - 1, bw / 2)
      axpy.in_complex_2(i).Im := ug_in_shifted(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))((bw / 2) - 1, 0)


    }

    shiftCount := shiftCount + 1.U
    when(shiftCount === (shiftCycles+100+24+12).U) {
      shifted_input := false.B
      non_shifted_input := true.B
    }

  }.elsewhen(non_shifted_input){

    when(io.pp_pg_ready) {
      index := Mux(index === (cols-1).U, 0.U, index + 1.U)
      sin_perm := sin_reg(index)
      cos_perm := cos_reg(index)

    }
    axpy.in_scalar_1 := sin_perm
    axpy.in_scalar_2 := cos_perm
    for(i <-0 until streaming_width) {
      axpy.in_complex_1(i).Re := io.pp_pg_i(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))(bw - 1, bw / 2)
      axpy.in_complex_1(i).Im := io.pp_pg_i(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))((bw / 2) - 1, 0)
      axpy.in_complex_2(i).Re := io.pp_ug_i(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))(bw - 1, bw / 2)
      axpy.in_complex_2(i).Im := io.pp_ug_i(streaming_width * bw - (i * bw) - 1, (streaming_width * bw - (bw * (i + 1))))((bw / 2) - 1, 0)


    }

  }.otherwise{

    when(io.pp_pg_ready) {
      index := Mux(index === (cols-1).U, 0.U, index + 1.U)
      sin_perm := sin_reg(index)
      cos_perm := cos_reg(index)

    }
    axpy.in_scalar_1 := 0.U
    axpy.in_scalar_2 := 0.U
    for(i <-0 until streaming_width) {
      axpy.in_complex_1(i).Re := 0.U
      axpy.in_complex_1(i).Im := 0.U
      axpy.in_complex_2(i).Re := 0.U
      axpy.in_complex_2(i).Im := 0.U


    }

  }




  val new_ug = Wire(Vec(streaming_width, UInt(bw.W)))
  for(i <- 0 until streaming_width){
    new_ug(i) := Cat(axpy.out_axpy(i).Re, axpy.out_axpy(i).Im)
  }
  io.out_ug:= Cat(new_ug)


  val controller = Module(new pp_controller(bw, streaming_width, cols,name) )





  val latency = 98+24+12
  val shift_reg = RegInit(VecInit.fill(latency)(0.U(bw.W)))
  shift_reg(0) := io.pp_ug_ready
  for(i <- 1 until latency){
    shift_reg(i) := shift_reg(i-1)
  }

  val shift_reg_axpy = RegInit(VecInit.fill(26)(0.U(bw.W)))
  shift_reg_axpy(0) := io.pp_ug_ready
  for(i <- 1 until 26){
    shift_reg_axpy(i) := shift_reg_axpy(i-1)
  }

  when(shifted_input){
    controller.io.in_valid:= shift_reg((latency-1))

  }.elsewhen(non_shifted_input){

    controller.io.in_valid:= shift_reg_axpy((26-1))
  }.otherwise{

    controller.io.in_valid:= 0.U
  }
  // controller.io.in_valid:= RegNext(io.tile2_ug_ready)
  controller.io.ug_in := io.out_ug
  controller.io.mem0_fi := io.pp_mem0_fi
  controller.io.mem1_fi := io.pp_mem1_fi
  controller.io.tsqr_fi := io.tsqr_fi
  //outputs
  io.pp_mem_addra:= controller.io.DMA_addra
  io.pp_mem_ena := controller.io.DMA_ena
  io.pp_mem_wea := controller.io.DMA_wea
  io.pp_mem_dina := controller.io.DMA_dina




  io.pp_tsqr_en:= controller.io.tsqr_en


}

class doublex_axpy(bw: Int, streaming_width:Int, name:Int) extends Module{

  val io = IO {
    new Bundle() {
      val in_complex_1 = Input(Vec((streaming_width), new ComplexNum(bw, name)))
      val in_complex_2 = Input(Vec((streaming_width), new ComplexNum(bw,name)))
      val in_scalar_1 = Input(UInt((bw).W))
      val in_scalar_2 = Input(UInt((bw).W))
      val out_axpy = Output(Vec((streaming_width), new ComplexNum(bw,name)))
      val valid_out = Output(Bool())
    }
  }

  val multiply_layer_1_Re = for(i <- 0 until streaming_width)yield{
    val multiply_1_Re = Module(new FP_mult_name(bw,13,name)).io
    multiply_1_Re.in_en := true.B
    multiply_1_Re.in_valid := true.B
    multiply_1_Re
  }
  val multiply_layer_1_Im = for(i <- 0 until streaming_width)yield{
    val multiply_1_Im = Module(new FP_mult_name(bw,13,name)).io
    multiply_1_Im.in_en := true.B
    multiply_1_Im.in_valid := true.B
    multiply_1_Im
  }
  val multiply_layer_2_Re = for(i <- 0 until streaming_width)yield{
    val multiply_2_Re = Module(new FP_mult_name(bw,13,name)).io
    multiply_2_Re.in_en := true.B
    multiply_2_Re.in_valid := true.B

    multiply_2_Re
  }
  val multiply_layer_2_Im = for(i <- 0 until streaming_width)yield{
    val multiply_2_Im = Module(new FP_mult_name(bw,13,name)).io
    multiply_2_Im.in_en := true.B
    multiply_2_Im.in_valid := true.B

    multiply_2_Im
  }

  val adder_layer_Re = for (i <- 0 until streaming_width) yield {
    val adder_Re = Module(new FP_add_name(bw,13,name)).io
    adder_Re.in_en := true.B
    adder_Re.in_valid:= true.B
    adder_Re
  }

  val adder_layer_Im = for (i <- 0 until streaming_width) yield {
    val adder_Im = Module(new FP_add_name(bw,13,name)).io
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


class ComplexNum(bw: Int, name:Int) extends Bundle{
  val Re = UInt(bw.W)
  val Im = UInt(bw.W)
}

class pp_controller(bw: Int, streaming_width:Int, columns: Int, name:Int) extends Module {
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


  val mem0_delayed = ShiftRegister(mem0_flag,26 )
  val mem1_delayed = ShiftRegister(mem1_flag,26 )

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


/*
class FP_div_name(bw: Int, L: Int, name:Int) extends Module {
  require(bw == 16 || bw == 32 || bw == 64 || bw == 128)
  val io = IO(new Bundle() {
    val in_en = Input(Bool())
    val in_valid = Input(Bool())
    val in_a = Input(UInt(bw.W))
    val in_b = Input(UInt(bw.W))
    val out_s = Output(UInt(bw.W))
    val out_valid = Output(Bool())
  })
  override def desiredName = s"FP_divider_${bw}_${L}_${name}"
  val (exponent, mantissa) = bw match {
    case 16 => (5,10)
    case 32 => (8,23)
    case 64 => (11,52)
    case 128 => (15,112)
  }
  val max_exp = (BigInt(2).pow(exponent) - 2).U(exponent.W)
  val min_exp = 1.U(exponent.W)
  val max_frac = (BigInt(2).pow(mantissa) - 1).U(mantissa.W)
  val min_frac = 0.U(mantissa.W)
  val bias = (BigInt(2).pow(exponent - 1) - 1).U(exponent.W)
  // get the sign bit of the two inptus
  val sign_wire = Wire(Vec(2, UInt(1.W)))
  sign_wire(0) := io.in_a(bw - 1)
  sign_wire(1) := io.in_b(bw - 1)

  // get the exponents of the two inputs
  val exp_wire = Wire(Vec(2, UInt(exponent.W)))
  when(io.in_a(bw - 2, mantissa) > max_exp) {
    exp_wire(0) := max_exp
  }.elsewhen(io.in_a(bw-2,mantissa) < min_exp){ // saturating inputs
    exp_wire(0) := min_exp
  }.otherwise {
    exp_wire(0) := io.in_a(bw - 2, mantissa)
  }
  when(io.in_b(bw - 2, mantissa) > max_exp) {
    exp_wire(1) := max_exp
  }.elsewhen(io.in_b(bw-2,mantissa) < min_exp){
    exp_wire(1) := min_exp
  }.otherwise {
    exp_wire(1) := io.in_b(bw - 2, mantissa)
  }

  // get the mantissa parts of the two inputs
  val frac_wire = Wire(Vec(2, UInt(mantissa.W)))
  frac_wire(0) := io.in_a(mantissa - 1, 0)
  frac_wire(1) := io.in_b(mantissa - 1, 0)

  // 1.0 + mantissa part of the two numbers
  val whole_frac_wire = Wire(Vec(2, UInt((mantissa + 1).W)))
  whole_frac_wire(0) := 1.U ## frac_wire(0)
  whole_frac_wire(1) := 1.U ## frac_wire(1)

  val new_sign_wire = Wire(UInt(1.W))
  new_sign_wire := sign_wire(0) ^ sign_wire(1)

  // subtract exponent value of the second input from the bias value
  val postProcess_exp_subtractor = Module(new full_subtractor_name(exponent,name))
  postProcess_exp_subtractor.io.in_a := exp_wire(0) // the bias
  postProcess_exp_subtractor.io.in_b := exp_wire(1) - bias // the second input
  postProcess_exp_subtractor.io.in_c := 0.U

  val frac_divider = Module(new divider_name((mantissa + 2), L,true, name)).io
  frac_divider.in_ready := io.in_en
  frac_divider.in_reset := false.B
  frac_divider.in_valid := io.in_valid
  frac_divider.in_a := whole_frac_wire(0) ## (0.U((1).W))
  frac_divider.in_b := whole_frac_wire(1) ## (0.U((1).W))

  val uo_check = ShiftRegister(exp_wire(1) < bias, L, io.in_en) //  if yes means we add to exp(0) else we do regular subtraction
  val carry_flag = ShiftRegister(postProcess_exp_subtractor.io.out_c.asBool, L, io.in_en) // if(y0check) then lookout for cflag low implies overflow, else cflag high implies underflow
  val msb_check = frac_divider.out_s((mantissa + 1))
  val exp_sum = ShiftRegister(postProcess_exp_subtractor.io.out_s, L, io.in_en)

  val new_sign_reg = ShiftRegister(new_sign_wire,L,io.in_en)


  val o_flag_reg = Mux(uo_check,!carry_flag || ((exp_sum -& (!msb_check).asUInt) > max_exp), false.B) // if true, overflow detected
  val u_flag_reg = Mux(!uo_check,carry_flag || ((exp_sum -& (!msb_check).asUInt) < min_exp), false.B) // if true, underflow detected
  val new_exp_reg = exp_sum
  val new_frac_reg = frac_divider.out_s

  io.out_valid := frac_divider.out_valid
  val out_sign = new_sign_reg
  val out_exp = Mux(o_flag_reg, max_exp, Mux(u_flag_reg, min_exp, Mux(msb_check, new_exp_reg, new_exp_reg - 1.U)))
  val out_frac = Mux(o_flag_reg, max_frac, Mux(u_flag_reg, min_frac,Mux(msb_check, new_frac_reg(mantissa, 1), new_frac_reg((mantissa - 1), 0))))
  io.out_s := out_sign ## out_exp ## out_frac
}
class FP_mult_name(bw: Int, pd: Int, name:Int) extends Module {
  require(bw == 16 || bw == 32 || bw == 64 || bw == 128)
  require(pd == 1 || pd == 3 || pd == 7 || pd == 8 || pd == 10 || pd == 13)
  val io = IO(new Bundle() {
    val in_en = Input(Bool())
    val in_valid = Input(Bool())
    val in_a = Input(UInt(bw.W))
    val in_b = Input(UInt(bw.W))
    val out_s = Output(UInt(bw.W))
    val out_valid = Output(Bool())
  })
  override def desiredName = s"FP_mult_${bw}_${pd}_v2_${name}"
  val (exponent, mantissa) = bw match {
    case 16 => (5,10)
    case 32 => (8,23)
    case 64 => (11,52)
    case 128 => (15,112)
  }
  val sr_array = pd match {
    case 1 => Array(0,0,0,0,0,0,0,0,0,1)
    case 3 => Array(1,0,0,1,1,0,0,0,0,0)
    case 7 => Array(1,0,0,1,1,0,1,1,1,1)
    case 8 => Array(1,0,0,2,3,0,1,0,0,1)
    case 10 => Array(1,1,1,1,1,1,1,1,1,1)
    case 13 => Array(1,1,1,2,2,1,1,2,1,1)
  }

  val in_a = ShiftRegister(io.in_a, sr_array(0) ,io.in_en)
  val in_b = ShiftRegister(io.in_b, sr_array(0), io.in_en)

  val sign_wire = Wire(Vec(2, UInt(1.W)))
  sign_wire(0) := in_a(bw - 1)
  sign_wire(1) := in_b(bw - 1)

  val max_exp = (BigInt(2).pow(exponent) - 2).U(exponent.W)
  val min_exp = 1.U(exponent.W)
  val max_frac = (BigInt(2).pow(mantissa) - 1).U(mantissa.W)
  val min_frac = 0.U(mantissa.W)
  val bias = (BigInt(2).pow(exponent - 1) - 1).U(exponent.W)

  // get the exponents of the two inputs
  val exp_wire = Wire(Vec(2, UInt(exponent.W)))
  when(in_a(bw - 2, mantissa) > max_exp) {
    exp_wire(0) := max_exp
  }.elsewhen(in_a(bw-2,mantissa) < min_exp){ // saturating inputs
    exp_wire(0) := min_exp
  }.otherwise {
    exp_wire(0) := in_a(bw - 2, mantissa)
  }
  when(in_b(bw - 2, mantissa) > max_exp) {
    exp_wire(1) := max_exp
  }.elsewhen(in_b(bw-2,mantissa) < min_exp){
    exp_wire(1) := min_exp
  }.otherwise {
    exp_wire(1) := in_b(bw - 2, mantissa)
  }

  // get the mantissa parts of the two inputs
  val frac_wire = Wire(Vec(2, UInt(mantissa.W)))
  frac_wire(0) := in_a(mantissa - 1, 0)
  frac_wire(1) := in_b(mantissa - 1, 0)

  // 1.0 + mantissa part of the two numbers
  val whole_frac_wire = Wire(Vec(2, UInt((mantissa + 1).W)))
  whole_frac_wire(0) := 1.U ## frac_wire(0)
  whole_frac_wire(1) := 1.U ## frac_wire(1)

  val whole_frac_sr = ShiftRegister(whole_frac_wire, sr_array(1), io.in_en)
  val sign_sr = ShiftRegister(sign_wire, sr_array(1), io.in_en)
  val exp_sr = ShiftRegister(exp_wire, sr_array(1), io.in_en)

  val new_sign_wire = Wire(UInt(1.W))
  new_sign_wire := sign_sr(0) ^ sign_sr(1)

  val new_sign_sr = ShiftRegister(new_sign_wire, sr_array(2), io.in_en)
  val exp_sr_2 = ShiftRegister(exp_sr, sr_array(2), io.in_en)
  val whole_frac_sr_2 = ShiftRegister(whole_frac_sr, sr_array(2), io.in_en)

  val exp_adder = Module(new full_adder_name(exponent,name))
  exp_adder.io.in_a := exp_sr_2(0)
  exp_adder.io.in_b := exp_sr_2(1) - bias
  exp_adder.io.in_c := 0.U

  val exp_adder_outs_sr = ShiftRegister(exp_adder.io.out_s, sr_array(3), io.in_en)
  val exp_adder_outc_sr = ShiftRegister(exp_adder.io.out_c, sr_array(3), io.in_en)
  val new_sign_sr_2 = ShiftRegister(new_sign_sr, sr_array(3), io.in_en)
  val exp_sr_3 = ShiftRegister(exp_sr_2, sr_array(3), io.in_en)
  val whole_frac_sr_3 = ShiftRegister(whole_frac_sr_2, sr_array(3), io.in_en)

  val frac_multiplier = Module(new multiplier_name(mantissa + 1,name)).io
  frac_multiplier.in_a := whole_frac_sr_3(0)
  frac_multiplier.in_b := whole_frac_sr_3(1)

  val frac_mult_out_sr = ShiftRegister(frac_multiplier.out_s, sr_array(4), io.in_en)
  val exp_adder_outs_sr_2 = ShiftRegister(exp_adder_outs_sr, sr_array(4), io.in_en)
  val exp_adder_outc_sr_2 = ShiftRegister(exp_adder_outc_sr, sr_array(4), io.in_en)
  val new_sign_sr_3 = ShiftRegister(new_sign_sr_2, sr_array(4), io.in_en)
  val exp_sr_4 = ShiftRegister(exp_sr_3, sr_array(4), io.in_en)


  val uo_check = ShiftRegister(exp_sr_4(1),sr_array(5), io.in_en) < bias
  val carry_flag = ShiftRegister(exp_adder_outc_sr_2.asBool, sr_array(5), io.in_en)
  val exp_sum = ShiftRegister(exp_adder_outs_sr_2, sr_array(5), io.in_en)
  val new_sign_reg = ShiftRegister(new_sign_sr_3,sr_array(5),io.in_en)
  val msb_check = ShiftRegister(frac_mult_out_sr((mantissa + 1) * 2 - 1),sr_array(5),io.in_en)
  val new_frac_reg = ShiftRegister(frac_mult_out_sr,sr_array(5),io.in_en)



  val u_flag_reg = ShiftRegister(Mux(uo_check,!carry_flag || ((exp_sum +& msb_check.asUInt) < min_exp), false.B), sr_array(6), io.in_en) // if true, underflow detected
  val o_flag_reg = ShiftRegister(Mux(!uo_check,carry_flag || ((exp_sum +& msb_check.asUInt) > max_exp), false.B), sr_array(6), io.in_en) // if true, overflow detected
  val new_exp_reg = ShiftRegister(exp_sum,sr_array(6),io.in_en)
  val new_sign_reg_2 = ShiftRegister(new_sign_reg,sr_array(6),io.in_en)
  val new_frac_reg_2 = ShiftRegister(new_frac_reg,sr_array(6),io.in_en)




  val out_exp_innermux = ShiftRegister(Mux(new_frac_reg_2((mantissa + 1) * 2 - 1).asBool, new_exp_reg + 1.U, new_exp_reg), sr_array(7), io.in_en)
  val out_frac_innermux = ShiftRegister(Mux(new_frac_reg_2((mantissa + 1) * 2 - 1).asBool, new_frac_reg_2((mantissa + 1) * 2 - 2, mantissa + 1), new_frac_reg_2((mantissa + 1) * 2 - 3, mantissa)), sr_array(7), io.in_en)
  val u_flag_reg_2 = ShiftRegister(u_flag_reg, sr_array(7), io.in_en) // if true, underflow detected
  val o_flag_reg_2 = ShiftRegister(o_flag_reg, sr_array(7), io.in_en) // if true, overflow detected
  val new_sign_reg_3 = ShiftRegister(new_sign_reg_2,sr_array(7),io.in_en)



  val out_exp_innermux_2 = ShiftRegister(Mux(o_flag_reg_2, max_exp, out_exp_innermux), sr_array(8), io.in_en)
  val out_frac_innermux_2 = ShiftRegister(Mux(o_flag_reg_2, max_frac, out_frac_innermux), sr_array(8), io.in_en)
  val new_sign_reg_4 = ShiftRegister(new_sign_reg_3,sr_array(8),io.in_en)
  val u_flag_reg_3 = ShiftRegister(u_flag_reg_2, sr_array(8), io.in_en) // if true, underflow detected

  val out_sign = new_sign_reg_4
  val out_exp = Mux(u_flag_reg_3, min_exp, out_exp_innermux_2)
  val out_frac = Mux(u_flag_reg_3, min_frac, out_frac_innermux_2)
  io.out_s := ShiftRegister(out_sign ## out_exp ## out_frac,sr_array(9),io.in_en)
  io.out_valid := ShiftRegister(io.in_valid, pd, io.in_en)
}
class FP_add_name(bw: Int, pd: Int, name:Int) extends Module {

  require(bw == 16 || bw == 32 || bw == 64 || bw == 128)
  require(pd == 1 || pd == 3 || pd == 7 || pd == 10 || pd == 11 || pd == 13)
  val io = IO(new Bundle() {
    val in_en = Input(Bool())
    val in_valid = Input(Bool())
    val in_a = Input(UInt(bw.W))
    val in_b = Input(UInt(bw.W))
    val out_s = Output(UInt(bw.W))
    val out_valid = Output(Bool())
  })
  override def desiredName = s"FP_add_${bw}_${pd}_${name}"
  val (exponent, mantissa) = bw match {
    case 16 => (5,10)
    case 32 => (8,23)
    case 64 => (11,52)
    case 128 => (15,112)
  }

  val sr_array = pd match {
    case 1 => Array(0,0,0,0,0,0,0,0,0,1)
    case 3 => Array(0,0,1,0,0,1,0,0,0,1)
    case 7 => Array(1,0,1,0,1,1,0,1,1,1)
    case 10 => Array(1,1,1,1,1,1,1,1,1,1)
    case 11 => Array(1,1,1,1,1,1,1,1,1,2)
    case 13 => Array(1,1,2,1,1,2,1,1,1,2)
  }

  val max_exp = (BigInt(2).pow(exponent) - 2).U(exponent.W)
  val min_exp = 1.U(exponent.W)
  val max_frac = (BigInt(2).pow(mantissa) - 1).U(mantissa.W)
  val min_frac = 0.U(mantissa.W)


  val in_a = ShiftRegister(io.in_a,sr_array(0),io.in_en)
  val in_b = ShiftRegister(io.in_b,sr_array(0),io.in_en)


  // get the sign bit of the two inptus
  val sign_wire = Wire(Vec(2, UInt(1.W)))
  sign_wire(0) := in_a(bw - 1)
  sign_wire(1) := in_b(bw - 1)

  // get the exponents of the two inputs
  val exp_wire = Wire(Vec(2, UInt(exponent.W)))
  when(in_a(bw - 2, mantissa) > BigInt(2).pow(exponent).U - 2.U) {
    exp_wire(0) := BigInt(2).pow(exponent).U - 2.U
  }.elsewhen(in_a(bw-2,mantissa) < 1.U){ // saturating inputs
    exp_wire(0) := 1.U
  }.otherwise {
    exp_wire(0) := in_a(bw - 2, mantissa)
  }
  when(in_b(bw - 2, mantissa) > BigInt(2).pow(exponent).U - 2.U) {
    exp_wire(1) := BigInt(2).pow(exponent).U - 2.U
  }.elsewhen(in_b(bw-2,mantissa) < 1.U){
    exp_wire(1) := 1.U
  }.otherwise {
    exp_wire(1) := in_b(bw - 2, mantissa)
  }

  // get the mantissa parts of the two inputs
  val frac_wire = Wire(Vec(2, UInt(mantissa.W)))
  frac_wire(0) := in_a(mantissa - 1, 0)
  frac_wire(1) := in_b(mantissa - 1, 0)

  // 1.0 + mantissa part of the two numbers
  val whole_frac_wire = Wire(Vec(2, UInt((mantissa + 1).W)))
  whole_frac_wire(0) := 1.U ## frac_wire(0)
  whole_frac_wire(1) := 1.U ## frac_wire(1)


  val exp_sr = ShiftRegister(exp_wire, sr_array(1), io.in_en)
  val whole_frac_sr = ShiftRegister(whole_frac_wire, sr_array(1), io.in_en)
  val sign_sr = ShiftRegister(sign_wire, sr_array(1), io.in_en)

  val exp_subtractor = Module(new full_subtractor_name(exponent, name))
  exp_subtractor.io.in_a := exp_sr(0)
  exp_subtractor.io.in_b := exp_sr(1)
  exp_subtractor.io.in_c := 0.U

  val exp_sub_out_c = ShiftRegister(exp_subtractor.io.out_c, sr_array(2), io.in_en)
  val exp_sub_out_s = ShiftRegister(exp_subtractor.io.out_s, sr_array(2), io.in_en)
  val exp_sr_2 = ShiftRegister(exp_sr, sr_array(2), io.in_en)
  val whole_frac_sr_2 = ShiftRegister(whole_frac_sr, sr_array(2), io.in_en)
  val sign_sr_2 = ShiftRegister(sign_sr, sr_array(2), io.in_en)

  val eqexp_arrange = ShiftRegister(Mux(exp_sr_2(0)===exp_sr_2(1),whole_frac_sr_2(1) > whole_frac_sr_2(0),false.B), sr_array(3), io.in_en)  // special case in which exponents are equal, check if mantissa1 > mantissa0
  val exp_sr_3 = ShiftRegister(exp_sr_2, sr_array(3), io.in_en)
  val whole_frac_sr_3 = ShiftRegister(whole_frac_sr_2, sr_array(3), io.in_en)
  val sign_sr_3 = ShiftRegister(sign_sr_2, sr_array(3), io.in_en)
  val exp_sub_out_c_2 = ShiftRegister(exp_sub_out_c, sr_array(3), io.in_en)
  val exp_sub_out_s_2 = ShiftRegister(exp_sub_out_s, sr_array(3), io.in_en)


  val redundant_op = ShiftRegister(Mux(exp_sub_out_c_2.asBool, (~exp_sub_out_s_2).asUInt + 1.U, exp_sub_out_s_2) > mantissa.U,sr_array(4),io.in_en) // difference between exponents overly large for alignment (could work around this by having more bits)
  val fracadd_in_a = ShiftRegister(Mux(exp_sub_out_c_2.asBool, whole_frac_sr_3(1), whole_frac_sr_3(eqexp_arrange)),sr_array(4),io.in_en) // selects the larger mantissa part of the two
  val fracadd_in_b = ShiftRegister(Mux(exp_sub_out_c_2.asBool, whole_frac_sr_3(0) >> ((~exp_sub_out_s_2).asUInt + 1.U), whole_frac_sr_3(!eqexp_arrange) >> exp_sub_out_s_2),sr_array(4),io.in_en) // whichever mantissa is smaller is aligned with respect to larger mantissa
  val ref_exp = ShiftRegister(Mux(exp_sub_out_c_2.asBool, exp_sr_3(1),exp_sr_3(0)),sr_array(4),io.in_en) // the larger exp of the two is reference
  val ref_sign = ShiftRegister(Mux(exp_sub_out_c_2.asBool, sign_sr_3(1),sign_sr_3(eqexp_arrange)),sr_array(4),io.in_en) // same with sign and so on
  val diff_sign = ShiftRegister(sign_sr_3(0) ^ sign_sr_3(1), sr_array(4), io.in_en) // need to check if signs are diff, if yes then we know result cannot grow so look out for leading zeros in frac sum else result may grow so check for frac sum carry


  val frac_adder = Module(new full_adder_name(mantissa + 1, name)).io
  frac_adder.in_a := fracadd_in_a
  frac_adder.in_b := Mux(diff_sign.asBool, (~fracadd_in_b).asUInt + 1.U, fracadd_in_b) // note that if signs are diff we need to twos complement the smaller inp regardless if it is actually negative or not
  frac_adder.in_c := 0.U

  val frac_adder_out_c = ShiftRegister(frac_adder.out_c, sr_array(5), io.in_en)
  val frac_adder_out_s = ShiftRegister(frac_adder.out_s, sr_array(5), io.in_en)
  val diff_sign_2 = ShiftRegister(diff_sign, sr_array(5), io.in_en)
  val redundant_op_2 = ShiftRegister(redundant_op, sr_array(5), io.in_en)
  val ref_sign_2 = ShiftRegister(ref_sign, sr_array(5), io.in_en)
  val ref_exp_2 = ShiftRegister(ref_exp, sr_array(5), io.in_en)

  val sign_out = ShiftRegister(Mux(diff_sign_2.asBool && !redundant_op_2, Mux(frac_adder_out_c.asBool, ref_sign_2, !ref_sign_2), ref_sign_2),sr_array(6),io.in_en) // from observation, if diff signs, then frac sum carry = 0 implies a sign change, otherwise same sign stays
  val fracadd_outs = ShiftRegister(frac_adder_out_s,sr_array(6),io.in_en)
  val fracadd_outc = ShiftRegister(frac_adder_out_c,sr_array(6),io.in_en)
  val diff_sign_3 = ShiftRegister(diff_sign_2, sr_array(6), io.in_en)
  val ref_exp_3 = ShiftRegister(ref_exp_2, sr_array(6), io.in_en)

  val LZC_inst = Module(new LZC_name(bw,2,name)).io
  LZC_inst.in_d := fracadd_outs ## (VecInit.fill(bw - (mantissa + 1))(true.B)).asUInt
  val leadzeroindex = ShiftRegister(LZC_inst.out_c, sr_array(7), io.in_en) // this lead zero index is computed because diff_sign implies result could be smaller which may introduce lead zeros in fracsum
  val ref_exp_4 = ShiftRegister(ref_exp_3, sr_array(7), io.in_en)
  val fracadd_outs_2 = ShiftRegister(fracadd_outs, sr_array(7), io.in_en)
  val diff_sign_4 = ShiftRegister(diff_sign_3, sr_array(7), io.in_en)
  val fracadd_outc_2 = ShiftRegister(fracadd_outc, sr_array(7), io.in_en)
  val sign_out_2 = ShiftRegister(sign_out, sr_array(7), io.in_en)

  val red = ref_exp_4 -& leadzeroindex
  val inc = ref_exp_4 +& 1.U

  val shifted_left = fracadd_outs_2(mantissa - 1, 0) << leadzeroindex

  val diff_sign_5 = ShiftRegister(diff_sign_4, sr_array(8), io.in_en)
  val innermux_frac_true = ShiftRegister(Mux(fracadd_outs_2(mantissa).asBool, fracadd_outs_2(mantissa-1,0), Mux(red(exponent) || (red < min_exp), min_frac, shifted_left)), sr_array(8), io.in_en)
  val innermux_frac_false = ShiftRegister(Mux(fracadd_outc_2.asBool, Mux(inc(exponent) || (inc > max_exp), max_frac, fracadd_outs_2(mantissa,1)), fracadd_outs_2(mantissa-1,0)), sr_array(8), io.in_en)
  val innermux_exp_true = ShiftRegister(Mux(fracadd_outs_2(mantissa).asBool, ref_exp_4, Mux(red(exponent) || (red < min_exp), min_exp, red(exponent-1,0))), sr_array(8), io.in_en)
  val innermux_exp_false = ShiftRegister(Mux(fracadd_outc_2.asBool, Mux(inc(exponent) || (inc > max_exp), max_exp, inc(exponent-1,0)), ref_exp_4), sr_array(8), io.in_en)
  val sign_out_3 = ShiftRegister(sign_out_2, sr_array(8), io.in_en)

  val norm_out_frac = (ShiftRegister(Mux(diff_sign_5.asBool,
    innermux_frac_true,
    innermux_frac_false),
    sr_array(9), io.in_en))(mantissa - 1,0)

  val norm_out_exp = ShiftRegister(Mux(diff_sign_5.asBool,
    innermux_exp_true,
    innermux_exp_false),
    sr_array(9), io.in_en)
  val norm_out_sign = ShiftRegister(sign_out_3, sr_array(9), io.in_en)

  io.out_valid := ShiftRegister(io.in_valid, pd, io.in_en)
  io.out_s := norm_out_sign ## norm_out_exp ## norm_out_frac
}
class FP_cos_name(bw: Int, iters: Int, name:Int) extends Module{
  val (exponent, mantissa) = bw match {
    case 16 => (5,10)
    case 32 => (8,23)
    case 64 => (11,52)
    case 128 => (15,112)
  }
  val io = IO(new Bundle{
    val in_en = Input(Bool())
    val in_valid = Input(Bool())
    val in_angle = Input(UInt(bw.W))
    val out_valid = Output(Bool())
    val out_cos = Output(UInt(bw.W))
    val out_sin = Output(UInt(bw.W))
  })
  override def desiredName = s"FP_cos_${bw}_$iters"
  val TWOPI = convert_string_to_IEEE_754((Math.PI * 2 ).toString, bw).U(bw.W)
  val fpdiv = Module(new FP_div_name(bw,15, name)).io
  fpdiv.in_en := io.in_en
  fpdiv.in_valid := io.in_valid
  fpdiv.in_a := io.in_angle
  fpdiv.in_b := TWOPI
  val fpfloor = Module(new FP_floor(bw)).io
  fpfloor.in_en := io.in_en
  fpfloor.in_valid := fpdiv.out_valid
  fpfloor.in_data := 0.U(1.W) ## fpdiv.out_s(bw-2,0)
  val sign = ShiftRegister(fpdiv.out_s(bw-1), 1, io.in_en)
  val fpmult = Module(new FP_mult_name(bw,3, name)).io
  fpmult.in_en := io.in_en
  fpmult.in_valid := fpfloor.out_valid
  fpmult.in_a := sign ## fpfloor.out_frac(bw-2,0)
  fpmult.in_b := TWOPI
  val floatfixed = Module(new FloatTOFixed(bw, bw-mantissa, mantissa)).io
  floatfixed.in_en := io.in_en
  floatfixed.in_valid := fpmult.out_valid
  floatfixed.in_float := fpmult.out_s
  val cordic = Module(new cordic(bw, false, mantissa, iters)).io
  cordic.in_en := io.in_en
  cordic.in_valid := floatfixed.out_valid
  cordic.in_d := floatfixed.out_fixed
  val fixedfloat_cos = Module(new FixedTOFloat(bw, bw-mantissa, mantissa)).io
  fixedfloat_cos.in_en := io.in_en
  fixedfloat_cos.in_valid := cordic.out_valid
  fixedfloat_cos.in_fixed := cordic.out_x
  val fixedfloat_sin = Module(new FixedTOFloat(bw, bw-mantissa, mantissa)).io
  fixedfloat_sin.in_en := io.in_en
  fixedfloat_sin.in_valid := cordic.out_valid
  fixedfloat_sin.in_fixed := cordic.out_y
  io.out_valid := fixedfloat_cos.out_valid
  io.out_cos := fixedfloat_cos.out_float
  io.out_sin := fixedfloat_sin.out_float
}

class FP_atan_name(bw: Int, iters: Int,name:Int) extends Module{
  val (exponent, mantissa) = bw match {
    case 16 => (5,10)
    case 32 => (8,23)
    case 64 => (11,52)
    case 128 => (15,112)
  }
  val io = IO(new Bundle{
    val in_en = Input(Bool())
    val in_valid = Input(Bool())
    val in_tan = Input(UInt(bw.W))
    val out_valid = Output(Bool())
    val out_atan = Output(UInt(bw.W))
  })
  override def desiredName = s"FP_atan_${bw}_$iters"
  val floatfixed = Module(new FloatTOFixed(bw, bw/2, bw/2)).io
  floatfixed.in_en := io.in_en
  floatfixed.in_valid := io.in_valid
  floatfixed.in_float := io.in_tan
  val cordic = Module(new cordic(bw, true, bw/2, iters)).io
  cordic.in_en := io.in_en
  cordic.in_valid := floatfixed.out_valid
  cordic.in_d := floatfixed.out_fixed
  val fixedfloat_atan = Module(new FixedTOFloat(bw, bw/2, bw/2)).io
  fixedfloat_atan.in_en := io.in_en
  fixedfloat_atan.in_valid := cordic.out_valid
  fixedfloat_atan.in_fixed := cordic.out_z
  io.out_valid := fixedfloat_atan.out_valid
  io.out_atan := fixedfloat_atan.out_float
}
*/