

 /*//*****************************************
 * 10/19/2023
 * Author: Blair Reasoner
 * Release version: 1
 * 
 * NOTE: Main module to be converted to 
 * RawModule in the future
 * **************************************/
*/



package tsqr_hh_datapath
import Binary_Modules.BinaryDesigns._
import chisel3._
import chisel3.util._
import chisel3.util.{log2Ceil, log2Floor}
import FPPackageMario.FP_Modules.FPUnits.{FP_add_name, FP_div_name, FP_mult_name, FP_sqrt}
import ComplexModules.FPComplex

import chiseltest.RawTester.test

import chisel3.{RawModule, withClockAndReset}
import ComplexModules.FPComplex._

import java.io.PrintWriter
import scala.collection.mutable

object hh_datapath_chisel{

  def main(args: Array[String]) : Unit = {
    val sw2 = new PrintWriter("hh_datapath_16_chisel_test.v")
    sw2.println(getVerilogString(new hh_datapath(12, 32, 16, 16)))
    sw2.close()
  }
//main datapath design module
class hh_datapath_1(name:Int, bw:Int, streaming_width:Int, CNT_WIDTH: Int)extends Module {
    val io = IO {
      new Bundle() {
        val clk = Input(Clock())
        val rst = Input(Bool())
        val hh_cnt = Input(UInt((CNT_WIDTH).W))
        val d1_rdy = Input(Bool())
        val d1_vld = Input(Bool())
        val d2_rdy = Input(Bool())
        val d2_vld = Input(Bool())
        val vk1_rdy = Input(Bool())
        val vk1_vld = Input(Bool())
        val d3_rdy = Input(Bool()) 
        val d3_vld = Input(Bool())
        val tk_rdy = Input(Bool())
        val tk_vld = Input(Bool())
        val d4_rdy = Input(Bool())
        val d4_vld = Input(Bool())
        val d5_rdy = Input(Bool())
        val d5_vld = Input(Bool())
        val yjp_rdy = Input(Bool())
        val yjp_vld = Input(Bool())
        val yj_sft = Input(Bool())
        val d4_sft = Input(Bool())
        val hh_din = Input(UInt((streaming_width*bw).W))
        val hh_dout = Output(UInt((streaming_width*bw).W))
      }
    }
    withClockAndReset (io.clk, io.rst){
  




    val yj_reg_vec_st512 = Reg(Vec(streaming_width/4,UInt(((48128).W))))
    val yj_reg_vec = Reg(Vec(streaming_width/2,UInt(((log2Ceil(streaming_width)*13+24+16+22+9)*2*bw).W)))
    val yj0 = Reg(UInt((streaming_width*bw).W))


      if (streaming_width == (512)) {
        when(io.rst) {
          yj0 := 0.U
          for (i <- 0 until streaming_width / 4) {
            yj_reg_vec_st512(i) := 0.U
          }
        }.elsewhen(io.yj_sft) {
          yj0 := yj_reg_vec_st512(streaming_width / 4 - 1)(streaming_width * bw - 1, 0)
          yj_reg_vec_st512(0) := Cat(io.hh_din, yj_reg_vec_st512(0)((48127), streaming_width * bw))
          for (i <- 1 until streaming_width / 4) {
            yj_reg_vec_st512(i) := Cat(yj_reg_vec_st512(i - 1)(streaming_width * bw - 1, 0), yj_reg_vec_st512(i)((48127), streaming_width * bw))
          }
        }
      }
      else{
        when(io.rst) {
          yj0 := 0.U
          for (i <- 0 until streaming_width / 2) {
            yj_reg_vec(i) := 0.U
          }
        }.elsewhen(io.yj_sft) {
          yj0 := yj_reg_vec(streaming_width / 2 - 1)(streaming_width * bw - 1, 0)
          //yj_reg_vec(0) := Cat(io.hh_din,yj_reg_vec(0)(((log2Ceil(streaming_width)*13+12+129+10-2)*2*bw -1),streaming_width*32))
          yj_reg_vec(0) := Cat(io.hh_din, yj_reg_vec(0)(((log2Ceil(streaming_width) * 13 + 24 + 16 + 22 + 9) * 2 * bw - 1), streaming_width * bw))
          for (i <- 1 until streaming_width / 2) {
            //yj_reg_vec(i):= Cat(yj_reg_vec(i-1)(streaming_width*32-1,0),yj_reg_vec(i)(((log2Ceil(streaming_width)*13+12+129+10-2)*2*bw-1),streaming_width*32))
            yj_reg_vec(i) := Cat(yj_reg_vec(i - 1)(streaming_width * bw - 1, 0), yj_reg_vec(i)(((log2Ceil(streaming_width) * 13 + 24 + 16 + 22 + 9) * 2 * bw - 1), streaming_width * bw))
          }
        }

      }

/*

    val yj0 = Reg(UInt((streaming_width*bw).W))
   //
    val yj_reg_1 = Reg(UInt(((log2Ceil(streaming_width)*13+24+129+22)*streaming_width*(bw/8)).W))
    val yj_reg_2 = Reg(UInt(((log2Ceil(streaming_width)*13+24+129+22)*streaming_width*(bw/8)).W))
    val yj_reg_3 = Reg(UInt(((log2Ceil(streaming_width)*13+24+129+22)*streaming_width*(bw/8)).W))
    val yj_reg_4 = Reg(UInt(((log2Ceil(streaming_width)*13+24+129+22)*streaming_width*(bw/8)).W))
    
    val yj_reg_5 = Reg(UInt(((log2Ceil(streaming_width)*13+24+129+22)*streaming_width*(bw/8)).W))
    val yj_reg_6 = Reg(UInt(((log2Ceil(streaming_width)*13+24+129+22)*streaming_width*(bw/8)).W))
    val yj_reg_7 = Reg(UInt(((log2Ceil(streaming_width)*13+24+129+22)*streaming_width*(bw/8)).W))
    val yj_reg_8 = Reg(UInt(((log2Ceil(streaming_width)*13+24+129+22)*streaming_width*(bw/8)).W))
    //


    when(io.rst){
      yj_reg_1 := 0.U
      yj_reg_2 := 0.U
      yj_reg_3 := 0.U
      yj_reg_4 := 0.U
      yj_reg_5 := 0.U
      yj_reg_6 := 0.U
      yj_reg_7 := 0.U
      yj_reg_8 := 0.U
      yj0 := 0.U
    }.elsewhen(io.yj_sft){


      yj_reg_8 := Cat(yj_reg_7(streaming_width*bw-1,0),yj_reg_8(((log2Ceil(streaming_width)*13+24+129+22+2-2)*streaming_width*(bw/8))-1,streaming_width*bw))
      yj_reg_7 := Cat(yj_reg_6(streaming_width*bw-1,0),yj_reg_7(((log2Ceil(streaming_width)*13+24+129+22+2-2)*streaming_width*(bw/8))-1,streaming_width*bw))
      yj_reg_6 := Cat(yj_reg_5(streaming_width*bw-1,0),yj_reg_6(((log2Ceil(streaming_width)*13+24+129+22+2-2)*streaming_width*(bw/8))-1,streaming_width*bw))
      yj_reg_5 := Cat(yj_reg_4(streaming_width*bw-1,0),yj_reg_5(((log2Ceil(streaming_width)*13+24+129+22+2-2)*streaming_width*(bw/8))-1,streaming_width*bw))
      yj_reg_4 := Cat(yj_reg_3(streaming_width*bw-1,0),yj_reg_4(((log2Ceil(streaming_width)*13+24+129+22+2-2)*streaming_width*(bw/8))-1,streaming_width*bw))
      yj_reg_3 := Cat(yj_reg_2(streaming_width*bw-1,0),yj_reg_3(((log2Ceil(streaming_width)*13+24+129+22+2-2)*streaming_width*(bw/8))-1,streaming_width*bw))
      yj_reg_2 := Cat(yj_reg_1(streaming_width*bw-1,0),yj_reg_2(((log2Ceil(streaming_width)*13+24+129+22+2-2)*streaming_width*(bw/8))-1,streaming_width*bw))
      yj_reg_1 := Cat(io.hh_din,yj_reg_1(((log2Ceil(streaming_width)*13+24+129+22+2-2)*streaming_width*(bw/8))-1,streaming_width*bw))
      yj0 := yj_reg_8(streaming_width*bw-1,0)
    }
    */
    val ddot_din_a = Wire(UInt((streaming_width*bw).W))
    val ddot_din_b = Wire(UInt((streaming_width*bw).W))
    val ddot_dout = Wire(UInt(bw.W))
    val vk = Wire(UInt((streaming_width*bw).W))
    val d1 = Wire(UInt((bw/2).W))
    val d3 = Wire(UInt((bw/2).W))
    val d4 = Wire(UInt(bw.W))
    val vk_update = Wire(UInt((streaming_width*bw).W))
    val ddot_din_a_reg = Reg(UInt((streaming_width*bw).W))
    val ddot_din_b_reg = Reg(UInt((streaming_width*bw).W))
    val vk_reg = Reg(UInt((streaming_width*bw).W))
    val d1_reg = Reg(UInt((bw/2).W))
    val d3_reg = Reg(UInt((bw/2).W))
    val x1_update = Wire(UInt(bw.W))
    val d2_update = Wire(UInt((bw/2).W))
    val vk1_update = Wire(UInt(bw.W))
    val tk_update = Wire(UInt(bw.W))
    val d4_update = Reg(UInt(bw.W))
    val d5_update = Wire(UInt(bw.W))
    val x1 = Wire(UInt(bw.W))
    val d2 = Wire(UInt((bw/2).W))
    val vk1 = Wire(UInt(bw.W))
    val tk = Wire(UInt((bw/2).W))
    val d5 = Wire(UInt(bw.W))
    val x1_reg = Reg(UInt(bw.W))
    val d2_reg = Reg(UInt((bw/2).W))
    val vk1_reg = Reg(UInt(bw.W))
    val tk_reg = Reg(UInt((bw/2).W))
    val d4_reg = Reg(UInt(bw.W))
    val d5_reg = Reg(UInt(bw.W))
    val d5_st512 = Reg(UInt(bw.W))


    when (io.rst){
      ddot_din_a_reg := 0.U
      ddot_din_b_reg := 0.U
      vk_reg := 0.U
      d1_reg := 0.U
      d3_reg := 0.U
      x1_reg := 0.U
      d2_reg := 0.U
      vk1_reg := 0.U
      tk_reg := 0.U
      d4_reg := 0.U
      d5_reg := 0.U
    }.otherwise{
      ddot_din_a_reg := ddot_din_a
      ddot_din_b_reg := ddot_din_b
      vk_reg := vk
      d1_reg := d1
      d3_reg := d3
      x1_reg := x1
      d2_reg := d2
      vk1_reg := vk1
      tk_reg := tk
      d4_reg := d4
      d5_reg := d5
    }

    when(io.d1_rdy){
      ddot_din_a := io.hh_din
    }.elsewhen(io.d3_rdy){
      ddot_din_a := vk
    }.elsewhen(io.d4_rdy){
      ddot_din_a := vk
    }.otherwise{
      ddot_din_a := ddot_din_a_reg
    }

    when(io.d1_rdy){
      ddot_din_b := io.hh_din
    }.elsewhen(io.d3_rdy){
      ddot_din_b := vk
    }.elsewhen(io.d4_rdy){
      ddot_din_b := io.hh_din
    }.otherwise{
      ddot_din_b := ddot_din_b_reg
    }
    
    when(io.vk1_vld){
      vk := vk_update
    }.otherwise{
      vk := vk_reg
    }

   /////VIVADO///// val d4_update_reg = Reg(UInt(((26)*bw).W))
   val d4_update_reg = Reg(UInt(((22)*bw).W)) // old is 126, possibly latency of divider
    when(io.rst){
      d4_update := 0.U
      d4_update_reg := 0.U
    }.elsewhen(io.d4_sft){
      d4_update := d4_update_reg(bw-1, 0)
      //d4_update_reg := Cat(ddot_dout, d4_update_reg(26*bw-1,bw))//126
      d4_update_reg := Cat(ddot_dout, d4_update_reg(22*bw-1,bw))
    }

    when(io.d1_vld){
      d1 := ddot_dout(bw-1,bw/2)
    }.otherwise{
      d1 := d1_reg
    }

    when(io.d3_vld){
      d3 := ddot_dout(bw-1,bw/2)

    }.otherwise{
      d3 := d3_reg
    }

    when(io.d1_rdy){
      x1 := x1_update
    }.otherwise{
      x1 := x1_reg
    }

    when(io.d2_vld){
      d2 := d2_update
    }.otherwise{
      d2 := d2_reg
    }

    when(io.vk1_vld){
      vk1 := vk1_update
    }.otherwise{
      vk1 := vk1_reg
    }

    when(io.tk_vld){
      tk := tk_update
    }.otherwise{
      tk := tk_reg
    }

    when(io.d5_rdy){
      d4 := d4_update
    }.otherwise{
      d4 := d4_reg
    }

    when(io.d5_vld){
      d5 := d5_update
    }.otherwise{
      d5 := d5_reg
    }
    
    val myVec = Wire(Vec(streaming_width, UInt(width = bw.W)))
    for(i <- 0 until streaming_width ){ 
      myVec(i) := io.hh_din(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))
    }
    when(io.rst){
      x1_update := 0.U
    }.elsewhen(io.d1_rdy){
      x1_update := myVec(io.hh_cnt)
    }.otherwise{
      x1_update := 0.U
    }

