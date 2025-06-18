package ComplexModules

import chisel3.{util, _}
import ComplexModules.FPComplex.FP_DDOT_dp_complex
import FPPackageMario.FP_Modules.FPUnits.{FP_add_name, FP_div_name, FP_mult_name, FP_sqrt}
import chisel3._
//import FPPackageMario.FP_Modules.FPUnits._
import scala.collection.mutable
import circt.stage.ChiselStage
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util._
import chisel3.util.{ShiftRegister, log2Ceil}
import java.io.PrintWriter

//import FP_Modules.FloatingPointDesigns._
object FPComplex { // these are the complex FP modules

  class ComplexNum(bw: Int, name:Int) extends Bundle{
    val Re = UInt(bw.W)
    val Im = UInt(bw.W)
  }

  class ComplexIO(bw: Int, name:Int) extends Bundle{
    val in_a = Input(new ComplexNum(bw,name))
    val in_b = Input(new ComplexNum(bw,name))
    val out_s = Output(new ComplexNum(bw,name))
  }

  class FPComplexAdder_v2(bw: Int, name:Int) extends Module {
    override def desiredName = s"FPComplexAdder_v2_${name}"
    val io = IO(new Bundle {
      val in_en = Input(Bool())
      val in_a = Input(new ComplexNum(bw,name))
      val in_b = Input(new ComplexNum(bw,name))
      val out_s = Output(new ComplexNum(bw,name))
    })
    val FP_adders = (for (i <- 0 until 2) yield {
      val fpadd = Module(new FP_add_name(bw,13,name)).io
      fpadd
    }).toVector
    FP_adders(0).in_en := io.in_en
    FP_adders(1).in_en := io.in_en
    FP_adders(0).in_valid := 1.B
    FP_adders(1).in_valid := 1.B
    FP_adders(0).in_a := io.in_a.Re
    FP_adders(0).in_b := io.in_b.Re
    FP_adders(1).in_a := io.in_a.Im
    FP_adders(1).in_b := io.in_b.Im
    io.out_s.Re := FP_adders(0).out_s
    io.out_s.Im := FP_adders(1).out_s
  }

  class FPComplexAdder_reducable_v2(bw: Int, sRe: Double, sIm: Double, add_reg: Boolean, name:Int) extends Module { //can reduce the adder count
        override def desiredName = s"FPComplexAdder_reducable_v2_${name}"

    val io = IO(new Bundle {
      val in_en = Input(Bool())
      val in_a = Input(new ComplexNum(bw,name))
      val in_b = Input(new ComplexNum(bw,name))
      val out_s = Output(new ComplexNum(bw,name))
    })
    if (sRe.abs < 0.00005) { // if inout a is zero
      if (add_reg) { // we have the option of adding a register to maintain the pipeline
        val result = RegInit(0.U.asTypeOf(new ComplexNum(bw,name)))
        when(io.in_en){
          result := io.in_b
          io.out_s := result
        }.otherwise{
          io.out_s := result
        }
      } else {
        io.out_s := io.in_b // combinational logic
      }
    } else if (sIm.abs < 0.00005) { // if input b is zero
      if (add_reg) {
        val result = RegInit(0.U.asTypeOf(new ComplexNum(bw,name)))
        when(io.in_en){
          result := io.in_a
          io.out_s := result
        }.otherwise{
          io.out_s := result
        }
      } else {
        io.out_s := io.in_a
      }
    } else { // none of the input a or input b magnitudes are zero
      val FP_adders = (for (i <- 0 until 2) yield {
        val fpadd = Module(new FP_add_name(bw,13,name)).io
        fpadd
      }).toVector
      FP_adders(0).in_en := io.in_en
      FP_adders(1).in_en := io.in_en
      FP_adders(0).in_a := io.in_a.Re
      FP_adders(0).in_b := io.in_b.Re
      FP_adders(1).in_a := io.in_a.Im
      FP_adders(1).in_b := io.in_b.Im
      io.out_s.Re := FP_adders(0).out_s
      io.out_s.Im := FP_adders(1).out_s
    }
  }

