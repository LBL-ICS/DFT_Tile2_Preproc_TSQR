module bus_wrapper(input                            clk      ,
                   input                            rst      ,
                   input                            tile2_en ,
                   input      [`MX_SIZE-1:0]        mx_no    ,
                   input                            mem0_fi  ,
                   input                            mem1_fi  ,
                   output reg [`2:0]                pp_en    ,

                   output                           dma_req  ,
                   input                            dma_gnt  ,
                   output                           dma_wr   ,
                   output     [`MX_HT*`MX_WD-1:0]   wea  ,

                   output     [`RAM_WEA_WIDTH-1:0]  wea  ,
                   output     [`RAM_ADDR_WIDTH-1:0] addra,
                   output     [`RAM_WIDTH-1:0]      dina ,
                   output                           clkb ,
                   output                           enb  ,              
                   output     [`RAM_ADDR_WIDTH-1:0] addrb,
                   output reg [`RAM_WIDTH-1:0]      doutb);
reg [`RAM_WIDTH-1:0] ram[0:`RAM_DEPTH-1]; 

integer i;
always @(posedge clka) begin
  if (ena) begin
      ram[addra]<= dina;
  end
end

always @(posedge clkb) begin
  if (enb) begin
      doutb <= ram[addrb];
  end
end
endmodule
