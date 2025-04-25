`include "define.v"
module simple_dual_19(input                            io_clka ,
                      input                            io_ena  ,
                      input      [`RAM_WEA_WIDTH-1:0]  io_wea  ,
                      input      [`RAM_ADDR_WIDTH-1:0] io_addra,
                      input      [`RAM_WIDTH-1:0]      io_dina ,
                      input                            io_clkb ,
                      input                            io_enb  ,              
                      input      [`RAM_ADDR_WIDTH-1:0] io_addrb,
                      output reg [`RAM_WIDTH-1:0]      io_doutb);
reg [`RAM_WIDTH-1:0] ram[0:`RAM_DEPTH-1]; 

generate
    genvar i;
    for (i = 0; i < `RAM_WEA_WIDTH; i = i + 1) begin : gen_block
        always @(posedge io_clka) begin
	  if(io_ena) begin
            if (io_wea[`RAM_WEA_WIDTH - i - 1]) begin
                ram[io_addra][`RAM_WIDTH - 8*(i+1) +: 8] <= io_dina[`RAM_WIDTH - 8*(i+1) +: 8];
            end
          end
        end
    end
endgenerate

//always @(posedge io_clkb) begin

//  if (io_enb) begin
//      io_doutb <= ram[io_addrb];
//  end
//end
//
reg [`RAM_WIDTH-1:0] doutb_reg;
always @(posedge io_clkb) begin
      	if (io_enb) begin     
	       	doutb_reg <= ram[io_addrb];
      	end
end
always @(posedge io_clkb) begin
      	io_doutb  <= doutb_reg;
end
endmodule