  class FPComplexSub_v2(bw: Int, name:Int) extends Module {
    override def desiredName = s"FPComplexSub_v2_${name}"
    val io = IO(new Bundle {
      val in_en = Input(Bool())
      val in_a = Input(new ComplexNum(bw,name))
      val in_b = Input(new ComplexNum(bw,name))
      val out_s = Output(new ComplexNum(bw,name))
    })
    val FP_subbers = (for (i <- 0 until 2) yield {
      val fpsub = Module(new FP_add_name(bw,13,name)).io/// switched from old subber to new adder
      fpsub
    }).toVector
    FP_subbers(0).in_en := io.in_en
    FP_subbers(1).in_en := io.in_en
    FP_subbers(0).in_valid := true.B
    FP_subbers(1).in_valid := true.B
    FP_subbers(0).in_a := io.in_a.Re
    FP_subbers(0).in_b := (io.in_b.Re.asSInt^((1.U << (bw - 1)).asSInt)).asUInt // make this negative
    FP_subbers(1).in_a := io.in_a.Im
    FP_subbers(1).in_b := (io.in_b.Im.asSInt^((1.U << (bw - 1)).asSInt)).asUInt// make this negative too
    io.out_s.Re := FP_subbers(0).out_s
    io.out_s.Im := FP_subbers(1).out_s
  }

// change fp operators

  class FPComplexMult_v2(bw: Int, name:Int) extends Module {
    override def desiredName = s"FPComplexMult_v2_${name}"
    val io = IO(new Bundle {
      val in_en = Input(Bool())
      val in_a = Input(new ComplexNum(bw,name))
      val in_b = Input(new ComplexNum(bw,name))
      val out_s = Output(new ComplexNum(bw,name))
    })


    
    val FP_sub = Module(new FP_add_name(bw,13,name)).io
    val FP_add = Module(new FP_add_name(bw,13,name)).io
    val FP_multipliers = (for (i <- 0 until 4) yield {
      val fpmult = Module(new FP_mult_name(bw,10,name)).io
      fpmult
    }).toVector
    for(i <- 0 until 4){
      FP_multipliers(i).in_en := io.in_en
      FP_multipliers(i).in_valid := true.B
    }
    FP_sub.in_en := io.in_en
    FP_add.in_en := io.in_en
    FP_sub.in_valid := true.B
    FP_add.in_valid := true.B
    FP_multipliers(0).in_a := io.in_a.Re
    FP_multipliers(0).in_b := io.in_b.Re
    FP_multipliers(1).in_a := io.in_a.Im
    FP_multipliers(1).in_b := io.in_b.Im
    FP_multipliers(2).in_a := io.in_a.Re
    FP_multipliers(2).in_b := io.in_b.Im
    FP_multipliers(3).in_a := io.in_a.Im
    FP_multipliers(3).in_b := io.in_b.Re
    FP_sub.in_a := FP_multipliers(0).out_s
    FP_sub.in_b := (FP_multipliers(1).out_s.asSInt^((1.U << (bw - 1)).asSInt)).asUInt
    FP_add.in_a := FP_multipliers(2).out_s
    FP_add.in_b := FP_multipliers(3).out_s
    io.out_s.Re := FP_sub.out_s
    io.out_s.Im := FP_add.out_s
  }


  class FPReg(depth: Int,bw: Int, name:Int) extends Module{
    override def desiredName = s"FPReg_${name}"
    val io = IO(new Bundle() {
      val in = Input(new ComplexNum(bw,name))
      val out = Output(new ComplexNum(bw,name))
    })

   // val reg = RegInit(VecInit.fill(depth)(0.U(bw.W)))
    //    val reg = RegInit(0.U.asTypeOf(new ComplexNum(bw)))
    val reg = RegInit(VecInit.fill(depth)(0.U.asTypeOf(new ComplexNum(bw,name))))
      reg(0) := io.in
      for(i <- 1 until depth){
        reg(i) := reg(i-1)
      }
    io.out := reg(depth - 1)
  }


