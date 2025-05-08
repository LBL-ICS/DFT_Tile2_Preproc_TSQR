`ifdef ST_WIDTH_INF_4        
gol_yjp0   = gol_col[127:64];    
gol_yjp1   = gol_col[63 : 0];    
dut_yjp0   = dut_col[127:64];    
dut_yjp1   = dut_col[63 : 0];    

//if(ieee754_to_fp(gol_yjp0[63:32])<0) begin gol_re_yjp0  =-ieee754_to_fp(gol_yjp0[63:32]); end else begin gol_re_yjp0=ieee754_to_fp(gol_yjp0[63:32]); end     
//if(ieee754_to_fp(gol_yjp1[63:32])<0) begin gol_re_yjp1  =-ieee754_to_fp(gol_yjp1[63:32]); end else begin gol_re_yjp1=ieee754_to_fp(gol_yjp1[63:32]); end     
//if(ieee754_to_fp(dut_yjp0[63:32])<0) begin dut_re_yjp0  =-ieee754_to_fp(dut_yjp0[63:32]); end else begin dut_re_yjp0=ieee754_to_fp(dut_yjp0[63:32]); end     
//if(ieee754_to_fp(dut_yjp1[63:32])<0) begin dut_re_yjp1  =-ieee754_to_fp(dut_yjp1[63:32]); end else begin dut_re_yjp1=ieee754_to_fp(dut_yjp1[63:32]); end     
//if(ieee754_to_fp(gol_yjp0[31: 0])<0) begin gol_im_yjp0  =-ieee754_to_fp(gol_yjp0[31: 0]); end else begin gol_im_yjp0=ieee754_to_fp(gol_yjp0[31: 0]); end     
//if(ieee754_to_fp(gol_yjp1[31: 0])<0) begin gol_im_yjp1  =-ieee754_to_fp(gol_yjp1[31: 0]); end else begin gol_im_yjp1=ieee754_to_fp(gol_yjp1[31: 0]); end     
//if(ieee754_to_fp(dut_yjp0[31: 0])<0) begin dut_im_yjp0  =-ieee754_to_fp(dut_yjp0[31: 0]); end else begin dut_im_yjp0=ieee754_to_fp(dut_yjp0[31: 0]); end     
//if(ieee754_to_fp(dut_yjp1[31: 0])<0) begin dut_im_yjp1  =-ieee754_to_fp(dut_yjp1[31: 0]); end else begin dut_im_yjp1=ieee754_to_fp(dut_yjp1[31: 0]); end     

gol_re_yjp0=ieee754_to_fp(gol_yjp0[63:32]);      
gol_re_yjp1=ieee754_to_fp(gol_yjp1[63:32]);      
dut_re_yjp0=ieee754_to_fp(dut_yjp0[63:32]);      
dut_re_yjp1=ieee754_to_fp(dut_yjp1[63:32]);      
gol_im_yjp0=ieee754_to_fp(gol_yjp0[31: 0]);      
gol_im_yjp1=ieee754_to_fp(gol_yjp1[31: 0]);      
dut_im_yjp0=ieee754_to_fp(dut_yjp0[31: 0]);      
dut_im_yjp1=ieee754_to_fp(dut_yjp1[31: 0]);      

if(gol_yjp0[63:32]==0) begin err_re_per0   = (dut_re_yjp0-gol_re_yjp0); end else begin err_re_per0   = ((dut_re_yjp0  -gol_re_yjp0  )/gol_re_yjp0  )*100; end
if(gol_yjp1[63:32]==0) begin err_re_per1   = (dut_re_yjp1-gol_re_yjp1); end else begin err_re_per1   = ((dut_re_yjp1  -gol_re_yjp1  )/gol_re_yjp1  )*100; end
if(gol_yjp0[31:0 ]==0) begin err_im_per0   = (dut_im_yjp0-gol_im_yjp0); end else begin err_im_per0   = ((dut_im_yjp0  -gol_im_yjp0  )/gol_im_yjp0  )*100; end
if(gol_yjp1[31:0 ]==0) begin err_im_per1   = (dut_im_yjp1-gol_im_yjp1); end else begin err_im_per1   = ((dut_im_yjp1  -gol_im_yjp1  )/gol_im_yjp1  )*100; end

if(err_re_per0<0) err_re_per0   = -err_re_per0  ; else err_re_per0   = err_re_per0  ;
if(err_re_per1<0) err_re_per1   = -err_re_per1  ; else err_re_per1   = err_re_per1  ;
if(err_im_per0<0) err_im_per0   = -err_im_per0  ; else err_im_per0   = err_im_per0  ;
if(err_im_per1<0) err_im_per1   = -err_im_per1  ; else err_im_per1   = err_im_per1  ;
`endif // ST_WIDTH_INF_16      

