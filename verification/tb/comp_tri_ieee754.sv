`ifdef ST_WIDTH_INF_4
$fwrite(tri_report_ieee754, "===============================%d Column Results    ======================================\n",col_index);
if(col_index>=0  ) $fwrite(tri_report_ieee754, "Item0   error re percent: %f%%, golden re result: %h, dut re result: %h\n", err_re_per0  , gol_re_yjp0  , dut_re_yjp0  );
if(col_index>=0  ) $fwrite(tri_report_ieee754, "Item0   error im percent: %f%%, golden im result: %h, dut im result: %h\n", err_im_per0  , gol_im_yjp0  , dut_im_yjp0  );
if(col_index>=1  ) $fwrite(tri_report_ieee754, "Item1   error re percent: %f%%, golden re result: %h, dut re result: %h\n", err_re_per1  , gol_re_yjp1  , dut_re_yjp1  );
if(col_index>=1  ) $fwrite(tri_report_ieee754, "Item1   error im percent: %f%%, golden im result: %h, dut im result: %h\n", err_im_per1  , gol_im_yjp1  , dut_im_yjp1  );
`endif // ST_WIDTH_INF_16