  class FP_square_root_newfpu(bw: Int, NR_iter: Int, name: Int) extends Module {
    override def desiredName = s"FP_square_root_newfpu_${name}"
    require(bw == 16 || bw == 32 || bw == 64 || bw == 128)
    val io = IO(new Bundle() {
      val in_en = Input(Bool())
      val in_a = Input(UInt(bw.W))
      val out_s = Output(UInt(bw.W))
    })
    var magic = scala.BigInt("0", 10)
    var exponent = 0
    var mantissa = 0
    var limit = scala.BigInt("0", 10)
    if (bw == 16) {
      exponent = 5
      mantissa = 10
      magic = scala.BigInt("23040", 10)
    } else if (bw == 32) {
      exponent = 8
      mantissa = 23
      magic = scala.BigInt("1597463007", 10)
    } else if (bw == 64) {
      exponent = 11
      mantissa = 52
      magic = scala.BigInt("6910469410427058089", 10)
    } else if (bw == 128) {
      exponent = 15
      mantissa = 112
      magic = scala.BigInt("127598099150064121557322682042419249152", 10)
    }
    limit = (magic * 2) / 3

    val number = Wire(UInt((bw).W))

    val threehalfs = 0x3FC00000.asUInt
    when(io.in_a(bw - 2, 0) > (limit * 2).U) {
      number := limit.U
    }.otherwise {
      number := io.in_a(bw - 2, 0) >> 1.U
    }

    // get the magic number
    val magic_num = magic.U((bw).W) // we are performing a fast inverse square root. Get the magic number

    val result = Wire(UInt(bw.W)) // subtract the adjusted input from the magic number and we have the inverse square root immediately (although an approximation)
    result := magic_num - number // the appoximation is obtained immediateley

    val x_n = RegInit(VecInit.fill(NR_iter*4)(0.U(bw.W)))
    val a_2 = RegInit(VecInit.fill(NR_iter*4)(0.U(bw.W)))
    val stage1_regs = RegInit(VecInit.fill(NR_iter)(VecInit.fill(2)(VecInit.fill(9)(0.U(bw.W)))))
    val stage2_regs = RegInit(VecInit.fill(NR_iter)(VecInit.fill(2)(VecInit.fill(9)(0.U(bw.W)))))
    val stage3_regs = RegInit(VecInit.fill(NR_iter)(VecInit.fill(2)(VecInit.fill(12)(0.U(bw.W)))))
    val stage4_regs = RegInit(VecInit.fill(NR_iter)(VecInit.fill(2)(VecInit.fill(9)(0.U(bw.W)))))

