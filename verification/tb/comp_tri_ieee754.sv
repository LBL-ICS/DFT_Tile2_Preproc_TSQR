`ifdef ST_WIDTH_INF_4
$fwrite(tri_report_ieee754, "===============================%d Column Results    ======================================\n",col_index);
if(col_index>=0  ) $fwrite(tri_report_ieee754, "Item0   error re percent: %f%%, golden re result: %h, dut re result: %h\n", err_re_per0  , gol_yjp0[63:32]  , dut_yjp0[63:32]  );
if(col_index>=0  ) $fwrite(tri_report_ieee754, "Item0   error im percent: %f%%, golden im result: %h, dut im result: %h\n", err_im_per0  , gol_yjp0[31: 0]  , dut_yjp0[31: 0]  );
if(col_index>=1  ) $fwrite(tri_report_ieee754, "Item1   error re percent: %f%%, golden re result: %h, dut re result: %h\n", err_re_per1  , gol_yjp1[63:32]  , dut_yjp1[63:32]  );
if(col_index>=1  ) $fwrite(tri_report_ieee754, "Item1   error im percent: %f%%, golden im result: %h, dut im result: %h\n", err_im_per1  , gol_yjp1[31: 0]  , dut_yjp1[31: 0]  );
`endif

`ifdef ST_WIDTH_INF_8
$fwrite(tri_report_ieee754, "===============================%d Column Results    ======================================\n",col_index);
if(col_index>=0  ) $fwrite(tri_report_ieee754, "Item0   error re percent: %f%%, golden re result: %h, dut re result: %h\n", err_re_per0  , gol_yjp0[63:32]  , dut_yjp0[63:32]  );
if(col_index>=0  ) $fwrite(tri_report_ieee754, "Item0   error im percent: %f%%, golden im result: %h, dut im result: %h\n", err_im_per0  , gol_yjp0[31: 0]  , dut_yjp0[31: 0]  );
if(col_index>=1  ) $fwrite(tri_report_ieee754, "Item1   error re percent: %f%%, golden re result: %h, dut re result: %h\n", err_re_per1  , gol_yjp1[63:32]  , dut_yjp1[63:32]  );
if(col_index>=1  ) $fwrite(tri_report_ieee754, "Item1   error im percent: %f%%, golden im result: %h, dut im result: %h\n", err_im_per1  , gol_yjp1[31: 0]  , dut_yjp1[31: 0]  );
//
if(col_index>=2  ) $fwrite(tri_report_ieee754, "Item2   error re percent: %f%%, golden re result: %h, dut re result: %h\n", err_re_per2  , gol_yjp2[63:32]  , dut_yjp2[63:32]  );
if(col_index>=2  ) $fwrite(tri_report_ieee754, "Item2   error im percent: %f%%, golden im result: %h, dut im result: %h\n", err_im_per2  , gol_yjp2[31: 0]  , dut_yjp2[31: 0]  );
if(col_index>=3  ) $fwrite(tri_report_ieee754, "Item3   error re percent: %f%%, golden re result: %h, dut re result: %h\n", err_re_per3  , gol_yjp3[63:32]  , dut_yjp3[63:32]  );
if(col_index>=3  ) $fwrite(tri_report_ieee754, "Item3   error im percent: %f%%, golden im result: %h, dut im result: %h\n", err_im_per3  , gol_yjp3[31: 0]  , dut_yjp3[31: 0]  );


`endif


// ST_WIDTH_INF_16
