module simple_dual(input                            clka ,
                   input                            ena  ,
                   input      [`RAM_WEA_WIDTH-1:0]  wea  ,
                   input      [`RAM_ADDR_WIDTH-1:0] addra,
                   input      [`RAM_WIDTH-1:0]      dina ,
                   input                            clkb ,
                   input                            enb  ,              
                   input      [`RAM_ADDR_WIDTH-1:0] addrb,
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