`ifdef ST_WIDTH_INF_8        
gol_yjp0   = gol_col[255:192];    
gol_yjp1   = gol_col[191 : 128];    
dut_yjp0   = dut_col[255:192];    
dut_yjp1   = dut_col[191 : 128];

gol_yjp2   = gol_col[127:64];    
gol_yjp3   = gol_col[63 : 0];    
dut_yjp2   = dut_col[127:64];    
dut_yjp3   = dut_col[63 : 0]; 

//if(ieee754_to_fp(gol_yjp0[63:32])<0) begin gol_re_yjp0  =-ieee754_to_fp(gol_yjp0[63:32]); end else begin gol_re_yjp0=ieee754_to_fp(gol_yjp0[63:32]); end     
//if(ieee754_to_fp(gol_yjp1[63:32])<0) begin gol_re_yjp1  =-ieee754_to_fp(gol_yjp1[63:32]); end else begin gol_re_yjp1=ieee754_to_fp(gol_yjp1[63:32]); end     
//if(ieee754_to_fp(dut_yjp0[63:32])<0) begin dut_re_yjp0  =-ieee754_to_fp(dut_yjp0[63:32]); end else begin dut_re_yjp0=ieee754_to_fp(dut_yjp0[63:32]); end     
//if(ieee754_to_fp(dut_yjp1[63:32])<0) begin dut_re_yjp1  =-ieee754_to_fp(dut_yjp1[63:32]); end else begin dut_re_yjp1=ieee754_to_fp(dut_yjp1[63:32]); end     
//if(ieee754_to_fp(gol_yjp0[31: 0])<0) begin gol_im_yjp0  =-ieee754_to_fp(gol_yjp0[31: 0]); end else begin gol_im_yjp0=ieee754_to_fp(gol_yjp0[31: 0]); end     
//if(ieee754_to_fp(gol_yjp1[31: 0])<0) begin gol_im_yjp1  =-ieee754_to_fp(gol_yjp1[31: 0]); end else begin gol_im_yjp1=ieee754_to_fp(gol_yjp1[31: 0]); end     
//if(ieee754_to_fp(dut_yjp0[31: 0])<0) begin dut_im_yjp0  =-ieee754_to_fp(dut_yjp0[31: 0]); end else begin dut_im_yjp0=ieee754_to_fp(dut_yjp0[31: 0]); end     
//if(ieee754_to_fp(dut_yjp1[31: 0])<0) begin dut_im_yjp1  =-ieee754_to_fp(dut_yjp1[31: 0]); end else begin dut_im_yjp1=ieee754_to_fp(dut_yjp1[31: 0]); end     

gol_re_yjp0=ieee754_to_fp(gol_yjp0[63:32]);      
gol_re_yjp1=ieee754_to_fp(gol_yjp1[63:32]);      
dut_re_yjp0=ieee754_to_fp(dut_yjp0[63:32]);      
dut_re_yjp1=ieee754_to_fp(dut_yjp1[63:32]);      
gol_im_yjp0=ieee754_to_fp(gol_yjp0[31: 0]);      
gol_im_yjp1=ieee754_to_fp(gol_yjp1[31: 0]);      
dut_im_yjp0=ieee754_to_fp(dut_yjp0[31: 0]);      
dut_im_yjp1=ieee754_to_fp(dut_yjp1[31: 0]);     

gol_re_yjp2=ieee754_to_fp(gol_yjp2[63:32]);      
gol_re_yjp3=ieee754_to_fp(gol_yjp3[63:32]);      
dut_re_yjp2=ieee754_to_fp(dut_yjp2[63:32]);      
dut_re_yjp3=ieee754_to_fp(dut_yjp3[63:32]);      
gol_im_yjp2=ieee754_to_fp(gol_yjp2[31: 0]);      
gol_im_yjp3=ieee754_to_fp(gol_yjp3[31: 0]);      
dut_im_yjp2=ieee754_to_fp(dut_yjp2[31: 0]);      
dut_im_yjp3=ieee754_to_fp(dut_yjp3[31: 0]);      


if(gol_yjp0[63:32]==0) begin err_re_per0   = (dut_re_yjp0-gol_re_yjp0); end else begin err_re_per0   = ((dut_re_yjp0  -gol_re_yjp0  )/gol_re_yjp0  )*100; end
if(gol_yjp1[63:32]==0) begin err_re_per1   = (dut_re_yjp1-gol_re_yjp1); end else begin err_re_per1   = ((dut_re_yjp1  -gol_re_yjp1  )/gol_re_yjp1  )*100; end
if(gol_yjp0[31:0 ]==0) begin err_im_per0   = (dut_im_yjp0-gol_im_yjp0); end else begin err_im_per0   = ((dut_im_yjp0  -gol_im_yjp0  )/gol_im_yjp0  )*100; end
if(gol_yjp1[31:0 ]==0) begin err_im_per1   = (dut_im_yjp1-gol_im_yjp1); end else begin err_im_per1   = ((dut_im_yjp1  -gol_im_yjp1  )/gol_im_yjp1  )*100; end

if(gol_yjp2[63:32]==0) begin err_re_per2   = (dut_re_yjp2-gol_re_yjp2); end else begin err_re_per2   = ((dut_re_yjp2  -gol_re_yjp2  )/gol_re_yjp2  )*100; end
if(gol_yjp3[63:32]==0) begin err_re_per3   = (dut_re_yjp3-gol_re_yjp3); end else begin err_re_per3   = ((dut_re_yjp3  -gol_re_yjp3  )/gol_re_yjp3  )*100; end
if(gol_yjp2[31:0 ]==0) begin err_im_per2   = (dut_im_yjp2-gol_im_yjp2); end else begin err_im_per2   = ((dut_im_yjp2  -gol_im_yjp2  )/gol_im_yjp2  )*100; end
if(gol_yjp3[31:0 ]==0) begin err_im_per3   = (dut_im_yjp3-gol_im_yjp3); end else begin err_im_per3   = ((dut_im_yjp3  -gol_im_yjp3  )/gol_im_yjp3  )*100; end


if(err_re_per0<0) err_re_per0   = -err_re_per0  ; else err_re_per0   = err_re_per0  ;
if(err_re_per1<0) err_re_per1   = -err_re_per1  ; else err_re_per1   = err_re_per1  ;
if(err_im_per0<0) err_im_per0   = -err_im_per0  ; else err_im_per0   = err_im_per0  ;
if(err_im_per1<0) err_im_per1   = -err_im_per1  ; else err_im_per1   = err_im_per1  ;

if(err_re_per2<0) err_re_per2   = -err_re_per2  ; else err_re_per2   = err_re_per2  ;
if(err_re_per3<0) err_re_per3   = -err_re_per3  ; else err_re_per3   = err_re_per3  ;
if(err_im_per2<0) err_im_per2   = -err_im_per2  ; else err_im_per2   = err_im_per2  ;
if(err_im_per3<0) err_im_per3   = -err_im_per3  ; else err_im_per3   = err_im_per3  ;

`endif // ST_WIDTH_INF_16  