    val multipliers = Vector.fill(NR_iter)(Vector.fill(3)(Module(new FP_mult_name(bw,10,name)).io))
    val subtractors = Vector.fill(NR_iter)(Module(new FP_add_name(bw,13,name)).io)
    multipliers.map(x=>x.map(x=>x.in_en := io.in_en))
    subtractors.map(x=>x.in_en := io.in_en)
    multipliers.map(x=>x.map(x=>x.in_valid := true.B))
    subtractors.map(x=>x.in_valid := true.B)
    for(i <- 0 until NR_iter){
      when(io.in_en) {
        for (j <- 1 until 12) {
          stage3_regs(i)(0)(j) := stage3_regs(i)(0)(j - 1)
          stage3_regs(i)(1)(j) := stage3_regs(i)(1)(j - 1)
          if (j < 9) {
            stage1_regs(i)(0)(j) := stage1_regs(i)(0)(j - 1)
            stage1_regs(i)(1)(j) := stage1_regs(i)(1)(j - 1)
            stage2_regs(i)(0)(j) := stage2_regs(i)(0)(j - 1)
            stage2_regs(i)(1)(j) := stage2_regs(i)(1)(j - 1)
            stage4_regs(i)(1)(j) := stage4_regs(i)(1)(j - 1)
          }
        }
      }
      for(j <- 0 until 4){
        if(j == 0){
          if(i == 0) {
            when(io.in_en) {
              x_n(i * 4) := result
              a_2(i * 4) := io.in_a(bw - 1) ## (io.in_a(bw - 2, mantissa) - 1.U) ## io.in_a(mantissa - 1, 0)
              stage1_regs(0)(0)(0) := x_n(0)
              stage1_regs(0)(1)(0) := a_2(0)
            }
            multipliers(0)(0).in_a := 0.U(1.W) ## result(bw - 2, 0)
            multipliers(0)(0).in_b := 0.U(1.W) ## result(bw - 2, 0)
          }else{
            when(io.in_en) {
              x_n(i * 4) := multipliers(i - 1)(2).out_s
              a_2(i * 4) := stage4_regs(i - 1)(1)(8)
              stage1_regs(i)(0)(0) := x_n(i * 4)
              stage1_regs(i)(1)(0) := a_2(i * 4)
            }
            multipliers(i)(0).in_a := 0.U(1.W) ## multipliers(i-1)(2).out_s(bw - 2, 0)
            multipliers(i)(0).in_b := 0.U(1.W) ## multipliers(i-1)(2).out_s(bw - 2, 0)
          }
        }else if(j == 1){
          multipliers(i)(1).in_a := multipliers(i)(0).out_s
          multipliers(i)(1).in_b := 0.U(1.W) ## stage1_regs(i)(1)(8)(bw-2,0)
          when(io.in_en) {
            a_2(i * 4 + 1) := stage1_regs(i)(1)(8)
            x_n(i * 4 + 1) := stage1_regs(i)(0)(8)
            stage2_regs(i)(0)(0) := x_n(i * 4 + 1)
            stage2_regs(i)(1)(0) := a_2(i * 4 + 1)
          }
        }else if(j == 2){
          subtractors(i).in_a := threehalfs
          subtractors(i).in_b := (multipliers(i)(1).out_s.asSInt^((1.U << (bw - 1)).asSInt)).asUInt
          when(io.in_en) {
            a_2(i * 4 + 2) := stage2_regs(i)(1)(8)
            x_n(i * 4 + 2) := stage2_regs(i)(0)(8)
            stage3_regs(i)(0)(0) := x_n(i * 4 + 2)
            stage3_regs(i)(1)(0) := a_2(i * 4 + 2)
          }
        }else if(j == 3){
          multipliers(i)(2).in_a := 0.U(1.W) ## stage3_regs(i)(0)(11)(bw-2,0)
          multipliers(i)(2).in_b := subtractors(i).out_s
          when(io.in_en) {
            a_2(i * 4 + 3) := stage3_regs(i)(1)(11)
            stage4_regs(i)(1)(0) := a_2(i * 4 + 3)
          }
        }
      }
    }
    val restore_a = Wire(UInt(bw.W))
    restore_a := stage4_regs(NR_iter-1)(1)(8)(bw - 1) ## (stage4_regs(NR_iter-1)(1)(8)(bw - 2, mantissa) + 1.U) ## stage4_regs(NR_iter-1)(1)(8)(mantissa - 1, 0)
    val multiplier4 = Module(new FP_mult_name(bw, 10,name))
    multiplier4.io.in_en := io.in_en
    multiplier4.io.in_valid := true.B
    multiplier4.io.in_a := 0.U(1.W) ## multipliers(NR_iter-1)(2).out_s(bw - 2, 0)
    multiplier4.io.in_b := restore_a
    io.out_s := multiplier4.io.out_s(bw - 2, 0)
  }

  class hqr5_complex(bw: Int,name:Int) extends Module{
    override def desiredName = s"hqr5_complex_${name}"
    require(bw == 16 || bw == 32 || bw == 64 || bw == 128)
    val io = IO(new Bundle() {
      val in_a = Input(new ComplexNum(bw,name))//x1
      val in_b = Input(new ComplexNum(bw,name))//d2
      val out_s = Output(new ComplexNum(bw,name))
    })
    
    //val sqrt = Module(new sqrtbb_viv2(bw)).io

