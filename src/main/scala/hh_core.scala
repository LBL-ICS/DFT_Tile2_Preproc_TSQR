/*************************************
 * 10-19-2023
 * Author: Blair Reasoner
 * Release version: 1
 * **********************************/


package tsqr_hh_core

import chisel3.{util, _}
import tsqr_hh_datapath.hh_datapath_chisel._
import chisel3.stage.ChiselGeneratorAnnotation
import circt.stage.{ChiselStage, FirtoolOption}
import chisel3.util._
import chisel3.util.{ShiftRegister, log2Ceil}
//import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest.RawTester.test
import chisel3.stage.ChiselGeneratorAnnotation

import firrtl.AnnotationSeq
import firrtl.options.TargetDirAnnotation
import chisel3.dontTouch


import java.io.PrintWriter
import scala.collection.mutable

//object Main{
//  def main(args: Array[String]) : Unit = {
//    val sw2 = new PrintWriter("hh_core.v")
//    sw2.println(getVerilogString(new hh_core_chisel.hh_core(17,32, 16, 16)))
//    sw2.close()
//  }



object Main{
  def main(args: Array[String]) : Unit = {
    val sw2 = new PrintWriter("hh_core.sv")

    sw2.println(getVerilogString(new hh_core_chisel.hh_core(19,64, 512, 16)))
    sw2.close()
  }
}


object hh_core_chisel{
  class hh_core(name:Int,bw:Int, streaming_width:Int, CNT_WIDTH: Int)extends RawModule{
    val clk = IO(Input(Clock()))
    val rst = IO(Input(Bool()))
    val hh_cnt = IO(Input(UInt(CNT_WIDTH.W)))
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
    val hh_st = IO(Input(Bool()))
    val mem0_fi = IO(Input(Bool()))
    val mem1_fi = IO(Input(Bool()))
    val dmx0_mem_ena = IO(Input(Bool()))
    val dmx0_mem_wea = IO(Input(UInt((streaming_width * 4).W)))
    val dmx0_mem_addra = IO(Input(UInt((log2Ceil(streaming_width) - 1).W)))
    val dmx0_mem_dina = IO(Input(UInt((streaming_width * (bw / 2)).W)))
    val dmx0_mem_enb = IO(Input(Bool()))
    val dmx0_mem_addrb = IO(Input(UInt((log2Ceil(streaming_width) - 1).W)))
    val dmx0_mem_doutb = IO(Output(UInt((streaming_width * (bw / 2)).W)))
    val dmx1_mem_ena = IO(Input(Bool()))
    val dmx1_mem_wea = IO(Input(UInt((streaming_width * 4).W)))
    val dmx1_mem_addra = IO(Input(UInt((log2Ceil(streaming_width) - 1).W)))
    val dmx1_mem_dina = IO(Input(UInt((streaming_width * (bw / 2)).W)))
    val dmx1_mem_enb = IO(Input(Bool()))
    val dmx1_mem_addrb = IO(Input(UInt((log2Ceil(streaming_width) - 1).W)))
    val dmx1_mem_doutb = IO(Output(UInt((streaming_width * (bw / 2)).W)))
    val rtri_mem_ena = IO(Input(Bool()))
    val rtri_mem_wea = IO(Input(UInt((streaming_width * 4).W)))
    val rtri_mem_addra = IO(Input(UInt((log2Ceil(streaming_width) - 1).W)))
    val rtri_mem_dina = IO(Input(UInt((streaming_width * (bw / 2)).W)))
    val rtri_mem_enb = IO(Input(Bool()))
    val rtri_mem_addrb = IO(Input(UInt((log2Ceil(streaming_width) - 1).W)))
    val rtri_mem_doutb = IO(Output(UInt((streaming_width * (bw / 2)).W)))
    val hh_dout = IO(Output(UInt((streaming_width * bw).W)))