  val myNewVec = Wire(Vec(streaming_width, UInt(width = bw.W)))

    for(i <- 0 until streaming_width ){
      myNewVec(streaming_width-1-i) := myVec(io.hh_cnt+1.U + i.U)
    }

    val myNewWire = Wire(UInt((streaming_width*bw).W))
    myNewWire := myNewVec.asUInt
    when(io.rst){
      vk_update := 0.U
    }.elsewhen(io.vk1_vld){
      vk_update := (Cat(vk1,myNewWire)>>((io.hh_cnt+1.U)*bw.U))

    }.otherwise{
      vk_update := 0.U
    }



  /*
   val ddot = Module(new FP_DDOT_dp(streaming_width,bw)).io
   
   for(i <- 0 until streaming_width ){ 
      ddot.in_a(i) := ddot_din_a_reg(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))
      ddot.in_b(i) := ddot_din_b_reg(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))
    }
    ddot_dout := ddot.out_s
    */
    
   val ddot = Module(new FP_DDOT_dp_complex(bw/2,streaming_width,name)).io

   for(i <- 0 until streaming_width ){ 
      ddot.in_a(i).Re := (ddot_din_a_reg(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1)))))(bw-1,bw/2)
      ddot.in_b(i).Re := (ddot_din_b_reg(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1)))))(bw-1,bw/2)
      ddot.in_a(i).Im := ((ddot_din_a_reg(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1)))))((bw/2)-1,0))^("h8000_0000".U)//flip sign of a to make complex conjugate with xor
      ddot.in_b(i).Im := (ddot_din_b_reg(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1)))))((bw/2)-1,0)
    }

    ddot_dout := Cat(ddot.out_s.Re,ddot.out_s.Im)

    val hqr3 = Module(new FP_sqrt(bw/2,23)).io//stays the same for complex
    hqr3.in_en := true.B
    hqr3.in_valid := true.B
    hqr3.in_a := d1
    d2_update := hqr3.out_s
    
    



   val hqr5= Module(new hqr5_complex(bw/2,name)).io
   hqr5.in_a.Re := x1(bw-1,bw/2)
   hqr5.in_a.Im := x1((bw/2)-1,0)
   hqr5.in_b.Re := d2
   hqr5.in_b.Im := 0.U
   vk1_update := Cat(hqr5.out_s.Re,hqr5.out_s.Im)



   val hqr7= Module(new hqr7(bw/2,name)).io
   hqr7.in_a := d3
   tk_update := hqr7.out_s





   val hqr10= Module(new FPComplexMult_v2(bw/2,name)).io//changes made for complex
   hqr10.in_en := true.B
   hqr10.in_a.Re := d4(bw-1,bw/2)
   hqr10.in_a.Im := d4((bw/2)-1,0)
   hqr10.in_b.Re := tk
   hqr10.in_b.Im := 0.U

   d5_update := Cat(hqr10.out_s.Re,hqr10.out_s.Im)


   /*val axpy= Module(new axpy_dp(bw,streaming_width)).io
   axpy.in_a := d5
   for(i <- 0 until streaming_width ){ 
      axpy.in_b(i) := vk(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))
      axpy.in_c(i) := yj0(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))
   }

   val myAxpyVec = Reg(Vec(streaming_width, UInt(width = bw.W)))
   when(io.rst){
    for(i <- 0 until streaming_width){
    myAxpyVec(streaming_width-i-1) := 0.U}
   }.otherwise{
   for(i <- 0 until streaming_width){
    myAxpyVec(streaming_width-i-1) := axpy.out_s(i)
   }}
   io.hh_dout := myAxpyVec.asUInt
  }*/

   val axpy= Module(new axpy_dp_complex(bw/2,streaming_width,name)).io
   axpy.in_a.Re := d5_reg(bw-1,bw/2)
   axpy.in_a.Im := d5_reg((bw/2)-1,0)
   for(i <- 0 until streaming_width ){ 
      axpy.in_b(i).Re := vk(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))(bw-1,bw/2)
      axpy.in_b(i).Im := vk(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))((bw/2)-1,0)

      axpy.in_c(i).Re := yj0(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))(bw-1,bw/2)
      axpy.in_c(i).Im := yj0(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))((bw/2)-1,0)
   }

   val myAxpyVec = Reg(Vec(streaming_width, UInt(width = bw.W)))
   when(io.rst){
    for(i <- 0 until streaming_width){
      myAxpyVec(streaming_width-i-1) := 0.U}
    }.otherwise{
      for(i <- 0 until streaming_width){
        myAxpyVec(streaming_width-i-1) := Cat(axpy.out_s(i).Re,axpy.out_s(i).Im)
      }
    }
      val hh_dout_val = if (streaming_width == 512) {
        ShiftRegister(myAxpyVec.asUInt, 40)
      } else {
        myAxpyVec.asUInt
      }

      io.hh_dout := hh_dout_val
    }


  }
  //RawModule of the datapath
  class hh_datapath(name:Int, bw:Int, streaming_width:Int, CNT_WIDTH: Int) extends RawModule{
        val clk = IO(Input(Clock()))
        val rst = IO(Input(Bool()))
        val hh_cnt = IO(Input(UInt((CNT_WIDTH).W)))
        val d1_rdy = IO(Input(Bool()))
        val d1_vld = IO(Input(Bool()))
        val d2_rdy = IO(Input(Bool()))
        val d2_vld = IO(Input(Bool()))
        val vk1_rdy = IO(Input(Bool()))
        val vk1_vld = IO(Input(Bool()))
        val d3_rdy = IO(Input(Bool()))
        val d3_vld = IO(Input(Bool()))
        val tk_rdy = IO(Input(Bool()))
        val tk_vld = IO(Input(Bool()))
        val d4_rdy = IO(Input(Bool()))
        val d4_vld = IO(Input(Bool()))
        val d5_rdy = IO(Input(Bool()))
        val d5_vld = IO(Input(Bool()))
        val yjp_rdy = IO(Input(Bool()))
        val yjp_vld = IO(Input(Bool()))
        val yj_sft = IO(Input(Bool()))
        val d4_sft = IO(Input(Bool()))
        val hh_din = IO(Input(UInt((streaming_width*bw).W)))
        val hh_dout = IO(Output(UInt((streaming_width*bw).W)))

        val hh_datapath_1 = withClockAndReset(clk,rst){Module(new hh_datapath_1(name, bw, streaming_width, CNT_WIDTH))}
        hh_datapath_1.io.clk := clk
        hh_datapath_1.io.rst := rst
        hh_datapath_1.io.hh_cnt := hh_cnt
        hh_datapath_1.io.d1_rdy := d1_rdy
        hh_datapath_1.io.d1_vld := d1_vld
        hh_datapath_1.io.d2_rdy := d2_rdy
        hh_datapath_1.io.d2_vld := d2_vld
        hh_datapath_1.io.vk1_rdy:= vk1_rdy
        hh_datapath_1.io.vk1_vld := vk1_vld
        hh_datapath_1.io.d3_rdy := d3_rdy
        hh_datapath_1.io.d3_vld := d3_vld
        hh_datapath_1.io.tk_rdy := tk_rdy
        hh_datapath_1.io.tk_vld := tk_vld
        hh_datapath_1.io.d4_rdy := d4_rdy
        hh_datapath_1.io.d4_vld := d4_vld
        hh_datapath_1.io.d5_rdy := d5_rdy
        hh_datapath_1.io.d5_vld := d5_vld
        hh_datapath_1.io.yjp_rdy := yjp_rdy
        hh_datapath_1.io.yjp_vld := yjp_vld
        hh_datapath_1.io.yj_sft := yj_sft
        hh_datapath_1.io.d4_sft := d4_sft
        hh_datapath_1.io.hh_din := hh_din
        hh_dout := hh_datapath_1.io.hh_dout
  }
      
}