    //val sqrt = Module(new sqrtbb_viv2(bw)).io
    val sqrt = Module(new FP_sqrt(bw,23)).io//stays the same for complex
    val multiplier1 = Module(new FPComplexMult_v2(bw,name)).io
    val multiplier2 = Module(new FPComplexMult_v2(bw,name)).io
    //val multiplier3 = Module(new FP_multiplier_10ccs(bw)).io
    //val multiplier4 = Module(new FP_multiplier_10ccs(bw)).io
    //val recip1 = Module(new FP_reciprocal_newfpu(bw,1)).io
    val div = Module(new FP_div_name(bw,15,name)).io
    val div2= Module(new FP_div_name(bw,15,name)).io

    val adder = Module(new FPComplexAdder_v2(bw,name)).io
    val cd1 = Reg(UInt(bw.W))
    val cd2 = Reg(UInt(bw.W))
    val ca = Reg(UInt(bw.W))
    val s = Reg(new ComplexNum(bw,name))
    
   // val recipout1 = Reg(UInt(bw.W))
    val conjugate = Wire(new ComplexNum(bw,name))
    conjugate.Re := io.in_a.Re
    conjugate.Im := io.in_a.Im^("h8000_0000".U)//xor togle im

    multiplier1.in_en := 1.B

    multiplier1.in_a := conjugate
    multiplier1.in_b := io.in_a
    cd1 := multiplier1.out_s.Re


    
    sqrt.in_en := 1.B
    sqrt.in_valid := 1.B
    sqrt.in_a := cd1
    cd2 := sqrt.out_s




    div.in_en := 1.B
    div.in_valid := 1.B
    div.in_a := io.in_a.Re
    div.in_b := cd2



    div2.in_en := 1.B
    div2.in_valid := 1.B
    div2.in_a := io.in_a.Im
    div2.in_b := cd2




    if(io.in_a.Re == 0.U && io.in_a.Im == 0.U){
      s.Re := "h_bf80_0000".U
      s.Im := "h_0000_0000".U
    }else{


      s.Re := div.out_s
      s.Im := div2.out_s
    }

    multiplier2.in_en := 1.B
    multiplier2.in_a := s
    multiplier2.in_b := io.in_b

    adder.in_en := 1.B
    adder.in_a := io.in_a
    adder.in_b := multiplier2.out_s

    io.out_s := adder.out_s
    
  }




  class FP_DDOT_dp_complex(bw: Int, n: Int, name:Int) extends Module {
    override def desiredName = s"FP_DDOT_dp_complex_${name}"
    val io = IO(new Bundle{
      val in_a = Input(Vec(n, new ComplexNum(bw,name)))
      val in_b = Input(Vec(n, new ComplexNum(bw,name)))
      val out_s = Output(new ComplexNum(bw,name))
    })
    var temp_n = n
    val add_per_layer = mutable.ArrayBuffer[Int]()
    val regs_per_layer = mutable.ArrayBuffer[Int]()
    while(temp_n>1){
      if(temp_n % 2 == 1){
        add_per_layer += temp_n/2
        temp_n /= 2
        temp_n += 1
        regs_per_layer += 1
      }else{
        add_per_layer += temp_n/2
        temp_n /= 2
        regs_per_layer += 0
      }
    }
    val multipliers = Vector.fill(n)(Module(new FPComplexMult_v2(bw,name)).io)
    multipliers.zipWithIndex.map(x=>x._1.in_a := io.in_a(x._2))
    multipliers.zipWithIndex.map(x=>x._1.in_b := io.in_b(x._2))
    multipliers.map(_.in_en := true.B)