    val internal_hh_dout = Wire(UInt((streaming_width*bw).W))
    withClockAndReset (clk, rst){
      val hh0_din_rdy = Reg(Bool())
      val hh1_din_rdy = Reg(Bool())
      val hh_st_shifted = RegInit(false.B)
      val hh_din_wire = Wire(UInt((streaming_width*bw).W))
      val hh_din_reg = Reg(UInt((streaming_width*bw).W))
      val hh_din_update = Wire(UInt((streaming_width*bw).W))
      val hh_dout_update = Wire(UInt((streaming_width*bw).W))
      val hh_din = Reg(UInt((streaming_width*bw).W))


      when(rst){
        hh_st_shifted := false.B
      }.otherwise{

        hh_st_shifted := hh_st
      }


      when(rst){
        hh0_din_rdy := 0.U
        hh1_din_rdy := 0.U
        hh_din_reg := 0.U
        hh_din := 0.U
      }.otherwise{
        hh0_din_rdy := (dmx0_mem_enb & rtri_mem_enb)
        hh1_din_rdy := (dmx1_mem_enb & rtri_mem_enb)

        hh_din_reg := hh_din_wire
        hh_din := hh_din_wire
      }


      when(hh0_din_rdy | hh1_din_rdy){
        hh_din_wire := hh_din_update
      }.elsewhen(hh_st){
        hh_din_wire := hh_dout_update

      }.otherwise{
        hh_din_wire := hh_din_reg
      }

      val dmx_mem_doutb = Wire(UInt((streaming_width*bw/2).W))
      dontTouch(dmx_mem_doutb)

      when(hh0_din_rdy){
        dmx_mem_doutb := dmx0_mem_doutb
      }.elsewhen(hh1_din_rdy){
        dmx_mem_doutb := dmx1_mem_doutb
      }.otherwise{
        dmx_mem_doutb := 0.U
      }

      val myTriMemVec = Wire(Vec(streaming_width/2, UInt(width = bw.W)))
      dontTouch(myTriMemVec)

      for(i <- 0 until streaming_width/2){
        myTriMemVec(i) := rtri_mem_doutb(streaming_width*bw/2-(i*bw)-1,(streaming_width*bw/2-(bw*(i+1))))
      }

      val myTriMemVec2 = Wire(Vec(streaming_width/2, UInt(width = bw.W)))
      dontTouch(myTriMemVec2)
      for(i <- 0 until streaming_width/2){
        myTriMemVec2(streaming_width/2 -1-i) :=  myTriMemVec(i.U + hh_cnt)
      }

      val myTriMemWire = Wire(UInt((streaming_width*bw/2).W))
      dontTouch(myTriMemWire)
      myTriMemWire := myTriMemVec2.asUInt

      when(hh0_din_rdy | hh1_din_rdy){
        hh_din_update := (Cat(myTriMemWire >> (hh_cnt*bw.U), dmx_mem_doutb))
      }.elsewhen(rst){
        hh_din_update := 0.U
      }.otherwise{
        hh_din_update := hh_din_reg
      }

      val myHhdoutVec = Wire(Vec(streaming_width, UInt(width = bw.W)))
      dontTouch(myHhdoutVec)

      for(i <- 0 until streaming_width){
        myHhdoutVec(i) := hh_dout(streaming_width*bw-(i*bw)-1,(streaming_width*bw-(bw*(i+1))))
      }

      val myHhdoutVec2 = Wire(Vec(streaming_width, UInt(width = bw.W)))
      dontTouch(myHhdoutVec2)
      for(i <- 0 until streaming_width){
        myHhdoutVec2(streaming_width -1-i) :=  myHhdoutVec(i.U + hh_cnt + 0.U)
      }

      val myHhdoutWire = Wire(UInt((streaming_width*bw).W))
      myHhdoutWire := myHhdoutVec2.asUInt
      dontTouch(myHhdoutWire)

      when(rst){
        hh_dout_update := 0.U
      }.elsewhen(hh_st){
        hh_dout_update := RegNext(myHhdoutWire)>> (hh_cnt*bw.U) // removed an extra regnext dania
        //hh_dout_update := RegNext(myHhdoutWire)>> (io.hh_cnt*bw.U) // removed an extra regnext dania
      }.otherwise{
        hh_dout_update := hh_din_reg
      }

      val u_dmx0= Module(new simple_dual(name, bw,streaming_width)).io

      u_dmx0.clka := clk
      u_dmx0.ena := dmx0_mem_ena
      u_dmx0.wea := dmx0_mem_wea
      u_dmx0.addra := dmx0_mem_addra
      u_dmx0.dina := dmx0_mem_dina
      u_dmx0.clkb := clk
      u_dmx0.enb := dmx0_mem_enb
      u_dmx0.addrb := dmx0_mem_addrb
      dmx0_mem_doutb := u_dmx0.doutb

      val u_dmx1= Module(new simple_dual(name, bw,streaming_width)).io
      u_dmx1.clka := clk
      u_dmx1.ena := dmx1_mem_ena
      u_dmx1.wea := dmx1_mem_wea
      u_dmx1.addra := dmx1_mem_addra
      u_dmx1.dina := dmx1_mem_dina
      u_dmx1.clkb := clk
      u_dmx1.enb := dmx1_mem_enb
      u_dmx1.addrb := dmx1_mem_addrb
      dmx1_mem_doutb := u_dmx1.doutb

      val u_rtri= Module(new simple_dual(name, bw,streaming_width)).io
      u_rtri.clka := clk
      u_rtri.ena := rtri_mem_ena
      u_rtri.wea := rtri_mem_wea
      u_rtri.addra := rtri_mem_addra
      u_rtri.dina := rtri_mem_dina
      u_rtri.clkb := clk
      u_rtri.enb := rtri_mem_enb
      u_rtri.addrb := rtri_mem_addrb
      rtri_mem_doutb := u_rtri.doutb

      val u_hh_datapath= Module(new hh_datapath_1(name,bw,streaming_width, CNT_WIDTH))

      u_hh_datapath.io.clk := clk
      u_hh_datapath.io.rst := rst
      u_hh_datapath.io.hh_cnt := hh_cnt
      u_hh_datapath.io.d1_rdy := d1_rdy
      u_hh_datapath.io.d1_vld := d1_vld
      u_hh_datapath.io.d2_rdy := d2_rdy
      u_hh_datapath.io.d2_vld := d2_vld
      u_hh_datapath.io.vk1_rdy := vk1_rdy
      u_hh_datapath.io.vk1_vld := vk1_vld
      u_hh_datapath.io.d3_rdy := d3_rdy
      u_hh_datapath.io.d3_vld := d3_vld
      u_hh_datapath.io.tk_rdy := tk_rdy
      u_hh_datapath.io.tk_vld := tk_vld
      u_hh_datapath.io.d4_rdy := d4_rdy
      u_hh_datapath.io.d4_vld := d4_vld
      u_hh_datapath.io.d5_rdy := d5_rdy
      u_hh_datapath.io.d5_vld := d5_vld
      u_hh_datapath.io.yjp_rdy := yjp_rdy
      u_hh_datapath.io.yjp_vld := yjp_vld
      u_hh_datapath.io.yj_sft := yj_sft
      u_hh_datapath.io.d4_sft := d4_sft
      u_hh_datapath.io.hh_din := hh_din
      internal_hh_dout := u_hh_datapath.io.hh_dout
      when(rst){
        hh_dout:= 0.U
      }.otherwise{
        hh_dout := internal_hh_dout
      }
    }
  }

