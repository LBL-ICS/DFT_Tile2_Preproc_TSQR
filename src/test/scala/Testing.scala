package Preprocessor
import chisel3._
import chiseltest._

import chiseltest.ChiselScalatestTester
import org.scalatest.flatspec.AnyFlatSpec


class double_axpy extends AnyFlatSpec with ChiselScalatestTester {
  "preprocessor" should "correctly convert fixed-point to double-precision float" in {
    test(new doublex_axpy(32,1)) { dut =>
      // Test case 1: Positive number
      dut.io.in_complex_1(0).Re.poke(0x3F800000.U) // Real part of first complex input
      dut.io.in_complex_1(0).Im.poke(0x40000000.U) // Imaginary part of first complex input

      dut.io.in_complex_2(0).Re.poke(0x40400000.U) // Real part of second complex input
      dut.io.in_complex_2(0).Im.poke(0x40800000.U) // Imaginary part of second complex input

      dut.io.in_scalar_1.poke("h40000000".U(32.W)) // Scalar 1
      dut.io.in_scalar_2.poke("h40400000".U(32.W)) // Scalar 2
      dut.clock.step(20)
      //dut.clock.step(1)
      dut.io.out_axpy(0).Re.expect(0x41300000.U) // Expected Real part of output
      dut.io.out_axpy(0).Im.expect(0x41800000.U) // Expected Imaginary part of output



    }
  }
}