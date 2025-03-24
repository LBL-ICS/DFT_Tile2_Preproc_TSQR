`ifdef ST_WIDTH_INF_2
$fwrite(tr_report_ieee754, "===============================%d Column Results    ======================================\n",mem_index);
 $fwrite(tr_report_ieee754, "Item0   error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r0  , golden_r0  , dut_r0  );
 $fwrite(tr_report_ieee754, "Item1   error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r1  , golden_r1  , dut_r1  );
 $fwrite(tr_report_ieee754, "Item0   error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i0  , golden_i0  , dut_i0  );
 $fwrite(tr_report_ieee754, "Item1   error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i1  , golden_i1  , dut_i1  );
`endif // ST_WIDTH_INF_2
`ifdef ST_WIDTH_INF_4
 $fwrite(tr_report_ieee754, "Item2   error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r2  , golden_r2  , dut_r2  );
 $fwrite(tr_report_ieee754, "Item3   error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r3  , golden_r3  , dut_r3  );
 $fwrite(tr_report_ieee754, "Item2   error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i2  , golden_i2  , dut_i2  );
 $fwrite(tr_report_ieee754, "Item3   error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i3  , golden_i3  , dut_i3  );
`endif // ST_WIDTH_INF_4
`ifdef ST_WIDTH_INF_16
 $fwrite(tr_report_ieee754, "Item4   error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r4  , golden_r4  , dut_r4  );
 $fwrite(tr_report_ieee754, "Item5   error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r5  , golden_r5  , dut_r5  );
 $fwrite(tr_report_ieee754, "Item6   error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r6  , golden_r6  , dut_r6  );
 $fwrite(tr_report_ieee754, "Item7   error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r7  , golden_r7  , dut_r7  );
 $fwrite(tr_report_ieee754, "Item8   error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r8  , golden_r8  , dut_r8  );
 $fwrite(tr_report_ieee754, "Item9   error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r9  , golden_r9  , dut_r9  );
 $fwrite(tr_report_ieee754, "Item10  error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r10 , golden_r10 , dut_r10 );
 $fwrite(tr_report_ieee754, "Item11  error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r11 , golden_r11 , dut_r11 );
 $fwrite(tr_report_ieee754, "Item12  error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r12 , golden_r12 , dut_r12 );
 $fwrite(tr_report_ieee754, "Item13  error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r13 , golden_r13 , dut_r13 );
 $fwrite(tr_report_ieee754, "Item14  error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r14 , golden_r14 , dut_r14 );
 $fwrite(tr_report_ieee754, "Item15  error percent_r: %f%%, golden result: %h, dut result: %h\n", error_percent_r15 , golden_r15 , dut_r15 );
 $fwrite(tr_report_ieee754, "Item4   error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i4  , golden_i4  , dut_i4  );
 $fwrite(tr_report_ieee754, "Item5   error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i5  , golden_i5  , dut_i5  );
 $fwrite(tr_report_ieee754, "Item6   error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i6  , golden_i6  , dut_i6  );
 $fwrite(tr_report_ieee754, "Item7   error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i7  , golden_i7  , dut_i7  );
 $fwrite(tr_report_ieee754, "Item8   error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i8  , golden_i8  , dut_i8  );
 $fwrite(tr_report_ieee754, "Item9   error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i9  , golden_i9  , dut_i9  );
 $fwrite(tr_report_ieee754, "Item10  error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i10 , golden_i10 , dut_i10 );
 $fwrite(tr_report_ieee754, "Item11  error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i11 , golden_i11 , dut_i11 );
 $fwrite(tr_report_ieee754, "Item12  error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i12 , golden_i12 , dut_i12 );
 $fwrite(tr_report_ieee754, "Item13  error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i13 , golden_i13 , dut_i13 );
 $fwrite(tr_report_ieee754, "Item14  error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i14 , golden_i14 , dut_i14 );
 $fwrite(tr_report_ieee754, "Item15  error percent_i: %f%%, golden result: %h, dut result: %h\n", error_percent_i15 , golden_i15 , dut_i15 );
`endif // ST_WIDTH_INF_16