  /*
   class simple_dual(bw:Int, streaming_width:Int)extends BlackBox{
         val io = IO {
             new Bundle() {
                 val clka = Input(Clock())
                 val clkb = Input(Clock())
                 val ena = Input(Bool())
                 val enb = Input(Bool())
                 val wea = Input(UInt((streaming_width*4).W))
                 val addra = Input(UInt((log2Ceil(streaming_width)-1).W))
                 val addrb = Input(UInt((log2Ceil(streaming_width)-1).W))
                 val dina = Input(UInt((streaming_width*bw/2).W))
                 val doutb = Output(UInt((streaming_width*bw/2).W))
             }
         }
     }
         */

  class simple_dual(name:Int,bw:Int, streaming_width:Int)extends Module{
    override def desiredName = s"simple_dual_${name}"
    val io = IO {
      new Bundle() {
        val clka = Input(Clock())
        val clkb = Input(Clock())
        val ena = Input(Bool())
        val enb = Input(Bool())
        val wea = Input(UInt((streaming_width*4).W))
        val addra = Input(UInt((log2Ceil(streaming_width)-1).W))
        val addrb = Input(UInt((log2Ceil(streaming_width)-1).W))
        val dina = Input(UInt((streaming_width*bw/2).W))
        val doutb = Output(UInt((streaming_width*bw/2).W))
      }
    }



    withClock (io.clka){
      val doutb = Reg(UInt((streaming_width*bw/2).W))
      io.doutb := doutb
      val ram = Mem(streaming_width/2, UInt((streaming_width*bw/2).W))
      val ramMirror = RegInit(VecInit(Seq.fill(streaming_width / 2)(0.U((streaming_width * bw / 2).W))))
      dontTouch(ramMirror)
      val ramtemp = Wire(Vec(streaming_width/2, UInt(width = (bw).W)))
      val dintemp = Wire(Vec(streaming_width/2, UInt(width = (bw).W)))

      when(io.ena){
        for(i <- 0 until streaming_width/2){
          //dintemp(streaming_width/2-1-i) := (io.dina(streaming_width*bw/2-1-(i*bw),streaming_width*bw/2-((i+1)*bw)))&(Cat((io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4)))))
          //ramtemp(streaming_width/2-1-i) := ((ram(io.addra))(streaming_width*bw/2-1-(i*bw),streaming_width*bw/2-((i+1)*bw)))& ~(Cat((io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4))),(io.wea(streaming_width*2-1-(i*4),streaming_width*2-((i+1)*4)))))
          dintemp(streaming_width/2-1-i) := (io.dina(streaming_width*bw/2-1-(i*bw),streaming_width*bw/2-((i+1)*bw)))&(Cat((io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8)))))
          ramtemp(streaming_width/2-1-i) := ((ram(io.addra))(streaming_width*bw/2-1-(i*bw),streaming_width*bw/2-((i+1)*bw)))& ~(Cat((io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8))),(io.wea(streaming_width*4-1-(i*8),streaming_width*4-((i+1)*8)))))
        }
        ram.write(io.addra, ramtemp.asUInt + dintemp.asUInt)
        ramMirror(io.addra) := ramtemp.asUInt + dintemp.asUInt
      }.otherwise{
        for(i <- 0 until streaming_width/2){
          dintemp(i) := 0.U
          ramtemp(i) := 0.U
        }
      }

      withClock (io.clkb){
        when(io.enb){
          doutb := RegNext(ram.read(io.addrb))
        }
      }
    }
  }


}

case class FirtoolOption(str: String)