    if(add_per_layer.nonEmpty) {
      val regs_and_adds = for (i <- 0 until add_per_layer.length) yield {
        val adds = for (j <- 0 until add_per_layer(i)) yield {
          Module(new FPComplexAdder_v2(bw,name)).io
        }
        adds.map(_.in_en := true.B)

        val regs = for (j <- 0 until regs_per_layer(i)) yield {
          //RegInit(0.U.asTypeOf(new ComplexNum(bw)))
          Module(new FPReg(13, bw,name)).io // add latency
        }
        (adds, regs)
      }
      //      regs_and_adds(0)._1.map(_.in_en := true.B)
      for (i <- 0 until regs_and_adds.length) {
        for (j <- 0 until add_per_layer(i) * 2 by 2) {
          val temp = if (i == 0) {
            multipliers(j).out_s
          } else {
            regs_and_adds(i - 1)._1(j).out_s
          }
          val temp2 = if (i == 0) {
            multipliers(j + 1).out_s
          } else {
            if (j / 2 == add_per_layer(i) - 1) {
              if (regs_per_layer(i - 1) == 1 && add_per_layer(i - 1) % 2 == 1) {
                regs_and_adds(i - 1)._2(0).out
              } else {
                regs_and_adds(i - 1)._1(j + 1).out_s
              }
            } else {
              regs_and_adds(i - 1)._1(j + 1).out_s
            }
          }
          //          regs_and_adds(i)._1(j / 2).in_en := io.in_en
          regs_and_adds(i)._1(j / 2).in_a := temp
          regs_and_adds(i)._1(j / 2).in_b := temp2
        }
        for (j <- 0 until regs_per_layer(i)) {
          val temp = if (i == 0) {
            multipliers(add_per_layer(i) * 2).out_s
          } else {
            if (regs_per_layer(i - 1) == 1) {
              regs_and_adds(i - 1)._2(0).out
            } else {
              regs_and_adds(i - 1)._1(add_per_layer(i) * 2).out_s
            }
          }
          //          regs_and_adds(i)._2(j).in_en := true.B
          regs_and_adds(i)._2(j).in := temp
        }
      }
      //      println(s"addper layer: ${add_per_layer}")
      io.out_s := RegNext(regs_and_adds(add_per_layer.length - 1)._1(0).out_s)
    }else{
      io.out_s :=  RegNext(multipliers(0).out_s)
    }
  }

  class axpy_dp_complex(bw:Int,level:Int, name:Int)extends Module {
    override def desiredName = s"axpy_dp_complex_${name}"
    val io = IO {
      new Bundle() {
        val in_a = Input(new ComplexNum(bw,name))
        val in_b = Input(Vec((level), new ComplexNum(bw,name)))
        val in_c = Input(Vec((level), new ComplexNum(bw,name)))
        val out_s = Output(Vec((level), new ComplexNum(bw,name)))
      }
    }

    val multiply_layer = for(i <- 0 until level)yield{
      val multiply = Module(new FPComplexMult_v2(bw,name)).io
      multiply.in_en := true.B
      multiply
    }
    val adder_layer = for (i <- 0 until level) yield {
      val adder = Module(new FPComplexAdder_v2(bw ,name)).io
      adder.in_en := true.B
      adder
    }

    val reg_array_h = for (j <- 0 until level) yield {
          //RegInit(0.U.asTypeOf(new ComplexNum(bw)))
          Module(new FPReg(23, bw,name)).io // mult + add late cy
        }
   
    for(i <- 0 until level){
      multiply_layer(i).in_a := io.in_a
      multiply_layer(i).in_b := io.in_b(i)
      reg_array_h(i).in := io.in_c(i)
      adder_layer(i).in_a :=  multiply_layer(i).out_s
      adder_layer(i).in_b := reg_array_h(i).out
      io.out_s(i) := adder_layer(i).out_s
    }
  }
    def main(args: Array[String]) : Unit = {
    val sw2 = new PrintWriter("cplx_div.v")
    //val sw2 = new PrintWriter("DDOT_COMPLEX.v")
    //val sw2 = new PrintWriter("AXPY_COMPLEX.v")
    //sw2.println(getVerilogString(new FP_DDOT_dp_complex(32, 4)))
    //sw2.println(getVerilogString(new FPComplexDivider(32)))
    //sw2.println(getVerilogString(new axpy_dp_complex(32,4)))

    sw2.close()
  }




}



object fp_ddot extends App {
  (new ChiselStage).execute(
    Array("--target", "systemverilog", "--target-dir", "verification/dut" ),
    Seq(ChiselGeneratorAnnotation(() => new FP_DDOT_dp_complex(32,2,19))
  ))
}