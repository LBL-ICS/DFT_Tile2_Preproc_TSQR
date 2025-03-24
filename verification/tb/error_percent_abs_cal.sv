`ifdef ST_WIDTH_INF_2        
golden_r0   = golden_column[`RAM_WIDTH-0  *32-1:`RAM_WIDTH-0  *32-32];    
golden_i0   = golden_column[`RAM_WIDTH-1  *32-1:`RAM_WIDTH-1  *32-32];    
golden_r1   = golden_column[`RAM_WIDTH-2  *32-1:`RAM_WIDTH-2  *32-32];    
golden_i1   = golden_column[`RAM_WIDTH-3  *32-1:`RAM_WIDTH-3  *32-32];    
`endif // ST_WIDTH_INF_2        
`ifdef ST_WIDTH_INF_2        
dut_r0     =    dut_column[`RAM_WIDTH-0  *32-1:`RAM_WIDTH-0  *32-32];    
dut_i0     =    dut_column[`RAM_WIDTH-1  *32-1:`RAM_WIDTH-1  *32-32];    
dut_r1     =    dut_column[`RAM_WIDTH-2  *32-1:`RAM_WIDTH-2  *32-32];    
dut_i1     =    dut_column[`RAM_WIDTH-3  *32-1:`RAM_WIDTH-3  *32-32];    
`endif // ST_WIDTH_INF_2        

`ifdef ST_WIDTH_INF_2        
if(ieee754_to_fp(golden_r0 )<0) begin golden_real_r0  =-ieee754_to_fp(golden_r0 ); end else begin golden_real_r0   =ieee754_to_fp(golden_r0   ); end     
if(ieee754_to_fp(golden_r1 )<0) begin golden_real_r1  =-ieee754_to_fp(golden_r1 ); end else begin golden_real_r1   =ieee754_to_fp(golden_r1   ); end     
if(ieee754_to_fp(golden_i0 )<0) begin golden_real_i0  =-ieee754_to_fp(golden_i0 ); end else begin golden_real_i0   =ieee754_to_fp(golden_i0   ); end     
if(ieee754_to_fp(golden_i1 )<0) begin golden_real_i1  =-ieee754_to_fp(golden_i1 ); end else begin golden_real_i1   =ieee754_to_fp(golden_i1   ); end     
`endif // ST_WIDTH_INF_2                                                                                                                                          

`ifdef ST_WIDTH_INF_2        
if(ieee754_to_fp(dut_r0  )<0) begin dut_real_r0  =-ieee754_to_fp(dut_r0   ); end else begin dut_real_r0   =ieee754_to_fp(dut_r0   ); end     
if(ieee754_to_fp(dut_r1  )<0) begin dut_real_r1  =-ieee754_to_fp(dut_r1   ); end else begin dut_real_r1   =ieee754_to_fp(dut_r1   ); end     
if(ieee754_to_fp(dut_i0  )<0) begin dut_real_i0  =-ieee754_to_fp(dut_i0   ); end else begin dut_real_i0   =ieee754_to_fp(dut_i0   ); end     
if(ieee754_to_fp(dut_i1  )<0) begin dut_real_i1  =-ieee754_to_fp(dut_i1   ); end else begin dut_real_i1   =ieee754_to_fp(dut_i1   ); end     
`endif // ST_WIDTH_INF_2                                                                                                                                          

`ifdef ST_WIDTH_INF_2        
error_percent_r0   = ((dut_real_r0  -golden_real_r0  )/golden_real_r0  )*100;
error_percent_r1   = ((dut_real_r1  -golden_real_r1  )/golden_real_r1  )*100;
error_percent_i0   = ((dut_real_i0  -golden_real_i0  )/golden_real_i0  )*100;
error_percent_i1   = ((dut_real_i1  -golden_real_i1  )/golden_real_i1  )*100;
`endif // ST_WIDTH_INF_2        

`ifdef ST_WIDTH_INF_2        
if(error_percent_r0  <0) error_percent_r0   = -error_percent_r0  ; else error_percent_r0   = error_percent_r0  ;
if(error_percent_r1  <0) error_percent_r1   = -error_percent_r1  ; else error_percent_r1   = error_percent_r1  ;
if(error_percent_i0  <0) error_percent_i0   = -error_percent_i0  ; else error_percent_i0   = error_percent_i0  ;
if(error_percent_i1  <0) error_percent_i1   = -error_percent_i1  ; else error_percent_i1   = error_percent_i1  ;
`endif // ST_WIDTH_INF_2        