class hqr5(bw: Int, name:Int) extends Module{
  override def desiredName = s"hqr5_${name}"
  require(bw == 16 || bw == 32 || bw == 64 || bw == 128)
  val io = IO(new Bundle() {
    val in_a = Input(UInt(bw.W))//x1
    val in_b = Input(UInt(bw.W))//d2
    val out_s = Output(UInt(bw.W))//vk1
  })
  val adder = Module(new FP_add_name(bw,13,name)).io
  val subtractor = Module(new FP_add_name(bw,13,name)).io
  adder.in_en := true.B
  adder.in_valid := true.B
  adder.in_a := io.in_a
  adder.in_b := io.in_b
  subtractor.in_en := true.B
  subtractor.in_valid := true.B
  subtractor.in_a := io.in_a
  subtractor.in_b := (io.in_b.asSInt^((1.U << (bw - 1)).asSInt)).asUInt

  when(io.in_a(bw-1)){
    io.out_s := subtractor.out_s
  }.otherwise{
    io.out_s := adder.out_s
  }
}




class hqr7(bw: Int, name: Int) extends Module{
  override def desiredName = s"hqr7_${name}"
  require(bw == 16 || bw == 32 || bw == 64 || bw == 128)
  val io = IO(new Bundle() {
    val in_a = Input(UInt(bw.W))
    val out_s = Output(UInt(bw.W))
  })
  val multiplier = Module(new FP_mult_name(bw, 10,name)).io
  val reciprocal = Module(new FP_div_name(bw,15,name)).io
  multiplier.in_en := true.B
  reciprocal.in_en := true.B
  multiplier.in_valid := true.B
  reciprocal.in_valid := true.B

  reciprocal.in_a := "h3F800000".U
  reciprocal.in_b := io.in_a
  multiplier.in_a := "hc0000000".U
  multiplier.in_b := reciprocal.out_s

  io.out_s := multiplier.out_s
}

