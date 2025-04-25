module fsm(
  input         clk,
  input         rst,
  input         tsqr_en,
  input  [15:0] tile_no,
  output [15:0] hh_cnt,
  output [15:0] mx_cnt,
  output        d1_rdy,
  output        d1_vld,
  output        d2_vld,
  output        vk1_vld,
  output        d3_rdy,
  output        d3_vld,
  output        tk_vld,
  output        d4_rdy,
  output        d5_rdy,
  output        d5_vld,
  output        yj_sft,
  output        d4_sft,
  output        hh_st,
  output        mem0_fi,
  output        mem1_fi,
  output        tsqr_fi,
  output        dmx0_mem_ena,
  output [15:0] dmx0_mem_wea,
  output        dmx0_mem_addra,
  output        dmx0_mem_enb,
  output        dmx0_mem_addrb,
  output        dmx1_mem_ena,
  output [15:0] dmx1_mem_wea,
  output        dmx1_mem_addra,
  output        dmx1_mem_enb,
  output        dmx1_mem_addrb,
  output        rtri_mem_ena,
  output [15:0] rtri_mem_wea,
  output        rtri_mem_addra,
  output        rtri_mem_enb,
  output        rtri_mem_addrb
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
`endif // RANDOMIZE_REG_INIT
  reg  hh_en; // @[tsqr_fsm.scala 92:24]
  reg  nxt_hh_en; // @[tsqr_fsm.scala 93:28]
  wire  _T = mem0_fi | mem1_fi; // @[tsqr_fsm.scala 97:28]
  wire  _GEN_0 = tsqr_en | nxt_hh_en; // @[tsqr_fsm.scala 100:23 93:28 99:28]
  reg [15:0] cnt; // @[tsqr_fsm.scala 109:22]
  reg [15:0] nxt_hh_cnt; // @[tsqr_fsm.scala 111:29]
  reg [15:0] nxt_mx_cnt; // @[tsqr_fsm.scala 112:29]
  wire  _T_1 = cnt == 16'h2fc; // @[tsqr_fsm.scala 114:18]
  wire [15:0] _nxt_cnt_T_1 = cnt + 16'h1; // @[tsqr_fsm.scala 117:28]
  wire [2:0] _T_3 = 3'h4 / 2'h2; // @[tsqr_fsm.scala 122:64]
  wire [2:0] _T_5 = _T_3 - 3'h1; // @[tsqr_fsm.scala 122:68]
  wire [15:0] _GEN_79 = {{13'd0}, _T_5}; // @[tsqr_fsm.scala 122:42]
  wire [15:0] _nxt_hh_cnt_T_1 = hh_cnt + 16'h1; // @[tsqr_fsm.scala 125:34]
  wire  _T_10 = hh_cnt == 16'h1; // @[tsqr_fsm.scala 130:22]
  wire [9:0] _T_17 = 10'h2fc - 10'h1; // @[tsqr_fsm.scala 132:77]
  wire [15:0] _GEN_80 = {{6'd0}, _T_17}; // @[tsqr_fsm.scala 132:63]
  wire [15:0] _nxt_mx_cnt_T_1 = mx_cnt + 16'h1; // @[tsqr_fsm.scala 133:34]
  reg [15:0] tr_cy_reg; // @[tsqr_fsm.scala 148:28]
  reg  tr_cnt_en; // @[tsqr_fsm.scala 149:28]
  reg [15:0] tr_cnt; // @[tsqr_fsm.scala 150:25]
  wire  rd_mem_fst = rst ? 1'h0 : tsqr_en & (~hh_en | ~nxt_hh_en); // @[tsqr_fsm.scala 155:18 156:24 161:24]
  wire  wr_mem_st = rst ? 1'h0 : hh_en & tr_cnt == 16'hed; // @[tsqr_fsm.scala 155:18 157:23 162:23]
  wire  rd_mem_st = rst ? 1'h0 : hh_en & cnt == 16'h207; // @[tsqr_fsm.scala 155:18 159:23 164:23]
  wire [15:0] _tr_cy_T_1 = 16'h2 - hh_cnt; // @[tsqr_fsm.scala 171:45]
  wire [15:0] tr_cy = rd_mem_st ? _tr_cy_T_1 : tr_cy_reg; // @[tsqr_fsm.scala 170:24 171:19 173:19]
  wire [15:0] _hh_fi_T_1 = 16'hee + tr_cy; // @[tsqr_fsm.scala 177:45]
  wire [15:0] _hh_fi_T_3 = _hh_fi_T_1 + 16'h1; // @[tsqr_fsm.scala 177:53]
  wire  hh_fi = tr_cnt == _hh_fi_T_3; // @[tsqr_fsm.scala 177:26]
  wire [15:0] _nxt_tr_cnt_T_1 = tr_cnt + 16'h1; // @[tsqr_fsm.scala 183:34]
  wire  _T_21 = hh_en & cnt == 16'h20c; // @[tsqr_fsm.scala 200:27]
  wire  _GEN_22 = hh_en & cnt == 16'h20c | tr_cnt_en; // @[tsqr_fsm.scala 200:51 201:23 149:28]
  wire  _GEN_23 = hh_fi ? 1'h0 : _GEN_22; // @[tsqr_fsm.scala 198:26 199:23]
  wire  _GEN_24 = rst ? 1'h0 : _GEN_23; // @[tsqr_fsm.scala 196:18 197:23]
  reg  tr_cnt_en_2; // @[tsqr_fsm.scala 203:30]
  wire  _GEN_25 = _T_21 | _GEN_24; // @[tsqr_fsm.scala 209:51 210:23]
  wire  _GEN_28 = hh_en & cnt == 16'h20b | tr_cnt_en_2; // @[tsqr_fsm.scala 216:51 217:25 203:30]
  reg  d1_rdy_REG; // @[tsqr_fsm.scala 220:26]
  reg  d1_vld_REG; // @[tsqr_fsm.scala 221:26]
  reg  d2_vld_REG; // @[tsqr_fsm.scala 223:26]
  wire  _vk1_vld_T = cnt == 16'h209; // @[tsqr_fsm.scala 225:41]
  wire  _vk1_vld_T_1 = hh_en & cnt == 16'h209; // @[tsqr_fsm.scala 225:34]
  reg  vk1_vld_REG; // @[tsqr_fsm.scala 225:27]
  reg  d3_rdy_REG; // @[tsqr_fsm.scala 226:26]
  reg  d3_vld_REG; // @[tsqr_fsm.scala 227:26]
  reg  tk_vld_REG; // @[tsqr_fsm.scala 229:26]
  wire [15:0] _d4_vld_T_3 = 16'h34 + tr_cy; // @[tsqr_fsm.scala 232:78]
  wire [15:0] _d5_vld_T_3 = _d4_vld_T_3 + 16'h80; // @[tsqr_fsm.scala 235:61]
  wire [15:0] _d5_vld_T_5 = _d5_vld_T_3 + 16'h16; // @[tsqr_fsm.scala 235:75]
  wire [15:0] _d5_vld_T_7 = _d5_vld_T_5 - tr_cy; // @[tsqr_fsm.scala 235:87]
  wire [15:0] _d5_vld_T_9 = _d5_vld_T_7 - 16'h1; // @[tsqr_fsm.scala 235:95]
  wire [5:0] _d5_vld_T_13 = 6'h34 - 6'h1; // @[tsqr_fsm.scala 235:127]
  wire [15:0] _GEN_81 = {{10'd0}, _d5_vld_T_13}; // @[tsqr_fsm.scala 235:132]
  wire [15:0] _d5_vld_T_15 = _GEN_81 + tr_cy; // @[tsqr_fsm.scala 235:132]
  wire [15:0] _d5_vld_T_17 = _d5_vld_T_15 + 16'h80; // @[tsqr_fsm.scala 235:139]
  wire [15:0] _d5_vld_T_19 = _d5_vld_T_17 + 16'h16; // @[tsqr_fsm.scala 235:153]
  wire [7:0] _d5_rdy_T_3 = 8'hb4 - 8'h2; // @[tsqr_fsm.scala 237:68]
  wire [15:0] _GEN_82 = {{8'd0}, _d5_rdy_T_3}; // @[tsqr_fsm.scala 237:39]
  wire [15:0] _d5_rdy_T_11 = _d5_vld_T_3 - 16'h2; // @[tsqr_fsm.scala 237:122]
  wire [15:0] _d4_sft_T_3 = 16'hb3 + tr_cy; // @[tsqr_fsm.scala 244:94]
  wire [15:0] _yj_sft_T_1 = 16'hcc + tr_cy; // @[tsqr_fsm.scala 246:64]
  wire [15:0] _yj_sft_T_3 = _yj_sft_T_1 - 16'h1; // @[tsqr_fsm.scala 246:72]
  reg  yj_sft_REG; // @[tsqr_fsm.scala 246:25]
  reg  dmx0_mem_enb_reg; // @[tsqr_fsm.scala 254:35]
  reg  dmx1_mem_enb_reg; // @[tsqr_fsm.scala 255:35]
  reg  rtri_mem_enb_reg; // @[tsqr_fsm.scala 256:35]
  reg  dmx0_mem_ena_reg; // @[tsqr_fsm.scala 257:35]
  reg  dmx1_mem_ena_reg; // @[tsqr_fsm.scala 258:35]
  reg  rtri_mem_ena_reg; // @[tsqr_fsm.scala 259:35]
  wire  _rd_dmx0_en_T_1 = ~mx_cnt[0]; // @[tsqr_fsm.scala 272:27]
  wire [15:0] _rd_dmx0_en_T_4 = 16'h209 + tr_cy; // @[tsqr_fsm.scala 272:76]
  wire [15:0] _rd_dmx0_en_T_6 = _rd_dmx0_en_T_4 + 16'h1; // @[tsqr_fsm.scala 272:84]
  wire  _rd_dmx0_en_T_8 = cnt >= 16'h209 & cnt < _rd_dmx0_en_T_6; // @[tsqr_fsm.scala 272:58]
  wire  rd_dmx0_en = rst ? 1'h0 : ~mx_cnt[0] & (cnt >= 16'h209 & cnt < _rd_dmx0_en_T_6); // @[tsqr_fsm.scala 264:18 265:24 272:24]
  wire  rd_dmx1_en = rst ? 1'h0 : mx_cnt[0] & _rd_dmx0_en_T_8; // @[tsqr_fsm.scala 264:18 266:24 273:24]
  wire  rd_rtri_en = rst ? 1'h0 : _rd_dmx0_en_T_8; // @[tsqr_fsm.scala 264:18 267:24 274:24]
  reg  dmx0_mem_addrb_reg; // @[tsqr_fsm.scala 280:37]
  reg  dmx1_mem_addrb_reg; // @[tsqr_fsm.scala 281:37]
  reg  rtri_mem_addrb_reg; // @[tsqr_fsm.scala 282:37]
  wire  _GEN_37 = rd_dmx0_en ? dmx0_mem_addrb_reg + 1'h1 : dmx0_mem_addrb_reg; // @[tsqr_fsm.scala 294:31 295:33 297:33]
  wire [15:0] _GEN_38 = _rd_dmx0_en_T_1 & _vk1_vld_T_1 ? hh_cnt : {{15'd0}, _GEN_37}; // @[tsqr_fsm.scala 292:63 293:32]
  wire [15:0] _GEN_39 = rd_mem_fst ? 16'h0 : _GEN_38; // @[tsqr_fsm.scala 290:25 291:33]
  wire  _GEN_40 = rd_dmx1_en ? dmx1_mem_addrb_reg + 1'h1 : dmx1_mem_addrb_reg; // @[tsqr_fsm.scala 304:31 305:33 307:33]
  wire [15:0] _GEN_41 = mx_cnt[0] & _vk1_vld_T_1 ? hh_cnt : {{15'd0}, _GEN_40}; // @[tsqr_fsm.scala 302:62 303:33]
  wire [15:0] _GEN_42 = rd_mem_fst ? 16'h0 : _GEN_41; // @[tsqr_fsm.scala 300:25 301:33]
  wire  _GEN_43 = rd_rtri_en ? rtri_mem_addrb_reg + 1'h1 : rtri_mem_addrb_reg; // @[tsqr_fsm.scala 314:31 315:33 317:33]
  wire [15:0] _GEN_44 = _vk1_vld_T_1 ? hh_cnt : {{15'd0}, _GEN_43}; // @[tsqr_fsm.scala 312:50 313:33]
  wire [15:0] _GEN_45 = rd_mem_fst ? 16'h0 : _GEN_44; // @[tsqr_fsm.scala 310:25 311:33]
  reg [15:0] dmx0_mem_wea_reg; // @[tsqr_fsm.scala 320:35]
  reg [15:0] dmx1_mem_wea_reg; // @[tsqr_fsm.scala 321:35]
  reg [15:0] rtri_mem_wea_reg; // @[tsqr_fsm.scala 322:35]
  reg [15:0] rtri_mem_wea_update; // @[tsqr_fsm.scala 325:38]
  wire  _dmx0_mem_ena_wire_T_2 = tr_cnt >= 16'hee; // @[tsqr_fsm.scala 332:55]
  wire  _dmx0_mem_ena_wire_T_6 = tr_cnt < _hh_fi_T_1; // @[tsqr_fsm.scala 332:85]
  wire  dmx0_mem_ena_wire = rst ? 1'h0 : _rd_dmx0_en_T_1 & tr_cnt >= 16'hee & tr_cnt < _hh_fi_T_1; // @[tsqr_fsm.scala 327:18 328:31 332:31]
  wire  dmx1_mem_ena_wire = rst ? 1'h0 : mx_cnt[0] & _dmx0_mem_ena_wire_T_2 & _dmx0_mem_ena_wire_T_6; // @[tsqr_fsm.scala 327:18 329:31 333:31]
  wire  rtri_mem_ena_wire = rst ? 1'h0 : _dmx0_mem_ena_wire_T_2 & _dmx0_mem_ena_wire_T_6; // @[tsqr_fsm.scala 327:18 330:31 334:31]
  reg  dmx0_mem_addra_reg; // @[tsqr_fsm.scala 365:37]
  reg  dmx1_mem_addra_reg; // @[tsqr_fsm.scala 366:37]
  reg  rtri_mem_addra_reg; // @[tsqr_fsm.scala 367:37]
  wire  _T_45 = hh_en & tr_cnt == 16'hee; // @[tsqr_fsm.scala 369:34]
  wire  _GEN_55 = dmx0_mem_ena_wire ? dmx0_mem_addra_reg + 1'h1 : dmx0_mem_addra_reg; // @[tsqr_fsm.scala 371:38 372:33 374:33]
  wire [15:0] _GEN_56 = _rd_dmx0_en_T_1 & (hh_en & tr_cnt == 16'hee) ? hh_cnt : {{15'd0}, _GEN_55}; // @[tsqr_fsm.scala 369:66 370:33]
  wire  _GEN_57 = dmx1_mem_ena_wire ? dmx1_mem_addra_reg + 1'h1 : dmx1_mem_addra_reg; // @[tsqr_fsm.scala 379:38 380:33 382:33]
  wire [15:0] _GEN_58 = mx_cnt[0] & _T_45 ? hh_cnt : {{15'd0}, _GEN_57}; // @[tsqr_fsm.scala 377:65 378:33]
  wire  _GEN_59 = rtri_mem_ena_wire ? rtri_mem_addra_reg + 1'h1 : rtri_mem_addra_reg; // @[tsqr_fsm.scala 387:38 388:33 390:33]
  wire [15:0] _GEN_60 = _T_45 ? hh_cnt : {{15'd0}, _GEN_59}; // @[tsqr_fsm.scala 385:53 386:33]
  wire  dmx0_mem_addra_wire = _GEN_56[0]; // @[tsqr_fsm.scala 286:39]
  wire  dmx1_mem_addra_wire = _GEN_58[0]; // @[tsqr_fsm.scala 287:39]
  wire  rtri_mem_addra_wire = _GEN_60[0]; // @[tsqr_fsm.scala 288:39]
  wire  dmx0_mem_addrb_wire = _GEN_39[0]; // @[tsqr_fsm.scala 283:39]
  wire  dmx1_mem_addrb_wire = _GEN_42[0]; // @[tsqr_fsm.scala 284:39]
  wire  rtri_mem_addrb_wire = _GEN_45[0]; // @[tsqr_fsm.scala 285:39]
  wire [15:0] _mem0_fi_T_5 = _hh_fi_T_1 - 16'h1; // @[tsqr_fsm.scala 428:63]
  wire  _mem0_fi_T_6 = tr_cnt == _mem0_fi_T_5; // @[tsqr_fsm.scala 428:36]
  wire  _mem0_fi_T_8 = tr_cy == 16'h1; // @[tsqr_fsm.scala 428:80]
  wire [15:0] _tsqr_fi_T_2 = tile_no - 16'h1; // @[tsqr_fsm.scala 431:58]
  wire [19:0] _rtri_mem_wea_update_T_2 = hh_cnt * 4'h8; // @[tsqr_fsm.scala 438:62]
  wire [15:0] _rtri_mem_wea_update_T_3 = rtri_mem_wea_update >> _rtri_mem_wea_update_T_2; // @[tsqr_fsm.scala 438:52]
  assign hh_cnt = rst ? 16'h0 : nxt_hh_cnt; // @[tsqr_fsm.scala 138:18 140:20 144:20]
  assign mx_cnt = rst ? 16'h0 : nxt_mx_cnt; // @[tsqr_fsm.scala 138:18 141:20 145:20]
  assign d1_rdy = d1_rdy_REG; // @[tsqr_fsm.scala 220:16]
  assign d1_vld = d1_vld_REG; // @[tsqr_fsm.scala 221:16]
  assign d2_vld = d2_vld_REG; // @[tsqr_fsm.scala 223:16]
  assign vk1_vld = vk1_vld_REG; // @[tsqr_fsm.scala 225:17]
  assign d3_rdy = d3_rdy_REG; // @[tsqr_fsm.scala 226:16]
  assign d3_vld = d3_vld_REG; // @[tsqr_fsm.scala 227:16]
  assign tk_vld = tk_vld_REG; // @[tsqr_fsm.scala 229:16]
  assign d4_rdy = tr_cnt_en & tr_cnt < tr_cy; // @[tsqr_fsm.scala 231:29]
  assign d5_rdy = tr_cnt_en & tr_cnt >= _GEN_82 & tr_cnt < _d5_rdy_T_11; // @[tsqr_fsm.scala 237:76]
  assign d5_vld = tr_cnt_en & tr_cnt >= _d5_vld_T_9 & tr_cnt < _d5_vld_T_19; // @[tsqr_fsm.scala 235:103]
  assign yj_sft = yj_sft_REG; // @[tsqr_fsm.scala 246:16]
  assign d4_sft = tr_cnt_en & tr_cnt >= 16'h33 & tr_cnt < _d4_sft_T_3; // @[tsqr_fsm.scala 244:57]
  assign hh_st = rst ? 1'h0 : hh_en & tr_cnt == 16'hf1; // @[tsqr_fsm.scala 155:18 158:19 163:19]
  assign mem0_fi = _rd_dmx0_en_T_1 & tr_cnt == _mem0_fi_T_5 & tr_cy == 16'h1; // @[tsqr_fsm.scala 428:71]
  assign mem1_fi = mx_cnt[0] & _mem0_fi_T_6 & _mem0_fi_T_8; // @[tsqr_fsm.scala 429:68]
  assign tsqr_fi = _T & mx_cnt == _tsqr_fi_T_2; // @[tsqr_fsm.scala 431:36]
  assign dmx0_mem_ena = dmx0_mem_ena_reg; // @[tsqr_fsm.scala 447:22]
  assign dmx0_mem_wea = _rd_dmx0_en_T_1 & wr_mem_st ? 16'hffff : dmx0_mem_wea_reg; // @[tsqr_fsm.scala 337:37 338:26 340:26]
  assign dmx0_mem_addra = dmx0_mem_addra_reg; // @[tsqr_fsm.scala 424:20]
  assign dmx0_mem_enb = dmx0_mem_enb_reg; // @[tsqr_fsm.scala 444:22]
  assign dmx0_mem_addrb = dmx0_mem_addrb_reg; // @[tsqr_fsm.scala 421:20]
  assign dmx1_mem_ena = dmx1_mem_ena_reg; // @[tsqr_fsm.scala 448:22]
  assign dmx1_mem_wea = mx_cnt[0] & wr_mem_st ? 16'hffff : dmx1_mem_wea_reg; // @[tsqr_fsm.scala 343:36 344:26 346:26]
  assign dmx1_mem_addra = dmx1_mem_addra_reg; // @[tsqr_fsm.scala 425:20]
  assign dmx1_mem_enb = dmx1_mem_enb_reg; // @[tsqr_fsm.scala 445:22]
  assign dmx1_mem_addrb = dmx1_mem_addrb_reg; // @[tsqr_fsm.scala 422:20]
  assign rtri_mem_ena = rtri_mem_ena_reg; // @[tsqr_fsm.scala 449:22]
  assign rtri_mem_wea = wr_mem_st ? rtri_mem_wea_update : rtri_mem_wea_reg; // @[tsqr_fsm.scala 349:24 350:26 352:26]
  assign rtri_mem_addra = rtri_mem_addra_reg; // @[tsqr_fsm.scala 426:20]
  assign rtri_mem_enb = rtri_mem_enb_reg; // @[tsqr_fsm.scala 446:22]
  assign rtri_mem_addrb = rtri_mem_addrb_reg; // @[tsqr_fsm.scala 423:20]
  always @(posedge clk) begin
    if (rst) begin // @[tsqr_fsm.scala 103:18]
      hh_en <= 1'h0; // @[tsqr_fsm.scala 104:19]
    end else begin
      hh_en <= nxt_hh_en; // @[tsqr_fsm.scala 106:19]
    end
    if (rst) begin // @[tsqr_fsm.scala 95:18]
      nxt_hh_en <= 1'h0; // @[tsqr_fsm.scala 96:23]
    end else if (mem0_fi | mem1_fi) begin // @[tsqr_fsm.scala 97:38]
      nxt_hh_en <= 1'h0; // @[tsqr_fsm.scala 98:23]
    end else begin
      nxt_hh_en <= _GEN_0;
    end
    if (rst) begin // @[tsqr_fsm.scala 138:18]
      cnt <= 16'h0; // @[tsqr_fsm.scala 139:17]
    end else if (cnt == 16'h2fc) begin // @[tsqr_fsm.scala 114:34]
      cnt <= 16'h0; // @[tsqr_fsm.scala 115:21]
    end else if (hh_en) begin // @[tsqr_fsm.scala 116:26]
      cnt <= _nxt_cnt_T_1; // @[tsqr_fsm.scala 117:21]
    end
    if (_T_1 & hh_cnt == _GEN_79) begin // @[tsqr_fsm.scala 122:75]
      nxt_hh_cnt <= 16'h0; // @[tsqr_fsm.scala 123:24]
    end else if (hh_en & _T_1) begin // @[tsqr_fsm.scala 124:48]
      nxt_hh_cnt <= _nxt_hh_cnt_T_1; // @[tsqr_fsm.scala 125:24]
    end else begin
      nxt_hh_cnt <= hh_cnt; // @[tsqr_fsm.scala 127:24]
    end
    if (hh_cnt == 16'h1 & mx_cnt == tile_no & _T_1) begin // @[tsqr_fsm.scala 130:96]
      nxt_mx_cnt <= 16'h0; // @[tsqr_fsm.scala 131:24]
    end else if (_T_10 & cnt == _GEN_80) begin // @[tsqr_fsm.scala 132:83]
      nxt_mx_cnt <= _nxt_mx_cnt_T_1; // @[tsqr_fsm.scala 133:24]
    end else begin
      nxt_mx_cnt <= mx_cnt; // @[tsqr_fsm.scala 135:24]
    end
    if (rst) begin // @[tsqr_fsm.scala 188:18]
      tr_cy_reg <= 16'h0; // @[tsqr_fsm.scala 190:23]
    end else if (rd_mem_st) begin // @[tsqr_fsm.scala 170:24]
      tr_cy_reg <= _tr_cy_T_1; // @[tsqr_fsm.scala 171:19]
    end
    if (rst) begin // @[tsqr_fsm.scala 205:18]
      tr_cnt_en <= 1'h0; // @[tsqr_fsm.scala 206:23]
    end else if (hh_fi) begin // @[tsqr_fsm.scala 207:26]
      tr_cnt_en <= 1'h0; // @[tsqr_fsm.scala 208:23]
    end else begin
      tr_cnt_en <= _GEN_25;
    end
    if (rst) begin // @[tsqr_fsm.scala 188:18]
      tr_cnt <= 16'h0; // @[tsqr_fsm.scala 189:20]
    end else if (hh_fi) begin // @[tsqr_fsm.scala 180:20]
      tr_cnt <= 16'h0; // @[tsqr_fsm.scala 181:24]
    end else if (tr_cnt_en) begin // @[tsqr_fsm.scala 182:30]
      tr_cnt <= _nxt_tr_cnt_T_1; // @[tsqr_fsm.scala 183:24]
    end
    if (rst) begin // @[tsqr_fsm.scala 212:18]
      tr_cnt_en_2 <= 1'h0; // @[tsqr_fsm.scala 213:25]
    end else if (hh_fi) begin // @[tsqr_fsm.scala 214:26]
      tr_cnt_en_2 <= 1'h0; // @[tsqr_fsm.scala 215:25]
    end else begin
      tr_cnt_en_2 <= _GEN_28;
    end
    d1_rdy_REG <= hh_en & cnt == 16'h1; // @[tsqr_fsm.scala 220:33]
    d1_vld_REG <= hh_en & cnt == 16'h34; // @[tsqr_fsm.scala 221:33]
    d2_vld_REG <= hh_en & cnt == 16'hbf; // @[tsqr_fsm.scala 223:33]
    vk1_vld_REG <= hh_en & cnt == 16'h209; // @[tsqr_fsm.scala 225:34]
    d3_rdy_REG <= hh_en & _vk1_vld_T; // @[tsqr_fsm.scala 226:33]
    d3_vld_REG <= hh_en & cnt == 16'h23d; // @[tsqr_fsm.scala 227:33]
    tk_vld_REG <= hh_en & cnt == 16'h2be; // @[tsqr_fsm.scala 229:33]
    yj_sft_REG <= tr_cnt_en_2 & tr_cnt < _yj_sft_T_3; // @[tsqr_fsm.scala 246:38]
    if (rst) begin // @[tsqr_fsm.scala 393:14]
      dmx0_mem_enb_reg <= 1'h0; // @[tsqr_fsm.scala 400:26]
    end else if (rst) begin // @[tsqr_fsm.scala 264:18]
      dmx0_mem_enb_reg <= 1'h0; // @[tsqr_fsm.scala 268:31]
    end else begin
      dmx0_mem_enb_reg <= _rd_dmx0_en_T_1 & rd_mem_fst | rd_dmx0_en; // @[tsqr_fsm.scala 275:31]
    end
    if (rst) begin // @[tsqr_fsm.scala 393:14]
      dmx1_mem_enb_reg <= 1'h0; // @[tsqr_fsm.scala 401:26]
    end else if (rst) begin // @[tsqr_fsm.scala 264:18]
      dmx1_mem_enb_reg <= 1'h0; // @[tsqr_fsm.scala 269:31]
    end else begin
      dmx1_mem_enb_reg <= mx_cnt[0] & rd_mem_fst | rd_dmx1_en; // @[tsqr_fsm.scala 276:31]
    end
    if (rst) begin // @[tsqr_fsm.scala 393:14]
      rtri_mem_enb_reg <= 1'h0; // @[tsqr_fsm.scala 402:26]
    end else if (rst) begin // @[tsqr_fsm.scala 264:18]
      rtri_mem_enb_reg <= 1'h0; // @[tsqr_fsm.scala 270:31]
    end else begin
      rtri_mem_enb_reg <= rd_mem_fst | rd_rtri_en; // @[tsqr_fsm.scala 277:31]
    end
    if (rst) begin // @[tsqr_fsm.scala 393:14]
      dmx0_mem_ena_reg <= 1'h0; // @[tsqr_fsm.scala 403:26]
    end else if (rst) begin // @[tsqr_fsm.scala 327:18]
      dmx0_mem_ena_reg <= 1'h0; // @[tsqr_fsm.scala 328:31]
    end else begin
      dmx0_mem_ena_reg <= _rd_dmx0_en_T_1 & tr_cnt >= 16'hee & tr_cnt < _hh_fi_T_1; // @[tsqr_fsm.scala 332:31]
    end
    if (rst) begin // @[tsqr_fsm.scala 393:14]
      dmx1_mem_ena_reg <= 1'h0; // @[tsqr_fsm.scala 404:26]
    end else if (rst) begin // @[tsqr_fsm.scala 327:18]
      dmx1_mem_ena_reg <= 1'h0; // @[tsqr_fsm.scala 329:31]
    end else begin
      dmx1_mem_ena_reg <= mx_cnt[0] & _dmx0_mem_ena_wire_T_2 & _dmx0_mem_ena_wire_T_6; // @[tsqr_fsm.scala 333:31]
    end
    if (rst) begin // @[tsqr_fsm.scala 393:14]
      rtri_mem_ena_reg <= 1'h0; // @[tsqr_fsm.scala 405:26]
    end else if (rst) begin // @[tsqr_fsm.scala 327:18]
      rtri_mem_ena_reg <= 1'h0; // @[tsqr_fsm.scala 330:31]
    end else begin
      rtri_mem_ena_reg <= _dmx0_mem_ena_wire_T_2 & _dmx0_mem_ena_wire_T_6; // @[tsqr_fsm.scala 334:31]
    end
    if (rst) begin // @[tsqr_fsm.scala 393:14]
      dmx0_mem_addrb_reg <= 1'h0; // @[tsqr_fsm.scala 397:28]
    end else begin
      dmx0_mem_addrb_reg <= dmx0_mem_addrb_wire; // @[tsqr_fsm.scala 410:28]
    end
    if (rst) begin // @[tsqr_fsm.scala 393:14]
      dmx1_mem_addrb_reg <= 1'h0; // @[tsqr_fsm.scala 398:28]
    end else begin
      dmx1_mem_addrb_reg <= dmx1_mem_addrb_wire; // @[tsqr_fsm.scala 411:28]
    end
    if (rst) begin // @[tsqr_fsm.scala 393:14]
      rtri_mem_addrb_reg <= 1'h0; // @[tsqr_fsm.scala 399:28]
    end else begin
      rtri_mem_addrb_reg <= rtri_mem_addrb_wire; // @[tsqr_fsm.scala 412:28]
    end
    if (rst) begin // @[tsqr_fsm.scala 355:18]
      dmx0_mem_wea_reg <= 16'h0; // @[tsqr_fsm.scala 356:30]
    end else begin
      dmx0_mem_wea_reg <= dmx0_mem_wea; // @[tsqr_fsm.scala 360:30]
    end
    if (rst) begin // @[tsqr_fsm.scala 355:18]
      dmx1_mem_wea_reg <= 16'h0; // @[tsqr_fsm.scala 357:30]
    end else begin
      dmx1_mem_wea_reg <= dmx1_mem_wea; // @[tsqr_fsm.scala 361:30]
    end
    if (rst) begin // @[tsqr_fsm.scala 355:18]
      rtri_mem_wea_reg <= 16'h0; // @[tsqr_fsm.scala 358:30]
    end else begin
      rtri_mem_wea_reg <= rtri_mem_wea; // @[tsqr_fsm.scala 362:30]
    end
    if (rst) begin // @[tsqr_fsm.scala 433:14]
      rtri_mem_wea_update <= 16'hffff; // @[tsqr_fsm.scala 436:29]
    end else if (hh_en & tr_cnt == 16'hec) begin // @[tsqr_fsm.scala 437:55]
      rtri_mem_wea_update <= _rtri_mem_wea_update_T_3; // @[tsqr_fsm.scala 438:29]
    end else begin
      rtri_mem_wea_update <= 16'hffff; // @[tsqr_fsm.scala 442:29]
    end
    if (rst) begin // @[tsqr_fsm.scala 393:14]
      dmx0_mem_addra_reg <= 1'h0; // @[tsqr_fsm.scala 394:28]
    end else begin
      dmx0_mem_addra_reg <= dmx0_mem_addra_wire; // @[tsqr_fsm.scala 407:28]
    end
    if (rst) begin // @[tsqr_fsm.scala 393:14]
      dmx1_mem_addra_reg <= 1'h0; // @[tsqr_fsm.scala 395:28]
    end else begin
      dmx1_mem_addra_reg <= dmx1_mem_addra_wire; // @[tsqr_fsm.scala 408:28]
    end
    if (rst) begin // @[tsqr_fsm.scala 393:14]
      rtri_mem_addra_reg <= 1'h0; // @[tsqr_fsm.scala 396:28]
    end else begin
      rtri_mem_addra_reg <= rtri_mem_addra_wire; // @[tsqr_fsm.scala 409:28]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  hh_en = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  nxt_hh_en = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  cnt = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  nxt_hh_cnt = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  nxt_mx_cnt = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  tr_cy_reg = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  tr_cnt_en = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  tr_cnt = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  tr_cnt_en_2 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  d1_rdy_REG = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  d1_vld_REG = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  d2_vld_REG = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  vk1_vld_REG = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  d3_rdy_REG = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  d3_vld_REG = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  tk_vld_REG = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  yj_sft_REG = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  dmx0_mem_enb_reg = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  dmx1_mem_enb_reg = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  rtri_mem_enb_reg = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  dmx0_mem_ena_reg = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  dmx1_mem_ena_reg = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  rtri_mem_ena_reg = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  dmx0_mem_addrb_reg = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  dmx1_mem_addrb_reg = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  rtri_mem_addrb_reg = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  dmx0_mem_wea_reg = _RAND_26[15:0];
  _RAND_27 = {1{`RANDOM}};
  dmx1_mem_wea_reg = _RAND_27[15:0];
  _RAND_28 = {1{`RANDOM}};
  rtri_mem_wea_reg = _RAND_28[15:0];
  _RAND_29 = {1{`RANDOM}};
  rtri_mem_wea_update = _RAND_29[15:0];
  _RAND_30 = {1{`RANDOM}};
  dmx0_mem_addra_reg = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  dmx1_mem_addra_reg = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  rtri_mem_addra_reg = _RAND_32[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module simple_dual_19(
  input          io_clka,
  input          io_clkb,
  input          io_ena,
  input          io_enb,
  input  [15:0]  io_wea,
  input          io_addra,
  input          io_addrb,
  input  [127:0] io_dina,
  output [127:0] io_doutb
);
`ifdef RANDOMIZE_MEM_INIT
  reg [127:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [127:0] _RAND_1;
  reg [127:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [127:0] ram [0:1]; // @[hh_core.scala 288:26]
  wire  ram_ramtemp_1_MPORT_en; // @[hh_core.scala 288:26]
  wire  ram_ramtemp_1_MPORT_addr; // @[hh_core.scala 288:26]
  wire [127:0] ram_ramtemp_1_MPORT_data; // @[hh_core.scala 288:26]
  wire  ram_ramtemp_0_MPORT_en; // @[hh_core.scala 288:26]
  wire  ram_ramtemp_0_MPORT_addr; // @[hh_core.scala 288:26]
  wire [127:0] ram_ramtemp_0_MPORT_data; // @[hh_core.scala 288:26]
  wire  ram_doutb_MPORT_en; // @[hh_core.scala 288:26]
  wire  ram_doutb_MPORT_addr; // @[hh_core.scala 288:26]
  wire [127:0] ram_doutb_MPORT_data; // @[hh_core.scala 288:26]
  wire [127:0] ram_MPORT_data; // @[hh_core.scala 288:26]
  wire  ram_MPORT_addr; // @[hh_core.scala 288:26]
  wire  ram_MPORT_mask; // @[hh_core.scala 288:26]
  wire  ram_MPORT_en; // @[hh_core.scala 288:26]
  reg [127:0] doutb; // @[hh_core.scala 286:28]
  wire [63:0] _dintemp_1_T_9 = {io_wea[15:8],io_wea[15:8],io_wea[15:8],io_wea[15:8],io_wea[15:8],io_wea[15:8],io_wea[15:
    8],io_wea[15:8]}; // @[Cat.scala 31:58]
  wire [63:0] _dintemp_1_T_10 = io_dina[127:64] & _dintemp_1_T_9; // @[hh_core.scala 295:123]
  wire [63:0] _ramtemp_1_T_10 = ~_dintemp_1_T_9; // @[hh_core.scala 296:133]
  wire [63:0] _ramtemp_1_T_11 = ram_ramtemp_1_MPORT_data[127:64] & _ramtemp_1_T_10; // @[hh_core.scala 296:131]
  wire [63:0] _dintemp_0_T_9 = {io_wea[7:0],io_wea[7:0],io_wea[7:0],io_wea[7:0],io_wea[7:0],io_wea[7:0],io_wea[7:0],
    io_wea[7:0]}; // @[Cat.scala 31:58]
  wire [63:0] _dintemp_0_T_10 = io_dina[63:0] & _dintemp_0_T_9; // @[hh_core.scala 295:123]
  wire [63:0] _ramtemp_0_T_10 = ~_dintemp_0_T_9; // @[hh_core.scala 296:133]
  wire [63:0] _ramtemp_0_T_11 = ram_ramtemp_0_MPORT_data[63:0] & _ramtemp_0_T_10; // @[hh_core.scala 296:131]
  wire [63:0] ramtemp_1 = io_ena ? _ramtemp_1_T_11 : 64'h0; // @[hh_core.scala 291:25 296:48 302:28]
  wire [63:0] ramtemp_0 = io_ena ? _ramtemp_0_T_11 : 64'h0; // @[hh_core.scala 291:25 296:48 302:28]
  wire [127:0] _T = {ramtemp_1,ramtemp_0}; // @[hh_core.scala 298:45]
  wire [63:0] dintemp_1 = io_ena ? _dintemp_1_T_10 : 64'h0; // @[hh_core.scala 291:25 295:48 301:28]
  wire [63:0] dintemp_0 = io_ena ? _dintemp_0_T_10 : 64'h0; // @[hh_core.scala 291:25 295:48 301:28]
  wire [127:0] _T_1 = {dintemp_1,dintemp_0}; // @[hh_core.scala 298:62]
  reg [127:0] doutb_REG; // @[hh_core.scala 307:37]
  assign ram_ramtemp_1_MPORT_en = io_ena;
  assign ram_ramtemp_1_MPORT_addr = io_addra;
  assign ram_ramtemp_1_MPORT_data = ram[ram_ramtemp_1_MPORT_addr]; // @[hh_core.scala 288:26]
  assign ram_ramtemp_0_MPORT_en = io_ena;
  assign ram_ramtemp_0_MPORT_addr = io_addra;
  assign ram_ramtemp_0_MPORT_data = ram[ram_ramtemp_0_MPORT_addr]; // @[hh_core.scala 288:26]
  assign ram_doutb_MPORT_en = io_enb;
  assign ram_doutb_MPORT_addr = io_addrb;
  assign ram_doutb_MPORT_data = ram[ram_doutb_MPORT_addr]; // @[hh_core.scala 288:26]
  assign ram_MPORT_data = _T + _T_1;
  assign ram_MPORT_addr = io_addra;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_ena;
  assign io_doutb = doutb; // @[hh_core.scala 287:22]
  always @(posedge io_clka) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[hh_core.scala 288:26]
    end
    if (io_enb) begin // @[hh_core.scala 306:29]
      doutb <= doutb_REG; // @[hh_core.scala 307:27]
    end
  end
  always @(posedge io_clkb) begin
    doutb_REG <= ram_doutb_MPORT_data; // @[hh_core.scala 307:37]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {4{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram[initvar] = _RAND_0[127:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {4{`RANDOM}};
  doutb = _RAND_1[127:0];
  _RAND_2 = {4{`RANDOM}};
  doutb_REG = _RAND_2[127:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module full_subber_19(
  input  [7:0] io_in_a,
  input  [7:0] io_in_b,
  output [7:0] io_out_s,
  output       io_out_c
);
  wire [8:0] _result_T = io_in_a - io_in_b; // @[BinaryDesigns.scala 74:23]
  wire [9:0] _result_T_2 = _result_T - 9'h0; // @[BinaryDesigns.scala 74:34]
  wire [8:0] result = _result_T_2[8:0]; // @[BinaryDesigns.scala 73:22 74:12]
  assign io_out_s = result[7:0]; // @[BinaryDesigns.scala 75:23]
  assign io_out_c = result[8]; // @[BinaryDesigns.scala 76:23]
endmodule
module full_adder_19(
  input  [23:0] io_in_a,
  input  [23:0] io_in_b,
  output [23:0] io_out_s,
  output        io_out_c
);
  wire [24:0] _result_T = io_in_a + io_in_b; // @[BinaryDesigns.scala 59:23]
  wire [25:0] _result_T_1 = {{1'd0}, _result_T}; // @[BinaryDesigns.scala 59:34]
  wire [24:0] result = _result_T_1[24:0]; // @[BinaryDesigns.scala 58:22 59:12]
  assign io_out_s = result[23:0]; // @[BinaryDesigns.scala 60:23]
  assign io_out_c = result[24]; // @[BinaryDesigns.scala 61:23]
endmodule
module FP_adder_13ccs_19(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_135;
`endif // RANDOMIZE_REG_INIT
  wire [7:0] subber_io_in_a; // @[FloatingPointDesigns.scala 1457:24]
  wire [7:0] subber_io_in_b; // @[FloatingPointDesigns.scala 1457:24]
  wire [7:0] subber_io_out_s; // @[FloatingPointDesigns.scala 1457:24]
  wire  subber_io_out_c; // @[FloatingPointDesigns.scala 1457:24]
  wire [23:0] adder_io_in_a; // @[FloatingPointDesigns.scala 1463:23]
  wire [23:0] adder_io_in_b; // @[FloatingPointDesigns.scala 1463:23]
  wire [23:0] adder_io_out_s; // @[FloatingPointDesigns.scala 1463:23]
  wire  adder_io_out_c; // @[FloatingPointDesigns.scala 1463:23]
  wire [7:0] subber2_io_in_a; // @[FloatingPointDesigns.scala 1524:25]
  wire [7:0] subber2_io_in_b; // @[FloatingPointDesigns.scala 1524:25]
  wire [7:0] subber2_io_out_s; // @[FloatingPointDesigns.scala 1524:25]
  wire  subber2_io_out_c; // @[FloatingPointDesigns.scala 1524:25]
  wire  sign_0 = io_in_a[31]; // @[FloatingPointDesigns.scala 1386:23]
  wire  sign_1 = io_in_b[31]; // @[FloatingPointDesigns.scala 1387:23]
  wire [8:0] _T_2 = 9'h100 - 9'h2; // @[FloatingPointDesigns.scala 1390:64]
  wire [8:0] _GEN_167 = {{1'd0}, io_in_a[30:23]}; // @[FloatingPointDesigns.scala 1390:36]
  wire [7:0] _GEN_0 = io_in_a[30:23] < 8'h1 ? 8'h1 : io_in_a[30:23]; // @[FloatingPointDesigns.scala 1392:46 1393:14 1395:14]
  wire [8:0] _GEN_1 = _GEN_167 > _T_2 ? _T_2 : {{1'd0}, _GEN_0}; // @[FloatingPointDesigns.scala 1390:71 1391:14]
  wire [8:0] _GEN_168 = {{1'd0}, io_in_b[30:23]}; // @[FloatingPointDesigns.scala 1397:36]
  wire [7:0] _GEN_2 = io_in_b[30:23] < 8'h1 ? 8'h1 : io_in_b[30:23]; // @[FloatingPointDesigns.scala 1399:45 1400:14 1402:14]
  wire [8:0] _GEN_3 = _GEN_168 > _T_2 ? _T_2 : {{1'd0}, _GEN_2}; // @[FloatingPointDesigns.scala 1397:71 1398:14]
  wire [22:0] frac_0 = io_in_a[22:0]; // @[FloatingPointDesigns.scala 1407:23]
  wire [22:0] frac_1 = io_in_b[22:0]; // @[FloatingPointDesigns.scala 1408:23]
  wire [23:0] whole_frac_0 = {1'h1,frac_0}; // @[FloatingPointDesigns.scala 1412:26]
  wire [23:0] whole_frac_1 = {1'h1,frac_1}; // @[FloatingPointDesigns.scala 1413:26]
  reg  sign_reg_0_0; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_0_1; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_1_0; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_1_1; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_2_0; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_2_1; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_3_0; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_3_1; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_4_0; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_4_1; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_5_0; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_5_1; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_6_0; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_6_1; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_7_0; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_7_1; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_8_0; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_8_1; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_9_0; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_9_1; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_10_0; // @[FloatingPointDesigns.scala 1415:28]
  reg  sign_reg_10_1; // @[FloatingPointDesigns.scala 1415:28]
  reg [7:0] exp_reg_0_0; // @[FloatingPointDesigns.scala 1416:28]
  reg [7:0] exp_reg_0_1; // @[FloatingPointDesigns.scala 1416:28]
  reg [7:0] exp_reg_1_0; // @[FloatingPointDesigns.scala 1416:28]
  reg [7:0] exp_reg_1_1; // @[FloatingPointDesigns.scala 1416:28]
  reg [7:0] exp_reg_2_0; // @[FloatingPointDesigns.scala 1416:28]
  reg [7:0] exp_reg_2_1; // @[FloatingPointDesigns.scala 1416:28]
  reg [22:0] frac_reg_0_0; // @[FloatingPointDesigns.scala 1417:28]
  reg [22:0] frac_reg_0_1; // @[FloatingPointDesigns.scala 1417:28]
  reg [22:0] frac_reg_1_0; // @[FloatingPointDesigns.scala 1417:28]
  reg [22:0] frac_reg_1_1; // @[FloatingPointDesigns.scala 1417:28]
  reg [22:0] frac_reg_2_0; // @[FloatingPointDesigns.scala 1417:28]
  reg [22:0] frac_reg_2_1; // @[FloatingPointDesigns.scala 1417:28]
  reg [23:0] wfrac_reg_0_0; // @[FloatingPointDesigns.scala 1418:28]
  reg [23:0] wfrac_reg_0_1; // @[FloatingPointDesigns.scala 1418:28]
  reg [23:0] wfrac_reg_1_0; // @[FloatingPointDesigns.scala 1418:28]
  reg [23:0] wfrac_reg_1_1; // @[FloatingPointDesigns.scala 1418:28]
  reg [23:0] wfrac_reg_2_0; // @[FloatingPointDesigns.scala 1418:28]
  reg [23:0] wfrac_reg_2_1; // @[FloatingPointDesigns.scala 1418:28]
  reg [7:0] subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1420:35]
  reg [7:0] subber_out_s_reg_1; // @[FloatingPointDesigns.scala 1420:35]
  reg  subber_out_c_reg_0; // @[FloatingPointDesigns.scala 1421:35]
  reg  subber_out_c_reg_1; // @[FloatingPointDesigns.scala 1421:35]
  reg [23:0] wire_temp_add_in_reg_0_0; // @[FloatingPointDesigns.scala 1423:39]
  reg [23:0] wire_temp_add_in_reg_0_1; // @[FloatingPointDesigns.scala 1423:39]
  reg [23:0] wire_temp_add_in_reg_1_0; // @[FloatingPointDesigns.scala 1423:39]
  reg [23:0] wire_temp_add_in_reg_1_1; // @[FloatingPointDesigns.scala 1423:39]
  reg  ref_s_reg_0; // @[FloatingPointDesigns.scala 1425:31]
  reg  ref_s_reg_1; // @[FloatingPointDesigns.scala 1425:31]
  reg  ref_s_reg_2; // @[FloatingPointDesigns.scala 1425:31]
  reg  ref_s_reg_3; // @[FloatingPointDesigns.scala 1425:31]
  reg  ref_s_reg_4; // @[FloatingPointDesigns.scala 1425:31]
  reg  ref_s_reg_5; // @[FloatingPointDesigns.scala 1425:31]
  reg  ref_s_reg_6; // @[FloatingPointDesigns.scala 1425:31]
  reg  ref_s_reg_7; // @[FloatingPointDesigns.scala 1425:31]
  reg [22:0] ref_frac_reg_0; // @[FloatingPointDesigns.scala 1426:31]
  reg [22:0] ref_frac_reg_1; // @[FloatingPointDesigns.scala 1426:31]
  reg [22:0] ref_frac_reg_2; // @[FloatingPointDesigns.scala 1426:31]
  reg [22:0] ref_frac_reg_3; // @[FloatingPointDesigns.scala 1426:31]
  reg [22:0] ref_frac_reg_4; // @[FloatingPointDesigns.scala 1426:31]
  reg [22:0] ref_frac_reg_5; // @[FloatingPointDesigns.scala 1426:31]
  reg [22:0] ref_frac_reg_6; // @[FloatingPointDesigns.scala 1426:31]
  reg [22:0] ref_frac_reg_7; // @[FloatingPointDesigns.scala 1426:31]
  reg [7:0] ref_exp_reg_0; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] ref_exp_reg_1; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] ref_exp_reg_2; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] ref_exp_reg_3; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] ref_exp_reg_4; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] ref_exp_reg_5; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] ref_exp_reg_6; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] ref_exp_reg_7; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] sub_exp_reg_0; // @[FloatingPointDesigns.scala 1428:31]
  reg [7:0] sub_exp_reg_1; // @[FloatingPointDesigns.scala 1428:31]
  reg [7:0] sub_exp_reg_2; // @[FloatingPointDesigns.scala 1428:31]
  reg [7:0] sub_exp_reg_3; // @[FloatingPointDesigns.scala 1428:31]
  reg [7:0] sub_exp_reg_4; // @[FloatingPointDesigns.scala 1428:31]
  reg [7:0] sub_exp_reg_5; // @[FloatingPointDesigns.scala 1428:31]
  reg [7:0] sub_exp_reg_6; // @[FloatingPointDesigns.scala 1428:31]
  reg [7:0] sub_exp_reg_7; // @[FloatingPointDesigns.scala 1428:31]
  reg [23:0] adder_io_out_s_reg_0; // @[FloatingPointDesigns.scala 1430:37]
  reg [23:0] adder_io_out_s_reg_1; // @[FloatingPointDesigns.scala 1430:37]
  reg [23:0] adder_io_out_s_reg_2; // @[FloatingPointDesigns.scala 1430:37]
  reg  adder_io_out_c_reg_0; // @[FloatingPointDesigns.scala 1431:37]
  reg  new_s_reg_0; // @[FloatingPointDesigns.scala 1433:35]
  reg  new_s_reg_1; // @[FloatingPointDesigns.scala 1433:35]
  reg  new_s_reg_2; // @[FloatingPointDesigns.scala 1433:35]
  reg  new_s_reg_3; // @[FloatingPointDesigns.scala 1433:35]
  reg  new_s_reg_4; // @[FloatingPointDesigns.scala 1433:35]
  reg  new_s_reg_5; // @[FloatingPointDesigns.scala 1433:35]
  reg [22:0] new_out_frac_reg_0; // @[FloatingPointDesigns.scala 1434:35]
  reg [7:0] new_out_exp_reg_0; // @[FloatingPointDesigns.scala 1435:35]
  reg  E_reg_0; // @[FloatingPointDesigns.scala 1436:24]
  reg  E_reg_1; // @[FloatingPointDesigns.scala 1436:24]
  reg  E_reg_2; // @[FloatingPointDesigns.scala 1436:24]
  reg  E_reg_3; // @[FloatingPointDesigns.scala 1436:24]
  reg  E_reg_4; // @[FloatingPointDesigns.scala 1436:24]
  reg  D_reg_0; // @[FloatingPointDesigns.scala 1437:24]
  reg  D_reg_1; // @[FloatingPointDesigns.scala 1437:24]
  reg  D_reg_2; // @[FloatingPointDesigns.scala 1437:24]
  reg  D_reg_3; // @[FloatingPointDesigns.scala 1437:24]
  reg  D_reg_4; // @[FloatingPointDesigns.scala 1437:24]
  reg [23:0] adder_result_reg_0; // @[FloatingPointDesigns.scala 1439:35]
  reg [23:0] adder_result_reg_1; // @[FloatingPointDesigns.scala 1439:35]
  reg [23:0] adder_result_reg_2; // @[FloatingPointDesigns.scala 1439:35]
  reg [5:0] leadingOne_reg_0; // @[FloatingPointDesigns.scala 1441:33]
  reg [5:0] leadingOne_reg_1; // @[FloatingPointDesigns.scala 1441:33]
  reg [31:0] io_in_a_reg_0; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_a_reg_1; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_a_reg_2; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_a_reg_3; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_a_reg_4; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_a_reg_5; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_a_reg_6; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_a_reg_7; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_a_reg_8; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_a_reg_9; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_a_reg_10; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_b_reg_0; // @[FloatingPointDesigns.scala 1444:30]
  reg [31:0] io_in_b_reg_1; // @[FloatingPointDesigns.scala 1444:30]
  reg [31:0] io_in_b_reg_2; // @[FloatingPointDesigns.scala 1444:30]
  reg [31:0] io_in_b_reg_3; // @[FloatingPointDesigns.scala 1444:30]
  reg [31:0] io_in_b_reg_4; // @[FloatingPointDesigns.scala 1444:30]
  reg [31:0] io_in_b_reg_5; // @[FloatingPointDesigns.scala 1444:30]
  reg [31:0] io_in_b_reg_6; // @[FloatingPointDesigns.scala 1444:30]
  reg [31:0] io_in_b_reg_7; // @[FloatingPointDesigns.scala 1444:30]
  reg [31:0] io_in_b_reg_8; // @[FloatingPointDesigns.scala 1444:30]
  reg [31:0] io_in_b_reg_9; // @[FloatingPointDesigns.scala 1444:30]
  reg [31:0] io_in_b_reg_10; // @[FloatingPointDesigns.scala 1444:30]
  reg [7:0] subber2_out_s_reg_0; // @[FloatingPointDesigns.scala 1446:36]
  reg  subber2_out_c_reg_0; // @[FloatingPointDesigns.scala 1447:36]
  reg [7:0] cmpl_subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1468:40]
  wire [7:0] _cmpl_subber_out_s_reg_0_T = ~subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1470:41]
  wire [7:0] _cmpl_subber_out_s_reg_0_T_2 = 8'h1 + _cmpl_subber_out_s_reg_0_T; // @[FloatingPointDesigns.scala 1470:39]
  wire [23:0] _wire_temp_add_in_0_T = wfrac_reg_2_0 >> cmpl_subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1478:46]
  wire [23:0] _wire_temp_add_in_1_T = wfrac_reg_2_1 >> subber_out_s_reg_1; // @[FloatingPointDesigns.scala 1486:46]
  reg [23:0] cmpl_wire_temp_add_in_reg_0_0; // @[FloatingPointDesigns.scala 1489:44]
  reg [23:0] cmpl_wire_temp_add_in_reg_0_1; // @[FloatingPointDesigns.scala 1489:44]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_0_T = ~wire_temp_add_in_reg_0_0; // @[FloatingPointDesigns.scala 1491:48]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_0_T_2 = 24'h1 + _cmpl_wire_temp_add_in_reg_0_0_T; // @[FloatingPointDesigns.scala 1491:46]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_1_T = ~wire_temp_add_in_reg_0_1; // @[FloatingPointDesigns.scala 1492:48]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_1_T_2 = 24'h1 + _cmpl_wire_temp_add_in_reg_0_1_T; // @[FloatingPointDesigns.scala 1492:46]
  wire [1:0] _adder_io_in_a_T = {sign_reg_4_1,sign_reg_4_0}; // @[FloatingPointDesigns.scala 1495:38]
  wire  _new_s_T = ~adder_io_out_c_reg_0; // @[FloatingPointDesigns.scala 1502:15]
  wire  new_s = ~adder_io_out_c_reg_0 & (sign_reg_5_0 | sign_reg_5_1) | sign_reg_5_0 & sign_reg_5_1; // @[FloatingPointDesigns.scala 1502:75]
  wire  _D_T_1 = sign_reg_5_0 ^ sign_reg_5_1; // @[FloatingPointDesigns.scala 1509:53]
  wire  D = _new_s_T | sign_reg_5_0 ^ sign_reg_5_1; // @[FloatingPointDesigns.scala 1509:35]
  wire  E = _new_s_T & ~adder_io_out_s_reg_0[23] | _new_s_T & ~_D_T_1 | adder_io_out_c_reg_0 & adder_io_out_s_reg_0[23]
     & _D_T_1; // @[FloatingPointDesigns.scala 1511:134]
  reg [23:0] cmpl_adder_io_out_s_reg_0; // @[FloatingPointDesigns.scala 1513:42]
  wire [23:0] _cmpl_adder_io_out_s_reg_0_T = ~adder_io_out_s_reg_1; // @[FloatingPointDesigns.scala 1516:43]
  wire [23:0] _cmpl_adder_io_out_s_reg_0_T_2 = 24'h1 + _cmpl_adder_io_out_s_reg_0_T; // @[FloatingPointDesigns.scala 1516:41]
  wire [1:0] _adder_result_T = {sign_reg_7_1,sign_reg_7_0}; // @[FloatingPointDesigns.scala 1520:53]
  wire [1:0] _leadingOne_T_25 = adder_result_reg_0[2] ? 2'h2 : {{1'd0}, adder_result_reg_0[1]}; // @[FloatingPointDesigns.scala 1523:70]
  wire [1:0] _leadingOne_T_26 = adder_result_reg_0[3] ? 2'h3 : _leadingOne_T_25; // @[FloatingPointDesigns.scala 1523:70]
  wire [2:0] _leadingOne_T_27 = adder_result_reg_0[4] ? 3'h4 : {{1'd0}, _leadingOne_T_26}; // @[FloatingPointDesigns.scala 1523:70]
  wire [2:0] _leadingOne_T_28 = adder_result_reg_0[5] ? 3'h5 : _leadingOne_T_27; // @[FloatingPointDesigns.scala 1523:70]
  wire [2:0] _leadingOne_T_29 = adder_result_reg_0[6] ? 3'h6 : _leadingOne_T_28; // @[FloatingPointDesigns.scala 1523:70]
  wire [2:0] _leadingOne_T_30 = adder_result_reg_0[7] ? 3'h7 : _leadingOne_T_29; // @[FloatingPointDesigns.scala 1523:70]
  wire [3:0] _leadingOne_T_31 = adder_result_reg_0[8] ? 4'h8 : {{1'd0}, _leadingOne_T_30}; // @[FloatingPointDesigns.scala 1523:70]
  wire [3:0] _leadingOne_T_32 = adder_result_reg_0[9] ? 4'h9 : _leadingOne_T_31; // @[FloatingPointDesigns.scala 1523:70]
  wire [3:0] _leadingOne_T_33 = adder_result_reg_0[10] ? 4'ha : _leadingOne_T_32; // @[FloatingPointDesigns.scala 1523:70]
  wire [3:0] _leadingOne_T_34 = adder_result_reg_0[11] ? 4'hb : _leadingOne_T_33; // @[FloatingPointDesigns.scala 1523:70]
  wire [3:0] _leadingOne_T_35 = adder_result_reg_0[12] ? 4'hc : _leadingOne_T_34; // @[FloatingPointDesigns.scala 1523:70]
  wire [3:0] _leadingOne_T_36 = adder_result_reg_0[13] ? 4'hd : _leadingOne_T_35; // @[FloatingPointDesigns.scala 1523:70]
  wire [3:0] _leadingOne_T_37 = adder_result_reg_0[14] ? 4'he : _leadingOne_T_36; // @[FloatingPointDesigns.scala 1523:70]
  wire [3:0] _leadingOne_T_38 = adder_result_reg_0[15] ? 4'hf : _leadingOne_T_37; // @[FloatingPointDesigns.scala 1523:70]
  wire [4:0] _leadingOne_T_39 = adder_result_reg_0[16] ? 5'h10 : {{1'd0}, _leadingOne_T_38}; // @[FloatingPointDesigns.scala 1523:70]
  wire [4:0] _leadingOne_T_40 = adder_result_reg_0[17] ? 5'h11 : _leadingOne_T_39; // @[FloatingPointDesigns.scala 1523:70]
  wire [4:0] _leadingOne_T_41 = adder_result_reg_0[18] ? 5'h12 : _leadingOne_T_40; // @[FloatingPointDesigns.scala 1523:70]
  wire [4:0] _leadingOne_T_42 = adder_result_reg_0[19] ? 5'h13 : _leadingOne_T_41; // @[FloatingPointDesigns.scala 1523:70]
  wire [4:0] _leadingOne_T_43 = adder_result_reg_0[20] ? 5'h14 : _leadingOne_T_42; // @[FloatingPointDesigns.scala 1523:70]
  wire [4:0] _leadingOne_T_44 = adder_result_reg_0[21] ? 5'h15 : _leadingOne_T_43; // @[FloatingPointDesigns.scala 1523:70]
  wire [4:0] _leadingOne_T_45 = adder_result_reg_0[22] ? 5'h16 : _leadingOne_T_44; // @[FloatingPointDesigns.scala 1523:70]
  wire [4:0] _leadingOne_T_46 = adder_result_reg_0[23] ? 5'h17 : _leadingOne_T_45; // @[FloatingPointDesigns.scala 1523:70]
  wire [5:0] leadingOne = _leadingOne_T_46 + 5'h1; // @[FloatingPointDesigns.scala 1523:77]
  wire [5:0] _subber2_io_in_b_T_1 = 6'h18 - leadingOne_reg_0; // @[FloatingPointDesigns.scala 1526:42]
  wire [7:0] exp_0 = _GEN_1[7:0]; // @[FloatingPointDesigns.scala 1388:19]
  wire [7:0] exp_1 = _GEN_3[7:0]; // @[FloatingPointDesigns.scala 1388:19]
  reg [31:0] reg_out_s; // @[FloatingPointDesigns.scala 1597:28]
  wire [8:0] _GEN_169 = {{1'd0}, ref_exp_reg_7}; // @[FloatingPointDesigns.scala 1614:29]
  wire [23:0] _new_out_frac_reg_0_T_2 = 24'h800000 - 24'h1; // @[FloatingPointDesigns.scala 1616:60]
  wire [7:0] _new_out_exp_reg_0_T_3 = ref_exp_reg_7 + 8'h1; // @[FloatingPointDesigns.scala 1618:48]
  wire [8:0] _GEN_142 = _GEN_169 == _T_2 ? _T_2 : {{1'd0}, _new_out_exp_reg_0_T_3}; // @[FloatingPointDesigns.scala 1614:66 1615:30 1618:30]
  wire [23:0] _GEN_143 = _GEN_169 == _T_2 ? _new_out_frac_reg_0_T_2 : {{1'd0}, adder_result_reg_2[23:1]}; // @[FloatingPointDesigns.scala 1614:66 1616:31 1619:31]
  wire [5:0] _new_out_frac_reg_0_T_6 = 6'h18 - leadingOne_reg_1; // @[FloatingPointDesigns.scala 1632:94]
  wire [85:0] _GEN_5 = {{63'd0}, adder_result_reg_2[22:0]}; // @[FloatingPointDesigns.scala 1632:73]
  wire [85:0] _new_out_frac_reg_0_T_7 = _GEN_5 << _new_out_frac_reg_0_T_6; // @[FloatingPointDesigns.scala 1632:73]
  wire [7:0] _GEN_144 = subber2_out_c_reg_0 ? 8'h1 : subber2_out_s_reg_0; // @[FloatingPointDesigns.scala 1627:46 1628:32 1631:32]
  wire [85:0] _GEN_145 = subber2_out_c_reg_0 ? 86'h0 : _new_out_frac_reg_0_T_7; // @[FloatingPointDesigns.scala 1627:46 1629:33 1632:33]
  wire [7:0] _GEN_146 = leadingOne_reg_1 == 6'h1 & adder_result_reg_2 == 24'h0 & ((sign_reg_10_0 ^ sign_reg_10_1) &
    io_in_a_reg_10[30:0] == io_in_b_reg_10[30:0]) ? 8'h0 : _GEN_144; // @[FloatingPointDesigns.scala 1623:184 1624:30]
  wire [85:0] _GEN_147 = leadingOne_reg_1 == 6'h1 & adder_result_reg_2 == 24'h0 & ((sign_reg_10_0 ^ sign_reg_10_1) &
    io_in_a_reg_10[30:0] == io_in_b_reg_10[30:0]) ? 86'h0 : _GEN_145; // @[FloatingPointDesigns.scala 1623:184 1625:31]
  wire  _GEN_148 = D_reg_4 ? new_s_reg_4 : new_s_reg_5; // @[FloatingPointDesigns.scala 1621:36 1622:22 1433:35]
  wire [7:0] _GEN_149 = D_reg_4 ? _GEN_146 : new_out_exp_reg_0; // @[FloatingPointDesigns.scala 1435:35 1621:36]
  wire [85:0] _GEN_150 = D_reg_4 ? _GEN_147 : {{63'd0}, new_out_frac_reg_0}; // @[FloatingPointDesigns.scala 1434:35 1621:36]
  wire  _GEN_151 = ~D_reg_4 ? new_s_reg_4 : _GEN_148; // @[FloatingPointDesigns.scala 1612:36 1613:22]
  wire [8:0] _GEN_152 = ~D_reg_4 ? _GEN_142 : {{1'd0}, _GEN_149}; // @[FloatingPointDesigns.scala 1612:36]
  wire [85:0] _GEN_153 = ~D_reg_4 ? {{62'd0}, _GEN_143} : _GEN_150; // @[FloatingPointDesigns.scala 1612:36]
  wire  _GEN_154 = E_reg_4 ? new_s_reg_4 : _GEN_151; // @[FloatingPointDesigns.scala 1608:36 1609:22]
  wire [8:0] _GEN_155 = E_reg_4 ? {{1'd0}, ref_exp_reg_7} : _GEN_152; // @[FloatingPointDesigns.scala 1608:36 1610:28]
  wire [85:0] _GEN_156 = E_reg_4 ? {{63'd0}, adder_result_reg_2[22:0]} : _GEN_153; // @[FloatingPointDesigns.scala 1608:36 1611:29]
  wire [85:0] _GEN_158 = sub_exp_reg_7 >= 8'h17 ? {{63'd0}, ref_frac_reg_7} : _GEN_156; // @[FloatingPointDesigns.scala 1604:48 1606:29]
  wire [8:0] _GEN_159 = sub_exp_reg_7 >= 8'h17 ? {{1'd0}, ref_exp_reg_7} : _GEN_155; // @[FloatingPointDesigns.scala 1604:48 1607:28]
  wire [8:0] _GEN_161 = io_in_a_reg_10[30:0] == 31'h0 & io_in_b_reg_10[30:0] == 31'h0 ? 9'h0 : _GEN_159; // @[FloatingPointDesigns.scala 1600:86 1602:28]
  wire [85:0] _GEN_162 = io_in_a_reg_10[30:0] == 31'h0 & io_in_b_reg_10[30:0] == 31'h0 ? 86'h0 : _GEN_158; // @[FloatingPointDesigns.scala 1600:86 1603:29]
  wire [31:0] _reg_out_s_T_1 = {new_s_reg_5,new_out_exp_reg_0,new_out_frac_reg_0}; // @[FloatingPointDesigns.scala 1636:55]
  wire [8:0] _GEN_164 = io_in_en ? _GEN_161 : {{1'd0}, new_out_exp_reg_0}; // @[FloatingPointDesigns.scala 1599:20 1435:35]
  wire [85:0] _GEN_165 = io_in_en ? _GEN_162 : {{63'd0}, new_out_frac_reg_0}; // @[FloatingPointDesigns.scala 1599:20 1434:35]
  wire [85:0] _GEN_170 = reset ? 86'h0 : _GEN_165; // @[FloatingPointDesigns.scala 1434:{35,35}]
  wire [8:0] _GEN_171 = reset ? 9'h0 : _GEN_164; // @[FloatingPointDesigns.scala 1435:{35,35}]
  full_subber_19 subber ( // @[FloatingPointDesigns.scala 1457:24]
    .io_in_a(subber_io_in_a),
    .io_in_b(subber_io_in_b),
    .io_out_s(subber_io_out_s),
    .io_out_c(subber_io_out_c)
  );
  full_adder_19 adder ( // @[FloatingPointDesigns.scala 1463:23]
    .io_in_a(adder_io_in_a),
    .io_in_b(adder_io_in_b),
    .io_out_s(adder_io_out_s),
    .io_out_c(adder_io_out_c)
  );
  full_subber_19 subber2 ( // @[FloatingPointDesigns.scala 1524:25]
    .io_in_a(subber2_io_in_a),
    .io_in_b(subber2_io_in_b),
    .io_out_s(subber2_io_out_s),
    .io_out_c(subber2_io_out_c)
  );
  assign io_out_s = reg_out_s; // @[FloatingPointDesigns.scala 1598:14]
  assign subber_io_in_a = exp_reg_0_0; // @[FloatingPointDesigns.scala 1458:20]
  assign subber_io_in_b = exp_reg_0_1; // @[FloatingPointDesigns.scala 1459:20]
  assign adder_io_in_a = _adder_io_in_a_T == 2'h1 ? cmpl_wire_temp_add_in_reg_0_0 : wire_temp_add_in_reg_1_0; // @[FloatingPointDesigns.scala 1495:25]
  assign adder_io_in_b = _adder_io_in_a_T == 2'h2 ? cmpl_wire_temp_add_in_reg_0_1 : wire_temp_add_in_reg_1_1; // @[FloatingPointDesigns.scala 1496:25]
  assign subber2_io_in_a = ref_exp_reg_6; // @[FloatingPointDesigns.scala 1525:21]
  assign subber2_io_in_b = {{2'd0}, _subber2_io_in_b_T_1}; // @[FloatingPointDesigns.scala 1526:21]
  always @(posedge clock) begin
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_0_0 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_0_0 <= sign_0; // @[FloatingPointDesigns.scala 1534:19]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_0_1 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_0_1 <= sign_1; // @[FloatingPointDesigns.scala 1534:19]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_1_0 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_1_0 <= sign_reg_0_0; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_1_1 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_1_1 <= sign_reg_0_1; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_2_0 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_2_0 <= sign_reg_1_0; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_2_1 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_2_1 <= sign_reg_1_1; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_3_0 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_3_0 <= sign_reg_2_0; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_3_1 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_3_1 <= sign_reg_2_1; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_4_0 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_4_0 <= sign_reg_3_0; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_4_1 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_4_1 <= sign_reg_3_1; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_5_0 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_5_0 <= sign_reg_4_0; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_5_1 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_5_1 <= sign_reg_4_1; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_6_0 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_6_0 <= sign_reg_5_0; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_6_1 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_6_1 <= sign_reg_5_1; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_7_0 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_7_0 <= sign_reg_6_0; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_7_1 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_7_1 <= sign_reg_6_1; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_8_0 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_8_0 <= sign_reg_7_0; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_8_1 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_8_1 <= sign_reg_7_1; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_9_0 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_9_0 <= sign_reg_8_0; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_9_1 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_9_1 <= sign_reg_8_1; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_10_0 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_10_0 <= sign_reg_9_0; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      sign_reg_10_1 <= 1'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sign_reg_10_1 <= sign_reg_9_1; // @[FloatingPointDesigns.scala 1567:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1416:28]
      exp_reg_0_0 <= 8'h0; // @[FloatingPointDesigns.scala 1416:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      exp_reg_0_0 <= exp_0; // @[FloatingPointDesigns.scala 1535:18]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1416:28]
      exp_reg_0_1 <= 8'h0; // @[FloatingPointDesigns.scala 1416:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      exp_reg_0_1 <= exp_1; // @[FloatingPointDesigns.scala 1535:18]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1416:28]
      exp_reg_1_0 <= 8'h0; // @[FloatingPointDesigns.scala 1416:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      exp_reg_1_0 <= exp_reg_0_0; // @[FloatingPointDesigns.scala 1585:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1416:28]
      exp_reg_1_1 <= 8'h0; // @[FloatingPointDesigns.scala 1416:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      exp_reg_1_1 <= exp_reg_0_1; // @[FloatingPointDesigns.scala 1585:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1416:28]
      exp_reg_2_0 <= 8'h0; // @[FloatingPointDesigns.scala 1416:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      exp_reg_2_0 <= exp_reg_1_0; // @[FloatingPointDesigns.scala 1585:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1416:28]
      exp_reg_2_1 <= 8'h0; // @[FloatingPointDesigns.scala 1416:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      exp_reg_2_1 <= exp_reg_1_1; // @[FloatingPointDesigns.scala 1585:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1417:28]
      frac_reg_0_0 <= 23'h0; // @[FloatingPointDesigns.scala 1417:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      frac_reg_0_0 <= frac_0; // @[FloatingPointDesigns.scala 1536:19]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1417:28]
      frac_reg_0_1 <= 23'h0; // @[FloatingPointDesigns.scala 1417:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      frac_reg_0_1 <= frac_1; // @[FloatingPointDesigns.scala 1536:19]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1417:28]
      frac_reg_1_0 <= 23'h0; // @[FloatingPointDesigns.scala 1417:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      frac_reg_1_0 <= frac_reg_0_0; // @[FloatingPointDesigns.scala 1586:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1417:28]
      frac_reg_1_1 <= 23'h0; // @[FloatingPointDesigns.scala 1417:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      frac_reg_1_1 <= frac_reg_0_1; // @[FloatingPointDesigns.scala 1586:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1417:28]
      frac_reg_2_0 <= 23'h0; // @[FloatingPointDesigns.scala 1417:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      frac_reg_2_0 <= frac_reg_1_0; // @[FloatingPointDesigns.scala 1586:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1417:28]
      frac_reg_2_1 <= 23'h0; // @[FloatingPointDesigns.scala 1417:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      frac_reg_2_1 <= frac_reg_1_1; // @[FloatingPointDesigns.scala 1586:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1418:28]
      wfrac_reg_0_0 <= 24'h0; // @[FloatingPointDesigns.scala 1418:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      wfrac_reg_0_0 <= whole_frac_0; // @[FloatingPointDesigns.scala 1537:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1418:28]
      wfrac_reg_0_1 <= 24'h0; // @[FloatingPointDesigns.scala 1418:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      wfrac_reg_0_1 <= whole_frac_1; // @[FloatingPointDesigns.scala 1537:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1418:28]
      wfrac_reg_1_0 <= 24'h0; // @[FloatingPointDesigns.scala 1418:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      wfrac_reg_1_0 <= wfrac_reg_0_0; // @[FloatingPointDesigns.scala 1587:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1418:28]
      wfrac_reg_1_1 <= 24'h0; // @[FloatingPointDesigns.scala 1418:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      wfrac_reg_1_1 <= wfrac_reg_0_1; // @[FloatingPointDesigns.scala 1587:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1418:28]
      wfrac_reg_2_0 <= 24'h0; // @[FloatingPointDesigns.scala 1418:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      wfrac_reg_2_0 <= wfrac_reg_1_0; // @[FloatingPointDesigns.scala 1587:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1418:28]
      wfrac_reg_2_1 <= 24'h0; // @[FloatingPointDesigns.scala 1418:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      wfrac_reg_2_1 <= wfrac_reg_1_1; // @[FloatingPointDesigns.scala 1587:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1420:35]
      subber_out_s_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1420:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      subber_out_s_reg_0 <= subber_io_out_s; // @[FloatingPointDesigns.scala 1539:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1420:35]
      subber_out_s_reg_1 <= 8'h0; // @[FloatingPointDesigns.scala 1420:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      subber_out_s_reg_1 <= subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1590:31]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1421:35]
      subber_out_c_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1421:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      subber_out_c_reg_0 <= subber_io_out_c; // @[FloatingPointDesigns.scala 1540:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1421:35]
      subber_out_c_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1421:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      subber_out_c_reg_1 <= subber_out_c_reg_0; // @[FloatingPointDesigns.scala 1591:31]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1423:39]
      wire_temp_add_in_reg_0_0 <= 24'h0; // @[FloatingPointDesigns.scala 1423:39]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      if (subber_out_c_reg_1) begin // @[FloatingPointDesigns.scala 1473:39]
        wire_temp_add_in_reg_0_0 <= _wire_temp_add_in_0_T; // @[FloatingPointDesigns.scala 1478:27]
      end else begin
        wire_temp_add_in_reg_0_0 <= wfrac_reg_2_0; // @[FloatingPointDesigns.scala 1485:27]
      end
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1423:39]
      wire_temp_add_in_reg_0_1 <= 24'h0; // @[FloatingPointDesigns.scala 1423:39]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      if (subber_out_c_reg_1) begin // @[FloatingPointDesigns.scala 1473:39]
        wire_temp_add_in_reg_0_1 <= wfrac_reg_2_1; // @[FloatingPointDesigns.scala 1479:27]
      end else begin
        wire_temp_add_in_reg_0_1 <= _wire_temp_add_in_1_T; // @[FloatingPointDesigns.scala 1486:27]
      end
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1423:39]
      wire_temp_add_in_reg_1_0 <= 24'h0; // @[FloatingPointDesigns.scala 1423:39]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      wire_temp_add_in_reg_1_0 <= wire_temp_add_in_reg_0_0; // @[FloatingPointDesigns.scala 1593:35]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1423:39]
      wire_temp_add_in_reg_1_1 <= 24'h0; // @[FloatingPointDesigns.scala 1423:39]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      wire_temp_add_in_reg_1_1 <= wire_temp_add_in_reg_0_1; // @[FloatingPointDesigns.scala 1593:35]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_s_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      if (subber_out_c_reg_1) begin // @[FloatingPointDesigns.scala 1473:39]
        ref_s_reg_0 <= sign_reg_2_1; // @[FloatingPointDesigns.scala 1476:13]
      end else begin
        ref_s_reg_0 <= sign_reg_2_0; // @[FloatingPointDesigns.scala 1483:13]
      end
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_s_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_s_reg_1 <= ref_s_reg_0; // @[FloatingPointDesigns.scala 1572:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_s_reg_2 <= 1'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_s_reg_2 <= ref_s_reg_1; // @[FloatingPointDesigns.scala 1572:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_s_reg_3 <= 1'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_s_reg_3 <= ref_s_reg_2; // @[FloatingPointDesigns.scala 1572:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_s_reg_4 <= 1'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_s_reg_4 <= ref_s_reg_3; // @[FloatingPointDesigns.scala 1572:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_s_reg_5 <= 1'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_s_reg_5 <= ref_s_reg_4; // @[FloatingPointDesigns.scala 1572:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_s_reg_6 <= 1'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_s_reg_6 <= ref_s_reg_5; // @[FloatingPointDesigns.scala 1572:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_s_reg_7 <= 1'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_s_reg_7 <= ref_s_reg_6; // @[FloatingPointDesigns.scala 1572:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_frac_reg_0 <= 23'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      if (subber_out_c_reg_1) begin // @[FloatingPointDesigns.scala 1473:39]
        ref_frac_reg_0 <= frac_reg_2_1; // @[FloatingPointDesigns.scala 1477:16]
      end else begin
        ref_frac_reg_0 <= frac_reg_2_0; // @[FloatingPointDesigns.scala 1484:16]
      end
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_frac_reg_1 <= 23'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_frac_reg_1 <= ref_frac_reg_0; // @[FloatingPointDesigns.scala 1573:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_frac_reg_2 <= 23'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_frac_reg_2 <= ref_frac_reg_1; // @[FloatingPointDesigns.scala 1573:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_frac_reg_3 <= 23'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_frac_reg_3 <= ref_frac_reg_2; // @[FloatingPointDesigns.scala 1573:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_frac_reg_4 <= 23'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_frac_reg_4 <= ref_frac_reg_3; // @[FloatingPointDesigns.scala 1573:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_frac_reg_5 <= 23'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_frac_reg_5 <= ref_frac_reg_4; // @[FloatingPointDesigns.scala 1573:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_frac_reg_6 <= 23'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_frac_reg_6 <= ref_frac_reg_5; // @[FloatingPointDesigns.scala 1573:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_frac_reg_7 <= 23'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_frac_reg_7 <= ref_frac_reg_6; // @[FloatingPointDesigns.scala 1573:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      ref_exp_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      if (subber_out_c_reg_1) begin // @[FloatingPointDesigns.scala 1473:39]
        ref_exp_reg_0 <= exp_reg_2_1; // @[FloatingPointDesigns.scala 1474:15]
      end else begin
        ref_exp_reg_0 <= exp_reg_2_0; // @[FloatingPointDesigns.scala 1481:15]
      end
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      ref_exp_reg_1 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_exp_reg_1 <= ref_exp_reg_0; // @[FloatingPointDesigns.scala 1574:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      ref_exp_reg_2 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_exp_reg_2 <= ref_exp_reg_1; // @[FloatingPointDesigns.scala 1574:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      ref_exp_reg_3 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_exp_reg_3 <= ref_exp_reg_2; // @[FloatingPointDesigns.scala 1574:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      ref_exp_reg_4 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_exp_reg_4 <= ref_exp_reg_3; // @[FloatingPointDesigns.scala 1574:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      ref_exp_reg_5 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_exp_reg_5 <= ref_exp_reg_4; // @[FloatingPointDesigns.scala 1574:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      ref_exp_reg_6 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_exp_reg_6 <= ref_exp_reg_5; // @[FloatingPointDesigns.scala 1574:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      ref_exp_reg_7 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      ref_exp_reg_7 <= ref_exp_reg_6; // @[FloatingPointDesigns.scala 1574:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1428:31]
      sub_exp_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1428:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      if (subber_out_c_reg_1) begin // @[FloatingPointDesigns.scala 1473:39]
        sub_exp_reg_0 <= cmpl_subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1475:15]
      end else begin
        sub_exp_reg_0 <= subber_out_s_reg_1; // @[FloatingPointDesigns.scala 1482:15]
      end
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1428:31]
      sub_exp_reg_1 <= 8'h0; // @[FloatingPointDesigns.scala 1428:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sub_exp_reg_1 <= sub_exp_reg_0; // @[FloatingPointDesigns.scala 1575:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1428:31]
      sub_exp_reg_2 <= 8'h0; // @[FloatingPointDesigns.scala 1428:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sub_exp_reg_2 <= sub_exp_reg_1; // @[FloatingPointDesigns.scala 1575:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1428:31]
      sub_exp_reg_3 <= 8'h0; // @[FloatingPointDesigns.scala 1428:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sub_exp_reg_3 <= sub_exp_reg_2; // @[FloatingPointDesigns.scala 1575:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1428:31]
      sub_exp_reg_4 <= 8'h0; // @[FloatingPointDesigns.scala 1428:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sub_exp_reg_4 <= sub_exp_reg_3; // @[FloatingPointDesigns.scala 1575:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1428:31]
      sub_exp_reg_5 <= 8'h0; // @[FloatingPointDesigns.scala 1428:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sub_exp_reg_5 <= sub_exp_reg_4; // @[FloatingPointDesigns.scala 1575:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1428:31]
      sub_exp_reg_6 <= 8'h0; // @[FloatingPointDesigns.scala 1428:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sub_exp_reg_6 <= sub_exp_reg_5; // @[FloatingPointDesigns.scala 1575:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1428:31]
      sub_exp_reg_7 <= 8'h0; // @[FloatingPointDesigns.scala 1428:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      sub_exp_reg_7 <= sub_exp_reg_6; // @[FloatingPointDesigns.scala 1575:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1430:37]
      adder_io_out_s_reg_0 <= 24'h0; // @[FloatingPointDesigns.scala 1430:37]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      adder_io_out_s_reg_0 <= adder_io_out_s; // @[FloatingPointDesigns.scala 1555:29]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1430:37]
      adder_io_out_s_reg_1 <= 24'h0; // @[FloatingPointDesigns.scala 1430:37]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      adder_io_out_s_reg_1 <= adder_io_out_s_reg_0; // @[FloatingPointDesigns.scala 1584:33]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1430:37]
      adder_io_out_s_reg_2 <= 24'h0; // @[FloatingPointDesigns.scala 1430:37]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      adder_io_out_s_reg_2 <= adder_io_out_s_reg_1; // @[FloatingPointDesigns.scala 1584:33]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1431:37]
      adder_io_out_c_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1431:37]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      adder_io_out_c_reg_0 <= adder_io_out_c; // @[FloatingPointDesigns.scala 1556:29]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1433:35]
      new_s_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1433:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      new_s_reg_0 <= new_s; // @[FloatingPointDesigns.scala 1549:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1433:35]
      new_s_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1433:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      new_s_reg_1 <= new_s_reg_0; // @[FloatingPointDesigns.scala 1580:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1433:35]
      new_s_reg_2 <= 1'h0; // @[FloatingPointDesigns.scala 1433:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      new_s_reg_2 <= new_s_reg_1; // @[FloatingPointDesigns.scala 1580:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1433:35]
      new_s_reg_3 <= 1'h0; // @[FloatingPointDesigns.scala 1433:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      new_s_reg_3 <= new_s_reg_2; // @[FloatingPointDesigns.scala 1580:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1433:35]
      new_s_reg_4 <= 1'h0; // @[FloatingPointDesigns.scala 1433:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      new_s_reg_4 <= new_s_reg_3; // @[FloatingPointDesigns.scala 1580:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1433:35]
      new_s_reg_5 <= 1'h0; // @[FloatingPointDesigns.scala 1433:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1599:20]
      if (io_in_a_reg_10[30:0] == 31'h0 & io_in_b_reg_10[30:0] == 31'h0) begin // @[FloatingPointDesigns.scala 1600:86]
        new_s_reg_5 <= 1'h0; // @[FloatingPointDesigns.scala 1601:22]
      end else if (sub_exp_reg_7 >= 8'h17) begin // @[FloatingPointDesigns.scala 1604:48]
        new_s_reg_5 <= ref_s_reg_7; // @[FloatingPointDesigns.scala 1605:22]
      end else begin
        new_s_reg_5 <= _GEN_154;
      end
    end
    new_out_frac_reg_0 <= _GEN_170[22:0]; // @[FloatingPointDesigns.scala 1434:{35,35}]
    new_out_exp_reg_0 <= _GEN_171[7:0]; // @[FloatingPointDesigns.scala 1435:{35,35}]
    if (reset) begin // @[FloatingPointDesigns.scala 1436:24]
      E_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1436:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      E_reg_0 <= E; // @[FloatingPointDesigns.scala 1552:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1436:24]
      E_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1436:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      E_reg_1 <= E_reg_0; // @[FloatingPointDesigns.scala 1578:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1436:24]
      E_reg_2 <= 1'h0; // @[FloatingPointDesigns.scala 1436:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      E_reg_2 <= E_reg_1; // @[FloatingPointDesigns.scala 1578:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1436:24]
      E_reg_3 <= 1'h0; // @[FloatingPointDesigns.scala 1436:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      E_reg_3 <= E_reg_2; // @[FloatingPointDesigns.scala 1578:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1436:24]
      E_reg_4 <= 1'h0; // @[FloatingPointDesigns.scala 1436:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      E_reg_4 <= E_reg_3; // @[FloatingPointDesigns.scala 1578:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1437:24]
      D_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1437:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      D_reg_0 <= D; // @[FloatingPointDesigns.scala 1553:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1437:24]
      D_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1437:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      D_reg_1 <= D_reg_0; // @[FloatingPointDesigns.scala 1579:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1437:24]
      D_reg_2 <= 1'h0; // @[FloatingPointDesigns.scala 1437:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      D_reg_2 <= D_reg_1; // @[FloatingPointDesigns.scala 1579:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1437:24]
      D_reg_3 <= 1'h0; // @[FloatingPointDesigns.scala 1437:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      D_reg_3 <= D_reg_2; // @[FloatingPointDesigns.scala 1579:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1437:24]
      D_reg_4 <= 1'h0; // @[FloatingPointDesigns.scala 1437:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      D_reg_4 <= D_reg_3; // @[FloatingPointDesigns.scala 1579:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1439:35]
      adder_result_reg_0 <= 24'h0; // @[FloatingPointDesigns.scala 1439:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      if (new_s_reg_1 & ^_adder_result_T) begin // @[FloatingPointDesigns.scala 1520:24]
        adder_result_reg_0 <= cmpl_adder_io_out_s_reg_0;
      end else begin
        adder_result_reg_0 <= adder_io_out_s_reg_2;
      end
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1439:35]
      adder_result_reg_1 <= 24'h0; // @[FloatingPointDesigns.scala 1439:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      adder_result_reg_1 <= adder_result_reg_0; // @[FloatingPointDesigns.scala 1583:31]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1439:35]
      adder_result_reg_2 <= 24'h0; // @[FloatingPointDesigns.scala 1439:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      adder_result_reg_2 <= adder_result_reg_1; // @[FloatingPointDesigns.scala 1583:31]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1441:33]
      leadingOne_reg_0 <= 6'h0; // @[FloatingPointDesigns.scala 1441:33]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      leadingOne_reg_0 <= leadingOne; // @[FloatingPointDesigns.scala 1560:25]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1441:33]
      leadingOne_reg_1 <= 6'h0; // @[FloatingPointDesigns.scala 1441:33]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      leadingOne_reg_1 <= leadingOne_reg_0; // @[FloatingPointDesigns.scala 1592:29]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_a_reg_0 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_a_reg_0 <= io_in_a; // @[FloatingPointDesigns.scala 1531:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_a_reg_1 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_a_reg_1 <= io_in_a_reg_0; // @[FloatingPointDesigns.scala 1568:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_a_reg_2 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_a_reg_2 <= io_in_a_reg_1; // @[FloatingPointDesigns.scala 1568:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_a_reg_3 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_a_reg_3 <= io_in_a_reg_2; // @[FloatingPointDesigns.scala 1568:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_a_reg_4 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_a_reg_4 <= io_in_a_reg_3; // @[FloatingPointDesigns.scala 1568:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_a_reg_5 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_a_reg_5 <= io_in_a_reg_4; // @[FloatingPointDesigns.scala 1568:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_a_reg_6 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_a_reg_6 <= io_in_a_reg_5; // @[FloatingPointDesigns.scala 1568:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_a_reg_7 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_a_reg_7 <= io_in_a_reg_6; // @[FloatingPointDesigns.scala 1568:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_a_reg_8 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_a_reg_8 <= io_in_a_reg_7; // @[FloatingPointDesigns.scala 1568:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_a_reg_9 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_a_reg_9 <= io_in_a_reg_8; // @[FloatingPointDesigns.scala 1568:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_a_reg_10 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_a_reg_10 <= io_in_a_reg_9; // @[FloatingPointDesigns.scala 1568:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1444:30]
      io_in_b_reg_0 <= 32'h0; // @[FloatingPointDesigns.scala 1444:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_b_reg_0 <= io_in_b; // @[FloatingPointDesigns.scala 1532:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1444:30]
      io_in_b_reg_1 <= 32'h0; // @[FloatingPointDesigns.scala 1444:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_b_reg_1 <= io_in_b_reg_0; // @[FloatingPointDesigns.scala 1569:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1444:30]
      io_in_b_reg_2 <= 32'h0; // @[FloatingPointDesigns.scala 1444:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_b_reg_2 <= io_in_b_reg_1; // @[FloatingPointDesigns.scala 1569:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1444:30]
      io_in_b_reg_3 <= 32'h0; // @[FloatingPointDesigns.scala 1444:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_b_reg_3 <= io_in_b_reg_2; // @[FloatingPointDesigns.scala 1569:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1444:30]
      io_in_b_reg_4 <= 32'h0; // @[FloatingPointDesigns.scala 1444:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_b_reg_4 <= io_in_b_reg_3; // @[FloatingPointDesigns.scala 1569:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1444:30]
      io_in_b_reg_5 <= 32'h0; // @[FloatingPointDesigns.scala 1444:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_b_reg_5 <= io_in_b_reg_4; // @[FloatingPointDesigns.scala 1569:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1444:30]
      io_in_b_reg_6 <= 32'h0; // @[FloatingPointDesigns.scala 1444:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_b_reg_6 <= io_in_b_reg_5; // @[FloatingPointDesigns.scala 1569:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1444:30]
      io_in_b_reg_7 <= 32'h0; // @[FloatingPointDesigns.scala 1444:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_b_reg_7 <= io_in_b_reg_6; // @[FloatingPointDesigns.scala 1569:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1444:30]
      io_in_b_reg_8 <= 32'h0; // @[FloatingPointDesigns.scala 1444:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_b_reg_8 <= io_in_b_reg_7; // @[FloatingPointDesigns.scala 1569:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1444:30]
      io_in_b_reg_9 <= 32'h0; // @[FloatingPointDesigns.scala 1444:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_b_reg_9 <= io_in_b_reg_8; // @[FloatingPointDesigns.scala 1569:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1444:30]
      io_in_b_reg_10 <= 32'h0; // @[FloatingPointDesigns.scala 1444:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      io_in_b_reg_10 <= io_in_b_reg_9; // @[FloatingPointDesigns.scala 1569:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1446:36]
      subber2_out_s_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1446:36]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      subber2_out_s_reg_0 <= subber2_io_out_s; // @[FloatingPointDesigns.scala 1562:28]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1447:36]
      subber2_out_c_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1447:36]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1530:19]
      subber2_out_c_reg_0 <= subber2_io_out_c; // @[FloatingPointDesigns.scala 1563:28]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1468:40]
      cmpl_subber_out_s_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1468:40]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1469:19]
      cmpl_subber_out_s_reg_0 <= _cmpl_subber_out_s_reg_0_T_2; // @[FloatingPointDesigns.scala 1470:32]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1489:44]
      cmpl_wire_temp_add_in_reg_0_0 <= 24'h0; // @[FloatingPointDesigns.scala 1489:44]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1490:19]
      cmpl_wire_temp_add_in_reg_0_0 <= _cmpl_wire_temp_add_in_reg_0_0_T_2; // @[FloatingPointDesigns.scala 1491:39]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1489:44]
      cmpl_wire_temp_add_in_reg_0_1 <= 24'h0; // @[FloatingPointDesigns.scala 1489:44]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1490:19]
      cmpl_wire_temp_add_in_reg_0_1 <= _cmpl_wire_temp_add_in_reg_0_1_T_2; // @[FloatingPointDesigns.scala 1492:39]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1513:42]
      cmpl_adder_io_out_s_reg_0 <= 24'h0; // @[FloatingPointDesigns.scala 1513:42]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1515:19]
      cmpl_adder_io_out_s_reg_0 <= _cmpl_adder_io_out_s_reg_0_T_2; // @[FloatingPointDesigns.scala 1516:34]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1597:28]
      reg_out_s <= 32'h0; // @[FloatingPointDesigns.scala 1597:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1599:20]
      reg_out_s <= _reg_out_s_T_1; // @[FloatingPointDesigns.scala 1636:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sign_reg_0_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  sign_reg_0_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  sign_reg_1_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  sign_reg_1_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  sign_reg_2_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  sign_reg_2_1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  sign_reg_3_0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  sign_reg_3_1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  sign_reg_4_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  sign_reg_4_1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sign_reg_5_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  sign_reg_5_1 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sign_reg_6_0 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  sign_reg_6_1 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sign_reg_7_0 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  sign_reg_7_1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  sign_reg_8_0 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sign_reg_8_1 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  sign_reg_9_0 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  sign_reg_9_1 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  sign_reg_10_0 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  sign_reg_10_1 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  exp_reg_0_0 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  exp_reg_0_1 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  exp_reg_1_0 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  exp_reg_1_1 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  exp_reg_2_0 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  exp_reg_2_1 = _RAND_27[7:0];
  _RAND_28 = {1{`RANDOM}};
  frac_reg_0_0 = _RAND_28[22:0];
  _RAND_29 = {1{`RANDOM}};
  frac_reg_0_1 = _RAND_29[22:0];
  _RAND_30 = {1{`RANDOM}};
  frac_reg_1_0 = _RAND_30[22:0];
  _RAND_31 = {1{`RANDOM}};
  frac_reg_1_1 = _RAND_31[22:0];
  _RAND_32 = {1{`RANDOM}};
  frac_reg_2_0 = _RAND_32[22:0];
  _RAND_33 = {1{`RANDOM}};
  frac_reg_2_1 = _RAND_33[22:0];
  _RAND_34 = {1{`RANDOM}};
  wfrac_reg_0_0 = _RAND_34[23:0];
  _RAND_35 = {1{`RANDOM}};
  wfrac_reg_0_1 = _RAND_35[23:0];
  _RAND_36 = {1{`RANDOM}};
  wfrac_reg_1_0 = _RAND_36[23:0];
  _RAND_37 = {1{`RANDOM}};
  wfrac_reg_1_1 = _RAND_37[23:0];
  _RAND_38 = {1{`RANDOM}};
  wfrac_reg_2_0 = _RAND_38[23:0];
  _RAND_39 = {1{`RANDOM}};
  wfrac_reg_2_1 = _RAND_39[23:0];
  _RAND_40 = {1{`RANDOM}};
  subber_out_s_reg_0 = _RAND_40[7:0];
  _RAND_41 = {1{`RANDOM}};
  subber_out_s_reg_1 = _RAND_41[7:0];
  _RAND_42 = {1{`RANDOM}};
  subber_out_c_reg_0 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  subber_out_c_reg_1 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  wire_temp_add_in_reg_0_0 = _RAND_44[23:0];
  _RAND_45 = {1{`RANDOM}};
  wire_temp_add_in_reg_0_1 = _RAND_45[23:0];
  _RAND_46 = {1{`RANDOM}};
  wire_temp_add_in_reg_1_0 = _RAND_46[23:0];
  _RAND_47 = {1{`RANDOM}};
  wire_temp_add_in_reg_1_1 = _RAND_47[23:0];
  _RAND_48 = {1{`RANDOM}};
  ref_s_reg_0 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  ref_s_reg_1 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  ref_s_reg_2 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  ref_s_reg_3 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  ref_s_reg_4 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  ref_s_reg_5 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  ref_s_reg_6 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  ref_s_reg_7 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  ref_frac_reg_0 = _RAND_56[22:0];
  _RAND_57 = {1{`RANDOM}};
  ref_frac_reg_1 = _RAND_57[22:0];
  _RAND_58 = {1{`RANDOM}};
  ref_frac_reg_2 = _RAND_58[22:0];
  _RAND_59 = {1{`RANDOM}};
  ref_frac_reg_3 = _RAND_59[22:0];
  _RAND_60 = {1{`RANDOM}};
  ref_frac_reg_4 = _RAND_60[22:0];
  _RAND_61 = {1{`RANDOM}};
  ref_frac_reg_5 = _RAND_61[22:0];
  _RAND_62 = {1{`RANDOM}};
  ref_frac_reg_6 = _RAND_62[22:0];
  _RAND_63 = {1{`RANDOM}};
  ref_frac_reg_7 = _RAND_63[22:0];
  _RAND_64 = {1{`RANDOM}};
  ref_exp_reg_0 = _RAND_64[7:0];
  _RAND_65 = {1{`RANDOM}};
  ref_exp_reg_1 = _RAND_65[7:0];
  _RAND_66 = {1{`RANDOM}};
  ref_exp_reg_2 = _RAND_66[7:0];
  _RAND_67 = {1{`RANDOM}};
  ref_exp_reg_3 = _RAND_67[7:0];
  _RAND_68 = {1{`RANDOM}};
  ref_exp_reg_4 = _RAND_68[7:0];
  _RAND_69 = {1{`RANDOM}};
  ref_exp_reg_5 = _RAND_69[7:0];
  _RAND_70 = {1{`RANDOM}};
  ref_exp_reg_6 = _RAND_70[7:0];
  _RAND_71 = {1{`RANDOM}};
  ref_exp_reg_7 = _RAND_71[7:0];
  _RAND_72 = {1{`RANDOM}};
  sub_exp_reg_0 = _RAND_72[7:0];
  _RAND_73 = {1{`RANDOM}};
  sub_exp_reg_1 = _RAND_73[7:0];
  _RAND_74 = {1{`RANDOM}};
  sub_exp_reg_2 = _RAND_74[7:0];
  _RAND_75 = {1{`RANDOM}};
  sub_exp_reg_3 = _RAND_75[7:0];
  _RAND_76 = {1{`RANDOM}};
  sub_exp_reg_4 = _RAND_76[7:0];
  _RAND_77 = {1{`RANDOM}};
  sub_exp_reg_5 = _RAND_77[7:0];
  _RAND_78 = {1{`RANDOM}};
  sub_exp_reg_6 = _RAND_78[7:0];
  _RAND_79 = {1{`RANDOM}};
  sub_exp_reg_7 = _RAND_79[7:0];
  _RAND_80 = {1{`RANDOM}};
  adder_io_out_s_reg_0 = _RAND_80[23:0];
  _RAND_81 = {1{`RANDOM}};
  adder_io_out_s_reg_1 = _RAND_81[23:0];
  _RAND_82 = {1{`RANDOM}};
  adder_io_out_s_reg_2 = _RAND_82[23:0];
  _RAND_83 = {1{`RANDOM}};
  adder_io_out_c_reg_0 = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  new_s_reg_0 = _RAND_84[0:0];
  _RAND_85 = {1{`RANDOM}};
  new_s_reg_1 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  new_s_reg_2 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  new_s_reg_3 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  new_s_reg_4 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  new_s_reg_5 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  new_out_frac_reg_0 = _RAND_90[22:0];
  _RAND_91 = {1{`RANDOM}};
  new_out_exp_reg_0 = _RAND_91[7:0];
  _RAND_92 = {1{`RANDOM}};
  E_reg_0 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  E_reg_1 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  E_reg_2 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  E_reg_3 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  E_reg_4 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  D_reg_0 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  D_reg_1 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  D_reg_2 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  D_reg_3 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  D_reg_4 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  adder_result_reg_0 = _RAND_102[23:0];
  _RAND_103 = {1{`RANDOM}};
  adder_result_reg_1 = _RAND_103[23:0];
  _RAND_104 = {1{`RANDOM}};
  adder_result_reg_2 = _RAND_104[23:0];
  _RAND_105 = {1{`RANDOM}};
  leadingOne_reg_0 = _RAND_105[5:0];
  _RAND_106 = {1{`RANDOM}};
  leadingOne_reg_1 = _RAND_106[5:0];
  _RAND_107 = {1{`RANDOM}};
  io_in_a_reg_0 = _RAND_107[31:0];
  _RAND_108 = {1{`RANDOM}};
  io_in_a_reg_1 = _RAND_108[31:0];
  _RAND_109 = {1{`RANDOM}};
  io_in_a_reg_2 = _RAND_109[31:0];
  _RAND_110 = {1{`RANDOM}};
  io_in_a_reg_3 = _RAND_110[31:0];
  _RAND_111 = {1{`RANDOM}};
  io_in_a_reg_4 = _RAND_111[31:0];
  _RAND_112 = {1{`RANDOM}};
  io_in_a_reg_5 = _RAND_112[31:0];
  _RAND_113 = {1{`RANDOM}};
  io_in_a_reg_6 = _RAND_113[31:0];
  _RAND_114 = {1{`RANDOM}};
  io_in_a_reg_7 = _RAND_114[31:0];
  _RAND_115 = {1{`RANDOM}};
  io_in_a_reg_8 = _RAND_115[31:0];
  _RAND_116 = {1{`RANDOM}};
  io_in_a_reg_9 = _RAND_116[31:0];
  _RAND_117 = {1{`RANDOM}};
  io_in_a_reg_10 = _RAND_117[31:0];
  _RAND_118 = {1{`RANDOM}};
  io_in_b_reg_0 = _RAND_118[31:0];
  _RAND_119 = {1{`RANDOM}};
  io_in_b_reg_1 = _RAND_119[31:0];
  _RAND_120 = {1{`RANDOM}};
  io_in_b_reg_2 = _RAND_120[31:0];
  _RAND_121 = {1{`RANDOM}};
  io_in_b_reg_3 = _RAND_121[31:0];
  _RAND_122 = {1{`RANDOM}};
  io_in_b_reg_4 = _RAND_122[31:0];
  _RAND_123 = {1{`RANDOM}};
  io_in_b_reg_5 = _RAND_123[31:0];
  _RAND_124 = {1{`RANDOM}};
  io_in_b_reg_6 = _RAND_124[31:0];
  _RAND_125 = {1{`RANDOM}};
  io_in_b_reg_7 = _RAND_125[31:0];
  _RAND_126 = {1{`RANDOM}};
  io_in_b_reg_8 = _RAND_126[31:0];
  _RAND_127 = {1{`RANDOM}};
  io_in_b_reg_9 = _RAND_127[31:0];
  _RAND_128 = {1{`RANDOM}};
  io_in_b_reg_10 = _RAND_128[31:0];
  _RAND_129 = {1{`RANDOM}};
  subber2_out_s_reg_0 = _RAND_129[7:0];
  _RAND_130 = {1{`RANDOM}};
  subber2_out_c_reg_0 = _RAND_130[0:0];
  _RAND_131 = {1{`RANDOM}};
  cmpl_subber_out_s_reg_0 = _RAND_131[7:0];
  _RAND_132 = {1{`RANDOM}};
  cmpl_wire_temp_add_in_reg_0_0 = _RAND_132[23:0];
  _RAND_133 = {1{`RANDOM}};
  cmpl_wire_temp_add_in_reg_0_1 = _RAND_133[23:0];
  _RAND_134 = {1{`RANDOM}};
  cmpl_adder_io_out_s_reg_0 = _RAND_134[23:0];
  _RAND_135 = {1{`RANDOM}};
  reg_out_s = _RAND_135[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FP_subtractor_13ccs_19(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
);
  wire  FP_adder_clock; // @[FloatingPointDesigns.scala 1652:26]
  wire  FP_adder_reset; // @[FloatingPointDesigns.scala 1652:26]
  wire  FP_adder_io_in_en; // @[FloatingPointDesigns.scala 1652:26]
  wire [31:0] FP_adder_io_in_a; // @[FloatingPointDesigns.scala 1652:26]
  wire [31:0] FP_adder_io_in_b; // @[FloatingPointDesigns.scala 1652:26]
  wire [31:0] FP_adder_io_out_s; // @[FloatingPointDesigns.scala 1652:26]
  wire  _adjusted_in_b_T_1 = ~io_in_b[31]; // @[FloatingPointDesigns.scala 1655:23]
  FP_adder_13ccs_19 FP_adder ( // @[FloatingPointDesigns.scala 1652:26]
    .clock(FP_adder_clock),
    .reset(FP_adder_reset),
    .io_in_en(FP_adder_io_in_en),
    .io_in_a(FP_adder_io_in_a),
    .io_in_b(FP_adder_io_in_b),
    .io_out_s(FP_adder_io_out_s)
  );
  assign io_out_s = FP_adder_io_out_s; // @[FloatingPointDesigns.scala 1659:14]
  assign FP_adder_clock = clock;
  assign FP_adder_reset = reset;
  assign FP_adder_io_in_en = io_in_en; // @[FloatingPointDesigns.scala 1656:23]
  assign FP_adder_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 1657:22]
  assign FP_adder_io_in_b = {_adjusted_in_b_T_1,io_in_b[30:0]}; // @[FloatingPointDesigns.scala 1655:41]
endmodule
module multiplier_19(
  input  [23:0] io_in_a,
  input  [23:0] io_in_b,
  output [47:0] io_out_s
);
  assign io_out_s = io_in_a * io_in_b; // @[BinaryDesigns.scala 87:23]
endmodule
module twoscomplement_19(
  input  [7:0] io_in,
  output [7:0] io_out
);
  wire [7:0] _x_T = ~io_in; // @[BinaryDesigns.scala 27:16]
  assign io_out = 8'h1 + _x_T; // @[BinaryDesigns.scala 27:14]
endmodule
module full_adder_19_2(
  input  [7:0] io_in_a,
  input  [7:0] io_in_b,
  output [7:0] io_out_s,
  output       io_out_c
);
  wire [8:0] _result_T = io_in_a + io_in_b; // @[BinaryDesigns.scala 59:23]
  wire [9:0] _result_T_1 = {{1'd0}, _result_T}; // @[BinaryDesigns.scala 59:34]
  wire [8:0] result = _result_T_1[8:0]; // @[BinaryDesigns.scala 58:22 59:12]
  assign io_out_s = result[7:0]; // @[BinaryDesigns.scala 60:23]
  assign io_out_c = result[8]; // @[BinaryDesigns.scala 61:23]
endmodule
module FP_multiplier_10ccs_19(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [63:0] _RAND_32;
  reg [63:0] _RAND_33;
  reg [63:0] _RAND_34;
  reg [63:0] _RAND_35;
  reg [63:0] _RAND_36;
  reg [63:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
`endif // RANDOMIZE_REG_INIT
  wire [23:0] multiplier_io_in_a; // @[FloatingPointDesigns.scala 1726:28]
  wire [23:0] multiplier_io_in_b; // @[FloatingPointDesigns.scala 1726:28]
  wire [47:0] multiplier_io_out_s; // @[FloatingPointDesigns.scala 1726:28]
  wire [7:0] subber_io_in_a; // @[FloatingPointDesigns.scala 1733:24]
  wire [7:0] subber_io_in_b; // @[FloatingPointDesigns.scala 1733:24]
  wire [7:0] subber_io_out_s; // @[FloatingPointDesigns.scala 1733:24]
  wire  subber_io_out_c; // @[FloatingPointDesigns.scala 1733:24]
  wire [7:0] complementN_io_in; // @[FloatingPointDesigns.scala 1742:29]
  wire [7:0] complementN_io_out; // @[FloatingPointDesigns.scala 1742:29]
  wire [7:0] adderN_io_in_a; // @[FloatingPointDesigns.scala 1759:24]
  wire [7:0] adderN_io_in_b; // @[FloatingPointDesigns.scala 1759:24]
  wire [7:0] adderN_io_out_s; // @[FloatingPointDesigns.scala 1759:24]
  wire  adderN_io_out_c; // @[FloatingPointDesigns.scala 1759:24]
  wire  s_0 = io_in_a[31]; // @[FloatingPointDesigns.scala 1692:20]
  wire  s_1 = io_in_b[31]; // @[FloatingPointDesigns.scala 1693:20]
  wire [8:0] _T_2 = 9'h100 - 9'h2; // @[FloatingPointDesigns.scala 1697:64]
  wire [8:0] _GEN_63 = {{1'd0}, io_in_a[30:23]}; // @[FloatingPointDesigns.scala 1697:36]
  wire [7:0] _GEN_0 = io_in_a[30:23] < 8'h1 ? 8'h1 : io_in_a[30:23]; // @[FloatingPointDesigns.scala 1699:45 1700:14 1702:14]
  wire [8:0] _GEN_1 = _GEN_63 > _T_2 ? _T_2 : {{1'd0}, _GEN_0}; // @[FloatingPointDesigns.scala 1697:71 1698:14]
  wire [8:0] _GEN_64 = {{1'd0}, io_in_b[30:23]}; // @[FloatingPointDesigns.scala 1704:36]
  wire [7:0] _GEN_2 = io_in_b[30:23] < 8'h1 ? 8'h1 : io_in_b[30:23]; // @[FloatingPointDesigns.scala 1706:45 1707:14 1709:14]
  wire [8:0] _GEN_3 = _GEN_64 > _T_2 ? _T_2 : {{1'd0}, _GEN_2}; // @[FloatingPointDesigns.scala 1704:71 1705:14]
  wire [22:0] frac_0 = io_in_a[22:0]; // @[FloatingPointDesigns.scala 1714:23]
  wire [22:0] frac_1 = io_in_b[22:0]; // @[FloatingPointDesigns.scala 1715:23]
  wire [23:0] new_frac_0 = {1'h1,frac_0}; // @[FloatingPointDesigns.scala 1719:24]
  wire [23:0] new_frac_1 = {1'h1,frac_1}; // @[FloatingPointDesigns.scala 1720:24]
  reg  s_reg_0_0; // @[FloatingPointDesigns.scala 1722:24]
  reg  s_reg_0_1; // @[FloatingPointDesigns.scala 1722:24]
  reg  s_reg_1_0; // @[FloatingPointDesigns.scala 1722:24]
  reg  s_reg_1_1; // @[FloatingPointDesigns.scala 1722:24]
  reg  s_reg_2_0; // @[FloatingPointDesigns.scala 1722:24]
  reg  s_reg_2_1; // @[FloatingPointDesigns.scala 1722:24]
  reg  s_reg_3_0; // @[FloatingPointDesigns.scala 1722:24]
  reg  s_reg_3_1; // @[FloatingPointDesigns.scala 1722:24]
  reg  s_reg_4_0; // @[FloatingPointDesigns.scala 1722:24]
  reg  s_reg_4_1; // @[FloatingPointDesigns.scala 1722:24]
  reg [7:0] exp_reg_0_0; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_0_1; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_1_0; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_1_1; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_2_0; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_2_1; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_3_0; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_3_1; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_4_0; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_4_1; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_5_0; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_5_1; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_6_0; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_6_1; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_7_0; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_7_1; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_8_0; // @[FloatingPointDesigns.scala 1723:26]
  reg [7:0] exp_reg_8_1; // @[FloatingPointDesigns.scala 1723:26]
  reg [23:0] new_frac_reg_0_0; // @[FloatingPointDesigns.scala 1724:31]
  reg [23:0] new_frac_reg_0_1; // @[FloatingPointDesigns.scala 1724:31]
  reg [23:0] new_frac_reg_1_0; // @[FloatingPointDesigns.scala 1724:31]
  reg [23:0] new_frac_reg_1_1; // @[FloatingPointDesigns.scala 1724:31]
  reg [47:0] multipplier_out_s_reg_0; // @[FloatingPointDesigns.scala 1730:40]
  reg [47:0] multipplier_out_s_reg_1; // @[FloatingPointDesigns.scala 1730:40]
  reg [47:0] multipplier_out_s_reg_2; // @[FloatingPointDesigns.scala 1730:40]
  reg [47:0] multipplier_out_s_reg_3; // @[FloatingPointDesigns.scala 1730:40]
  reg [47:0] multipplier_out_s_reg_4; // @[FloatingPointDesigns.scala 1730:40]
  reg [47:0] multipplier_out_s_reg_5; // @[FloatingPointDesigns.scala 1730:40]
  reg [7:0] subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1738:35]
  reg [7:0] complementN_out_reg_0; // @[FloatingPointDesigns.scala 1745:38]
  reg [7:0] complementN_out_reg_1; // @[FloatingPointDesigns.scala 1745:38]
  reg [7:0] complementN_out_reg_2; // @[FloatingPointDesigns.scala 1745:38]
  wire  new_s = s_reg_4_0 ^ s_reg_4_1; // @[FloatingPointDesigns.scala 1748:26]
  reg  new_s_reg_0; // @[FloatingPointDesigns.scala 1750:28]
  reg  new_s_reg_1; // @[FloatingPointDesigns.scala 1750:28]
  reg  new_s_reg_2; // @[FloatingPointDesigns.scala 1750:28]
  reg  new_s_reg_3; // @[FloatingPointDesigns.scala 1750:28]
  wire  is_exp1_neg_wire = exp_reg_5_1 < 8'h7f; // @[FloatingPointDesigns.scala 1753:40]
  reg  is_exp1_neg_reg_0; // @[FloatingPointDesigns.scala 1755:34]
  reg  is_exp1_neg_reg_1; // @[FloatingPointDesigns.scala 1755:34]
  wire [7:0] _adderN_io_in_a_T_1 = exp_reg_6_0 + 8'h1; // @[FloatingPointDesigns.scala 1763:39]
  reg [7:0] adderN_out_s_reg_0; // @[FloatingPointDesigns.scala 1770:35]
  reg  adderN_out_c_reg_0; // @[FloatingPointDesigns.scala 1771:35]
  reg [7:0] new_exp_reg_0; // @[FloatingPointDesigns.scala 1773:30]
  reg [22:0] new_mant_reg_0; // @[FloatingPointDesigns.scala 1774:31]
  reg [31:0] reg_out_s; // @[FloatingPointDesigns.scala 1776:28]
  wire  _new_exp_reg_0_T_1 = ~adderN_out_c_reg_0; // @[FloatingPointDesigns.scala 1780:55]
  wire [7:0] _new_exp_reg_0_T_2 = ~adderN_out_c_reg_0 ? 8'h1 : adderN_out_s_reg_0; // @[FloatingPointDesigns.scala 1780:54]
  wire  _new_exp_reg_0_T_5 = adderN_out_c_reg_0 | adderN_out_s_reg_0 > 8'hfe; // @[FloatingPointDesigns.scala 1780:142]
  wire [7:0] _new_exp_reg_0_T_6 = adderN_out_c_reg_0 | adderN_out_s_reg_0 > 8'hfe ? 8'hfe : adderN_out_s_reg_0; // @[FloatingPointDesigns.scala 1780:114]
  wire [7:0] _new_exp_reg_0_T_7 = is_exp1_neg_reg_1 ? _new_exp_reg_0_T_2 : _new_exp_reg_0_T_6; // @[FloatingPointDesigns.scala 1780:30]
  wire [22:0] _new_mant_reg_0_T_3 = _new_exp_reg_0_T_1 ? 23'h0 : multipplier_out_s_reg_5[46:24]; // @[FloatingPointDesigns.scala 1781:55]
  wire [22:0] _new_mant_reg_0_T_8 = _new_exp_reg_0_T_5 ? 23'h7fffff : multipplier_out_s_reg_5[46:24]; // @[FloatingPointDesigns.scala 1781:160]
  wire [22:0] _new_mant_reg_0_T_13 = _new_exp_reg_0_T_1 ? 23'h0 : multipplier_out_s_reg_5[45:23]; // @[FloatingPointDesigns.scala 1784:55]
  wire [22:0] _new_mant_reg_0_T_18 = _new_exp_reg_0_T_5 ? 23'h7fffff : multipplier_out_s_reg_5[45:23]; // @[FloatingPointDesigns.scala 1784:156]
  wire [31:0] _reg_out_s_T_1 = {new_s_reg_3,new_exp_reg_0,new_mant_reg_0}; // @[FloatingPointDesigns.scala 1822:53]
  wire [7:0] exp_0 = _GEN_1[7:0]; // @[FloatingPointDesigns.scala 1696:19]
  wire [7:0] exp_1 = _GEN_3[7:0]; // @[FloatingPointDesigns.scala 1696:19]
  multiplier_19 multiplier ( // @[FloatingPointDesigns.scala 1726:28]
    .io_in_a(multiplier_io_in_a),
    .io_in_b(multiplier_io_in_b),
    .io_out_s(multiplier_io_out_s)
  );
  full_subber_19 subber ( // @[FloatingPointDesigns.scala 1733:24]
    .io_in_a(subber_io_in_a),
    .io_in_b(subber_io_in_b),
    .io_out_s(subber_io_out_s),
    .io_out_c(subber_io_out_c)
  );
  twoscomplement_19 complementN ( // @[FloatingPointDesigns.scala 1742:29]
    .io_in(complementN_io_in),
    .io_out(complementN_io_out)
  );
  full_adder_19_2 adderN ( // @[FloatingPointDesigns.scala 1759:24]
    .io_in_a(adderN_io_in_a),
    .io_in_b(adderN_io_in_b),
    .io_out_s(adderN_io_out_s),
    .io_out_c(adderN_io_out_c)
  );
  assign io_out_s = reg_out_s; // @[FloatingPointDesigns.scala 1825:14]
  assign multiplier_io_in_a = new_frac_reg_1_0; // @[FloatingPointDesigns.scala 1727:24]
  assign multiplier_io_in_b = new_frac_reg_1_1; // @[FloatingPointDesigns.scala 1728:24]
  assign subber_io_in_a = 8'h7f; // @[FloatingPointDesigns.scala 1734:20]
  assign subber_io_in_b = exp_reg_2_1; // @[FloatingPointDesigns.scala 1735:20]
  assign complementN_io_in = subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1743:23]
  assign adderN_io_in_a = multipplier_out_s_reg_4[47] ? _adderN_io_in_a_T_1 : exp_reg_6_0; // @[FloatingPointDesigns.scala 1762:70 1763:22 1766:22]
  assign adderN_io_in_b = complementN_out_reg_2; // @[FloatingPointDesigns.scala 1762:70 1764:22 1767:22]
  always @(posedge clock) begin
    if (reset) begin // @[FloatingPointDesigns.scala 1722:24]
      s_reg_0_0 <= 1'h0; // @[FloatingPointDesigns.scala 1722:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      s_reg_0_0 <= s_0; // @[FloatingPointDesigns.scala 1787:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1722:24]
      s_reg_0_1 <= 1'h0; // @[FloatingPointDesigns.scala 1722:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      s_reg_0_1 <= s_1; // @[FloatingPointDesigns.scala 1787:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1722:24]
      s_reg_1_0 <= 1'h0; // @[FloatingPointDesigns.scala 1722:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      s_reg_1_0 <= s_reg_0_0; // @[FloatingPointDesigns.scala 1804:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1722:24]
      s_reg_1_1 <= 1'h0; // @[FloatingPointDesigns.scala 1722:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      s_reg_1_1 <= s_reg_0_1; // @[FloatingPointDesigns.scala 1804:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1722:24]
      s_reg_2_0 <= 1'h0; // @[FloatingPointDesigns.scala 1722:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      s_reg_2_0 <= s_reg_1_0; // @[FloatingPointDesigns.scala 1804:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1722:24]
      s_reg_2_1 <= 1'h0; // @[FloatingPointDesigns.scala 1722:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      s_reg_2_1 <= s_reg_1_1; // @[FloatingPointDesigns.scala 1804:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1722:24]
      s_reg_3_0 <= 1'h0; // @[FloatingPointDesigns.scala 1722:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      s_reg_3_0 <= s_reg_2_0; // @[FloatingPointDesigns.scala 1804:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1722:24]
      s_reg_3_1 <= 1'h0; // @[FloatingPointDesigns.scala 1722:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      s_reg_3_1 <= s_reg_2_1; // @[FloatingPointDesigns.scala 1804:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1722:24]
      s_reg_4_0 <= 1'h0; // @[FloatingPointDesigns.scala 1722:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      s_reg_4_0 <= s_reg_3_0; // @[FloatingPointDesigns.scala 1804:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1722:24]
      s_reg_4_1 <= 1'h0; // @[FloatingPointDesigns.scala 1722:24]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      s_reg_4_1 <= s_reg_3_1; // @[FloatingPointDesigns.scala 1804:22]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_0_0 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_0_0 <= exp_0; // @[FloatingPointDesigns.scala 1788:18]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_0_1 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_0_1 <= exp_1; // @[FloatingPointDesigns.scala 1788:18]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_1_0 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_1_0 <= exp_reg_0_0; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_1_1 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_1_1 <= exp_reg_0_1; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_2_0 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_2_0 <= exp_reg_1_0; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_2_1 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_2_1 <= exp_reg_1_1; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_3_0 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_3_0 <= exp_reg_2_0; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_3_1 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_3_1 <= exp_reg_2_1; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_4_0 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_4_0 <= exp_reg_3_0; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_4_1 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_4_1 <= exp_reg_3_1; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_5_0 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_5_0 <= exp_reg_4_0; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_5_1 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_5_1 <= exp_reg_4_1; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_6_0 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_6_0 <= exp_reg_5_0; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_6_1 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_6_1 <= exp_reg_5_1; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_7_0 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_7_0 <= exp_reg_6_0; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_7_1 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_7_1 <= exp_reg_6_1; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_8_0 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_8_0 <= exp_reg_7_0; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1723:26]
      exp_reg_8_1 <= 8'h0; // @[FloatingPointDesigns.scala 1723:26]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      exp_reg_8_1 <= exp_reg_7_1; // @[FloatingPointDesigns.scala 1800:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1724:31]
      new_frac_reg_0_0 <= 24'h0; // @[FloatingPointDesigns.scala 1724:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      new_frac_reg_0_0 <= new_frac_0; // @[FloatingPointDesigns.scala 1789:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1724:31]
      new_frac_reg_0_1 <= 24'h0; // @[FloatingPointDesigns.scala 1724:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      new_frac_reg_0_1 <= new_frac_1; // @[FloatingPointDesigns.scala 1789:23]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1724:31]
      new_frac_reg_1_0 <= 24'h0; // @[FloatingPointDesigns.scala 1724:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      new_frac_reg_1_0 <= new_frac_reg_0_0; // @[FloatingPointDesigns.scala 1810:35]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1724:31]
      new_frac_reg_1_1 <= 24'h0; // @[FloatingPointDesigns.scala 1724:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      new_frac_reg_1_1 <= new_frac_reg_0_1; // @[FloatingPointDesigns.scala 1810:35]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1730:40]
      multipplier_out_s_reg_0 <= 48'h0; // @[FloatingPointDesigns.scala 1730:40]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      multipplier_out_s_reg_0 <= multiplier_io_out_s; // @[FloatingPointDesigns.scala 1790:32]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1730:40]
      multipplier_out_s_reg_1 <= 48'h0; // @[FloatingPointDesigns.scala 1730:40]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      multipplier_out_s_reg_1 <= multipplier_out_s_reg_0; // @[FloatingPointDesigns.scala 1802:36]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1730:40]
      multipplier_out_s_reg_2 <= 48'h0; // @[FloatingPointDesigns.scala 1730:40]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      multipplier_out_s_reg_2 <= multipplier_out_s_reg_1; // @[FloatingPointDesigns.scala 1802:36]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1730:40]
      multipplier_out_s_reg_3 <= 48'h0; // @[FloatingPointDesigns.scala 1730:40]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      multipplier_out_s_reg_3 <= multipplier_out_s_reg_2; // @[FloatingPointDesigns.scala 1802:36]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1730:40]
      multipplier_out_s_reg_4 <= 48'h0; // @[FloatingPointDesigns.scala 1730:40]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      multipplier_out_s_reg_4 <= multipplier_out_s_reg_3; // @[FloatingPointDesigns.scala 1802:36]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1730:40]
      multipplier_out_s_reg_5 <= 48'h0; // @[FloatingPointDesigns.scala 1730:40]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      multipplier_out_s_reg_5 <= multipplier_out_s_reg_4; // @[FloatingPointDesigns.scala 1802:36]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1738:35]
      subber_out_s_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1738:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      subber_out_s_reg_0 <= subber_io_out_s; // @[FloatingPointDesigns.scala 1791:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1745:38]
      complementN_out_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1745:38]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      complementN_out_reg_0 <= complementN_io_out; // @[FloatingPointDesigns.scala 1793:30]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1745:38]
      complementN_out_reg_1 <= 8'h0; // @[FloatingPointDesigns.scala 1745:38]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      complementN_out_reg_1 <= complementN_out_reg_0; // @[FloatingPointDesigns.scala 1808:40]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1745:38]
      complementN_out_reg_2 <= 8'h0; // @[FloatingPointDesigns.scala 1745:38]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      complementN_out_reg_2 <= complementN_out_reg_1; // @[FloatingPointDesigns.scala 1808:40]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1750:28]
      new_s_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1750:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      new_s_reg_0 <= new_s; // @[FloatingPointDesigns.scala 1794:20]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1750:28]
      new_s_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1750:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      new_s_reg_1 <= new_s_reg_0; // @[FloatingPointDesigns.scala 1806:28]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1750:28]
      new_s_reg_2 <= 1'h0; // @[FloatingPointDesigns.scala 1750:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      new_s_reg_2 <= new_s_reg_1; // @[FloatingPointDesigns.scala 1806:28]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1750:28]
      new_s_reg_3 <= 1'h0; // @[FloatingPointDesigns.scala 1750:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      new_s_reg_3 <= new_s_reg_2; // @[FloatingPointDesigns.scala 1806:28]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1755:34]
      is_exp1_neg_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1755:34]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      is_exp1_neg_reg_0 <= is_exp1_neg_wire; // @[FloatingPointDesigns.scala 1795:26]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1755:34]
      is_exp1_neg_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1755:34]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      is_exp1_neg_reg_1 <= is_exp1_neg_reg_0; // @[FloatingPointDesigns.scala 1811:38]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1770:35]
      adderN_out_s_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1770:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      adderN_out_s_reg_0 <= adderN_io_out_s; // @[FloatingPointDesigns.scala 1796:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1771:35]
      adderN_out_c_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1771:35]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      adderN_out_c_reg_0 <= adderN_io_out_c; // @[FloatingPointDesigns.scala 1797:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1773:30]
      new_exp_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1773:30]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      if (multipplier_out_s_reg_5[47]) begin // @[FloatingPointDesigns.scala 1779:72]
        new_exp_reg_0 <= _new_exp_reg_0_T_7; // @[FloatingPointDesigns.scala 1780:24]
      end else begin
        new_exp_reg_0 <= _new_exp_reg_0_T_7; // @[FloatingPointDesigns.scala 1783:24]
      end
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1774:31]
      new_mant_reg_0 <= 23'h0; // @[FloatingPointDesigns.scala 1774:31]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      if (multipplier_out_s_reg_5[47]) begin // @[FloatingPointDesigns.scala 1779:72]
        if (is_exp1_neg_reg_1) begin // @[FloatingPointDesigns.scala 1781:31]
          new_mant_reg_0 <= _new_mant_reg_0_T_3;
        end else begin
          new_mant_reg_0 <= _new_mant_reg_0_T_8;
        end
      end else if (is_exp1_neg_reg_1) begin // @[FloatingPointDesigns.scala 1784:31]
        new_mant_reg_0 <= _new_mant_reg_0_T_13;
      end else begin
        new_mant_reg_0 <= _new_mant_reg_0_T_18;
      end
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1776:28]
      reg_out_s <= 32'h0; // @[FloatingPointDesigns.scala 1776:28]
    end else if (io_in_en) begin // @[FloatingPointDesigns.scala 1778:19]
      if (exp_reg_8_0 == 8'h0 | exp_reg_8_1 == 8'h0) begin // @[FloatingPointDesigns.scala 1819:60]
        reg_out_s <= 32'h0; // @[FloatingPointDesigns.scala 1820:19]
      end else begin
        reg_out_s <= _reg_out_s_T_1; // @[FloatingPointDesigns.scala 1822:19]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  s_reg_0_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  s_reg_0_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  s_reg_1_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  s_reg_1_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  s_reg_2_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  s_reg_2_1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  s_reg_3_0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  s_reg_3_1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  s_reg_4_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  s_reg_4_1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  exp_reg_0_0 = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  exp_reg_0_1 = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  exp_reg_1_0 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  exp_reg_1_1 = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  exp_reg_2_0 = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  exp_reg_2_1 = _RAND_15[7:0];
  _RAND_16 = {1{`RANDOM}};
  exp_reg_3_0 = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  exp_reg_3_1 = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  exp_reg_4_0 = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  exp_reg_4_1 = _RAND_19[7:0];
  _RAND_20 = {1{`RANDOM}};
  exp_reg_5_0 = _RAND_20[7:0];
  _RAND_21 = {1{`RANDOM}};
  exp_reg_5_1 = _RAND_21[7:0];
  _RAND_22 = {1{`RANDOM}};
  exp_reg_6_0 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  exp_reg_6_1 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  exp_reg_7_0 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  exp_reg_7_1 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  exp_reg_8_0 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  exp_reg_8_1 = _RAND_27[7:0];
  _RAND_28 = {1{`RANDOM}};
  new_frac_reg_0_0 = _RAND_28[23:0];
  _RAND_29 = {1{`RANDOM}};
  new_frac_reg_0_1 = _RAND_29[23:0];
  _RAND_30 = {1{`RANDOM}};
  new_frac_reg_1_0 = _RAND_30[23:0];
  _RAND_31 = {1{`RANDOM}};
  new_frac_reg_1_1 = _RAND_31[23:0];
  _RAND_32 = {2{`RANDOM}};
  multipplier_out_s_reg_0 = _RAND_32[47:0];
  _RAND_33 = {2{`RANDOM}};
  multipplier_out_s_reg_1 = _RAND_33[47:0];
  _RAND_34 = {2{`RANDOM}};
  multipplier_out_s_reg_2 = _RAND_34[47:0];
  _RAND_35 = {2{`RANDOM}};
  multipplier_out_s_reg_3 = _RAND_35[47:0];
  _RAND_36 = {2{`RANDOM}};
  multipplier_out_s_reg_4 = _RAND_36[47:0];
  _RAND_37 = {2{`RANDOM}};
  multipplier_out_s_reg_5 = _RAND_37[47:0];
  _RAND_38 = {1{`RANDOM}};
  subber_out_s_reg_0 = _RAND_38[7:0];
  _RAND_39 = {1{`RANDOM}};
  complementN_out_reg_0 = _RAND_39[7:0];
  _RAND_40 = {1{`RANDOM}};
  complementN_out_reg_1 = _RAND_40[7:0];
  _RAND_41 = {1{`RANDOM}};
  complementN_out_reg_2 = _RAND_41[7:0];
  _RAND_42 = {1{`RANDOM}};
  new_s_reg_0 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  new_s_reg_1 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  new_s_reg_2 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  new_s_reg_3 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  is_exp1_neg_reg_0 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  is_exp1_neg_reg_1 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  adderN_out_s_reg_0 = _RAND_48[7:0];
  _RAND_49 = {1{`RANDOM}};
  adderN_out_c_reg_0 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  new_exp_reg_0 = _RAND_50[7:0];
  _RAND_51 = {1{`RANDOM}};
  new_mant_reg_0 = _RAND_51[22:0];
  _RAND_52 = {1{`RANDOM}};
  reg_out_s = _RAND_52[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FPComplexMult_v2_19(
  input         clock,
  input         reset,
  input  [31:0] io_in_a_Re,
  input  [31:0] io_in_a_Im,
  input  [31:0] io_in_b_Re,
  input  [31:0] io_in_b_Im,
  output [31:0] io_out_s_Re,
  output [31:0] io_out_s_Im
);
  wire  FP_subtractor_13ccs_19_clock; // @[FPComplex.scala 178:24]
  wire  FP_subtractor_13ccs_19_reset; // @[FPComplex.scala 178:24]
  wire  FP_subtractor_13ccs_19_io_in_en; // @[FPComplex.scala 178:24]
  wire [31:0] FP_subtractor_13ccs_19_io_in_a; // @[FPComplex.scala 178:24]
  wire [31:0] FP_subtractor_13ccs_19_io_in_b; // @[FPComplex.scala 178:24]
  wire [31:0] FP_subtractor_13ccs_19_io_out_s; // @[FPComplex.scala 178:24]
  wire  FP_adder_13ccs_19_clock; // @[FPComplex.scala 179:24]
  wire  FP_adder_13ccs_19_reset; // @[FPComplex.scala 179:24]
  wire  FP_adder_13ccs_19_io_in_en; // @[FPComplex.scala 179:24]
  wire [31:0] FP_adder_13ccs_19_io_in_a; // @[FPComplex.scala 179:24]
  wire [31:0] FP_adder_13ccs_19_io_in_b; // @[FPComplex.scala 179:24]
  wire [31:0] FP_adder_13ccs_19_io_out_s; // @[FPComplex.scala 179:24]
  wire  FP_multiplier_10ccs_19_clock; // @[FPComplex.scala 181:26]
  wire  FP_multiplier_10ccs_19_reset; // @[FPComplex.scala 181:26]
  wire  FP_multiplier_10ccs_19_io_in_en; // @[FPComplex.scala 181:26]
  wire [31:0] FP_multiplier_10ccs_19_io_in_a; // @[FPComplex.scala 181:26]
  wire [31:0] FP_multiplier_10ccs_19_io_in_b; // @[FPComplex.scala 181:26]
  wire [31:0] FP_multiplier_10ccs_19_io_out_s; // @[FPComplex.scala 181:26]
  wire  FP_multiplier_10ccs_19_1_clock; // @[FPComplex.scala 181:26]
  wire  FP_multiplier_10ccs_19_1_reset; // @[FPComplex.scala 181:26]
  wire  FP_multiplier_10ccs_19_1_io_in_en; // @[FPComplex.scala 181:26]
  wire [31:0] FP_multiplier_10ccs_19_1_io_in_a; // @[FPComplex.scala 181:26]
  wire [31:0] FP_multiplier_10ccs_19_1_io_in_b; // @[FPComplex.scala 181:26]
  wire [31:0] FP_multiplier_10ccs_19_1_io_out_s; // @[FPComplex.scala 181:26]
  wire  FP_multiplier_10ccs_19_2_clock; // @[FPComplex.scala 181:26]
  wire  FP_multiplier_10ccs_19_2_reset; // @[FPComplex.scala 181:26]
  wire  FP_multiplier_10ccs_19_2_io_in_en; // @[FPComplex.scala 181:26]
  wire [31:0] FP_multiplier_10ccs_19_2_io_in_a; // @[FPComplex.scala 181:26]
  wire [31:0] FP_multiplier_10ccs_19_2_io_in_b; // @[FPComplex.scala 181:26]
  wire [31:0] FP_multiplier_10ccs_19_2_io_out_s; // @[FPComplex.scala 181:26]
  wire  FP_multiplier_10ccs_19_3_clock; // @[FPComplex.scala 181:26]
  wire  FP_multiplier_10ccs_19_3_reset; // @[FPComplex.scala 181:26]
  wire  FP_multiplier_10ccs_19_3_io_in_en; // @[FPComplex.scala 181:26]
  wire [31:0] FP_multiplier_10ccs_19_3_io_in_a; // @[FPComplex.scala 181:26]
  wire [31:0] FP_multiplier_10ccs_19_3_io_in_b; // @[FPComplex.scala 181:26]
  wire [31:0] FP_multiplier_10ccs_19_3_io_out_s; // @[FPComplex.scala 181:26]
  FP_subtractor_13ccs_19 FP_subtractor_13ccs_19 ( // @[FPComplex.scala 178:24]
    .clock(FP_subtractor_13ccs_19_clock),
    .reset(FP_subtractor_13ccs_19_reset),
    .io_in_en(FP_subtractor_13ccs_19_io_in_en),
    .io_in_a(FP_subtractor_13ccs_19_io_in_a),
    .io_in_b(FP_subtractor_13ccs_19_io_in_b),
    .io_out_s(FP_subtractor_13ccs_19_io_out_s)
  );
  FP_adder_13ccs_19 FP_adder_13ccs_19 ( // @[FPComplex.scala 179:24]
    .clock(FP_adder_13ccs_19_clock),
    .reset(FP_adder_13ccs_19_reset),
    .io_in_en(FP_adder_13ccs_19_io_in_en),
    .io_in_a(FP_adder_13ccs_19_io_in_a),
    .io_in_b(FP_adder_13ccs_19_io_in_b),
    .io_out_s(FP_adder_13ccs_19_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19 ( // @[FPComplex.scala 181:26]
    .clock(FP_multiplier_10ccs_19_clock),
    .reset(FP_multiplier_10ccs_19_reset),
    .io_in_en(FP_multiplier_10ccs_19_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_1 ( // @[FPComplex.scala 181:26]
    .clock(FP_multiplier_10ccs_19_1_clock),
    .reset(FP_multiplier_10ccs_19_1_reset),
    .io_in_en(FP_multiplier_10ccs_19_1_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_1_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_1_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_1_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_2 ( // @[FPComplex.scala 181:26]
    .clock(FP_multiplier_10ccs_19_2_clock),
    .reset(FP_multiplier_10ccs_19_2_reset),
    .io_in_en(FP_multiplier_10ccs_19_2_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_2_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_2_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_2_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_3 ( // @[FPComplex.scala 181:26]
    .clock(FP_multiplier_10ccs_19_3_clock),
    .reset(FP_multiplier_10ccs_19_3_reset),
    .io_in_en(FP_multiplier_10ccs_19_3_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_3_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_3_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_3_io_out_s)
  );
  assign io_out_s_Re = FP_subtractor_13ccs_19_io_out_s; // @[FPComplex.scala 201:17]
  assign io_out_s_Im = FP_adder_13ccs_19_io_out_s; // @[FPComplex.scala 202:17]
  assign FP_subtractor_13ccs_19_clock = clock;
  assign FP_subtractor_13ccs_19_reset = reset;
  assign FP_subtractor_13ccs_19_io_in_en = 1'h1; // @[FPComplex.scala 187:18]
  assign FP_subtractor_13ccs_19_io_in_a = FP_multiplier_10ccs_19_io_out_s; // @[FPComplex.scala 197:17]
  assign FP_subtractor_13ccs_19_io_in_b = FP_multiplier_10ccs_19_1_io_out_s; // @[FPComplex.scala 198:17]
  assign FP_adder_13ccs_19_clock = clock;
  assign FP_adder_13ccs_19_reset = reset;
  assign FP_adder_13ccs_19_io_in_en = 1'h1; // @[FPComplex.scala 188:18]
  assign FP_adder_13ccs_19_io_in_a = FP_multiplier_10ccs_19_2_io_out_s; // @[FPComplex.scala 199:17]
  assign FP_adder_13ccs_19_io_in_b = FP_multiplier_10ccs_19_3_io_out_s; // @[FPComplex.scala 200:17]
  assign FP_multiplier_10ccs_19_clock = clock;
  assign FP_multiplier_10ccs_19_reset = reset;
  assign FP_multiplier_10ccs_19_io_in_en = 1'h1; // @[FPComplex.scala 185:31]
  assign FP_multiplier_10ccs_19_io_in_a = io_in_a_Re; // @[FPComplex.scala 189:28]
  assign FP_multiplier_10ccs_19_io_in_b = io_in_b_Re; // @[FPComplex.scala 190:28]
  assign FP_multiplier_10ccs_19_1_clock = clock;
  assign FP_multiplier_10ccs_19_1_reset = reset;
  assign FP_multiplier_10ccs_19_1_io_in_en = 1'h1; // @[FPComplex.scala 185:31]
  assign FP_multiplier_10ccs_19_1_io_in_a = io_in_a_Im; // @[FPComplex.scala 191:28]
  assign FP_multiplier_10ccs_19_1_io_in_b = io_in_b_Im; // @[FPComplex.scala 192:28]
  assign FP_multiplier_10ccs_19_2_clock = clock;
  assign FP_multiplier_10ccs_19_2_reset = reset;
  assign FP_multiplier_10ccs_19_2_io_in_en = 1'h1; // @[FPComplex.scala 185:31]
  assign FP_multiplier_10ccs_19_2_io_in_a = io_in_a_Re; // @[FPComplex.scala 193:28]
  assign FP_multiplier_10ccs_19_2_io_in_b = io_in_b_Im; // @[FPComplex.scala 194:28]
  assign FP_multiplier_10ccs_19_3_clock = clock;
  assign FP_multiplier_10ccs_19_3_reset = reset;
  assign FP_multiplier_10ccs_19_3_io_in_en = 1'h1; // @[FPComplex.scala 185:31]
  assign FP_multiplier_10ccs_19_3_io_in_a = io_in_a_Im; // @[FPComplex.scala 195:28]
  assign FP_multiplier_10ccs_19_3_io_in_b = io_in_b_Re; // @[FPComplex.scala 196:28]
endmodule
module FPComplexAdder_v2_19(
  input         clock,
  input         reset,
  input  [31:0] io_in_a_Re,
  input  [31:0] io_in_a_Im,
  input  [31:0] io_in_b_Re,
  input  [31:0] io_in_b_Im,
  output [31:0] io_out_s_Re,
  output [31:0] io_out_s_Im
);
  wire  FP_adder_13ccs_19_clock; // @[FPComplex.scala 36:25]
  wire  FP_adder_13ccs_19_reset; // @[FPComplex.scala 36:25]
  wire  FP_adder_13ccs_19_io_in_en; // @[FPComplex.scala 36:25]
  wire [31:0] FP_adder_13ccs_19_io_in_a; // @[FPComplex.scala 36:25]
  wire [31:0] FP_adder_13ccs_19_io_in_b; // @[FPComplex.scala 36:25]
  wire [31:0] FP_adder_13ccs_19_io_out_s; // @[FPComplex.scala 36:25]
  wire  FP_adder_13ccs_19_1_clock; // @[FPComplex.scala 36:25]
  wire  FP_adder_13ccs_19_1_reset; // @[FPComplex.scala 36:25]
  wire  FP_adder_13ccs_19_1_io_in_en; // @[FPComplex.scala 36:25]
  wire [31:0] FP_adder_13ccs_19_1_io_in_a; // @[FPComplex.scala 36:25]
  wire [31:0] FP_adder_13ccs_19_1_io_in_b; // @[FPComplex.scala 36:25]
  wire [31:0] FP_adder_13ccs_19_1_io_out_s; // @[FPComplex.scala 36:25]
  FP_adder_13ccs_19 FP_adder_13ccs_19 ( // @[FPComplex.scala 36:25]
    .clock(FP_adder_13ccs_19_clock),
    .reset(FP_adder_13ccs_19_reset),
    .io_in_en(FP_adder_13ccs_19_io_in_en),
    .io_in_a(FP_adder_13ccs_19_io_in_a),
    .io_in_b(FP_adder_13ccs_19_io_in_b),
    .io_out_s(FP_adder_13ccs_19_io_out_s)
  );
  FP_adder_13ccs_19 FP_adder_13ccs_19_1 ( // @[FPComplex.scala 36:25]
    .clock(FP_adder_13ccs_19_1_clock),
    .reset(FP_adder_13ccs_19_1_reset),
    .io_in_en(FP_adder_13ccs_19_1_io_in_en),
    .io_in_a(FP_adder_13ccs_19_1_io_in_a),
    .io_in_b(FP_adder_13ccs_19_1_io_in_b),
    .io_out_s(FP_adder_13ccs_19_1_io_out_s)
  );
  assign io_out_s_Re = FP_adder_13ccs_19_io_out_s; // @[FPComplex.scala 45:17]
  assign io_out_s_Im = FP_adder_13ccs_19_1_io_out_s; // @[FPComplex.scala 46:17]
  assign FP_adder_13ccs_19_clock = clock;
  assign FP_adder_13ccs_19_reset = reset;
  assign FP_adder_13ccs_19_io_in_en = 1'h1; // @[FPComplex.scala 39:24]
  assign FP_adder_13ccs_19_io_in_a = io_in_a_Re; // @[FPComplex.scala 41:23]
  assign FP_adder_13ccs_19_io_in_b = io_in_b_Re; // @[FPComplex.scala 42:23]
  assign FP_adder_13ccs_19_1_clock = clock;
  assign FP_adder_13ccs_19_1_reset = reset;
  assign FP_adder_13ccs_19_1_io_in_en = 1'h1; // @[FPComplex.scala 40:24]
  assign FP_adder_13ccs_19_1_io_in_a = io_in_a_Im; // @[FPComplex.scala 43:23]
  assign FP_adder_13ccs_19_1_io_in_b = io_in_b_Im; // @[FPComplex.scala 44:23]
endmodule
module FP_DDOT_dp_complex_19(
  input         clock,
  input         reset,
  input  [31:0] io_in_a_0_Re,
  input  [31:0] io_in_a_0_Im,
  input  [31:0] io_in_a_1_Re,
  input  [31:0] io_in_a_1_Im,
  input  [31:0] io_in_a_2_Re,
  input  [31:0] io_in_a_2_Im,
  input  [31:0] io_in_a_3_Re,
  input  [31:0] io_in_a_3_Im,
  input  [31:0] io_in_b_0_Re,
  input  [31:0] io_in_b_0_Im,
  input  [31:0] io_in_b_1_Re,
  input  [31:0] io_in_b_1_Im,
  input  [31:0] io_in_b_2_Re,
  input  [31:0] io_in_b_2_Im,
  input  [31:0] io_in_b_3_Re,
  input  [31:0] io_in_b_3_Im,
  output [31:0] io_out_s_Re,
  output [31:0] io_out_s_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  FPComplexMult_v2_19_clock; // @[FPComplex.scala 1129:44]
  wire  FPComplexMult_v2_19_reset; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_io_in_a_Re; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_io_in_a_Im; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_io_in_b_Re; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_io_in_b_Im; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_io_out_s_Re; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_io_out_s_Im; // @[FPComplex.scala 1129:44]
  wire  FPComplexMult_v2_19_1_clock; // @[FPComplex.scala 1129:44]
  wire  FPComplexMult_v2_19_1_reset; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_1_io_in_a_Re; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_1_io_in_a_Im; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_1_io_in_b_Re; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_1_io_in_b_Im; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_1_io_out_s_Re; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_1_io_out_s_Im; // @[FPComplex.scala 1129:44]
  wire  FPComplexMult_v2_19_2_clock; // @[FPComplex.scala 1129:44]
  wire  FPComplexMult_v2_19_2_reset; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_2_io_in_a_Re; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_2_io_in_a_Im; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_2_io_in_b_Re; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_2_io_in_b_Im; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_2_io_out_s_Re; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_2_io_out_s_Im; // @[FPComplex.scala 1129:44]
  wire  FPComplexMult_v2_19_3_clock; // @[FPComplex.scala 1129:44]
  wire  FPComplexMult_v2_19_3_reset; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_3_io_in_a_Re; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_3_io_in_a_Im; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_3_io_in_b_Re; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_3_io_in_b_Im; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_3_io_out_s_Re; // @[FPComplex.scala 1129:44]
  wire [31:0] FPComplexMult_v2_19_3_io_out_s_Im; // @[FPComplex.scala 1129:44]
  wire  FPComplexAdder_v2_19_clock; // @[FPComplex.scala 1136:17]
  wire  FPComplexAdder_v2_19_reset; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_io_in_a_Re; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_io_in_a_Im; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_io_in_b_Re; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_io_in_b_Im; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_io_out_s_Re; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_io_out_s_Im; // @[FPComplex.scala 1136:17]
  wire  FPComplexAdder_v2_19_1_clock; // @[FPComplex.scala 1136:17]
  wire  FPComplexAdder_v2_19_1_reset; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_1_io_in_a_Re; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_1_io_in_a_Im; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_1_io_in_b_Re; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_1_io_in_b_Im; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_1_io_out_s_Re; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_1_io_out_s_Im; // @[FPComplex.scala 1136:17]
  wire  FPComplexAdder_v2_19_2_clock; // @[FPComplex.scala 1136:17]
  wire  FPComplexAdder_v2_19_2_reset; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_2_io_in_a_Re; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_2_io_in_a_Im; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_2_io_in_b_Re; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_2_io_in_b_Im; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_2_io_out_s_Re; // @[FPComplex.scala 1136:17]
  wire [31:0] FPComplexAdder_v2_19_2_io_out_s_Im; // @[FPComplex.scala 1136:17]
  reg [31:0] io_out_s_REG_Re; // @[FPComplex.scala 1185:26]
  reg [31:0] io_out_s_REG_Im; // @[FPComplex.scala 1185:26]
  FPComplexMult_v2_19 FPComplexMult_v2_19 ( // @[FPComplex.scala 1129:44]
    .clock(FPComplexMult_v2_19_clock),
    .reset(FPComplexMult_v2_19_reset),
    .io_in_a_Re(FPComplexMult_v2_19_io_in_a_Re),
    .io_in_a_Im(FPComplexMult_v2_19_io_in_a_Im),
    .io_in_b_Re(FPComplexMult_v2_19_io_in_b_Re),
    .io_in_b_Im(FPComplexMult_v2_19_io_in_b_Im),
    .io_out_s_Re(FPComplexMult_v2_19_io_out_s_Re),
    .io_out_s_Im(FPComplexMult_v2_19_io_out_s_Im)
  );
  FPComplexMult_v2_19 FPComplexMult_v2_19_1 ( // @[FPComplex.scala 1129:44]
    .clock(FPComplexMult_v2_19_1_clock),
    .reset(FPComplexMult_v2_19_1_reset),
    .io_in_a_Re(FPComplexMult_v2_19_1_io_in_a_Re),
    .io_in_a_Im(FPComplexMult_v2_19_1_io_in_a_Im),
    .io_in_b_Re(FPComplexMult_v2_19_1_io_in_b_Re),
    .io_in_b_Im(FPComplexMult_v2_19_1_io_in_b_Im),
    .io_out_s_Re(FPComplexMult_v2_19_1_io_out_s_Re),
    .io_out_s_Im(FPComplexMult_v2_19_1_io_out_s_Im)
  );
  FPComplexMult_v2_19 FPComplexMult_v2_19_2 ( // @[FPComplex.scala 1129:44]
    .clock(FPComplexMult_v2_19_2_clock),
    .reset(FPComplexMult_v2_19_2_reset),
    .io_in_a_Re(FPComplexMult_v2_19_2_io_in_a_Re),
    .io_in_a_Im(FPComplexMult_v2_19_2_io_in_a_Im),
    .io_in_b_Re(FPComplexMult_v2_19_2_io_in_b_Re),
    .io_in_b_Im(FPComplexMult_v2_19_2_io_in_b_Im),
    .io_out_s_Re(FPComplexMult_v2_19_2_io_out_s_Re),
    .io_out_s_Im(FPComplexMult_v2_19_2_io_out_s_Im)
  );
  FPComplexMult_v2_19 FPComplexMult_v2_19_3 ( // @[FPComplex.scala 1129:44]
    .clock(FPComplexMult_v2_19_3_clock),
    .reset(FPComplexMult_v2_19_3_reset),
    .io_in_a_Re(FPComplexMult_v2_19_3_io_in_a_Re),
    .io_in_a_Im(FPComplexMult_v2_19_3_io_in_a_Im),
    .io_in_b_Re(FPComplexMult_v2_19_3_io_in_b_Re),
    .io_in_b_Im(FPComplexMult_v2_19_3_io_in_b_Im),
    .io_out_s_Re(FPComplexMult_v2_19_3_io_out_s_Re),
    .io_out_s_Im(FPComplexMult_v2_19_3_io_out_s_Im)
  );
  FPComplexAdder_v2_19 FPComplexAdder_v2_19 ( // @[FPComplex.scala 1136:17]
    .clock(FPComplexAdder_v2_19_clock),
    .reset(FPComplexAdder_v2_19_reset),
    .io_in_a_Re(FPComplexAdder_v2_19_io_in_a_Re),
    .io_in_a_Im(FPComplexAdder_v2_19_io_in_a_Im),
    .io_in_b_Re(FPComplexAdder_v2_19_io_in_b_Re),
    .io_in_b_Im(FPComplexAdder_v2_19_io_in_b_Im),
    .io_out_s_Re(FPComplexAdder_v2_19_io_out_s_Re),
    .io_out_s_Im(FPComplexAdder_v2_19_io_out_s_Im)
  );
  FPComplexAdder_v2_19 FPComplexAdder_v2_19_1 ( // @[FPComplex.scala 1136:17]
    .clock(FPComplexAdder_v2_19_1_clock),
    .reset(FPComplexAdder_v2_19_1_reset),
    .io_in_a_Re(FPComplexAdder_v2_19_1_io_in_a_Re),
    .io_in_a_Im(FPComplexAdder_v2_19_1_io_in_a_Im),
    .io_in_b_Re(FPComplexAdder_v2_19_1_io_in_b_Re),
    .io_in_b_Im(FPComplexAdder_v2_19_1_io_in_b_Im),
    .io_out_s_Re(FPComplexAdder_v2_19_1_io_out_s_Re),
    .io_out_s_Im(FPComplexAdder_v2_19_1_io_out_s_Im)
  );
  FPComplexAdder_v2_19 FPComplexAdder_v2_19_2 ( // @[FPComplex.scala 1136:17]
    .clock(FPComplexAdder_v2_19_2_clock),
    .reset(FPComplexAdder_v2_19_2_reset),
    .io_in_a_Re(FPComplexAdder_v2_19_2_io_in_a_Re),
    .io_in_a_Im(FPComplexAdder_v2_19_2_io_in_a_Im),
    .io_in_b_Re(FPComplexAdder_v2_19_2_io_in_b_Re),
    .io_in_b_Im(FPComplexAdder_v2_19_2_io_in_b_Im),
    .io_out_s_Re(FPComplexAdder_v2_19_2_io_out_s_Re),
    .io_out_s_Im(FPComplexAdder_v2_19_2_io_out_s_Im)
  );
  assign io_out_s_Re = io_out_s_REG_Re; // @[FPComplex.scala 1185:16]
  assign io_out_s_Im = io_out_s_REG_Im; // @[FPComplex.scala 1185:16]
  assign FPComplexMult_v2_19_clock = clock;
  assign FPComplexMult_v2_19_reset = reset;
  assign FPComplexMult_v2_19_io_in_a_Re = io_in_a_0_Re; // @[FPComplex.scala 1130:47]
  assign FPComplexMult_v2_19_io_in_a_Im = io_in_a_0_Im; // @[FPComplex.scala 1130:47]
  assign FPComplexMult_v2_19_io_in_b_Re = io_in_b_0_Re; // @[FPComplex.scala 1131:47]
  assign FPComplexMult_v2_19_io_in_b_Im = io_in_b_0_Im; // @[FPComplex.scala 1131:47]
  assign FPComplexMult_v2_19_1_clock = clock;
  assign FPComplexMult_v2_19_1_reset = reset;
  assign FPComplexMult_v2_19_1_io_in_a_Re = io_in_a_1_Re; // @[FPComplex.scala 1130:47]
  assign FPComplexMult_v2_19_1_io_in_a_Im = io_in_a_1_Im; // @[FPComplex.scala 1130:47]
  assign FPComplexMult_v2_19_1_io_in_b_Re = io_in_b_1_Re; // @[FPComplex.scala 1131:47]
  assign FPComplexMult_v2_19_1_io_in_b_Im = io_in_b_1_Im; // @[FPComplex.scala 1131:47]
  assign FPComplexMult_v2_19_2_clock = clock;
  assign FPComplexMult_v2_19_2_reset = reset;
  assign FPComplexMult_v2_19_2_io_in_a_Re = io_in_a_2_Re; // @[FPComplex.scala 1130:47]
  assign FPComplexMult_v2_19_2_io_in_a_Im = io_in_a_2_Im; // @[FPComplex.scala 1130:47]
  assign FPComplexMult_v2_19_2_io_in_b_Re = io_in_b_2_Re; // @[FPComplex.scala 1131:47]
  assign FPComplexMult_v2_19_2_io_in_b_Im = io_in_b_2_Im; // @[FPComplex.scala 1131:47]
  assign FPComplexMult_v2_19_3_clock = clock;
  assign FPComplexMult_v2_19_3_reset = reset;
  assign FPComplexMult_v2_19_3_io_in_a_Re = io_in_a_3_Re; // @[FPComplex.scala 1130:47]
  assign FPComplexMult_v2_19_3_io_in_a_Im = io_in_a_3_Im; // @[FPComplex.scala 1130:47]
  assign FPComplexMult_v2_19_3_io_in_b_Re = io_in_b_3_Re; // @[FPComplex.scala 1131:47]
  assign FPComplexMult_v2_19_3_io_in_b_Im = io_in_b_3_Im; // @[FPComplex.scala 1131:47]
  assign FPComplexAdder_v2_19_clock = clock;
  assign FPComplexAdder_v2_19_reset = reset;
  assign FPComplexAdder_v2_19_io_in_a_Re = FPComplexMult_v2_19_io_out_s_Re; // @[FPComplex.scala 1167:43]
  assign FPComplexAdder_v2_19_io_in_a_Im = FPComplexMult_v2_19_io_out_s_Im; // @[FPComplex.scala 1167:43]
  assign FPComplexAdder_v2_19_io_in_b_Re = FPComplexMult_v2_19_1_io_out_s_Re; // @[FPComplex.scala 1168:43]
  assign FPComplexAdder_v2_19_io_in_b_Im = FPComplexMult_v2_19_1_io_out_s_Im; // @[FPComplex.scala 1168:43]
  assign FPComplexAdder_v2_19_1_clock = clock;
  assign FPComplexAdder_v2_19_1_reset = reset;
  assign FPComplexAdder_v2_19_1_io_in_a_Re = FPComplexMult_v2_19_2_io_out_s_Re; // @[FPComplex.scala 1167:43]
  assign FPComplexAdder_v2_19_1_io_in_a_Im = FPComplexMult_v2_19_2_io_out_s_Im; // @[FPComplex.scala 1167:43]
  assign FPComplexAdder_v2_19_1_io_in_b_Re = FPComplexMult_v2_19_3_io_out_s_Re; // @[FPComplex.scala 1168:43]
  assign FPComplexAdder_v2_19_1_io_in_b_Im = FPComplexMult_v2_19_3_io_out_s_Im; // @[FPComplex.scala 1168:43]
  assign FPComplexAdder_v2_19_2_clock = clock;
  assign FPComplexAdder_v2_19_2_reset = reset;
  assign FPComplexAdder_v2_19_2_io_in_a_Re = FPComplexAdder_v2_19_io_out_s_Re; // @[FPComplex.scala 1167:43]
  assign FPComplexAdder_v2_19_2_io_in_a_Im = FPComplexAdder_v2_19_io_out_s_Im; // @[FPComplex.scala 1167:43]
  assign FPComplexAdder_v2_19_2_io_in_b_Re = FPComplexAdder_v2_19_1_io_out_s_Re; // @[FPComplex.scala 1168:43]
  assign FPComplexAdder_v2_19_2_io_in_b_Im = FPComplexAdder_v2_19_1_io_out_s_Im; // @[FPComplex.scala 1168:43]
  always @(posedge clock) begin
    io_out_s_REG_Re <= FPComplexAdder_v2_19_2_io_out_s_Re; // @[FPComplex.scala 1185:26]
    io_out_s_REG_Im <= FPComplexAdder_v2_19_2_io_out_s_Im; // @[FPComplex.scala 1185:26]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_out_s_REG_Re = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  io_out_s_REG_Im = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FP_square_root_newfpu_19(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
  output [31:0] io_out_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_135;
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
  reg [31:0] _RAND_139;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
  reg [31:0] _RAND_144;
  reg [31:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_153;
  reg [31:0] _RAND_154;
  reg [31:0] _RAND_155;
  reg [31:0] _RAND_156;
  reg [31:0] _RAND_157;
  reg [31:0] _RAND_158;
  reg [31:0] _RAND_159;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_163;
  reg [31:0] _RAND_164;
  reg [31:0] _RAND_165;
  reg [31:0] _RAND_166;
  reg [31:0] _RAND_167;
  reg [31:0] _RAND_168;
  reg [31:0] _RAND_169;
  reg [31:0] _RAND_170;
  reg [31:0] _RAND_171;
  reg [31:0] _RAND_172;
  reg [31:0] _RAND_173;
  reg [31:0] _RAND_174;
  reg [31:0] _RAND_175;
  reg [31:0] _RAND_176;
  reg [31:0] _RAND_177;
  reg [31:0] _RAND_178;
  reg [31:0] _RAND_179;
  reg [31:0] _RAND_180;
  reg [31:0] _RAND_181;
  reg [31:0] _RAND_182;
  reg [31:0] _RAND_183;
  reg [31:0] _RAND_184;
  reg [31:0] _RAND_185;
  reg [31:0] _RAND_186;
  reg [31:0] _RAND_187;
  reg [31:0] _RAND_188;
  reg [31:0] _RAND_189;
  reg [31:0] _RAND_190;
  reg [31:0] _RAND_191;
  reg [31:0] _RAND_192;
  reg [31:0] _RAND_193;
  reg [31:0] _RAND_194;
  reg [31:0] _RAND_195;
  reg [31:0] _RAND_196;
  reg [31:0] _RAND_197;
  reg [31:0] _RAND_198;
  reg [31:0] _RAND_199;
  reg [31:0] _RAND_200;
  reg [31:0] _RAND_201;
  reg [31:0] _RAND_202;
  reg [31:0] _RAND_203;
  reg [31:0] _RAND_204;
  reg [31:0] _RAND_205;
  reg [31:0] _RAND_206;
  reg [31:0] _RAND_207;
  reg [31:0] _RAND_208;
  reg [31:0] _RAND_209;
  reg [31:0] _RAND_210;
  reg [31:0] _RAND_211;
  reg [31:0] _RAND_212;
  reg [31:0] _RAND_213;
  reg [31:0] _RAND_214;
  reg [31:0] _RAND_215;
  reg [31:0] _RAND_216;
  reg [31:0] _RAND_217;
  reg [31:0] _RAND_218;
  reg [31:0] _RAND_219;
  reg [31:0] _RAND_220;
  reg [31:0] _RAND_221;
  reg [31:0] _RAND_222;
  reg [31:0] _RAND_223;
  reg [31:0] _RAND_224;
  reg [31:0] _RAND_225;
  reg [31:0] _RAND_226;
  reg [31:0] _RAND_227;
`endif // RANDOMIZE_REG_INIT
  wire  FP_multiplier_10ccs_19_clock; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_reset; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_io_in_en; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_io_in_a; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_io_in_b; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_io_out_s; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_1_clock; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_1_reset; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_1_io_in_en; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_1_io_in_a; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_1_io_in_b; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_1_io_out_s; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_2_clock; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_2_reset; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_2_io_in_en; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_2_io_in_a; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_2_io_in_b; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_2_io_out_s; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_3_clock; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_3_reset; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_3_io_in_en; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_3_io_in_a; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_3_io_in_b; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_3_io_out_s; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_4_clock; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_4_reset; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_4_io_in_en; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_4_io_in_a; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_4_io_in_b; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_4_io_out_s; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_5_clock; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_5_reset; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_5_io_in_en; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_5_io_in_a; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_5_io_in_b; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_5_io_out_s; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_6_clock; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_6_reset; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_6_io_in_en; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_6_io_in_a; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_6_io_in_b; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_6_io_out_s; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_7_clock; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_7_reset; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_7_io_in_en; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_7_io_in_a; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_7_io_in_b; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_7_io_out_s; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_8_clock; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_8_reset; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_multiplier_10ccs_19_8_io_in_en; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_8_io_in_a; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_8_io_in_b; // @[FloatingPointDesigns.scala 1881:65]
  wire [31:0] FP_multiplier_10ccs_19_8_io_out_s; // @[FloatingPointDesigns.scala 1881:65]
  wire  FP_subtractor_13ccs_19_clock; // @[FloatingPointDesigns.scala 1882:50]
  wire  FP_subtractor_13ccs_19_reset; // @[FloatingPointDesigns.scala 1882:50]
  wire  FP_subtractor_13ccs_19_io_in_en; // @[FloatingPointDesigns.scala 1882:50]
  wire [31:0] FP_subtractor_13ccs_19_io_in_a; // @[FloatingPointDesigns.scala 1882:50]
  wire [31:0] FP_subtractor_13ccs_19_io_in_b; // @[FloatingPointDesigns.scala 1882:50]
  wire [31:0] FP_subtractor_13ccs_19_io_out_s; // @[FloatingPointDesigns.scala 1882:50]
  wire  FP_subtractor_13ccs_19_1_clock; // @[FloatingPointDesigns.scala 1882:50]
  wire  FP_subtractor_13ccs_19_1_reset; // @[FloatingPointDesigns.scala 1882:50]
  wire  FP_subtractor_13ccs_19_1_io_in_en; // @[FloatingPointDesigns.scala 1882:50]
  wire [31:0] FP_subtractor_13ccs_19_1_io_in_a; // @[FloatingPointDesigns.scala 1882:50]
  wire [31:0] FP_subtractor_13ccs_19_1_io_in_b; // @[FloatingPointDesigns.scala 1882:50]
  wire [31:0] FP_subtractor_13ccs_19_1_io_out_s; // @[FloatingPointDesigns.scala 1882:50]
  wire  FP_subtractor_13ccs_19_2_clock; // @[FloatingPointDesigns.scala 1882:50]
  wire  FP_subtractor_13ccs_19_2_reset; // @[FloatingPointDesigns.scala 1882:50]
  wire  FP_subtractor_13ccs_19_2_io_in_en; // @[FloatingPointDesigns.scala 1882:50]
  wire [31:0] FP_subtractor_13ccs_19_2_io_in_a; // @[FloatingPointDesigns.scala 1882:50]
  wire [31:0] FP_subtractor_13ccs_19_2_io_in_b; // @[FloatingPointDesigns.scala 1882:50]
  wire [31:0] FP_subtractor_13ccs_19_2_io_out_s; // @[FloatingPointDesigns.scala 1882:50]
  wire  multiplier4_clock; // @[FloatingPointDesigns.scala 1950:29]
  wire  multiplier4_reset; // @[FloatingPointDesigns.scala 1950:29]
  wire  multiplier4_io_in_en; // @[FloatingPointDesigns.scala 1950:29]
  wire [31:0] multiplier4_io_in_a; // @[FloatingPointDesigns.scala 1950:29]
  wire [31:0] multiplier4_io_in_b; // @[FloatingPointDesigns.scala 1950:29]
  wire [31:0] multiplier4_io_out_s; // @[FloatingPointDesigns.scala 1950:29]
  wire [30:0] _number_T_1 = {{1'd0}, io_in_a[30:1]}; // @[FloatingPointDesigns.scala 1865:36]
  wire [30:0] _GEN_0 = io_in_a[30:0] > 31'h7ef477d4 ? 31'h3f7a3bea : _number_T_1; // @[FloatingPointDesigns.scala 1862:46 1863:14 1865:14]
  wire [31:0] number = {{1'd0}, _GEN_0}; // @[FloatingPointDesigns.scala 1859:22]
  wire [31:0] result = 32'h5f3759df - number; // @[FloatingPointDesigns.scala 1872:25]
  reg [31:0] x_n_0; // @[FloatingPointDesigns.scala 1874:22]
  reg [31:0] x_n_1; // @[FloatingPointDesigns.scala 1874:22]
  reg [31:0] x_n_2; // @[FloatingPointDesigns.scala 1874:22]
  reg [31:0] x_n_4; // @[FloatingPointDesigns.scala 1874:22]
  reg [31:0] x_n_5; // @[FloatingPointDesigns.scala 1874:22]
  reg [31:0] x_n_6; // @[FloatingPointDesigns.scala 1874:22]
  reg [31:0] x_n_8; // @[FloatingPointDesigns.scala 1874:22]
  reg [31:0] x_n_9; // @[FloatingPointDesigns.scala 1874:22]
  reg [31:0] x_n_10; // @[FloatingPointDesigns.scala 1874:22]
  reg [31:0] a_2_0; // @[FloatingPointDesigns.scala 1875:22]
  reg [31:0] a_2_1; // @[FloatingPointDesigns.scala 1875:22]
  reg [31:0] a_2_2; // @[FloatingPointDesigns.scala 1875:22]
  reg [31:0] a_2_3; // @[FloatingPointDesigns.scala 1875:22]
  reg [31:0] a_2_4; // @[FloatingPointDesigns.scala 1875:22]
  reg [31:0] a_2_5; // @[FloatingPointDesigns.scala 1875:22]
  reg [31:0] a_2_6; // @[FloatingPointDesigns.scala 1875:22]
  reg [31:0] a_2_7; // @[FloatingPointDesigns.scala 1875:22]
  reg [31:0] a_2_8; // @[FloatingPointDesigns.scala 1875:22]
  reg [31:0] a_2_9; // @[FloatingPointDesigns.scala 1875:22]
  reg [31:0] a_2_10; // @[FloatingPointDesigns.scala 1875:22]
  reg [31:0] a_2_11; // @[FloatingPointDesigns.scala 1875:22]
  reg [31:0] stage1_regs_0_0_0; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_0_1; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_0_2; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_0_3; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_0_4; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_0_5; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_0_6; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_0_7; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_0_8; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_1_0; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_1_1; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_1_2; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_1_3; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_1_4; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_1_5; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_1_6; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_1_7; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_0_1_8; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_0_0; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_0_1; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_0_2; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_0_3; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_0_4; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_0_5; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_0_6; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_0_7; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_0_8; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_1_0; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_1_1; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_1_2; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_1_3; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_1_4; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_1_5; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_1_6; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_1_7; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_1_1_8; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_0_0; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_0_1; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_0_2; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_0_3; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_0_4; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_0_5; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_0_6; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_0_7; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_0_8; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_1_0; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_1_1; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_1_2; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_1_3; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_1_4; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_1_5; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_1_6; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_1_7; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage1_regs_2_1_8; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage2_regs_0_0_0; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_0_1; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_0_2; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_0_3; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_0_4; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_0_5; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_0_6; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_0_7; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_0_8; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_1_0; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_1_1; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_1_2; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_1_3; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_1_4; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_1_5; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_1_6; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_1_7; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_0_1_8; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_0_0; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_0_1; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_0_2; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_0_3; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_0_4; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_0_5; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_0_6; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_0_7; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_0_8; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_1_0; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_1_1; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_1_2; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_1_3; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_1_4; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_1_5; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_1_6; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_1_7; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_1_1_8; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_0_0; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_0_1; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_0_2; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_0_3; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_0_4; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_0_5; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_0_6; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_0_7; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_0_8; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_1_0; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_1_1; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_1_2; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_1_3; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_1_4; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_1_5; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_1_6; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_1_7; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage2_regs_2_1_8; // @[FloatingPointDesigns.scala 1877:30]
  reg [31:0] stage3_regs_0_0_0; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_0_1; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_0_2; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_0_3; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_0_4; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_0_5; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_0_6; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_0_7; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_0_8; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_0_9; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_0_10; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_0_11; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_1_0; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_1_1; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_1_2; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_1_3; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_1_4; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_1_5; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_1_6; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_1_7; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_1_8; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_1_9; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_1_10; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_0_1_11; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_0_0; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_0_1; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_0_2; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_0_3; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_0_4; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_0_5; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_0_6; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_0_7; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_0_8; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_0_9; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_0_10; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_0_11; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_1_0; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_1_1; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_1_2; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_1_3; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_1_4; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_1_5; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_1_6; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_1_7; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_1_8; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_1_9; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_1_10; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_1_1_11; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_0_0; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_0_1; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_0_2; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_0_3; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_0_4; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_0_5; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_0_6; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_0_7; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_0_8; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_0_9; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_0_10; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_0_11; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_1_0; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_1_1; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_1_2; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_1_3; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_1_4; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_1_5; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_1_6; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_1_7; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_1_8; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_1_9; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_1_10; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage3_regs_2_1_11; // @[FloatingPointDesigns.scala 1878:30]
  reg [31:0] stage4_regs_0_1_0; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_0_1_1; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_0_1_2; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_0_1_3; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_0_1_4; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_0_1_5; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_0_1_6; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_0_1_7; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_0_1_8; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_1_1_0; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_1_1_1; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_1_1_2; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_1_1_3; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_1_1_4; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_1_1_5; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_1_1_6; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_1_1_7; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_1_1_8; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_2_1_0; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_2_1_1; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_2_1_2; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_2_1_3; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_2_1_4; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_2_1_5; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_2_1_6; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_2_1_7; // @[FloatingPointDesigns.scala 1879:30]
  reg [31:0] stage4_regs_2_1_8; // @[FloatingPointDesigns.scala 1879:30]
  wire [7:0] _a_2_0_T_3 = io_in_a[30:23] - 8'h1; // @[FloatingPointDesigns.scala 1904:75]
  wire [31:0] _a_2_0_T_6 = {io_in_a[31],_a_2_0_T_3,io_in_a[22:0]}; // @[FloatingPointDesigns.scala 1904:82]
  wire [31:0] _GEN_139 = FP_multiplier_10ccs_19_2_io_out_s; // @[FloatingPointDesigns.scala 1874:22 1911:28 1912:26]
  wire [31:0] _GEN_215 = FP_multiplier_10ccs_19_5_io_out_s; // @[FloatingPointDesigns.scala 1874:22 1911:28 1912:26]
  wire [7:0] _restore_a_T_3 = stage4_regs_2_1_8[30:23] + 8'h1; // @[FloatingPointDesigns.scala 1949:106]
  wire [8:0] _restore_a_T_4 = {stage4_regs_2_1_8[31],_restore_a_T_3}; // @[FloatingPointDesigns.scala 1949:55]
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19 ( // @[FloatingPointDesigns.scala 1881:65]
    .clock(FP_multiplier_10ccs_19_clock),
    .reset(FP_multiplier_10ccs_19_reset),
    .io_in_en(FP_multiplier_10ccs_19_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_1 ( // @[FloatingPointDesigns.scala 1881:65]
    .clock(FP_multiplier_10ccs_19_1_clock),
    .reset(FP_multiplier_10ccs_19_1_reset),
    .io_in_en(FP_multiplier_10ccs_19_1_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_1_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_1_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_1_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_2 ( // @[FloatingPointDesigns.scala 1881:65]
    .clock(FP_multiplier_10ccs_19_2_clock),
    .reset(FP_multiplier_10ccs_19_2_reset),
    .io_in_en(FP_multiplier_10ccs_19_2_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_2_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_2_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_2_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_3 ( // @[FloatingPointDesigns.scala 1881:65]
    .clock(FP_multiplier_10ccs_19_3_clock),
    .reset(FP_multiplier_10ccs_19_3_reset),
    .io_in_en(FP_multiplier_10ccs_19_3_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_3_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_3_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_3_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_4 ( // @[FloatingPointDesigns.scala 1881:65]
    .clock(FP_multiplier_10ccs_19_4_clock),
    .reset(FP_multiplier_10ccs_19_4_reset),
    .io_in_en(FP_multiplier_10ccs_19_4_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_4_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_4_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_4_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_5 ( // @[FloatingPointDesigns.scala 1881:65]
    .clock(FP_multiplier_10ccs_19_5_clock),
    .reset(FP_multiplier_10ccs_19_5_reset),
    .io_in_en(FP_multiplier_10ccs_19_5_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_5_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_5_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_5_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_6 ( // @[FloatingPointDesigns.scala 1881:65]
    .clock(FP_multiplier_10ccs_19_6_clock),
    .reset(FP_multiplier_10ccs_19_6_reset),
    .io_in_en(FP_multiplier_10ccs_19_6_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_6_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_6_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_6_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_7 ( // @[FloatingPointDesigns.scala 1881:65]
    .clock(FP_multiplier_10ccs_19_7_clock),
    .reset(FP_multiplier_10ccs_19_7_reset),
    .io_in_en(FP_multiplier_10ccs_19_7_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_7_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_7_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_7_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_8 ( // @[FloatingPointDesigns.scala 1881:65]
    .clock(FP_multiplier_10ccs_19_8_clock),
    .reset(FP_multiplier_10ccs_19_8_reset),
    .io_in_en(FP_multiplier_10ccs_19_8_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_8_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_8_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_8_io_out_s)
  );
  FP_subtractor_13ccs_19 FP_subtractor_13ccs_19 ( // @[FloatingPointDesigns.scala 1882:50]
    .clock(FP_subtractor_13ccs_19_clock),
    .reset(FP_subtractor_13ccs_19_reset),
    .io_in_en(FP_subtractor_13ccs_19_io_in_en),
    .io_in_a(FP_subtractor_13ccs_19_io_in_a),
    .io_in_b(FP_subtractor_13ccs_19_io_in_b),
    .io_out_s(FP_subtractor_13ccs_19_io_out_s)
  );
  FP_subtractor_13ccs_19 FP_subtractor_13ccs_19_1 ( // @[FloatingPointDesigns.scala 1882:50]
    .clock(FP_subtractor_13ccs_19_1_clock),
    .reset(FP_subtractor_13ccs_19_1_reset),
    .io_in_en(FP_subtractor_13ccs_19_1_io_in_en),
    .io_in_a(FP_subtractor_13ccs_19_1_io_in_a),
    .io_in_b(FP_subtractor_13ccs_19_1_io_in_b),
    .io_out_s(FP_subtractor_13ccs_19_1_io_out_s)
  );
  FP_subtractor_13ccs_19 FP_subtractor_13ccs_19_2 ( // @[FloatingPointDesigns.scala 1882:50]
    .clock(FP_subtractor_13ccs_19_2_clock),
    .reset(FP_subtractor_13ccs_19_2_reset),
    .io_in_en(FP_subtractor_13ccs_19_2_io_in_en),
    .io_in_a(FP_subtractor_13ccs_19_2_io_in_a),
    .io_in_b(FP_subtractor_13ccs_19_2_io_in_b),
    .io_out_s(FP_subtractor_13ccs_19_2_io_out_s)
  );
  FP_multiplier_10ccs_19 multiplier4 ( // @[FloatingPointDesigns.scala 1950:29]
    .clock(multiplier4_clock),
    .reset(multiplier4_reset),
    .io_in_en(multiplier4_io_in_en),
    .io_in_a(multiplier4_io_in_a),
    .io_in_b(multiplier4_io_in_b),
    .io_out_s(multiplier4_io_out_s)
  );
  assign io_out_s = {{1'd0}, multiplier4_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 1954:14]
  assign FP_multiplier_10ccs_19_clock = clock;
  assign FP_multiplier_10ccs_19_reset = reset;
  assign FP_multiplier_10ccs_19_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1883:41]
  assign FP_multiplier_10ccs_19_io_in_a = {1'h0,result[30:0]}; // @[FloatingPointDesigns.scala 1908:48]
  assign FP_multiplier_10ccs_19_io_in_b = {1'h0,result[30:0]}; // @[FloatingPointDesigns.scala 1909:48]
  assign FP_multiplier_10ccs_19_1_clock = clock;
  assign FP_multiplier_10ccs_19_1_reset = reset;
  assign FP_multiplier_10ccs_19_1_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1883:41]
  assign FP_multiplier_10ccs_19_1_io_in_a = FP_multiplier_10ccs_19_io_out_s; // @[FloatingPointDesigns.scala 1921:34]
  assign FP_multiplier_10ccs_19_1_io_in_b = {1'h0,stage1_regs_0_1_8[30:0]}; // @[FloatingPointDesigns.scala 1922:46]
  assign FP_multiplier_10ccs_19_2_clock = clock;
  assign FP_multiplier_10ccs_19_2_reset = reset;
  assign FP_multiplier_10ccs_19_2_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1883:41]
  assign FP_multiplier_10ccs_19_2_io_in_a = {1'h0,stage3_regs_0_0_11[30:0]}; // @[FloatingPointDesigns.scala 1939:46]
  assign FP_multiplier_10ccs_19_2_io_in_b = FP_subtractor_13ccs_19_io_out_s; // @[FloatingPointDesigns.scala 1940:34]
  assign FP_multiplier_10ccs_19_3_clock = clock;
  assign FP_multiplier_10ccs_19_3_reset = reset;
  assign FP_multiplier_10ccs_19_3_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1883:41]
  assign FP_multiplier_10ccs_19_3_io_in_a = {1'h0,FP_multiplier_10ccs_19_2_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 1917:48]
  assign FP_multiplier_10ccs_19_3_io_in_b = {1'h0,FP_multiplier_10ccs_19_2_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 1918:48]
  assign FP_multiplier_10ccs_19_4_clock = clock;
  assign FP_multiplier_10ccs_19_4_reset = reset;
  assign FP_multiplier_10ccs_19_4_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1883:41]
  assign FP_multiplier_10ccs_19_4_io_in_a = FP_multiplier_10ccs_19_3_io_out_s; // @[FloatingPointDesigns.scala 1921:34]
  assign FP_multiplier_10ccs_19_4_io_in_b = {1'h0,stage1_regs_1_1_8[30:0]}; // @[FloatingPointDesigns.scala 1922:46]
  assign FP_multiplier_10ccs_19_5_clock = clock;
  assign FP_multiplier_10ccs_19_5_reset = reset;
  assign FP_multiplier_10ccs_19_5_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1883:41]
  assign FP_multiplier_10ccs_19_5_io_in_a = {1'h0,stage3_regs_1_0_11[30:0]}; // @[FloatingPointDesigns.scala 1939:46]
  assign FP_multiplier_10ccs_19_5_io_in_b = FP_subtractor_13ccs_19_1_io_out_s; // @[FloatingPointDesigns.scala 1940:34]
  assign FP_multiplier_10ccs_19_6_clock = clock;
  assign FP_multiplier_10ccs_19_6_reset = reset;
  assign FP_multiplier_10ccs_19_6_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1883:41]
  assign FP_multiplier_10ccs_19_6_io_in_a = {1'h0,FP_multiplier_10ccs_19_5_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 1917:48]
  assign FP_multiplier_10ccs_19_6_io_in_b = {1'h0,FP_multiplier_10ccs_19_5_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 1918:48]
  assign FP_multiplier_10ccs_19_7_clock = clock;
  assign FP_multiplier_10ccs_19_7_reset = reset;
  assign FP_multiplier_10ccs_19_7_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1883:41]
  assign FP_multiplier_10ccs_19_7_io_in_a = FP_multiplier_10ccs_19_6_io_out_s; // @[FloatingPointDesigns.scala 1921:34]
  assign FP_multiplier_10ccs_19_7_io_in_b = {1'h0,stage1_regs_2_1_8[30:0]}; // @[FloatingPointDesigns.scala 1922:46]
  assign FP_multiplier_10ccs_19_8_clock = clock;
  assign FP_multiplier_10ccs_19_8_reset = reset;
  assign FP_multiplier_10ccs_19_8_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1883:41]
  assign FP_multiplier_10ccs_19_8_io_in_a = {1'h0,stage3_regs_2_0_11[30:0]}; // @[FloatingPointDesigns.scala 1939:46]
  assign FP_multiplier_10ccs_19_8_io_in_b = FP_subtractor_13ccs_19_2_io_out_s; // @[FloatingPointDesigns.scala 1940:34]
  assign FP_subtractor_13ccs_19_clock = clock;
  assign FP_subtractor_13ccs_19_reset = reset;
  assign FP_subtractor_13ccs_19_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1884:32]
  assign FP_subtractor_13ccs_19_io_in_a = 32'h3fc00000; // @[FloatingPointDesigns.scala 1860:26 1861:16]
  assign FP_subtractor_13ccs_19_io_in_b = FP_multiplier_10ccs_19_1_io_out_s; // @[FloatingPointDesigns.scala 1931:31]
  assign FP_subtractor_13ccs_19_1_clock = clock;
  assign FP_subtractor_13ccs_19_1_reset = reset;
  assign FP_subtractor_13ccs_19_1_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1884:32]
  assign FP_subtractor_13ccs_19_1_io_in_a = 32'h3fc00000; // @[FloatingPointDesigns.scala 1860:26 1861:16]
  assign FP_subtractor_13ccs_19_1_io_in_b = FP_multiplier_10ccs_19_4_io_out_s; // @[FloatingPointDesigns.scala 1931:31]
  assign FP_subtractor_13ccs_19_2_clock = clock;
  assign FP_subtractor_13ccs_19_2_reset = reset;
  assign FP_subtractor_13ccs_19_2_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1884:32]
  assign FP_subtractor_13ccs_19_2_io_in_a = 32'h3fc00000; // @[FloatingPointDesigns.scala 1860:26 1861:16]
  assign FP_subtractor_13ccs_19_2_io_in_b = FP_multiplier_10ccs_19_7_io_out_s; // @[FloatingPointDesigns.scala 1931:31]
  assign multiplier4_clock = clock;
  assign multiplier4_reset = reset;
  assign multiplier4_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 1951:26]
  assign multiplier4_io_in_a = {1'h0,FP_multiplier_10ccs_19_8_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 1952:37]
  assign multiplier4_io_in_b = {_restore_a_T_4,stage4_regs_2_1_8[22:0]}; // @[FloatingPointDesigns.scala 1949:113]
  always @(posedge clock) begin
    if (reset) begin // @[FloatingPointDesigns.scala 1874:22]
      x_n_0 <= 32'h0; // @[FloatingPointDesigns.scala 1874:22]
    end else begin
      x_n_0 <= result;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:22]
      x_n_1 <= 32'h0; // @[FloatingPointDesigns.scala 1874:22]
    end else begin
      x_n_1 <= stage1_regs_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:22]
      x_n_2 <= 32'h0; // @[FloatingPointDesigns.scala 1874:22]
    end else begin
      x_n_2 <= stage2_regs_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:22]
      x_n_4 <= 32'h0; // @[FloatingPointDesigns.scala 1874:22]
    end else begin
      x_n_4 <= _GEN_139;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:22]
      x_n_5 <= 32'h0; // @[FloatingPointDesigns.scala 1874:22]
    end else begin
      x_n_5 <= stage1_regs_1_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:22]
      x_n_6 <= 32'h0; // @[FloatingPointDesigns.scala 1874:22]
    end else begin
      x_n_6 <= stage2_regs_1_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:22]
      x_n_8 <= 32'h0; // @[FloatingPointDesigns.scala 1874:22]
    end else begin
      x_n_8 <= _GEN_215;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:22]
      x_n_9 <= 32'h0; // @[FloatingPointDesigns.scala 1874:22]
    end else begin
      x_n_9 <= stage1_regs_2_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:22]
      x_n_10 <= 32'h0; // @[FloatingPointDesigns.scala 1874:22]
    end else begin
      x_n_10 <= stage2_regs_2_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:22]
      a_2_0 <= 32'h0; // @[FloatingPointDesigns.scala 1875:22]
    end else begin
      a_2_0 <= _a_2_0_T_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:22]
      a_2_1 <= 32'h0; // @[FloatingPointDesigns.scala 1875:22]
    end else begin
      a_2_1 <= stage1_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:22]
      a_2_2 <= 32'h0; // @[FloatingPointDesigns.scala 1875:22]
    end else begin
      a_2_2 <= stage2_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:22]
      a_2_3 <= 32'h0; // @[FloatingPointDesigns.scala 1875:22]
    end else begin
      a_2_3 <= stage3_regs_0_1_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:22]
      a_2_4 <= 32'h0; // @[FloatingPointDesigns.scala 1875:22]
    end else begin
      a_2_4 <= stage4_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:22]
      a_2_5 <= 32'h0; // @[FloatingPointDesigns.scala 1875:22]
    end else begin
      a_2_5 <= stage1_regs_1_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:22]
      a_2_6 <= 32'h0; // @[FloatingPointDesigns.scala 1875:22]
    end else begin
      a_2_6 <= stage2_regs_1_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:22]
      a_2_7 <= 32'h0; // @[FloatingPointDesigns.scala 1875:22]
    end else begin
      a_2_7 <= stage3_regs_1_1_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:22]
      a_2_8 <= 32'h0; // @[FloatingPointDesigns.scala 1875:22]
    end else begin
      a_2_8 <= stage4_regs_1_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:22]
      a_2_9 <= 32'h0; // @[FloatingPointDesigns.scala 1875:22]
    end else begin
      a_2_9 <= stage1_regs_2_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:22]
      a_2_10 <= 32'h0; // @[FloatingPointDesigns.scala 1875:22]
    end else begin
      a_2_10 <= stage2_regs_2_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:22]
      a_2_11 <= 32'h0; // @[FloatingPointDesigns.scala 1875:22]
    end else begin
      a_2_11 <= stage3_regs_2_1_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_0_0 <= x_n_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_0_1 <= stage1_regs_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_0_2 <= stage1_regs_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_0_3 <= stage1_regs_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_0_4 <= stage1_regs_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_0_5 <= stage1_regs_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_0_6 <= stage1_regs_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_0_7 <= stage1_regs_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_0_8 <= stage1_regs_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_1_0 <= a_2_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_1_1 <= stage1_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_1_2 <= stage1_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_1_3 <= stage1_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_1_4 <= stage1_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_1_5 <= stage1_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_1_6 <= stage1_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_1_7 <= stage1_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_0_1_8 <= stage1_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_0_0 <= x_n_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_0_1 <= stage1_regs_1_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_0_2 <= stage1_regs_1_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_0_3 <= stage1_regs_1_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_0_4 <= stage1_regs_1_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_0_5 <= stage1_regs_1_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_0_6 <= stage1_regs_1_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_0_7 <= stage1_regs_1_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_0_8 <= stage1_regs_1_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_1_0 <= a_2_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_1_1 <= stage1_regs_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_1_2 <= stage1_regs_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_1_3 <= stage1_regs_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_1_4 <= stage1_regs_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_1_5 <= stage1_regs_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_1_6 <= stage1_regs_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_1_7 <= stage1_regs_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_1_1_8 <= stage1_regs_1_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_0_0 <= x_n_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_0_1 <= stage1_regs_2_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_0_2 <= stage1_regs_2_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_0_3 <= stage1_regs_2_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_0_4 <= stage1_regs_2_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_0_5 <= stage1_regs_2_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_0_6 <= stage1_regs_2_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_0_7 <= stage1_regs_2_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_0_8 <= stage1_regs_2_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_1_0 <= a_2_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_1_1 <= stage1_regs_2_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_1_2 <= stage1_regs_2_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_1_3 <= stage1_regs_2_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_1_4 <= stage1_regs_2_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_1_5 <= stage1_regs_2_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_1_6 <= stage1_regs_2_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_1_7 <= stage1_regs_2_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage1_regs_2_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage1_regs_2_1_8 <= stage1_regs_2_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_0_0 <= x_n_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_0_1 <= stage2_regs_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_0_2 <= stage2_regs_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_0_3 <= stage2_regs_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_0_4 <= stage2_regs_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_0_5 <= stage2_regs_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_0_6 <= stage2_regs_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_0_7 <= stage2_regs_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_0_8 <= stage2_regs_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_1_0 <= a_2_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_1_1 <= stage2_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_1_2 <= stage2_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_1_3 <= stage2_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_1_4 <= stage2_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_1_5 <= stage2_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_1_6 <= stage2_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_1_7 <= stage2_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_0_1_8 <= stage2_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_0_0 <= x_n_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_0_1 <= stage2_regs_1_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_0_2 <= stage2_regs_1_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_0_3 <= stage2_regs_1_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_0_4 <= stage2_regs_1_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_0_5 <= stage2_regs_1_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_0_6 <= stage2_regs_1_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_0_7 <= stage2_regs_1_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_0_8 <= stage2_regs_1_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_1_0 <= a_2_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_1_1 <= stage2_regs_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_1_2 <= stage2_regs_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_1_3 <= stage2_regs_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_1_4 <= stage2_regs_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_1_5 <= stage2_regs_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_1_6 <= stage2_regs_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_1_7 <= stage2_regs_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_1_1_8 <= stage2_regs_1_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_0_0 <= x_n_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_0_1 <= stage2_regs_2_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_0_2 <= stage2_regs_2_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_0_3 <= stage2_regs_2_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_0_4 <= stage2_regs_2_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_0_5 <= stage2_regs_2_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_0_6 <= stage2_regs_2_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_0_7 <= stage2_regs_2_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_0_8 <= stage2_regs_2_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_1_0 <= a_2_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_1_1 <= stage2_regs_2_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_1_2 <= stage2_regs_2_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_1_3 <= stage2_regs_2_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_1_4 <= stage2_regs_2_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_1_5 <= stage2_regs_2_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_1_6 <= stage2_regs_2_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_1_7 <= stage2_regs_2_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1877:30]
      stage2_regs_2_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1877:30]
    end else begin
      stage2_regs_2_1_8 <= stage2_regs_2_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_0_0 <= x_n_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_0_1 <= stage3_regs_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_0_2 <= stage3_regs_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_0_3 <= stage3_regs_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_0_4 <= stage3_regs_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_0_5 <= stage3_regs_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_0_6 <= stage3_regs_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_0_7 <= stage3_regs_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_0_8 <= stage3_regs_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_0_9 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_0_9 <= stage3_regs_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_0_10 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_0_10 <= stage3_regs_0_0_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_0_11 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_0_11 <= stage3_regs_0_0_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_1_0 <= a_2_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_1_1 <= stage3_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_1_2 <= stage3_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_1_3 <= stage3_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_1_4 <= stage3_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_1_5 <= stage3_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_1_6 <= stage3_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_1_7 <= stage3_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_1_8 <= stage3_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_1_9 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_1_9 <= stage3_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_1_10 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_1_10 <= stage3_regs_0_1_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_0_1_11 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_0_1_11 <= stage3_regs_0_1_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_0_0 <= x_n_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_0_1 <= stage3_regs_1_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_0_2 <= stage3_regs_1_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_0_3 <= stage3_regs_1_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_0_4 <= stage3_regs_1_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_0_5 <= stage3_regs_1_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_0_6 <= stage3_regs_1_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_0_7 <= stage3_regs_1_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_0_8 <= stage3_regs_1_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_0_9 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_0_9 <= stage3_regs_1_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_0_10 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_0_10 <= stage3_regs_1_0_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_0_11 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_0_11 <= stage3_regs_1_0_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_1_0 <= a_2_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_1_1 <= stage3_regs_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_1_2 <= stage3_regs_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_1_3 <= stage3_regs_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_1_4 <= stage3_regs_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_1_5 <= stage3_regs_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_1_6 <= stage3_regs_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_1_7 <= stage3_regs_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_1_8 <= stage3_regs_1_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_1_9 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_1_9 <= stage3_regs_1_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_1_10 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_1_10 <= stage3_regs_1_1_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_1_1_11 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_1_1_11 <= stage3_regs_1_1_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_0_0 <= x_n_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_0_1 <= stage3_regs_2_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_0_2 <= stage3_regs_2_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_0_3 <= stage3_regs_2_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_0_4 <= stage3_regs_2_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_0_5 <= stage3_regs_2_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_0_6 <= stage3_regs_2_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_0_7 <= stage3_regs_2_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_0_8 <= stage3_regs_2_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_0_9 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_0_9 <= stage3_regs_2_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_0_10 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_0_10 <= stage3_regs_2_0_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_0_11 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_0_11 <= stage3_regs_2_0_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_1_0 <= a_2_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_1_1 <= stage3_regs_2_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_1_2 <= stage3_regs_2_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_1_3 <= stage3_regs_2_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_1_4 <= stage3_regs_2_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_1_5 <= stage3_regs_2_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_1_6 <= stage3_regs_2_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_1_7 <= stage3_regs_2_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_1_8 <= stage3_regs_2_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_1_9 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_1_9 <= stage3_regs_2_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_1_10 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_1_10 <= stage3_regs_2_1_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1878:30]
      stage3_regs_2_1_11 <= 32'h0; // @[FloatingPointDesigns.scala 1878:30]
    end else begin
      stage3_regs_2_1_11 <= stage3_regs_2_1_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_0_1_0 <= a_2_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_0_1_1 <= stage4_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_0_1_2 <= stage4_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_0_1_3 <= stage4_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_0_1_4 <= stage4_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_0_1_5 <= stage4_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_0_1_6 <= stage4_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_0_1_7 <= stage4_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_0_1_8 <= stage4_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_1_1_0 <= a_2_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_1_1_1 <= stage4_regs_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_1_1_2 <= stage4_regs_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_1_1_3 <= stage4_regs_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_1_1_4 <= stage4_regs_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_1_1_5 <= stage4_regs_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_1_1_6 <= stage4_regs_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_1_1_7 <= stage4_regs_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_1_1_8 <= stage4_regs_1_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_2_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_2_1_0 <= a_2_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_2_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_2_1_1 <= stage4_regs_2_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_2_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_2_1_2 <= stage4_regs_2_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_2_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_2_1_3 <= stage4_regs_2_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_2_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_2_1_4 <= stage4_regs_2_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_2_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_2_1_5 <= stage4_regs_2_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_2_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_2_1_6 <= stage4_regs_2_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_2_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_2_1_7 <= stage4_regs_2_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1879:30]
      stage4_regs_2_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1879:30]
    end else begin
      stage4_regs_2_1_8 <= stage4_regs_2_1_7;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  x_n_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  x_n_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  x_n_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  x_n_4 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  x_n_5 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  x_n_6 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  x_n_8 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  x_n_9 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  x_n_10 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  a_2_0 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  a_2_1 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  a_2_2 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  a_2_3 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  a_2_4 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  a_2_5 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  a_2_6 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  a_2_7 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  a_2_8 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  a_2_9 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  a_2_10 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  a_2_11 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  stage1_regs_0_0_0 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  stage1_regs_0_0_1 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  stage1_regs_0_0_2 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  stage1_regs_0_0_3 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  stage1_regs_0_0_4 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  stage1_regs_0_0_5 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  stage1_regs_0_0_6 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  stage1_regs_0_0_7 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  stage1_regs_0_0_8 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  stage1_regs_0_1_0 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  stage1_regs_0_1_1 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  stage1_regs_0_1_2 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  stage1_regs_0_1_3 = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  stage1_regs_0_1_4 = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  stage1_regs_0_1_5 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  stage1_regs_0_1_6 = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  stage1_regs_0_1_7 = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  stage1_regs_0_1_8 = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  stage1_regs_1_0_0 = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  stage1_regs_1_0_1 = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  stage1_regs_1_0_2 = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  stage1_regs_1_0_3 = _RAND_42[31:0];
  _RAND_43 = {1{`RANDOM}};
  stage1_regs_1_0_4 = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  stage1_regs_1_0_5 = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  stage1_regs_1_0_6 = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  stage1_regs_1_0_7 = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  stage1_regs_1_0_8 = _RAND_47[31:0];
  _RAND_48 = {1{`RANDOM}};
  stage1_regs_1_1_0 = _RAND_48[31:0];
  _RAND_49 = {1{`RANDOM}};
  stage1_regs_1_1_1 = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  stage1_regs_1_1_2 = _RAND_50[31:0];
  _RAND_51 = {1{`RANDOM}};
  stage1_regs_1_1_3 = _RAND_51[31:0];
  _RAND_52 = {1{`RANDOM}};
  stage1_regs_1_1_4 = _RAND_52[31:0];
  _RAND_53 = {1{`RANDOM}};
  stage1_regs_1_1_5 = _RAND_53[31:0];
  _RAND_54 = {1{`RANDOM}};
  stage1_regs_1_1_6 = _RAND_54[31:0];
  _RAND_55 = {1{`RANDOM}};
  stage1_regs_1_1_7 = _RAND_55[31:0];
  _RAND_56 = {1{`RANDOM}};
  stage1_regs_1_1_8 = _RAND_56[31:0];
  _RAND_57 = {1{`RANDOM}};
  stage1_regs_2_0_0 = _RAND_57[31:0];
  _RAND_58 = {1{`RANDOM}};
  stage1_regs_2_0_1 = _RAND_58[31:0];
  _RAND_59 = {1{`RANDOM}};
  stage1_regs_2_0_2 = _RAND_59[31:0];
  _RAND_60 = {1{`RANDOM}};
  stage1_regs_2_0_3 = _RAND_60[31:0];
  _RAND_61 = {1{`RANDOM}};
  stage1_regs_2_0_4 = _RAND_61[31:0];
  _RAND_62 = {1{`RANDOM}};
  stage1_regs_2_0_5 = _RAND_62[31:0];
  _RAND_63 = {1{`RANDOM}};
  stage1_regs_2_0_6 = _RAND_63[31:0];
  _RAND_64 = {1{`RANDOM}};
  stage1_regs_2_0_7 = _RAND_64[31:0];
  _RAND_65 = {1{`RANDOM}};
  stage1_regs_2_0_8 = _RAND_65[31:0];
  _RAND_66 = {1{`RANDOM}};
  stage1_regs_2_1_0 = _RAND_66[31:0];
  _RAND_67 = {1{`RANDOM}};
  stage1_regs_2_1_1 = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  stage1_regs_2_1_2 = _RAND_68[31:0];
  _RAND_69 = {1{`RANDOM}};
  stage1_regs_2_1_3 = _RAND_69[31:0];
  _RAND_70 = {1{`RANDOM}};
  stage1_regs_2_1_4 = _RAND_70[31:0];
  _RAND_71 = {1{`RANDOM}};
  stage1_regs_2_1_5 = _RAND_71[31:0];
  _RAND_72 = {1{`RANDOM}};
  stage1_regs_2_1_6 = _RAND_72[31:0];
  _RAND_73 = {1{`RANDOM}};
  stage1_regs_2_1_7 = _RAND_73[31:0];
  _RAND_74 = {1{`RANDOM}};
  stage1_regs_2_1_8 = _RAND_74[31:0];
  _RAND_75 = {1{`RANDOM}};
  stage2_regs_0_0_0 = _RAND_75[31:0];
  _RAND_76 = {1{`RANDOM}};
  stage2_regs_0_0_1 = _RAND_76[31:0];
  _RAND_77 = {1{`RANDOM}};
  stage2_regs_0_0_2 = _RAND_77[31:0];
  _RAND_78 = {1{`RANDOM}};
  stage2_regs_0_0_3 = _RAND_78[31:0];
  _RAND_79 = {1{`RANDOM}};
  stage2_regs_0_0_4 = _RAND_79[31:0];
  _RAND_80 = {1{`RANDOM}};
  stage2_regs_0_0_5 = _RAND_80[31:0];
  _RAND_81 = {1{`RANDOM}};
  stage2_regs_0_0_6 = _RAND_81[31:0];
  _RAND_82 = {1{`RANDOM}};
  stage2_regs_0_0_7 = _RAND_82[31:0];
  _RAND_83 = {1{`RANDOM}};
  stage2_regs_0_0_8 = _RAND_83[31:0];
  _RAND_84 = {1{`RANDOM}};
  stage2_regs_0_1_0 = _RAND_84[31:0];
  _RAND_85 = {1{`RANDOM}};
  stage2_regs_0_1_1 = _RAND_85[31:0];
  _RAND_86 = {1{`RANDOM}};
  stage2_regs_0_1_2 = _RAND_86[31:0];
  _RAND_87 = {1{`RANDOM}};
  stage2_regs_0_1_3 = _RAND_87[31:0];
  _RAND_88 = {1{`RANDOM}};
  stage2_regs_0_1_4 = _RAND_88[31:0];
  _RAND_89 = {1{`RANDOM}};
  stage2_regs_0_1_5 = _RAND_89[31:0];
  _RAND_90 = {1{`RANDOM}};
  stage2_regs_0_1_6 = _RAND_90[31:0];
  _RAND_91 = {1{`RANDOM}};
  stage2_regs_0_1_7 = _RAND_91[31:0];
  _RAND_92 = {1{`RANDOM}};
  stage2_regs_0_1_8 = _RAND_92[31:0];
  _RAND_93 = {1{`RANDOM}};
  stage2_regs_1_0_0 = _RAND_93[31:0];
  _RAND_94 = {1{`RANDOM}};
  stage2_regs_1_0_1 = _RAND_94[31:0];
  _RAND_95 = {1{`RANDOM}};
  stage2_regs_1_0_2 = _RAND_95[31:0];
  _RAND_96 = {1{`RANDOM}};
  stage2_regs_1_0_3 = _RAND_96[31:0];
  _RAND_97 = {1{`RANDOM}};
  stage2_regs_1_0_4 = _RAND_97[31:0];
  _RAND_98 = {1{`RANDOM}};
  stage2_regs_1_0_5 = _RAND_98[31:0];
  _RAND_99 = {1{`RANDOM}};
  stage2_regs_1_0_6 = _RAND_99[31:0];
  _RAND_100 = {1{`RANDOM}};
  stage2_regs_1_0_7 = _RAND_100[31:0];
  _RAND_101 = {1{`RANDOM}};
  stage2_regs_1_0_8 = _RAND_101[31:0];
  _RAND_102 = {1{`RANDOM}};
  stage2_regs_1_1_0 = _RAND_102[31:0];
  _RAND_103 = {1{`RANDOM}};
  stage2_regs_1_1_1 = _RAND_103[31:0];
  _RAND_104 = {1{`RANDOM}};
  stage2_regs_1_1_2 = _RAND_104[31:0];
  _RAND_105 = {1{`RANDOM}};
  stage2_regs_1_1_3 = _RAND_105[31:0];
  _RAND_106 = {1{`RANDOM}};
  stage2_regs_1_1_4 = _RAND_106[31:0];
  _RAND_107 = {1{`RANDOM}};
  stage2_regs_1_1_5 = _RAND_107[31:0];
  _RAND_108 = {1{`RANDOM}};
  stage2_regs_1_1_6 = _RAND_108[31:0];
  _RAND_109 = {1{`RANDOM}};
  stage2_regs_1_1_7 = _RAND_109[31:0];
  _RAND_110 = {1{`RANDOM}};
  stage2_regs_1_1_8 = _RAND_110[31:0];
  _RAND_111 = {1{`RANDOM}};
  stage2_regs_2_0_0 = _RAND_111[31:0];
  _RAND_112 = {1{`RANDOM}};
  stage2_regs_2_0_1 = _RAND_112[31:0];
  _RAND_113 = {1{`RANDOM}};
  stage2_regs_2_0_2 = _RAND_113[31:0];
  _RAND_114 = {1{`RANDOM}};
  stage2_regs_2_0_3 = _RAND_114[31:0];
  _RAND_115 = {1{`RANDOM}};
  stage2_regs_2_0_4 = _RAND_115[31:0];
  _RAND_116 = {1{`RANDOM}};
  stage2_regs_2_0_5 = _RAND_116[31:0];
  _RAND_117 = {1{`RANDOM}};
  stage2_regs_2_0_6 = _RAND_117[31:0];
  _RAND_118 = {1{`RANDOM}};
  stage2_regs_2_0_7 = _RAND_118[31:0];
  _RAND_119 = {1{`RANDOM}};
  stage2_regs_2_0_8 = _RAND_119[31:0];
  _RAND_120 = {1{`RANDOM}};
  stage2_regs_2_1_0 = _RAND_120[31:0];
  _RAND_121 = {1{`RANDOM}};
  stage2_regs_2_1_1 = _RAND_121[31:0];
  _RAND_122 = {1{`RANDOM}};
  stage2_regs_2_1_2 = _RAND_122[31:0];
  _RAND_123 = {1{`RANDOM}};
  stage2_regs_2_1_3 = _RAND_123[31:0];
  _RAND_124 = {1{`RANDOM}};
  stage2_regs_2_1_4 = _RAND_124[31:0];
  _RAND_125 = {1{`RANDOM}};
  stage2_regs_2_1_5 = _RAND_125[31:0];
  _RAND_126 = {1{`RANDOM}};
  stage2_regs_2_1_6 = _RAND_126[31:0];
  _RAND_127 = {1{`RANDOM}};
  stage2_regs_2_1_7 = _RAND_127[31:0];
  _RAND_128 = {1{`RANDOM}};
  stage2_regs_2_1_8 = _RAND_128[31:0];
  _RAND_129 = {1{`RANDOM}};
  stage3_regs_0_0_0 = _RAND_129[31:0];
  _RAND_130 = {1{`RANDOM}};
  stage3_regs_0_0_1 = _RAND_130[31:0];
  _RAND_131 = {1{`RANDOM}};
  stage3_regs_0_0_2 = _RAND_131[31:0];
  _RAND_132 = {1{`RANDOM}};
  stage3_regs_0_0_3 = _RAND_132[31:0];
  _RAND_133 = {1{`RANDOM}};
  stage3_regs_0_0_4 = _RAND_133[31:0];
  _RAND_134 = {1{`RANDOM}};
  stage3_regs_0_0_5 = _RAND_134[31:0];
  _RAND_135 = {1{`RANDOM}};
  stage3_regs_0_0_6 = _RAND_135[31:0];
  _RAND_136 = {1{`RANDOM}};
  stage3_regs_0_0_7 = _RAND_136[31:0];
  _RAND_137 = {1{`RANDOM}};
  stage3_regs_0_0_8 = _RAND_137[31:0];
  _RAND_138 = {1{`RANDOM}};
  stage3_regs_0_0_9 = _RAND_138[31:0];
  _RAND_139 = {1{`RANDOM}};
  stage3_regs_0_0_10 = _RAND_139[31:0];
  _RAND_140 = {1{`RANDOM}};
  stage3_regs_0_0_11 = _RAND_140[31:0];
  _RAND_141 = {1{`RANDOM}};
  stage3_regs_0_1_0 = _RAND_141[31:0];
  _RAND_142 = {1{`RANDOM}};
  stage3_regs_0_1_1 = _RAND_142[31:0];
  _RAND_143 = {1{`RANDOM}};
  stage3_regs_0_1_2 = _RAND_143[31:0];
  _RAND_144 = {1{`RANDOM}};
  stage3_regs_0_1_3 = _RAND_144[31:0];
  _RAND_145 = {1{`RANDOM}};
  stage3_regs_0_1_4 = _RAND_145[31:0];
  _RAND_146 = {1{`RANDOM}};
  stage3_regs_0_1_5 = _RAND_146[31:0];
  _RAND_147 = {1{`RANDOM}};
  stage3_regs_0_1_6 = _RAND_147[31:0];
  _RAND_148 = {1{`RANDOM}};
  stage3_regs_0_1_7 = _RAND_148[31:0];
  _RAND_149 = {1{`RANDOM}};
  stage3_regs_0_1_8 = _RAND_149[31:0];
  _RAND_150 = {1{`RANDOM}};
  stage3_regs_0_1_9 = _RAND_150[31:0];
  _RAND_151 = {1{`RANDOM}};
  stage3_regs_0_1_10 = _RAND_151[31:0];
  _RAND_152 = {1{`RANDOM}};
  stage3_regs_0_1_11 = _RAND_152[31:0];
  _RAND_153 = {1{`RANDOM}};
  stage3_regs_1_0_0 = _RAND_153[31:0];
  _RAND_154 = {1{`RANDOM}};
  stage3_regs_1_0_1 = _RAND_154[31:0];
  _RAND_155 = {1{`RANDOM}};
  stage3_regs_1_0_2 = _RAND_155[31:0];
  _RAND_156 = {1{`RANDOM}};
  stage3_regs_1_0_3 = _RAND_156[31:0];
  _RAND_157 = {1{`RANDOM}};
  stage3_regs_1_0_4 = _RAND_157[31:0];
  _RAND_158 = {1{`RANDOM}};
  stage3_regs_1_0_5 = _RAND_158[31:0];
  _RAND_159 = {1{`RANDOM}};
  stage3_regs_1_0_6 = _RAND_159[31:0];
  _RAND_160 = {1{`RANDOM}};
  stage3_regs_1_0_7 = _RAND_160[31:0];
  _RAND_161 = {1{`RANDOM}};
  stage3_regs_1_0_8 = _RAND_161[31:0];
  _RAND_162 = {1{`RANDOM}};
  stage3_regs_1_0_9 = _RAND_162[31:0];
  _RAND_163 = {1{`RANDOM}};
  stage3_regs_1_0_10 = _RAND_163[31:0];
  _RAND_164 = {1{`RANDOM}};
  stage3_regs_1_0_11 = _RAND_164[31:0];
  _RAND_165 = {1{`RANDOM}};
  stage3_regs_1_1_0 = _RAND_165[31:0];
  _RAND_166 = {1{`RANDOM}};
  stage3_regs_1_1_1 = _RAND_166[31:0];
  _RAND_167 = {1{`RANDOM}};
  stage3_regs_1_1_2 = _RAND_167[31:0];
  _RAND_168 = {1{`RANDOM}};
  stage3_regs_1_1_3 = _RAND_168[31:0];
  _RAND_169 = {1{`RANDOM}};
  stage3_regs_1_1_4 = _RAND_169[31:0];
  _RAND_170 = {1{`RANDOM}};
  stage3_regs_1_1_5 = _RAND_170[31:0];
  _RAND_171 = {1{`RANDOM}};
  stage3_regs_1_1_6 = _RAND_171[31:0];
  _RAND_172 = {1{`RANDOM}};
  stage3_regs_1_1_7 = _RAND_172[31:0];
  _RAND_173 = {1{`RANDOM}};
  stage3_regs_1_1_8 = _RAND_173[31:0];
  _RAND_174 = {1{`RANDOM}};
  stage3_regs_1_1_9 = _RAND_174[31:0];
  _RAND_175 = {1{`RANDOM}};
  stage3_regs_1_1_10 = _RAND_175[31:0];
  _RAND_176 = {1{`RANDOM}};
  stage3_regs_1_1_11 = _RAND_176[31:0];
  _RAND_177 = {1{`RANDOM}};
  stage3_regs_2_0_0 = _RAND_177[31:0];
  _RAND_178 = {1{`RANDOM}};
  stage3_regs_2_0_1 = _RAND_178[31:0];
  _RAND_179 = {1{`RANDOM}};
  stage3_regs_2_0_2 = _RAND_179[31:0];
  _RAND_180 = {1{`RANDOM}};
  stage3_regs_2_0_3 = _RAND_180[31:0];
  _RAND_181 = {1{`RANDOM}};
  stage3_regs_2_0_4 = _RAND_181[31:0];
  _RAND_182 = {1{`RANDOM}};
  stage3_regs_2_0_5 = _RAND_182[31:0];
  _RAND_183 = {1{`RANDOM}};
  stage3_regs_2_0_6 = _RAND_183[31:0];
  _RAND_184 = {1{`RANDOM}};
  stage3_regs_2_0_7 = _RAND_184[31:0];
  _RAND_185 = {1{`RANDOM}};
  stage3_regs_2_0_8 = _RAND_185[31:0];
  _RAND_186 = {1{`RANDOM}};
  stage3_regs_2_0_9 = _RAND_186[31:0];
  _RAND_187 = {1{`RANDOM}};
  stage3_regs_2_0_10 = _RAND_187[31:0];
  _RAND_188 = {1{`RANDOM}};
  stage3_regs_2_0_11 = _RAND_188[31:0];
  _RAND_189 = {1{`RANDOM}};
  stage3_regs_2_1_0 = _RAND_189[31:0];
  _RAND_190 = {1{`RANDOM}};
  stage3_regs_2_1_1 = _RAND_190[31:0];
  _RAND_191 = {1{`RANDOM}};
  stage3_regs_2_1_2 = _RAND_191[31:0];
  _RAND_192 = {1{`RANDOM}};
  stage3_regs_2_1_3 = _RAND_192[31:0];
  _RAND_193 = {1{`RANDOM}};
  stage3_regs_2_1_4 = _RAND_193[31:0];
  _RAND_194 = {1{`RANDOM}};
  stage3_regs_2_1_5 = _RAND_194[31:0];
  _RAND_195 = {1{`RANDOM}};
  stage3_regs_2_1_6 = _RAND_195[31:0];
  _RAND_196 = {1{`RANDOM}};
  stage3_regs_2_1_7 = _RAND_196[31:0];
  _RAND_197 = {1{`RANDOM}};
  stage3_regs_2_1_8 = _RAND_197[31:0];
  _RAND_198 = {1{`RANDOM}};
  stage3_regs_2_1_9 = _RAND_198[31:0];
  _RAND_199 = {1{`RANDOM}};
  stage3_regs_2_1_10 = _RAND_199[31:0];
  _RAND_200 = {1{`RANDOM}};
  stage3_regs_2_1_11 = _RAND_200[31:0];
  _RAND_201 = {1{`RANDOM}};
  stage4_regs_0_1_0 = _RAND_201[31:0];
  _RAND_202 = {1{`RANDOM}};
  stage4_regs_0_1_1 = _RAND_202[31:0];
  _RAND_203 = {1{`RANDOM}};
  stage4_regs_0_1_2 = _RAND_203[31:0];
  _RAND_204 = {1{`RANDOM}};
  stage4_regs_0_1_3 = _RAND_204[31:0];
  _RAND_205 = {1{`RANDOM}};
  stage4_regs_0_1_4 = _RAND_205[31:0];
  _RAND_206 = {1{`RANDOM}};
  stage4_regs_0_1_5 = _RAND_206[31:0];
  _RAND_207 = {1{`RANDOM}};
  stage4_regs_0_1_6 = _RAND_207[31:0];
  _RAND_208 = {1{`RANDOM}};
  stage4_regs_0_1_7 = _RAND_208[31:0];
  _RAND_209 = {1{`RANDOM}};
  stage4_regs_0_1_8 = _RAND_209[31:0];
  _RAND_210 = {1{`RANDOM}};
  stage4_regs_1_1_0 = _RAND_210[31:0];
  _RAND_211 = {1{`RANDOM}};
  stage4_regs_1_1_1 = _RAND_211[31:0];
  _RAND_212 = {1{`RANDOM}};
  stage4_regs_1_1_2 = _RAND_212[31:0];
  _RAND_213 = {1{`RANDOM}};
  stage4_regs_1_1_3 = _RAND_213[31:0];
  _RAND_214 = {1{`RANDOM}};
  stage4_regs_1_1_4 = _RAND_214[31:0];
  _RAND_215 = {1{`RANDOM}};
  stage4_regs_1_1_5 = _RAND_215[31:0];
  _RAND_216 = {1{`RANDOM}};
  stage4_regs_1_1_6 = _RAND_216[31:0];
  _RAND_217 = {1{`RANDOM}};
  stage4_regs_1_1_7 = _RAND_217[31:0];
  _RAND_218 = {1{`RANDOM}};
  stage4_regs_1_1_8 = _RAND_218[31:0];
  _RAND_219 = {1{`RANDOM}};
  stage4_regs_2_1_0 = _RAND_219[31:0];
  _RAND_220 = {1{`RANDOM}};
  stage4_regs_2_1_1 = _RAND_220[31:0];
  _RAND_221 = {1{`RANDOM}};
  stage4_regs_2_1_2 = _RAND_221[31:0];
  _RAND_222 = {1{`RANDOM}};
  stage4_regs_2_1_3 = _RAND_222[31:0];
  _RAND_223 = {1{`RANDOM}};
  stage4_regs_2_1_4 = _RAND_223[31:0];
  _RAND_224 = {1{`RANDOM}};
  stage4_regs_2_1_5 = _RAND_224[31:0];
  _RAND_225 = {1{`RANDOM}};
  stage4_regs_2_1_6 = _RAND_225[31:0];
  _RAND_226 = {1{`RANDOM}};
  stage4_regs_2_1_7 = _RAND_226[31:0];
  _RAND_227 = {1{`RANDOM}};
  stage4_regs_2_1_8 = _RAND_227[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FP_reciprocal_newfpu_19(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
  output [31:0] io_out_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_135;
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
  reg [31:0] _RAND_139;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
  reg [31:0] _RAND_144;
  reg [31:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_153;
  reg [31:0] _RAND_154;
  reg [31:0] _RAND_155;
  reg [31:0] _RAND_156;
  reg [31:0] _RAND_157;
  reg [31:0] _RAND_158;
  reg [31:0] _RAND_159;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_163;
  reg [31:0] _RAND_164;
  reg [31:0] _RAND_165;
  reg [31:0] _RAND_166;
  reg [31:0] _RAND_167;
  reg [31:0] _RAND_168;
  reg [31:0] _RAND_169;
  reg [31:0] _RAND_170;
  reg [31:0] _RAND_171;
  reg [31:0] _RAND_172;
  reg [31:0] _RAND_173;
  reg [31:0] _RAND_174;
  reg [31:0] _RAND_175;
  reg [31:0] _RAND_176;
  reg [31:0] _RAND_177;
  reg [31:0] _RAND_178;
  reg [31:0] _RAND_179;
  reg [31:0] _RAND_180;
  reg [31:0] _RAND_181;
  reg [31:0] _RAND_182;
  reg [31:0] _RAND_183;
  reg [31:0] _RAND_184;
  reg [31:0] _RAND_185;
  reg [31:0] _RAND_186;
  reg [31:0] _RAND_187;
  reg [31:0] _RAND_188;
  reg [31:0] _RAND_189;
  reg [31:0] _RAND_190;
  reg [31:0] _RAND_191;
  reg [31:0] _RAND_192;
  reg [31:0] _RAND_193;
  reg [31:0] _RAND_194;
  reg [31:0] _RAND_195;
  reg [31:0] _RAND_196;
  reg [31:0] _RAND_197;
`endif // RANDOMIZE_REG_INIT
  wire  FP_multiplier_10ccs_19_clock; // @[FloatingPointDesigns.scala 2011:65]
  wire  FP_multiplier_10ccs_19_reset; // @[FloatingPointDesigns.scala 2011:65]
  wire  FP_multiplier_10ccs_19_io_in_en; // @[FloatingPointDesigns.scala 2011:65]
  wire [31:0] FP_multiplier_10ccs_19_io_in_a; // @[FloatingPointDesigns.scala 2011:65]
  wire [31:0] FP_multiplier_10ccs_19_io_in_b; // @[FloatingPointDesigns.scala 2011:65]
  wire [31:0] FP_multiplier_10ccs_19_io_out_s; // @[FloatingPointDesigns.scala 2011:65]
  wire  FP_multiplier_10ccs_19_1_clock; // @[FloatingPointDesigns.scala 2011:65]
  wire  FP_multiplier_10ccs_19_1_reset; // @[FloatingPointDesigns.scala 2011:65]
  wire  FP_multiplier_10ccs_19_1_io_in_en; // @[FloatingPointDesigns.scala 2011:65]
  wire [31:0] FP_multiplier_10ccs_19_1_io_in_a; // @[FloatingPointDesigns.scala 2011:65]
  wire [31:0] FP_multiplier_10ccs_19_1_io_in_b; // @[FloatingPointDesigns.scala 2011:65]
  wire [31:0] FP_multiplier_10ccs_19_1_io_out_s; // @[FloatingPointDesigns.scala 2011:65]
  wire  FP_multiplier_10ccs_19_2_clock; // @[FloatingPointDesigns.scala 2011:65]
  wire  FP_multiplier_10ccs_19_2_reset; // @[FloatingPointDesigns.scala 2011:65]
  wire  FP_multiplier_10ccs_19_2_io_in_en; // @[FloatingPointDesigns.scala 2011:65]
  wire [31:0] FP_multiplier_10ccs_19_2_io_in_a; // @[FloatingPointDesigns.scala 2011:65]
  wire [31:0] FP_multiplier_10ccs_19_2_io_in_b; // @[FloatingPointDesigns.scala 2011:65]
  wire [31:0] FP_multiplier_10ccs_19_2_io_out_s; // @[FloatingPointDesigns.scala 2011:65]
  wire  FP_subtractor_13ccs_19_clock; // @[FloatingPointDesigns.scala 2012:50]
  wire  FP_subtractor_13ccs_19_reset; // @[FloatingPointDesigns.scala 2012:50]
  wire  FP_subtractor_13ccs_19_io_in_en; // @[FloatingPointDesigns.scala 2012:50]
  wire [31:0] FP_subtractor_13ccs_19_io_in_a; // @[FloatingPointDesigns.scala 2012:50]
  wire [31:0] FP_subtractor_13ccs_19_io_in_b; // @[FloatingPointDesigns.scala 2012:50]
  wire [31:0] FP_subtractor_13ccs_19_io_out_s; // @[FloatingPointDesigns.scala 2012:50]
  wire  multiplier4_clock; // @[FloatingPointDesigns.scala 2091:29]
  wire  multiplier4_reset; // @[FloatingPointDesigns.scala 2091:29]
  wire  multiplier4_io_in_en; // @[FloatingPointDesigns.scala 2091:29]
  wire [31:0] multiplier4_io_in_a; // @[FloatingPointDesigns.scala 2091:29]
  wire [31:0] multiplier4_io_in_b; // @[FloatingPointDesigns.scala 2091:29]
  wire [31:0] multiplier4_io_out_s; // @[FloatingPointDesigns.scala 2091:29]
  wire  FP_multiplier_10ccs_19_3_clock; // @[FloatingPointDesigns.scala 2103:69]
  wire  FP_multiplier_10ccs_19_3_reset; // @[FloatingPointDesigns.scala 2103:69]
  wire  FP_multiplier_10ccs_19_3_io_in_en; // @[FloatingPointDesigns.scala 2103:69]
  wire [31:0] FP_multiplier_10ccs_19_3_io_in_a; // @[FloatingPointDesigns.scala 2103:69]
  wire [31:0] FP_multiplier_10ccs_19_3_io_in_b; // @[FloatingPointDesigns.scala 2103:69]
  wire [31:0] FP_multiplier_10ccs_19_3_io_out_s; // @[FloatingPointDesigns.scala 2103:69]
  wire  FP_multiplier_10ccs_19_4_clock; // @[FloatingPointDesigns.scala 2103:69]
  wire  FP_multiplier_10ccs_19_4_reset; // @[FloatingPointDesigns.scala 2103:69]
  wire  FP_multiplier_10ccs_19_4_io_in_en; // @[FloatingPointDesigns.scala 2103:69]
  wire [31:0] FP_multiplier_10ccs_19_4_io_in_a; // @[FloatingPointDesigns.scala 2103:69]
  wire [31:0] FP_multiplier_10ccs_19_4_io_in_b; // @[FloatingPointDesigns.scala 2103:69]
  wire [31:0] FP_multiplier_10ccs_19_4_io_out_s; // @[FloatingPointDesigns.scala 2103:69]
  wire  FP_multiplier_10ccs_19_5_clock; // @[FloatingPointDesigns.scala 2103:69]
  wire  FP_multiplier_10ccs_19_5_reset; // @[FloatingPointDesigns.scala 2103:69]
  wire  FP_multiplier_10ccs_19_5_io_in_en; // @[FloatingPointDesigns.scala 2103:69]
  wire [31:0] FP_multiplier_10ccs_19_5_io_in_a; // @[FloatingPointDesigns.scala 2103:69]
  wire [31:0] FP_multiplier_10ccs_19_5_io_in_b; // @[FloatingPointDesigns.scala 2103:69]
  wire [31:0] FP_multiplier_10ccs_19_5_io_out_s; // @[FloatingPointDesigns.scala 2103:69]
  wire  FP_multiplier_10ccs_19_6_clock; // @[FloatingPointDesigns.scala 2103:69]
  wire  FP_multiplier_10ccs_19_6_reset; // @[FloatingPointDesigns.scala 2103:69]
  wire  FP_multiplier_10ccs_19_6_io_in_en; // @[FloatingPointDesigns.scala 2103:69]
  wire [31:0] FP_multiplier_10ccs_19_6_io_in_a; // @[FloatingPointDesigns.scala 2103:69]
  wire [31:0] FP_multiplier_10ccs_19_6_io_in_b; // @[FloatingPointDesigns.scala 2103:69]
  wire [31:0] FP_multiplier_10ccs_19_6_io_out_s; // @[FloatingPointDesigns.scala 2103:69]
  wire  FP_subtractor_13ccs_19_1_clock; // @[FloatingPointDesigns.scala 2104:54]
  wire  FP_subtractor_13ccs_19_1_reset; // @[FloatingPointDesigns.scala 2104:54]
  wire  FP_subtractor_13ccs_19_1_io_in_en; // @[FloatingPointDesigns.scala 2104:54]
  wire [31:0] FP_subtractor_13ccs_19_1_io_in_a; // @[FloatingPointDesigns.scala 2104:54]
  wire [31:0] FP_subtractor_13ccs_19_1_io_in_b; // @[FloatingPointDesigns.scala 2104:54]
  wire [31:0] FP_subtractor_13ccs_19_1_io_out_s; // @[FloatingPointDesigns.scala 2104:54]
  wire  FP_subtractor_13ccs_19_2_clock; // @[FloatingPointDesigns.scala 2104:54]
  wire  FP_subtractor_13ccs_19_2_reset; // @[FloatingPointDesigns.scala 2104:54]
  wire  FP_subtractor_13ccs_19_2_io_in_en; // @[FloatingPointDesigns.scala 2104:54]
  wire [31:0] FP_subtractor_13ccs_19_2_io_in_a; // @[FloatingPointDesigns.scala 2104:54]
  wire [31:0] FP_subtractor_13ccs_19_2_io_in_b; // @[FloatingPointDesigns.scala 2104:54]
  wire [31:0] FP_subtractor_13ccs_19_2_io_out_s; // @[FloatingPointDesigns.scala 2104:54]
  wire [30:0] _number_T_1 = {{1'd0}, io_in_a[30:1]}; // @[FloatingPointDesigns.scala 1996:36]
  wire [30:0] _GEN_0 = io_in_a[30:0] > 31'h7ef477d4 ? 31'h3f7a3bea : _number_T_1; // @[FloatingPointDesigns.scala 1993:46 1994:14 1996:14]
  wire [31:0] number = {{1'd0}, _GEN_0}; // @[FloatingPointDesigns.scala 1988:22]
  wire [31:0] result = 32'h5f3759df - number; // @[FloatingPointDesigns.scala 2003:25]
  reg [31:0] x_n_0; // @[FloatingPointDesigns.scala 2005:22]
  reg [31:0] x_n_1; // @[FloatingPointDesigns.scala 2005:22]
  reg [31:0] x_n_2; // @[FloatingPointDesigns.scala 2005:22]
  reg [31:0] a_2_0; // @[FloatingPointDesigns.scala 2006:22]
  reg [31:0] a_2_1; // @[FloatingPointDesigns.scala 2006:22]
  reg [31:0] a_2_2; // @[FloatingPointDesigns.scala 2006:22]
  reg [31:0] a_2_3; // @[FloatingPointDesigns.scala 2006:22]
  reg [31:0] stage1_regs_0_0_0; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_0_1; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_0_2; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_0_3; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_0_4; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_0_5; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_0_6; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_0_7; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_0_8; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_1_0; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_1_1; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_1_2; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_1_3; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_1_4; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_1_5; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_1_6; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_1_7; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage1_regs_0_1_8; // @[FloatingPointDesigns.scala 2007:30]
  reg [31:0] stage2_regs_0_0_0; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_0_1; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_0_2; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_0_3; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_0_4; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_0_5; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_0_6; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_0_7; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_0_8; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_1_0; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_1_1; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_1_2; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_1_3; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_1_4; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_1_5; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_1_6; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_1_7; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage2_regs_0_1_8; // @[FloatingPointDesigns.scala 2008:30]
  reg [31:0] stage3_regs_0_0_0; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_0_1; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_0_2; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_0_3; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_0_4; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_0_5; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_0_6; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_0_7; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_0_8; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_0_9; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_0_10; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_0_11; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_1_0; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_1_1; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_1_2; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_1_3; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_1_4; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_1_5; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_1_6; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_1_7; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_1_8; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_1_9; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_1_10; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage3_regs_0_1_11; // @[FloatingPointDesigns.scala 2009:30]
  reg [31:0] stage4_regs_0_1_0; // @[FloatingPointDesigns.scala 2010:30]
  reg [31:0] stage4_regs_0_1_1; // @[FloatingPointDesigns.scala 2010:30]
  reg [31:0] stage4_regs_0_1_2; // @[FloatingPointDesigns.scala 2010:30]
  reg [31:0] stage4_regs_0_1_3; // @[FloatingPointDesigns.scala 2010:30]
  reg [31:0] stage4_regs_0_1_4; // @[FloatingPointDesigns.scala 2010:30]
  reg [31:0] stage4_regs_0_1_5; // @[FloatingPointDesigns.scala 2010:30]
  reg [31:0] stage4_regs_0_1_6; // @[FloatingPointDesigns.scala 2010:30]
  reg [31:0] stage4_regs_0_1_7; // @[FloatingPointDesigns.scala 2010:30]
  reg [31:0] stage4_regs_0_1_8; // @[FloatingPointDesigns.scala 2010:30]
  wire [7:0] _a_2_0_T_3 = io_in_a[30:23] - 8'h1; // @[FloatingPointDesigns.scala 2036:75]
  wire [31:0] _a_2_0_T_6 = {io_in_a[31],_a_2_0_T_3,io_in_a[22:0]}; // @[FloatingPointDesigns.scala 2036:82]
  reg [31:0] a_2_isr_to_r; // @[FloatingPointDesigns.scala 2081:31]
  reg [31:0] transition_regs_0; // @[FloatingPointDesigns.scala 2082:34]
  reg [31:0] transition_regs_1; // @[FloatingPointDesigns.scala 2082:34]
  reg [31:0] transition_regs_2; // @[FloatingPointDesigns.scala 2082:34]
  reg [31:0] transition_regs_3; // @[FloatingPointDesigns.scala 2082:34]
  reg [31:0] transition_regs_4; // @[FloatingPointDesigns.scala 2082:34]
  reg [31:0] transition_regs_5; // @[FloatingPointDesigns.scala 2082:34]
  reg [31:0] transition_regs_6; // @[FloatingPointDesigns.scala 2082:34]
  reg [31:0] transition_regs_7; // @[FloatingPointDesigns.scala 2082:34]
  reg [31:0] transition_regs_8; // @[FloatingPointDesigns.scala 2082:34]
  wire [7:0] _a_2_isr_to_r_T_3 = stage4_regs_0_1_8[30:23] + 8'h1; // @[FloatingPointDesigns.scala 2084:115]
  wire [31:0] _a_2_isr_to_r_T_6 = {stage4_regs_0_1_8[31],_a_2_isr_to_r_T_3,stage4_regs_0_1_8[22:0]}; // @[FloatingPointDesigns.scala 2084:122]
  reg [31:0] x_n_r_0; // @[FloatingPointDesigns.scala 2098:24]
  reg [31:0] x_n_r_1; // @[FloatingPointDesigns.scala 2098:24]
  reg [31:0] x_n_r_3; // @[FloatingPointDesigns.scala 2098:24]
  reg [31:0] x_n_r_4; // @[FloatingPointDesigns.scala 2098:24]
  reg [31:0] a_2_r_0; // @[FloatingPointDesigns.scala 2099:24]
  reg [31:0] a_2_r_1; // @[FloatingPointDesigns.scala 2099:24]
  reg [31:0] a_2_r_2; // @[FloatingPointDesigns.scala 2099:24]
  reg [31:0] a_2_r_3; // @[FloatingPointDesigns.scala 2099:24]
  reg [31:0] a_2_r_4; // @[FloatingPointDesigns.scala 2099:24]
  reg [31:0] a_2_r_5; // @[FloatingPointDesigns.scala 2099:24]
  reg [31:0] stage1_regs_r_0_0_0; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_0_1; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_0_2; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_0_3; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_0_4; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_0_5; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_0_6; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_0_7; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_0_8; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_1_0; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_1_1; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_1_2; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_1_3; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_1_4; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_1_5; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_1_6; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_1_7; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_0_1_8; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_0_0; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_0_1; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_0_2; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_0_3; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_0_4; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_0_5; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_0_6; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_0_7; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_0_8; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_1_0; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_1_1; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_1_2; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_1_3; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_1_4; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_1_5; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_1_6; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_1_7; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage1_regs_r_1_1_8; // @[FloatingPointDesigns.scala 2100:32]
  reg [31:0] stage2_regs_r_0_0_0; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_0_1; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_0_2; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_0_3; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_0_4; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_0_5; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_0_6; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_0_7; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_0_8; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_0_9; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_0_10; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_0_11; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_1_0; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_1_1; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_1_2; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_1_3; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_1_4; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_1_5; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_1_6; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_1_7; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_1_8; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_1_9; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_1_10; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_0_1_11; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_0_0; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_0_1; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_0_2; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_0_3; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_0_4; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_0_5; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_0_6; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_0_7; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_0_8; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_0_9; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_0_10; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_0_11; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_1_0; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_1_1; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_1_2; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_1_3; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_1_4; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_1_5; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_1_6; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_1_7; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_1_8; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_1_9; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_1_10; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage2_regs_r_1_1_11; // @[FloatingPointDesigns.scala 2101:32]
  reg [31:0] stage3_regs_r_0_1_0; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_0_1_1; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_0_1_2; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_0_1_3; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_0_1_4; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_0_1_5; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_0_1_6; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_0_1_7; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_0_1_8; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_1_1_0; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_1_1_1; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_1_1_2; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_1_1_3; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_1_1_4; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_1_1_5; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_1_1_6; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_1_1_7; // @[FloatingPointDesigns.scala 2102:32]
  reg [31:0] stage3_regs_r_1_1_8; // @[FloatingPointDesigns.scala 2102:32]
  wire [31:0] _GEN_133 = multiplier4_io_out_s; // @[FloatingPointDesigns.scala 2098:24 2123:28 2124:28]
  wire [31:0] _GEN_189 = FP_multiplier_10ccs_19_4_io_out_s; // @[FloatingPointDesigns.scala 2098:24 2132:28 2133:28]
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19 ( // @[FloatingPointDesigns.scala 2011:65]
    .clock(FP_multiplier_10ccs_19_clock),
    .reset(FP_multiplier_10ccs_19_reset),
    .io_in_en(FP_multiplier_10ccs_19_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_1 ( // @[FloatingPointDesigns.scala 2011:65]
    .clock(FP_multiplier_10ccs_19_1_clock),
    .reset(FP_multiplier_10ccs_19_1_reset),
    .io_in_en(FP_multiplier_10ccs_19_1_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_1_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_1_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_1_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_2 ( // @[FloatingPointDesigns.scala 2011:65]
    .clock(FP_multiplier_10ccs_19_2_clock),
    .reset(FP_multiplier_10ccs_19_2_reset),
    .io_in_en(FP_multiplier_10ccs_19_2_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_2_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_2_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_2_io_out_s)
  );
  FP_subtractor_13ccs_19 FP_subtractor_13ccs_19 ( // @[FloatingPointDesigns.scala 2012:50]
    .clock(FP_subtractor_13ccs_19_clock),
    .reset(FP_subtractor_13ccs_19_reset),
    .io_in_en(FP_subtractor_13ccs_19_io_in_en),
    .io_in_a(FP_subtractor_13ccs_19_io_in_a),
    .io_in_b(FP_subtractor_13ccs_19_io_in_b),
    .io_out_s(FP_subtractor_13ccs_19_io_out_s)
  );
  FP_multiplier_10ccs_19 multiplier4 ( // @[FloatingPointDesigns.scala 2091:29]
    .clock(multiplier4_clock),
    .reset(multiplier4_reset),
    .io_in_en(multiplier4_io_in_en),
    .io_in_a(multiplier4_io_in_a),
    .io_in_b(multiplier4_io_in_b),
    .io_out_s(multiplier4_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_3 ( // @[FloatingPointDesigns.scala 2103:69]
    .clock(FP_multiplier_10ccs_19_3_clock),
    .reset(FP_multiplier_10ccs_19_3_reset),
    .io_in_en(FP_multiplier_10ccs_19_3_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_3_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_3_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_3_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_4 ( // @[FloatingPointDesigns.scala 2103:69]
    .clock(FP_multiplier_10ccs_19_4_clock),
    .reset(FP_multiplier_10ccs_19_4_reset),
    .io_in_en(FP_multiplier_10ccs_19_4_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_4_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_4_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_4_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_5 ( // @[FloatingPointDesigns.scala 2103:69]
    .clock(FP_multiplier_10ccs_19_5_clock),
    .reset(FP_multiplier_10ccs_19_5_reset),
    .io_in_en(FP_multiplier_10ccs_19_5_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_5_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_5_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_5_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19_6 ( // @[FloatingPointDesigns.scala 2103:69]
    .clock(FP_multiplier_10ccs_19_6_clock),
    .reset(FP_multiplier_10ccs_19_6_reset),
    .io_in_en(FP_multiplier_10ccs_19_6_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_6_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_6_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_6_io_out_s)
  );
  FP_subtractor_13ccs_19 FP_subtractor_13ccs_19_1 ( // @[FloatingPointDesigns.scala 2104:54]
    .clock(FP_subtractor_13ccs_19_1_clock),
    .reset(FP_subtractor_13ccs_19_1_reset),
    .io_in_en(FP_subtractor_13ccs_19_1_io_in_en),
    .io_in_a(FP_subtractor_13ccs_19_1_io_in_a),
    .io_in_b(FP_subtractor_13ccs_19_1_io_in_b),
    .io_out_s(FP_subtractor_13ccs_19_1_io_out_s)
  );
  FP_subtractor_13ccs_19 FP_subtractor_13ccs_19_2 ( // @[FloatingPointDesigns.scala 2104:54]
    .clock(FP_subtractor_13ccs_19_2_clock),
    .reset(FP_subtractor_13ccs_19_2_reset),
    .io_in_en(FP_subtractor_13ccs_19_2_io_in_en),
    .io_in_a(FP_subtractor_13ccs_19_2_io_in_a),
    .io_in_b(FP_subtractor_13ccs_19_2_io_in_b),
    .io_out_s(FP_subtractor_13ccs_19_2_io_out_s)
  );
  assign io_out_s = {stage3_regs_r_1_1_8[31],FP_multiplier_10ccs_19_6_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 2160:58]
  assign FP_multiplier_10ccs_19_clock = clock;
  assign FP_multiplier_10ccs_19_reset = reset;
  assign FP_multiplier_10ccs_19_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2013:41]
  assign FP_multiplier_10ccs_19_io_in_a = {1'h0,result[30:0]}; // @[FloatingPointDesigns.scala 2040:48]
  assign FP_multiplier_10ccs_19_io_in_b = {1'h0,result[30:0]}; // @[FloatingPointDesigns.scala 2041:48]
  assign FP_multiplier_10ccs_19_1_clock = clock;
  assign FP_multiplier_10ccs_19_1_reset = reset;
  assign FP_multiplier_10ccs_19_1_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2013:41]
  assign FP_multiplier_10ccs_19_1_io_in_a = FP_multiplier_10ccs_19_io_out_s; // @[FloatingPointDesigns.scala 2053:34]
  assign FP_multiplier_10ccs_19_1_io_in_b = {1'h0,stage1_regs_0_1_8[30:0]}; // @[FloatingPointDesigns.scala 2054:46]
  assign FP_multiplier_10ccs_19_2_clock = clock;
  assign FP_multiplier_10ccs_19_2_reset = reset;
  assign FP_multiplier_10ccs_19_2_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2013:41]
  assign FP_multiplier_10ccs_19_2_io_in_a = {1'h0,stage3_regs_0_0_11[30:0]}; // @[FloatingPointDesigns.scala 2071:46]
  assign FP_multiplier_10ccs_19_2_io_in_b = FP_subtractor_13ccs_19_io_out_s; // @[FloatingPointDesigns.scala 2072:34]
  assign FP_subtractor_13ccs_19_clock = clock;
  assign FP_subtractor_13ccs_19_reset = reset;
  assign FP_subtractor_13ccs_19_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2014:32]
  assign FP_subtractor_13ccs_19_io_in_a = 32'h3fc00000; // @[FloatingPointDesigns.scala 1989:26 1990:16]
  assign FP_subtractor_13ccs_19_io_in_b = FP_multiplier_10ccs_19_1_io_out_s; // @[FloatingPointDesigns.scala 2063:31]
  assign multiplier4_clock = clock;
  assign multiplier4_reset = reset;
  assign multiplier4_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2092:26]
  assign multiplier4_io_in_a = {1'h0,FP_multiplier_10ccs_19_2_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 2093:37]
  assign multiplier4_io_in_b = {1'h0,FP_multiplier_10ccs_19_2_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 2094:37]
  assign FP_multiplier_10ccs_19_3_clock = clock;
  assign FP_multiplier_10ccs_19_3_reset = reset;
  assign FP_multiplier_10ccs_19_3_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2105:43]
  assign FP_multiplier_10ccs_19_3_io_in_a = {1'h0,multiplier4_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 2129:50]
  assign FP_multiplier_10ccs_19_3_io_in_b = {1'h0,transition_regs_8[30:0]}; // @[FloatingPointDesigns.scala 2130:50]
  assign FP_multiplier_10ccs_19_4_clock = clock;
  assign FP_multiplier_10ccs_19_4_reset = reset;
  assign FP_multiplier_10ccs_19_4_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2105:43]
  assign FP_multiplier_10ccs_19_4_io_in_a = {1'h0,stage2_regs_r_0_0_11[30:0]}; // @[FloatingPointDesigns.scala 2151:48]
  assign FP_multiplier_10ccs_19_4_io_in_b = FP_subtractor_13ccs_19_1_io_out_s; // @[FloatingPointDesigns.scala 2152:36]
  assign FP_multiplier_10ccs_19_5_clock = clock;
  assign FP_multiplier_10ccs_19_5_reset = reset;
  assign FP_multiplier_10ccs_19_5_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2105:43]
  assign FP_multiplier_10ccs_19_5_io_in_a = {1'h0,FP_multiplier_10ccs_19_4_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 2138:50]
  assign FP_multiplier_10ccs_19_5_io_in_b = {1'h0,stage3_regs_r_0_1_8[30:0]}; // @[FloatingPointDesigns.scala 2139:50]
  assign FP_multiplier_10ccs_19_6_clock = clock;
  assign FP_multiplier_10ccs_19_6_reset = reset;
  assign FP_multiplier_10ccs_19_6_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2105:43]
  assign FP_multiplier_10ccs_19_6_io_in_a = {1'h0,stage2_regs_r_1_0_11[30:0]}; // @[FloatingPointDesigns.scala 2151:48]
  assign FP_multiplier_10ccs_19_6_io_in_b = FP_subtractor_13ccs_19_2_io_out_s; // @[FloatingPointDesigns.scala 2152:36]
  assign FP_subtractor_13ccs_19_1_clock = clock;
  assign FP_subtractor_13ccs_19_1_reset = reset;
  assign FP_subtractor_13ccs_19_1_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2106:34]
  assign FP_subtractor_13ccs_19_1_io_in_a = 32'h40000000; // @[FloatingPointDesigns.scala 1991:19 1992:9]
  assign FP_subtractor_13ccs_19_1_io_in_b = FP_multiplier_10ccs_19_3_io_out_s; // @[FloatingPointDesigns.scala 2143:33]
  assign FP_subtractor_13ccs_19_2_clock = clock;
  assign FP_subtractor_13ccs_19_2_reset = reset;
  assign FP_subtractor_13ccs_19_2_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2106:34]
  assign FP_subtractor_13ccs_19_2_io_in_a = 32'h40000000; // @[FloatingPointDesigns.scala 1991:19 1992:9]
  assign FP_subtractor_13ccs_19_2_io_in_b = FP_multiplier_10ccs_19_5_io_out_s; // @[FloatingPointDesigns.scala 2143:33]
  always @(posedge clock) begin
    if (reset) begin // @[FloatingPointDesigns.scala 2005:22]
      x_n_0 <= 32'h0; // @[FloatingPointDesigns.scala 2005:22]
    end else begin
      x_n_0 <= result;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:22]
      x_n_1 <= 32'h0; // @[FloatingPointDesigns.scala 2005:22]
    end else begin
      x_n_1 <= stage1_regs_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:22]
      x_n_2 <= 32'h0; // @[FloatingPointDesigns.scala 2005:22]
    end else begin
      x_n_2 <= stage2_regs_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:22]
      a_2_0 <= 32'h0; // @[FloatingPointDesigns.scala 2006:22]
    end else begin
      a_2_0 <= _a_2_0_T_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:22]
      a_2_1 <= 32'h0; // @[FloatingPointDesigns.scala 2006:22]
    end else begin
      a_2_1 <= stage1_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:22]
      a_2_2 <= 32'h0; // @[FloatingPointDesigns.scala 2006:22]
    end else begin
      a_2_2 <= stage2_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:22]
      a_2_3 <= 32'h0; // @[FloatingPointDesigns.scala 2006:22]
    end else begin
      a_2_3 <= stage3_regs_0_1_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_0_0 <= x_n_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_0_1 <= stage1_regs_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_0_2 <= stage1_regs_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_0_3 <= stage1_regs_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_0_4 <= stage1_regs_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_0_5 <= stage1_regs_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_0_6 <= stage1_regs_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_0_7 <= stage1_regs_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_0_8 <= stage1_regs_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_1_0 <= a_2_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_1_1 <= stage1_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_1_2 <= stage1_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_1_3 <= stage1_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_1_4 <= stage1_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_1_5 <= stage1_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_1_6 <= stage1_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_1_7 <= stage1_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2007:30]
      stage1_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2007:30]
    end else begin
      stage1_regs_0_1_8 <= stage1_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_0_0 <= x_n_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_0_1 <= stage2_regs_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_0_2 <= stage2_regs_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_0_3 <= stage2_regs_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_0_4 <= stage2_regs_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_0_5 <= stage2_regs_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_0_6 <= stage2_regs_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_0_7 <= stage2_regs_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_0_8 <= stage2_regs_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_1_0 <= a_2_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_1_1 <= stage2_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_1_2 <= stage2_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_1_3 <= stage2_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_1_4 <= stage2_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_1_5 <= stage2_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_1_6 <= stage2_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_1_7 <= stage2_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2008:30]
      stage2_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2008:30]
    end else begin
      stage2_regs_0_1_8 <= stage2_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_0_0 <= x_n_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_0_1 <= stage3_regs_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_0_2 <= stage3_regs_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_0_3 <= stage3_regs_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_0_4 <= stage3_regs_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_0_5 <= stage3_regs_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_0_6 <= stage3_regs_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_0_7 <= stage3_regs_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_0_8 <= stage3_regs_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_0_9 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_0_9 <= stage3_regs_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_0_10 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_0_10 <= stage3_regs_0_0_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_0_11 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_0_11 <= stage3_regs_0_0_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_1_0 <= a_2_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_1_1 <= stage3_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_1_2 <= stage3_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_1_3 <= stage3_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_1_4 <= stage3_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_1_5 <= stage3_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_1_6 <= stage3_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_1_7 <= stage3_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_1_8 <= stage3_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_1_9 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_1_9 <= stage3_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_1_10 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_1_10 <= stage3_regs_0_1_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2009:30]
      stage3_regs_0_1_11 <= 32'h0; // @[FloatingPointDesigns.scala 2009:30]
    end else begin
      stage3_regs_0_1_11 <= stage3_regs_0_1_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2010:30]
      stage4_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2010:30]
    end else begin
      stage4_regs_0_1_0 <= a_2_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2010:30]
      stage4_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2010:30]
    end else begin
      stage4_regs_0_1_1 <= stage4_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2010:30]
      stage4_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2010:30]
    end else begin
      stage4_regs_0_1_2 <= stage4_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2010:30]
      stage4_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2010:30]
    end else begin
      stage4_regs_0_1_3 <= stage4_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2010:30]
      stage4_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2010:30]
    end else begin
      stage4_regs_0_1_4 <= stage4_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2010:30]
      stage4_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2010:30]
    end else begin
      stage4_regs_0_1_5 <= stage4_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2010:30]
      stage4_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2010:30]
    end else begin
      stage4_regs_0_1_6 <= stage4_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2010:30]
      stage4_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2010:30]
    end else begin
      stage4_regs_0_1_7 <= stage4_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2010:30]
      stage4_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2010:30]
    end else begin
      stage4_regs_0_1_8 <= stage4_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2081:31]
      a_2_isr_to_r <= 32'h0; // @[FloatingPointDesigns.scala 2081:31]
    end else begin
      a_2_isr_to_r <= _a_2_isr_to_r_T_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2082:34]
      transition_regs_0 <= 32'h0; // @[FloatingPointDesigns.scala 2082:34]
    end else begin
      transition_regs_0 <= a_2_isr_to_r;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2082:34]
      transition_regs_1 <= 32'h0; // @[FloatingPointDesigns.scala 2082:34]
    end else begin
      transition_regs_1 <= transition_regs_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2082:34]
      transition_regs_2 <= 32'h0; // @[FloatingPointDesigns.scala 2082:34]
    end else begin
      transition_regs_2 <= transition_regs_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2082:34]
      transition_regs_3 <= 32'h0; // @[FloatingPointDesigns.scala 2082:34]
    end else begin
      transition_regs_3 <= transition_regs_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2082:34]
      transition_regs_4 <= 32'h0; // @[FloatingPointDesigns.scala 2082:34]
    end else begin
      transition_regs_4 <= transition_regs_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2082:34]
      transition_regs_5 <= 32'h0; // @[FloatingPointDesigns.scala 2082:34]
    end else begin
      transition_regs_5 <= transition_regs_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2082:34]
      transition_regs_6 <= 32'h0; // @[FloatingPointDesigns.scala 2082:34]
    end else begin
      transition_regs_6 <= transition_regs_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2082:34]
      transition_regs_7 <= 32'h0; // @[FloatingPointDesigns.scala 2082:34]
    end else begin
      transition_regs_7 <= transition_regs_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2082:34]
      transition_regs_8 <= 32'h0; // @[FloatingPointDesigns.scala 2082:34]
    end else begin
      transition_regs_8 <= transition_regs_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:24]
      x_n_r_0 <= 32'h0; // @[FloatingPointDesigns.scala 2098:24]
    end else begin
      x_n_r_0 <= _GEN_133;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:24]
      x_n_r_1 <= 32'h0; // @[FloatingPointDesigns.scala 2098:24]
    end else begin
      x_n_r_1 <= stage1_regs_r_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:24]
      x_n_r_3 <= 32'h0; // @[FloatingPointDesigns.scala 2098:24]
    end else begin
      x_n_r_3 <= _GEN_189;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:24]
      x_n_r_4 <= 32'h0; // @[FloatingPointDesigns.scala 2098:24]
    end else begin
      x_n_r_4 <= stage1_regs_r_1_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2099:24]
      a_2_r_0 <= 32'h0; // @[FloatingPointDesigns.scala 2099:24]
    end else begin
      a_2_r_0 <= transition_regs_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2099:24]
      a_2_r_1 <= 32'h0; // @[FloatingPointDesigns.scala 2099:24]
    end else begin
      a_2_r_1 <= stage1_regs_r_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2099:24]
      a_2_r_2 <= 32'h0; // @[FloatingPointDesigns.scala 2099:24]
    end else begin
      a_2_r_2 <= stage2_regs_r_0_1_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2099:24]
      a_2_r_3 <= 32'h0; // @[FloatingPointDesigns.scala 2099:24]
    end else begin
      a_2_r_3 <= stage3_regs_r_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2099:24]
      a_2_r_4 <= 32'h0; // @[FloatingPointDesigns.scala 2099:24]
    end else begin
      a_2_r_4 <= stage1_regs_r_1_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2099:24]
      a_2_r_5 <= 32'h0; // @[FloatingPointDesigns.scala 2099:24]
    end else begin
      a_2_r_5 <= stage2_regs_r_1_1_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_0_0 <= x_n_r_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_0_1 <= stage1_regs_r_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_0_2 <= stage1_regs_r_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_0_3 <= stage1_regs_r_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_0_4 <= stage1_regs_r_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_0_5 <= stage1_regs_r_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_0_6 <= stage1_regs_r_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_0_7 <= stage1_regs_r_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_0_8 <= stage1_regs_r_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_1_0 <= a_2_r_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_1_1 <= stage1_regs_r_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_1_2 <= stage1_regs_r_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_1_3 <= stage1_regs_r_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_1_4 <= stage1_regs_r_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_1_5 <= stage1_regs_r_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_1_6 <= stage1_regs_r_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_1_7 <= stage1_regs_r_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_0_1_8 <= stage1_regs_r_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_0_0 <= x_n_r_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_0_1 <= stage1_regs_r_1_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_0_2 <= stage1_regs_r_1_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_0_3 <= stage1_regs_r_1_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_0_4 <= stage1_regs_r_1_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_0_5 <= stage1_regs_r_1_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_0_6 <= stage1_regs_r_1_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_0_7 <= stage1_regs_r_1_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_0_8 <= stage1_regs_r_1_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_1_0 <= a_2_r_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_1_1 <= stage1_regs_r_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_1_2 <= stage1_regs_r_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_1_3 <= stage1_regs_r_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_1_4 <= stage1_regs_r_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_1_5 <= stage1_regs_r_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_1_6 <= stage1_regs_r_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_1_7 <= stage1_regs_r_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2100:32]
      stage1_regs_r_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2100:32]
    end else begin
      stage1_regs_r_1_1_8 <= stage1_regs_r_1_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_0_0 <= x_n_r_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_0_1 <= stage2_regs_r_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_0_2 <= stage2_regs_r_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_0_3 <= stage2_regs_r_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_0_4 <= stage2_regs_r_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_0_5 <= stage2_regs_r_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_0_6 <= stage2_regs_r_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_0_7 <= stage2_regs_r_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_0_8 <= stage2_regs_r_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_0_9 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_0_9 <= stage2_regs_r_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_0_10 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_0_10 <= stage2_regs_r_0_0_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_0_11 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_0_11 <= stage2_regs_r_0_0_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_1_0 <= a_2_r_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_1_1 <= stage2_regs_r_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_1_2 <= stage2_regs_r_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_1_3 <= stage2_regs_r_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_1_4 <= stage2_regs_r_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_1_5 <= stage2_regs_r_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_1_6 <= stage2_regs_r_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_1_7 <= stage2_regs_r_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_1_8 <= stage2_regs_r_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_1_9 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_1_9 <= stage2_regs_r_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_1_10 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_1_10 <= stage2_regs_r_0_1_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_0_1_11 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_0_1_11 <= stage2_regs_r_0_1_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_0_0 <= x_n_r_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_0_1 <= stage2_regs_r_1_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_0_2 <= stage2_regs_r_1_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_0_3 <= stage2_regs_r_1_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_0_4 <= stage2_regs_r_1_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_0_5 <= stage2_regs_r_1_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_0_6 <= stage2_regs_r_1_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_0_7 <= stage2_regs_r_1_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_0_8 <= stage2_regs_r_1_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_0_9 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_0_9 <= stage2_regs_r_1_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_0_10 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_0_10 <= stage2_regs_r_1_0_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_0_11 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_0_11 <= stage2_regs_r_1_0_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_1_0 <= a_2_r_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_1_1 <= stage2_regs_r_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_1_2 <= stage2_regs_r_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_1_3 <= stage2_regs_r_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_1_4 <= stage2_regs_r_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_1_5 <= stage2_regs_r_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_1_6 <= stage2_regs_r_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_1_7 <= stage2_regs_r_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_1_8 <= stage2_regs_r_1_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_1_9 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_1_9 <= stage2_regs_r_1_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_1_10 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_1_10 <= stage2_regs_r_1_1_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2101:32]
      stage2_regs_r_1_1_11 <= 32'h0; // @[FloatingPointDesigns.scala 2101:32]
    end else begin
      stage2_regs_r_1_1_11 <= stage2_regs_r_1_1_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_0_1_0 <= a_2_r_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_0_1_1 <= stage3_regs_r_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_0_1_2 <= stage3_regs_r_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_0_1_3 <= stage3_regs_r_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_0_1_4 <= stage3_regs_r_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_0_1_5 <= stage3_regs_r_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_0_1_6 <= stage3_regs_r_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_0_1_7 <= stage3_regs_r_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_0_1_8 <= stage3_regs_r_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_1_1_0 <= a_2_r_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_1_1_1 <= stage3_regs_r_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_1_1_2 <= stage3_regs_r_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_1_1_3 <= stage3_regs_r_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_1_1_4 <= stage3_regs_r_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_1_1_5 <= stage3_regs_r_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_1_1_6 <= stage3_regs_r_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_1_1_7 <= stage3_regs_r_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2102:32]
      stage3_regs_r_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2102:32]
    end else begin
      stage3_regs_r_1_1_8 <= stage3_regs_r_1_1_7;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  x_n_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  x_n_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  x_n_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  a_2_0 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  a_2_1 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  a_2_2 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  a_2_3 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  stage1_regs_0_0_0 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  stage1_regs_0_0_1 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  stage1_regs_0_0_2 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  stage1_regs_0_0_3 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  stage1_regs_0_0_4 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  stage1_regs_0_0_5 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  stage1_regs_0_0_6 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  stage1_regs_0_0_7 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  stage1_regs_0_0_8 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  stage1_regs_0_1_0 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  stage1_regs_0_1_1 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  stage1_regs_0_1_2 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  stage1_regs_0_1_3 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  stage1_regs_0_1_4 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  stage1_regs_0_1_5 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  stage1_regs_0_1_6 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  stage1_regs_0_1_7 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  stage1_regs_0_1_8 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  stage2_regs_0_0_0 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  stage2_regs_0_0_1 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  stage2_regs_0_0_2 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  stage2_regs_0_0_3 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  stage2_regs_0_0_4 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  stage2_regs_0_0_5 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  stage2_regs_0_0_6 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  stage2_regs_0_0_7 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  stage2_regs_0_0_8 = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  stage2_regs_0_1_0 = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  stage2_regs_0_1_1 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  stage2_regs_0_1_2 = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  stage2_regs_0_1_3 = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  stage2_regs_0_1_4 = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  stage2_regs_0_1_5 = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  stage2_regs_0_1_6 = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  stage2_regs_0_1_7 = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  stage2_regs_0_1_8 = _RAND_42[31:0];
  _RAND_43 = {1{`RANDOM}};
  stage3_regs_0_0_0 = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  stage3_regs_0_0_1 = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  stage3_regs_0_0_2 = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  stage3_regs_0_0_3 = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  stage3_regs_0_0_4 = _RAND_47[31:0];
  _RAND_48 = {1{`RANDOM}};
  stage3_regs_0_0_5 = _RAND_48[31:0];
  _RAND_49 = {1{`RANDOM}};
  stage3_regs_0_0_6 = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  stage3_regs_0_0_7 = _RAND_50[31:0];
  _RAND_51 = {1{`RANDOM}};
  stage3_regs_0_0_8 = _RAND_51[31:0];
  _RAND_52 = {1{`RANDOM}};
  stage3_regs_0_0_9 = _RAND_52[31:0];
  _RAND_53 = {1{`RANDOM}};
  stage3_regs_0_0_10 = _RAND_53[31:0];
  _RAND_54 = {1{`RANDOM}};
  stage3_regs_0_0_11 = _RAND_54[31:0];
  _RAND_55 = {1{`RANDOM}};
  stage3_regs_0_1_0 = _RAND_55[31:0];
  _RAND_56 = {1{`RANDOM}};
  stage3_regs_0_1_1 = _RAND_56[31:0];
  _RAND_57 = {1{`RANDOM}};
  stage3_regs_0_1_2 = _RAND_57[31:0];
  _RAND_58 = {1{`RANDOM}};
  stage3_regs_0_1_3 = _RAND_58[31:0];
  _RAND_59 = {1{`RANDOM}};
  stage3_regs_0_1_4 = _RAND_59[31:0];
  _RAND_60 = {1{`RANDOM}};
  stage3_regs_0_1_5 = _RAND_60[31:0];
  _RAND_61 = {1{`RANDOM}};
  stage3_regs_0_1_6 = _RAND_61[31:0];
  _RAND_62 = {1{`RANDOM}};
  stage3_regs_0_1_7 = _RAND_62[31:0];
  _RAND_63 = {1{`RANDOM}};
  stage3_regs_0_1_8 = _RAND_63[31:0];
  _RAND_64 = {1{`RANDOM}};
  stage3_regs_0_1_9 = _RAND_64[31:0];
  _RAND_65 = {1{`RANDOM}};
  stage3_regs_0_1_10 = _RAND_65[31:0];
  _RAND_66 = {1{`RANDOM}};
  stage3_regs_0_1_11 = _RAND_66[31:0];
  _RAND_67 = {1{`RANDOM}};
  stage4_regs_0_1_0 = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  stage4_regs_0_1_1 = _RAND_68[31:0];
  _RAND_69 = {1{`RANDOM}};
  stage4_regs_0_1_2 = _RAND_69[31:0];
  _RAND_70 = {1{`RANDOM}};
  stage4_regs_0_1_3 = _RAND_70[31:0];
  _RAND_71 = {1{`RANDOM}};
  stage4_regs_0_1_4 = _RAND_71[31:0];
  _RAND_72 = {1{`RANDOM}};
  stage4_regs_0_1_5 = _RAND_72[31:0];
  _RAND_73 = {1{`RANDOM}};
  stage4_regs_0_1_6 = _RAND_73[31:0];
  _RAND_74 = {1{`RANDOM}};
  stage4_regs_0_1_7 = _RAND_74[31:0];
  _RAND_75 = {1{`RANDOM}};
  stage4_regs_0_1_8 = _RAND_75[31:0];
  _RAND_76 = {1{`RANDOM}};
  a_2_isr_to_r = _RAND_76[31:0];
  _RAND_77 = {1{`RANDOM}};
  transition_regs_0 = _RAND_77[31:0];
  _RAND_78 = {1{`RANDOM}};
  transition_regs_1 = _RAND_78[31:0];
  _RAND_79 = {1{`RANDOM}};
  transition_regs_2 = _RAND_79[31:0];
  _RAND_80 = {1{`RANDOM}};
  transition_regs_3 = _RAND_80[31:0];
  _RAND_81 = {1{`RANDOM}};
  transition_regs_4 = _RAND_81[31:0];
  _RAND_82 = {1{`RANDOM}};
  transition_regs_5 = _RAND_82[31:0];
  _RAND_83 = {1{`RANDOM}};
  transition_regs_6 = _RAND_83[31:0];
  _RAND_84 = {1{`RANDOM}};
  transition_regs_7 = _RAND_84[31:0];
  _RAND_85 = {1{`RANDOM}};
  transition_regs_8 = _RAND_85[31:0];
  _RAND_86 = {1{`RANDOM}};
  x_n_r_0 = _RAND_86[31:0];
  _RAND_87 = {1{`RANDOM}};
  x_n_r_1 = _RAND_87[31:0];
  _RAND_88 = {1{`RANDOM}};
  x_n_r_3 = _RAND_88[31:0];
  _RAND_89 = {1{`RANDOM}};
  x_n_r_4 = _RAND_89[31:0];
  _RAND_90 = {1{`RANDOM}};
  a_2_r_0 = _RAND_90[31:0];
  _RAND_91 = {1{`RANDOM}};
  a_2_r_1 = _RAND_91[31:0];
  _RAND_92 = {1{`RANDOM}};
  a_2_r_2 = _RAND_92[31:0];
  _RAND_93 = {1{`RANDOM}};
  a_2_r_3 = _RAND_93[31:0];
  _RAND_94 = {1{`RANDOM}};
  a_2_r_4 = _RAND_94[31:0];
  _RAND_95 = {1{`RANDOM}};
  a_2_r_5 = _RAND_95[31:0];
  _RAND_96 = {1{`RANDOM}};
  stage1_regs_r_0_0_0 = _RAND_96[31:0];
  _RAND_97 = {1{`RANDOM}};
  stage1_regs_r_0_0_1 = _RAND_97[31:0];
  _RAND_98 = {1{`RANDOM}};
  stage1_regs_r_0_0_2 = _RAND_98[31:0];
  _RAND_99 = {1{`RANDOM}};
  stage1_regs_r_0_0_3 = _RAND_99[31:0];
  _RAND_100 = {1{`RANDOM}};
  stage1_regs_r_0_0_4 = _RAND_100[31:0];
  _RAND_101 = {1{`RANDOM}};
  stage1_regs_r_0_0_5 = _RAND_101[31:0];
  _RAND_102 = {1{`RANDOM}};
  stage1_regs_r_0_0_6 = _RAND_102[31:0];
  _RAND_103 = {1{`RANDOM}};
  stage1_regs_r_0_0_7 = _RAND_103[31:0];
  _RAND_104 = {1{`RANDOM}};
  stage1_regs_r_0_0_8 = _RAND_104[31:0];
  _RAND_105 = {1{`RANDOM}};
  stage1_regs_r_0_1_0 = _RAND_105[31:0];
  _RAND_106 = {1{`RANDOM}};
  stage1_regs_r_0_1_1 = _RAND_106[31:0];
  _RAND_107 = {1{`RANDOM}};
  stage1_regs_r_0_1_2 = _RAND_107[31:0];
  _RAND_108 = {1{`RANDOM}};
  stage1_regs_r_0_1_3 = _RAND_108[31:0];
  _RAND_109 = {1{`RANDOM}};
  stage1_regs_r_0_1_4 = _RAND_109[31:0];
  _RAND_110 = {1{`RANDOM}};
  stage1_regs_r_0_1_5 = _RAND_110[31:0];
  _RAND_111 = {1{`RANDOM}};
  stage1_regs_r_0_1_6 = _RAND_111[31:0];
  _RAND_112 = {1{`RANDOM}};
  stage1_regs_r_0_1_7 = _RAND_112[31:0];
  _RAND_113 = {1{`RANDOM}};
  stage1_regs_r_0_1_8 = _RAND_113[31:0];
  _RAND_114 = {1{`RANDOM}};
  stage1_regs_r_1_0_0 = _RAND_114[31:0];
  _RAND_115 = {1{`RANDOM}};
  stage1_regs_r_1_0_1 = _RAND_115[31:0];
  _RAND_116 = {1{`RANDOM}};
  stage1_regs_r_1_0_2 = _RAND_116[31:0];
  _RAND_117 = {1{`RANDOM}};
  stage1_regs_r_1_0_3 = _RAND_117[31:0];
  _RAND_118 = {1{`RANDOM}};
  stage1_regs_r_1_0_4 = _RAND_118[31:0];
  _RAND_119 = {1{`RANDOM}};
  stage1_regs_r_1_0_5 = _RAND_119[31:0];
  _RAND_120 = {1{`RANDOM}};
  stage1_regs_r_1_0_6 = _RAND_120[31:0];
  _RAND_121 = {1{`RANDOM}};
  stage1_regs_r_1_0_7 = _RAND_121[31:0];
  _RAND_122 = {1{`RANDOM}};
  stage1_regs_r_1_0_8 = _RAND_122[31:0];
  _RAND_123 = {1{`RANDOM}};
  stage1_regs_r_1_1_0 = _RAND_123[31:0];
  _RAND_124 = {1{`RANDOM}};
  stage1_regs_r_1_1_1 = _RAND_124[31:0];
  _RAND_125 = {1{`RANDOM}};
  stage1_regs_r_1_1_2 = _RAND_125[31:0];
  _RAND_126 = {1{`RANDOM}};
  stage1_regs_r_1_1_3 = _RAND_126[31:0];
  _RAND_127 = {1{`RANDOM}};
  stage1_regs_r_1_1_4 = _RAND_127[31:0];
  _RAND_128 = {1{`RANDOM}};
  stage1_regs_r_1_1_5 = _RAND_128[31:0];
  _RAND_129 = {1{`RANDOM}};
  stage1_regs_r_1_1_6 = _RAND_129[31:0];
  _RAND_130 = {1{`RANDOM}};
  stage1_regs_r_1_1_7 = _RAND_130[31:0];
  _RAND_131 = {1{`RANDOM}};
  stage1_regs_r_1_1_8 = _RAND_131[31:0];
  _RAND_132 = {1{`RANDOM}};
  stage2_regs_r_0_0_0 = _RAND_132[31:0];
  _RAND_133 = {1{`RANDOM}};
  stage2_regs_r_0_0_1 = _RAND_133[31:0];
  _RAND_134 = {1{`RANDOM}};
  stage2_regs_r_0_0_2 = _RAND_134[31:0];
  _RAND_135 = {1{`RANDOM}};
  stage2_regs_r_0_0_3 = _RAND_135[31:0];
  _RAND_136 = {1{`RANDOM}};
  stage2_regs_r_0_0_4 = _RAND_136[31:0];
  _RAND_137 = {1{`RANDOM}};
  stage2_regs_r_0_0_5 = _RAND_137[31:0];
  _RAND_138 = {1{`RANDOM}};
  stage2_regs_r_0_0_6 = _RAND_138[31:0];
  _RAND_139 = {1{`RANDOM}};
  stage2_regs_r_0_0_7 = _RAND_139[31:0];
  _RAND_140 = {1{`RANDOM}};
  stage2_regs_r_0_0_8 = _RAND_140[31:0];
  _RAND_141 = {1{`RANDOM}};
  stage2_regs_r_0_0_9 = _RAND_141[31:0];
  _RAND_142 = {1{`RANDOM}};
  stage2_regs_r_0_0_10 = _RAND_142[31:0];
  _RAND_143 = {1{`RANDOM}};
  stage2_regs_r_0_0_11 = _RAND_143[31:0];
  _RAND_144 = {1{`RANDOM}};
  stage2_regs_r_0_1_0 = _RAND_144[31:0];
  _RAND_145 = {1{`RANDOM}};
  stage2_regs_r_0_1_1 = _RAND_145[31:0];
  _RAND_146 = {1{`RANDOM}};
  stage2_regs_r_0_1_2 = _RAND_146[31:0];
  _RAND_147 = {1{`RANDOM}};
  stage2_regs_r_0_1_3 = _RAND_147[31:0];
  _RAND_148 = {1{`RANDOM}};
  stage2_regs_r_0_1_4 = _RAND_148[31:0];
  _RAND_149 = {1{`RANDOM}};
  stage2_regs_r_0_1_5 = _RAND_149[31:0];
  _RAND_150 = {1{`RANDOM}};
  stage2_regs_r_0_1_6 = _RAND_150[31:0];
  _RAND_151 = {1{`RANDOM}};
  stage2_regs_r_0_1_7 = _RAND_151[31:0];
  _RAND_152 = {1{`RANDOM}};
  stage2_regs_r_0_1_8 = _RAND_152[31:0];
  _RAND_153 = {1{`RANDOM}};
  stage2_regs_r_0_1_9 = _RAND_153[31:0];
  _RAND_154 = {1{`RANDOM}};
  stage2_regs_r_0_1_10 = _RAND_154[31:0];
  _RAND_155 = {1{`RANDOM}};
  stage2_regs_r_0_1_11 = _RAND_155[31:0];
  _RAND_156 = {1{`RANDOM}};
  stage2_regs_r_1_0_0 = _RAND_156[31:0];
  _RAND_157 = {1{`RANDOM}};
  stage2_regs_r_1_0_1 = _RAND_157[31:0];
  _RAND_158 = {1{`RANDOM}};
  stage2_regs_r_1_0_2 = _RAND_158[31:0];
  _RAND_159 = {1{`RANDOM}};
  stage2_regs_r_1_0_3 = _RAND_159[31:0];
  _RAND_160 = {1{`RANDOM}};
  stage2_regs_r_1_0_4 = _RAND_160[31:0];
  _RAND_161 = {1{`RANDOM}};
  stage2_regs_r_1_0_5 = _RAND_161[31:0];
  _RAND_162 = {1{`RANDOM}};
  stage2_regs_r_1_0_6 = _RAND_162[31:0];
  _RAND_163 = {1{`RANDOM}};
  stage2_regs_r_1_0_7 = _RAND_163[31:0];
  _RAND_164 = {1{`RANDOM}};
  stage2_regs_r_1_0_8 = _RAND_164[31:0];
  _RAND_165 = {1{`RANDOM}};
  stage2_regs_r_1_0_9 = _RAND_165[31:0];
  _RAND_166 = {1{`RANDOM}};
  stage2_regs_r_1_0_10 = _RAND_166[31:0];
  _RAND_167 = {1{`RANDOM}};
  stage2_regs_r_1_0_11 = _RAND_167[31:0];
  _RAND_168 = {1{`RANDOM}};
  stage2_regs_r_1_1_0 = _RAND_168[31:0];
  _RAND_169 = {1{`RANDOM}};
  stage2_regs_r_1_1_1 = _RAND_169[31:0];
  _RAND_170 = {1{`RANDOM}};
  stage2_regs_r_1_1_2 = _RAND_170[31:0];
  _RAND_171 = {1{`RANDOM}};
  stage2_regs_r_1_1_3 = _RAND_171[31:0];
  _RAND_172 = {1{`RANDOM}};
  stage2_regs_r_1_1_4 = _RAND_172[31:0];
  _RAND_173 = {1{`RANDOM}};
  stage2_regs_r_1_1_5 = _RAND_173[31:0];
  _RAND_174 = {1{`RANDOM}};
  stage2_regs_r_1_1_6 = _RAND_174[31:0];
  _RAND_175 = {1{`RANDOM}};
  stage2_regs_r_1_1_7 = _RAND_175[31:0];
  _RAND_176 = {1{`RANDOM}};
  stage2_regs_r_1_1_8 = _RAND_176[31:0];
  _RAND_177 = {1{`RANDOM}};
  stage2_regs_r_1_1_9 = _RAND_177[31:0];
  _RAND_178 = {1{`RANDOM}};
  stage2_regs_r_1_1_10 = _RAND_178[31:0];
  _RAND_179 = {1{`RANDOM}};
  stage2_regs_r_1_1_11 = _RAND_179[31:0];
  _RAND_180 = {1{`RANDOM}};
  stage3_regs_r_0_1_0 = _RAND_180[31:0];
  _RAND_181 = {1{`RANDOM}};
  stage3_regs_r_0_1_1 = _RAND_181[31:0];
  _RAND_182 = {1{`RANDOM}};
  stage3_regs_r_0_1_2 = _RAND_182[31:0];
  _RAND_183 = {1{`RANDOM}};
  stage3_regs_r_0_1_3 = _RAND_183[31:0];
  _RAND_184 = {1{`RANDOM}};
  stage3_regs_r_0_1_4 = _RAND_184[31:0];
  _RAND_185 = {1{`RANDOM}};
  stage3_regs_r_0_1_5 = _RAND_185[31:0];
  _RAND_186 = {1{`RANDOM}};
  stage3_regs_r_0_1_6 = _RAND_186[31:0];
  _RAND_187 = {1{`RANDOM}};
  stage3_regs_r_0_1_7 = _RAND_187[31:0];
  _RAND_188 = {1{`RANDOM}};
  stage3_regs_r_0_1_8 = _RAND_188[31:0];
  _RAND_189 = {1{`RANDOM}};
  stage3_regs_r_1_1_0 = _RAND_189[31:0];
  _RAND_190 = {1{`RANDOM}};
  stage3_regs_r_1_1_1 = _RAND_190[31:0];
  _RAND_191 = {1{`RANDOM}};
  stage3_regs_r_1_1_2 = _RAND_191[31:0];
  _RAND_192 = {1{`RANDOM}};
  stage3_regs_r_1_1_3 = _RAND_192[31:0];
  _RAND_193 = {1{`RANDOM}};
  stage3_regs_r_1_1_4 = _RAND_193[31:0];
  _RAND_194 = {1{`RANDOM}};
  stage3_regs_r_1_1_5 = _RAND_194[31:0];
  _RAND_195 = {1{`RANDOM}};
  stage3_regs_r_1_1_6 = _RAND_195[31:0];
  _RAND_196 = {1{`RANDOM}};
  stage3_regs_r_1_1_7 = _RAND_196[31:0];
  _RAND_197 = {1{`RANDOM}};
  stage3_regs_r_1_1_8 = _RAND_197[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FP_divider_newfpu_19(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
`endif // RANDOMIZE_REG_INIT
  wire  FP_reciprocal_newfpu_19_clock; // @[FloatingPointDesigns.scala 2177:28]
  wire  FP_reciprocal_newfpu_19_reset; // @[FloatingPointDesigns.scala 2177:28]
  wire [31:0] FP_reciprocal_newfpu_19_io_in_a; // @[FloatingPointDesigns.scala 2177:28]
  wire [31:0] FP_reciprocal_newfpu_19_io_out_s; // @[FloatingPointDesigns.scala 2177:28]
  wire  FP_multiplier_10ccs_19_clock; // @[FloatingPointDesigns.scala 2180:28]
  wire  FP_multiplier_10ccs_19_reset; // @[FloatingPointDesigns.scala 2180:28]
  wire  FP_multiplier_10ccs_19_io_in_en; // @[FloatingPointDesigns.scala 2180:28]
  wire [31:0] FP_multiplier_10ccs_19_io_in_a; // @[FloatingPointDesigns.scala 2180:28]
  wire [31:0] FP_multiplier_10ccs_19_io_in_b; // @[FloatingPointDesigns.scala 2180:28]
  wire [31:0] FP_multiplier_10ccs_19_io_out_s; // @[FloatingPointDesigns.scala 2180:28]
  reg [31:0] regs_0; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_1; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_2; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_3; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_4; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_5; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_6; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_7; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_8; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_9; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_10; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_11; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_12; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_13; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_14; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_15; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_16; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_17; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_18; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_19; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_20; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_21; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_22; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_23; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_24; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_25; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_26; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_27; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_28; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_29; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_30; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_31; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_32; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_33; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_34; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_35; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_36; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_37; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_38; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_39; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_40; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_41; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_42; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_43; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_44; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_45; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_46; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_47; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_48; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_49; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_50; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_51; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_52; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_53; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_54; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_55; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_56; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_57; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_58; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_59; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_60; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_61; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_62; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_63; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_64; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_65; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_66; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_67; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_68; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_69; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_70; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_71; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_72; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_73; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_74; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_75; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_76; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_77; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_78; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_79; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_80; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_81; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_82; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_83; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_84; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_85; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_86; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_87; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_88; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_89; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_90; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_91; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_92; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_93; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_94; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_95; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_96; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_97; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_98; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_99; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_100; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_101; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_102; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_103; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_104; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_105; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_106; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_107; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_108; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_109; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_110; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_111; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_112; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_113; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_114; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_115; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_116; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_117; // @[FloatingPointDesigns.scala 2172:23]
  reg [31:0] regs_118; // @[FloatingPointDesigns.scala 2172:23]
  FP_reciprocal_newfpu_19 FP_reciprocal_newfpu_19 ( // @[FloatingPointDesigns.scala 2177:28]
    .clock(FP_reciprocal_newfpu_19_clock),
    .reset(FP_reciprocal_newfpu_19_reset),
    .io_in_a(FP_reciprocal_newfpu_19_io_in_a),
    .io_out_s(FP_reciprocal_newfpu_19_io_out_s)
  );
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19 ( // @[FloatingPointDesigns.scala 2180:28]
    .clock(FP_multiplier_10ccs_19_clock),
    .reset(FP_multiplier_10ccs_19_reset),
    .io_in_en(FP_multiplier_10ccs_19_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_io_out_s)
  );
  assign io_out_s = FP_multiplier_10ccs_19_io_out_s; // @[FloatingPointDesigns.scala 2184:14]
  assign FP_reciprocal_newfpu_19_clock = clock;
  assign FP_reciprocal_newfpu_19_reset = reset;
  assign FP_reciprocal_newfpu_19_io_in_a = io_in_b; // @[FloatingPointDesigns.scala 2179:21]
  assign FP_multiplier_10ccs_19_clock = clock;
  assign FP_multiplier_10ccs_19_reset = reset;
  assign FP_multiplier_10ccs_19_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2181:22]
  assign FP_multiplier_10ccs_19_io_in_a = regs_118; // @[FloatingPointDesigns.scala 2182:21]
  assign FP_multiplier_10ccs_19_io_in_b = FP_reciprocal_newfpu_19_io_out_s; // @[FloatingPointDesigns.scala 2183:21]
  always @(posedge clock) begin
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_0 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_0 <= io_in_a; // @[FloatingPointDesigns.scala 2173:13]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_1 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_1 <= regs_0; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_2 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_2 <= regs_1; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_3 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_3 <= regs_2; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_4 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_4 <= regs_3; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_5 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_5 <= regs_4; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_6 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_6 <= regs_5; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_7 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_7 <= regs_6; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_8 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_8 <= regs_7; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_9 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_9 <= regs_8; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_10 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_10 <= regs_9; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_11 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_11 <= regs_10; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_12 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_12 <= regs_11; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_13 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_13 <= regs_12; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_14 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_14 <= regs_13; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_15 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_15 <= regs_14; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_16 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_16 <= regs_15; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_17 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_17 <= regs_16; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_18 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_18 <= regs_17; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_19 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_19 <= regs_18; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_20 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_20 <= regs_19; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_21 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_21 <= regs_20; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_22 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_22 <= regs_21; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_23 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_23 <= regs_22; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_24 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_24 <= regs_23; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_25 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_25 <= regs_24; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_26 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_26 <= regs_25; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_27 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_27 <= regs_26; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_28 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_28 <= regs_27; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_29 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_29 <= regs_28; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_30 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_30 <= regs_29; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_31 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_31 <= regs_30; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_32 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_32 <= regs_31; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_33 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_33 <= regs_32; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_34 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_34 <= regs_33; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_35 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_35 <= regs_34; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_36 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_36 <= regs_35; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_37 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_37 <= regs_36; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_38 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_38 <= regs_37; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_39 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_39 <= regs_38; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_40 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_40 <= regs_39; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_41 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_41 <= regs_40; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_42 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_42 <= regs_41; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_43 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_43 <= regs_42; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_44 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_44 <= regs_43; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_45 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_45 <= regs_44; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_46 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_46 <= regs_45; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_47 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_47 <= regs_46; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_48 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_48 <= regs_47; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_49 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_49 <= regs_48; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_50 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_50 <= regs_49; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_51 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_51 <= regs_50; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_52 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_52 <= regs_51; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_53 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_53 <= regs_52; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_54 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_54 <= regs_53; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_55 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_55 <= regs_54; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_56 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_56 <= regs_55; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_57 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_57 <= regs_56; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_58 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_58 <= regs_57; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_59 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_59 <= regs_58; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_60 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_60 <= regs_59; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_61 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_61 <= regs_60; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_62 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_62 <= regs_61; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_63 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_63 <= regs_62; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_64 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_64 <= regs_63; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_65 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_65 <= regs_64; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_66 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_66 <= regs_65; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_67 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_67 <= regs_66; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_68 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_68 <= regs_67; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_69 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_69 <= regs_68; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_70 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_70 <= regs_69; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_71 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_71 <= regs_70; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_72 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_72 <= regs_71; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_73 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_73 <= regs_72; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_74 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_74 <= regs_73; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_75 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_75 <= regs_74; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_76 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_76 <= regs_75; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_77 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_77 <= regs_76; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_78 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_78 <= regs_77; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_79 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_79 <= regs_78; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_80 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_80 <= regs_79; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_81 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_81 <= regs_80; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_82 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_82 <= regs_81; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_83 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_83 <= regs_82; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_84 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_84 <= regs_83; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_85 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_85 <= regs_84; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_86 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_86 <= regs_85; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_87 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_87 <= regs_86; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_88 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_88 <= regs_87; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_89 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_89 <= regs_88; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_90 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_90 <= regs_89; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_91 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_91 <= regs_90; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_92 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_92 <= regs_91; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_93 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_93 <= regs_92; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_94 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_94 <= regs_93; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_95 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_95 <= regs_94; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_96 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_96 <= regs_95; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_97 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_97 <= regs_96; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_98 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_98 <= regs_97; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_99 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_99 <= regs_98; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_100 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_100 <= regs_99; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_101 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_101 <= regs_100; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_102 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_102 <= regs_101; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_103 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_103 <= regs_102; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_104 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_104 <= regs_103; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_105 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_105 <= regs_104; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_106 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_106 <= regs_105; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_107 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_107 <= regs_106; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_108 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_108 <= regs_107; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_109 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_109 <= regs_108; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_110 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_110 <= regs_109; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_111 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_111 <= regs_110; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_112 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_112 <= regs_111; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_113 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_113 <= regs_112; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_114 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_114 <= regs_113; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_115 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_115 <= regs_114; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_116 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_116 <= regs_115; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_117 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_117 <= regs_116; // @[FloatingPointDesigns.scala 2175:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2172:23]
      regs_118 <= 32'h0; // @[FloatingPointDesigns.scala 2172:23]
    end else begin
      regs_118 <= regs_117; // @[FloatingPointDesigns.scala 2175:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regs_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  regs_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  regs_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  regs_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  regs_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  regs_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  regs_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  regs_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  regs_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  regs_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  regs_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  regs_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  regs_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  regs_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  regs_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  regs_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  regs_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  regs_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  regs_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  regs_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  regs_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  regs_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  regs_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  regs_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  regs_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  regs_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  regs_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  regs_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  regs_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  regs_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  regs_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  regs_31 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  regs_32 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  regs_33 = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  regs_34 = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  regs_35 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  regs_36 = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  regs_37 = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  regs_38 = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  regs_39 = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  regs_40 = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  regs_41 = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  regs_42 = _RAND_42[31:0];
  _RAND_43 = {1{`RANDOM}};
  regs_43 = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  regs_44 = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  regs_45 = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  regs_46 = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  regs_47 = _RAND_47[31:0];
  _RAND_48 = {1{`RANDOM}};
  regs_48 = _RAND_48[31:0];
  _RAND_49 = {1{`RANDOM}};
  regs_49 = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  regs_50 = _RAND_50[31:0];
  _RAND_51 = {1{`RANDOM}};
  regs_51 = _RAND_51[31:0];
  _RAND_52 = {1{`RANDOM}};
  regs_52 = _RAND_52[31:0];
  _RAND_53 = {1{`RANDOM}};
  regs_53 = _RAND_53[31:0];
  _RAND_54 = {1{`RANDOM}};
  regs_54 = _RAND_54[31:0];
  _RAND_55 = {1{`RANDOM}};
  regs_55 = _RAND_55[31:0];
  _RAND_56 = {1{`RANDOM}};
  regs_56 = _RAND_56[31:0];
  _RAND_57 = {1{`RANDOM}};
  regs_57 = _RAND_57[31:0];
  _RAND_58 = {1{`RANDOM}};
  regs_58 = _RAND_58[31:0];
  _RAND_59 = {1{`RANDOM}};
  regs_59 = _RAND_59[31:0];
  _RAND_60 = {1{`RANDOM}};
  regs_60 = _RAND_60[31:0];
  _RAND_61 = {1{`RANDOM}};
  regs_61 = _RAND_61[31:0];
  _RAND_62 = {1{`RANDOM}};
  regs_62 = _RAND_62[31:0];
  _RAND_63 = {1{`RANDOM}};
  regs_63 = _RAND_63[31:0];
  _RAND_64 = {1{`RANDOM}};
  regs_64 = _RAND_64[31:0];
  _RAND_65 = {1{`RANDOM}};
  regs_65 = _RAND_65[31:0];
  _RAND_66 = {1{`RANDOM}};
  regs_66 = _RAND_66[31:0];
  _RAND_67 = {1{`RANDOM}};
  regs_67 = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  regs_68 = _RAND_68[31:0];
  _RAND_69 = {1{`RANDOM}};
  regs_69 = _RAND_69[31:0];
  _RAND_70 = {1{`RANDOM}};
  regs_70 = _RAND_70[31:0];
  _RAND_71 = {1{`RANDOM}};
  regs_71 = _RAND_71[31:0];
  _RAND_72 = {1{`RANDOM}};
  regs_72 = _RAND_72[31:0];
  _RAND_73 = {1{`RANDOM}};
  regs_73 = _RAND_73[31:0];
  _RAND_74 = {1{`RANDOM}};
  regs_74 = _RAND_74[31:0];
  _RAND_75 = {1{`RANDOM}};
  regs_75 = _RAND_75[31:0];
  _RAND_76 = {1{`RANDOM}};
  regs_76 = _RAND_76[31:0];
  _RAND_77 = {1{`RANDOM}};
  regs_77 = _RAND_77[31:0];
  _RAND_78 = {1{`RANDOM}};
  regs_78 = _RAND_78[31:0];
  _RAND_79 = {1{`RANDOM}};
  regs_79 = _RAND_79[31:0];
  _RAND_80 = {1{`RANDOM}};
  regs_80 = _RAND_80[31:0];
  _RAND_81 = {1{`RANDOM}};
  regs_81 = _RAND_81[31:0];
  _RAND_82 = {1{`RANDOM}};
  regs_82 = _RAND_82[31:0];
  _RAND_83 = {1{`RANDOM}};
  regs_83 = _RAND_83[31:0];
  _RAND_84 = {1{`RANDOM}};
  regs_84 = _RAND_84[31:0];
  _RAND_85 = {1{`RANDOM}};
  regs_85 = _RAND_85[31:0];
  _RAND_86 = {1{`RANDOM}};
  regs_86 = _RAND_86[31:0];
  _RAND_87 = {1{`RANDOM}};
  regs_87 = _RAND_87[31:0];
  _RAND_88 = {1{`RANDOM}};
  regs_88 = _RAND_88[31:0];
  _RAND_89 = {1{`RANDOM}};
  regs_89 = _RAND_89[31:0];
  _RAND_90 = {1{`RANDOM}};
  regs_90 = _RAND_90[31:0];
  _RAND_91 = {1{`RANDOM}};
  regs_91 = _RAND_91[31:0];
  _RAND_92 = {1{`RANDOM}};
  regs_92 = _RAND_92[31:0];
  _RAND_93 = {1{`RANDOM}};
  regs_93 = _RAND_93[31:0];
  _RAND_94 = {1{`RANDOM}};
  regs_94 = _RAND_94[31:0];
  _RAND_95 = {1{`RANDOM}};
  regs_95 = _RAND_95[31:0];
  _RAND_96 = {1{`RANDOM}};
  regs_96 = _RAND_96[31:0];
  _RAND_97 = {1{`RANDOM}};
  regs_97 = _RAND_97[31:0];
  _RAND_98 = {1{`RANDOM}};
  regs_98 = _RAND_98[31:0];
  _RAND_99 = {1{`RANDOM}};
  regs_99 = _RAND_99[31:0];
  _RAND_100 = {1{`RANDOM}};
  regs_100 = _RAND_100[31:0];
  _RAND_101 = {1{`RANDOM}};
  regs_101 = _RAND_101[31:0];
  _RAND_102 = {1{`RANDOM}};
  regs_102 = _RAND_102[31:0];
  _RAND_103 = {1{`RANDOM}};
  regs_103 = _RAND_103[31:0];
  _RAND_104 = {1{`RANDOM}};
  regs_104 = _RAND_104[31:0];
  _RAND_105 = {1{`RANDOM}};
  regs_105 = _RAND_105[31:0];
  _RAND_106 = {1{`RANDOM}};
  regs_106 = _RAND_106[31:0];
  _RAND_107 = {1{`RANDOM}};
  regs_107 = _RAND_107[31:0];
  _RAND_108 = {1{`RANDOM}};
  regs_108 = _RAND_108[31:0];
  _RAND_109 = {1{`RANDOM}};
  regs_109 = _RAND_109[31:0];
  _RAND_110 = {1{`RANDOM}};
  regs_110 = _RAND_110[31:0];
  _RAND_111 = {1{`RANDOM}};
  regs_111 = _RAND_111[31:0];
  _RAND_112 = {1{`RANDOM}};
  regs_112 = _RAND_112[31:0];
  _RAND_113 = {1{`RANDOM}};
  regs_113 = _RAND_113[31:0];
  _RAND_114 = {1{`RANDOM}};
  regs_114 = _RAND_114[31:0];
  _RAND_115 = {1{`RANDOM}};
  regs_115 = _RAND_115[31:0];
  _RAND_116 = {1{`RANDOM}};
  regs_116 = _RAND_116[31:0];
  _RAND_117 = {1{`RANDOM}};
  regs_117 = _RAND_117[31:0];
  _RAND_118 = {1{`RANDOM}};
  regs_118 = _RAND_118[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module hqr5_complex_19(
  input         clock,
  input         reset,
  input  [31:0] io_in_a_Re,
  input  [31:0] io_in_a_Im,
  input  [31:0] io_in_b_Re,
  output [31:0] io_out_s_Re,
  output [31:0] io_out_s_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  FP_square_root_newfpu_19_clock; // @[FPComplex.scala 994:22]
  wire  FP_square_root_newfpu_19_reset; // @[FPComplex.scala 994:22]
  wire [31:0] FP_square_root_newfpu_19_io_in_a; // @[FPComplex.scala 994:22]
  wire [31:0] FP_square_root_newfpu_19_io_out_s; // @[FPComplex.scala 994:22]
  wire  FPComplexMult_v2_19_clock; // @[FPComplex.scala 995:29]
  wire  FPComplexMult_v2_19_reset; // @[FPComplex.scala 995:29]
  wire [31:0] FPComplexMult_v2_19_io_in_a_Re; // @[FPComplex.scala 995:29]
  wire [31:0] FPComplexMult_v2_19_io_in_a_Im; // @[FPComplex.scala 995:29]
  wire [31:0] FPComplexMult_v2_19_io_in_b_Re; // @[FPComplex.scala 995:29]
  wire [31:0] FPComplexMult_v2_19_io_in_b_Im; // @[FPComplex.scala 995:29]
  wire [31:0] FPComplexMult_v2_19_io_out_s_Re; // @[FPComplex.scala 995:29]
  wire [31:0] FPComplexMult_v2_19_io_out_s_Im; // @[FPComplex.scala 995:29]
  wire  FPComplexMult_v2_19_1_clock; // @[FPComplex.scala 996:29]
  wire  FPComplexMult_v2_19_1_reset; // @[FPComplex.scala 996:29]
  wire [31:0] FPComplexMult_v2_19_1_io_in_a_Re; // @[FPComplex.scala 996:29]
  wire [31:0] FPComplexMult_v2_19_1_io_in_a_Im; // @[FPComplex.scala 996:29]
  wire [31:0] FPComplexMult_v2_19_1_io_in_b_Re; // @[FPComplex.scala 996:29]
  wire [31:0] FPComplexMult_v2_19_1_io_in_b_Im; // @[FPComplex.scala 996:29]
  wire [31:0] FPComplexMult_v2_19_1_io_out_s_Re; // @[FPComplex.scala 996:29]
  wire [31:0] FPComplexMult_v2_19_1_io_out_s_Im; // @[FPComplex.scala 996:29]
  wire  FP_divider_newfpu_19_clock; // @[FPComplex.scala 1000:21]
  wire  FP_divider_newfpu_19_reset; // @[FPComplex.scala 1000:21]
  wire [31:0] FP_divider_newfpu_19_io_in_a; // @[FPComplex.scala 1000:21]
  wire [31:0] FP_divider_newfpu_19_io_in_b; // @[FPComplex.scala 1000:21]
  wire [31:0] FP_divider_newfpu_19_io_out_s; // @[FPComplex.scala 1000:21]
  wire  FP_divider_newfpu_19_1_clock; // @[FPComplex.scala 1001:21]
  wire  FP_divider_newfpu_19_1_reset; // @[FPComplex.scala 1001:21]
  wire [31:0] FP_divider_newfpu_19_1_io_in_a; // @[FPComplex.scala 1001:21]
  wire [31:0] FP_divider_newfpu_19_1_io_in_b; // @[FPComplex.scala 1001:21]
  wire [31:0] FP_divider_newfpu_19_1_io_out_s; // @[FPComplex.scala 1001:21]
  wire  FPComplexAdder_v2_19_clock; // @[FPComplex.scala 1003:23]
  wire  FPComplexAdder_v2_19_reset; // @[FPComplex.scala 1003:23]
  wire [31:0] FPComplexAdder_v2_19_io_in_a_Re; // @[FPComplex.scala 1003:23]
  wire [31:0] FPComplexAdder_v2_19_io_in_a_Im; // @[FPComplex.scala 1003:23]
  wire [31:0] FPComplexAdder_v2_19_io_in_b_Re; // @[FPComplex.scala 1003:23]
  wire [31:0] FPComplexAdder_v2_19_io_in_b_Im; // @[FPComplex.scala 1003:23]
  wire [31:0] FPComplexAdder_v2_19_io_out_s_Re; // @[FPComplex.scala 1003:23]
  wire [31:0] FPComplexAdder_v2_19_io_out_s_Im; // @[FPComplex.scala 1003:23]
  reg [31:0] cd1; // @[FPComplex.scala 1004:18]
  reg [31:0] cd2; // @[FPComplex.scala 1005:18]
  reg [31:0] s_Re; // @[FPComplex.scala 1007:16]
  reg [31:0] s_Im; // @[FPComplex.scala 1007:16]
  FP_square_root_newfpu_19 FP_square_root_newfpu_19 ( // @[FPComplex.scala 994:22]
    .clock(FP_square_root_newfpu_19_clock),
    .reset(FP_square_root_newfpu_19_reset),
    .io_in_a(FP_square_root_newfpu_19_io_in_a),
    .io_out_s(FP_square_root_newfpu_19_io_out_s)
  );
  FPComplexMult_v2_19 FPComplexMult_v2_19 ( // @[FPComplex.scala 995:29]
    .clock(FPComplexMult_v2_19_clock),
    .reset(FPComplexMult_v2_19_reset),
    .io_in_a_Re(FPComplexMult_v2_19_io_in_a_Re),
    .io_in_a_Im(FPComplexMult_v2_19_io_in_a_Im),
    .io_in_b_Re(FPComplexMult_v2_19_io_in_b_Re),
    .io_in_b_Im(FPComplexMult_v2_19_io_in_b_Im),
    .io_out_s_Re(FPComplexMult_v2_19_io_out_s_Re),
    .io_out_s_Im(FPComplexMult_v2_19_io_out_s_Im)
  );
  FPComplexMult_v2_19 FPComplexMult_v2_19_1 ( // @[FPComplex.scala 996:29]
    .clock(FPComplexMult_v2_19_1_clock),
    .reset(FPComplexMult_v2_19_1_reset),
    .io_in_a_Re(FPComplexMult_v2_19_1_io_in_a_Re),
    .io_in_a_Im(FPComplexMult_v2_19_1_io_in_a_Im),
    .io_in_b_Re(FPComplexMult_v2_19_1_io_in_b_Re),
    .io_in_b_Im(FPComplexMult_v2_19_1_io_in_b_Im),
    .io_out_s_Re(FPComplexMult_v2_19_1_io_out_s_Re),
    .io_out_s_Im(FPComplexMult_v2_19_1_io_out_s_Im)
  );
  FP_divider_newfpu_19 FP_divider_newfpu_19 ( // @[FPComplex.scala 1000:21]
    .clock(FP_divider_newfpu_19_clock),
    .reset(FP_divider_newfpu_19_reset),
    .io_in_a(FP_divider_newfpu_19_io_in_a),
    .io_in_b(FP_divider_newfpu_19_io_in_b),
    .io_out_s(FP_divider_newfpu_19_io_out_s)
  );
  FP_divider_newfpu_19 FP_divider_newfpu_19_1 ( // @[FPComplex.scala 1001:21]
    .clock(FP_divider_newfpu_19_1_clock),
    .reset(FP_divider_newfpu_19_1_reset),
    .io_in_a(FP_divider_newfpu_19_1_io_in_a),
    .io_in_b(FP_divider_newfpu_19_1_io_in_b),
    .io_out_s(FP_divider_newfpu_19_1_io_out_s)
  );
  FPComplexAdder_v2_19 FPComplexAdder_v2_19 ( // @[FPComplex.scala 1003:23]
    .clock(FPComplexAdder_v2_19_clock),
    .reset(FPComplexAdder_v2_19_reset),
    .io_in_a_Re(FPComplexAdder_v2_19_io_in_a_Re),
    .io_in_a_Im(FPComplexAdder_v2_19_io_in_a_Im),
    .io_in_b_Re(FPComplexAdder_v2_19_io_in_b_Re),
    .io_in_b_Im(FPComplexAdder_v2_19_io_in_b_Im),
    .io_out_s_Re(FPComplexAdder_v2_19_io_out_s_Re),
    .io_out_s_Im(FPComplexAdder_v2_19_io_out_s_Im)
  );
  assign io_out_s_Re = FPComplexAdder_v2_19_io_out_s_Re; // @[FPComplex.scala 1100:14]
  assign io_out_s_Im = FPComplexAdder_v2_19_io_out_s_Im; // @[FPComplex.scala 1100:14]
  assign FP_square_root_newfpu_19_clock = clock;
  assign FP_square_root_newfpu_19_reset = reset;
  assign FP_square_root_newfpu_19_io_in_a = cd1; // @[FPComplex.scala 1027:15]
  assign FPComplexMult_v2_19_clock = clock;
  assign FPComplexMult_v2_19_reset = reset;
  assign FPComplexMult_v2_19_io_in_a_Re = io_in_a_Re; // @[FPComplex.scala 1010:25 1011:18]
  assign FPComplexMult_v2_19_io_in_a_Im = io_in_a_Im ^ 32'h80000000; // @[FPComplex.scala 1012:31]
  assign FPComplexMult_v2_19_io_in_b_Re = io_in_a_Re; // @[FPComplex.scala 1016:22]
  assign FPComplexMult_v2_19_io_in_b_Im = io_in_a_Im; // @[FPComplex.scala 1016:22]
  assign FPComplexMult_v2_19_1_clock = clock;
  assign FPComplexMult_v2_19_1_reset = reset;
  assign FPComplexMult_v2_19_1_io_in_a_Re = s_Re; // @[FPComplex.scala 1093:22]
  assign FPComplexMult_v2_19_1_io_in_a_Im = s_Im; // @[FPComplex.scala 1093:22]
  assign FPComplexMult_v2_19_1_io_in_b_Re = io_in_b_Re; // @[FPComplex.scala 1094:22]
  assign FPComplexMult_v2_19_1_io_in_b_Im = 32'h0; // @[FPComplex.scala 1094:22]
  assign FP_divider_newfpu_19_clock = clock;
  assign FP_divider_newfpu_19_reset = reset;
  assign FP_divider_newfpu_19_io_in_a = io_in_a_Re; // @[FPComplex.scala 1060:14]
  assign FP_divider_newfpu_19_io_in_b = cd2; // @[FPComplex.scala 1061:14]
  assign FP_divider_newfpu_19_1_clock = clock;
  assign FP_divider_newfpu_19_1_reset = reset;
  assign FP_divider_newfpu_19_1_io_in_a = io_in_a_Im; // @[FPComplex.scala 1066:15]
  assign FP_divider_newfpu_19_1_io_in_b = cd2; // @[FPComplex.scala 1067:15]
  assign FPComplexAdder_v2_19_clock = clock;
  assign FPComplexAdder_v2_19_reset = reset;
  assign FPComplexAdder_v2_19_io_in_a_Re = io_in_a_Re; // @[FPComplex.scala 1097:16]
  assign FPComplexAdder_v2_19_io_in_a_Im = io_in_a_Im; // @[FPComplex.scala 1097:16]
  assign FPComplexAdder_v2_19_io_in_b_Re = FPComplexMult_v2_19_1_io_out_s_Re; // @[FPComplex.scala 1098:16]
  assign FPComplexAdder_v2_19_io_in_b_Im = FPComplexMult_v2_19_1_io_out_s_Im; // @[FPComplex.scala 1098:16]
  always @(posedge clock) begin
    cd1 <= FPComplexMult_v2_19_io_out_s_Re; // @[FPComplex.scala 1017:9]
    cd2 <= FP_square_root_newfpu_19_io_out_s; // @[FPComplex.scala 1028:9]
    s_Re <= FP_divider_newfpu_19_io_out_s; // @[FPComplex.scala 1088:12]
    s_Im <= FP_divider_newfpu_19_1_io_out_s; // @[FPComplex.scala 1089:12]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cd1 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  cd2 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  s_Re = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  s_Im = _RAND_3[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module hqr7_19(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
  output [31:0] io_out_s
);
  wire  FP_multiplier_10ccs_19_clock; // @[FloatingPointDesigns.scala 2548:28]
  wire  FP_multiplier_10ccs_19_reset; // @[FloatingPointDesigns.scala 2548:28]
  wire  FP_multiplier_10ccs_19_io_in_en; // @[FloatingPointDesigns.scala 2548:28]
  wire [31:0] FP_multiplier_10ccs_19_io_in_a; // @[FloatingPointDesigns.scala 2548:28]
  wire [31:0] FP_multiplier_10ccs_19_io_in_b; // @[FloatingPointDesigns.scala 2548:28]
  wire [31:0] FP_multiplier_10ccs_19_io_out_s; // @[FloatingPointDesigns.scala 2548:28]
  wire  FP_reciprocal_newfpu_19_clock; // @[FloatingPointDesigns.scala 2549:28]
  wire  FP_reciprocal_newfpu_19_reset; // @[FloatingPointDesigns.scala 2549:28]
  wire [31:0] FP_reciprocal_newfpu_19_io_in_a; // @[FloatingPointDesigns.scala 2549:28]
  wire [31:0] FP_reciprocal_newfpu_19_io_out_s; // @[FloatingPointDesigns.scala 2549:28]
  FP_multiplier_10ccs_19 FP_multiplier_10ccs_19 ( // @[FloatingPointDesigns.scala 2548:28]
    .clock(FP_multiplier_10ccs_19_clock),
    .reset(FP_multiplier_10ccs_19_reset),
    .io_in_en(FP_multiplier_10ccs_19_io_in_en),
    .io_in_a(FP_multiplier_10ccs_19_io_in_a),
    .io_in_b(FP_multiplier_10ccs_19_io_in_b),
    .io_out_s(FP_multiplier_10ccs_19_io_out_s)
  );
  FP_reciprocal_newfpu_19 FP_reciprocal_newfpu_19 ( // @[FloatingPointDesigns.scala 2549:28]
    .clock(FP_reciprocal_newfpu_19_clock),
    .reset(FP_reciprocal_newfpu_19_reset),
    .io_in_a(FP_reciprocal_newfpu_19_io_in_a),
    .io_out_s(FP_reciprocal_newfpu_19_io_out_s)
  );
  assign io_out_s = FP_multiplier_10ccs_19_io_out_s; // @[FloatingPointDesigns.scala 2556:14]
  assign FP_multiplier_10ccs_19_clock = clock;
  assign FP_multiplier_10ccs_19_reset = reset;
  assign FP_multiplier_10ccs_19_io_in_en = 1'h1; // @[FloatingPointDesigns.scala 2550:22]
  assign FP_multiplier_10ccs_19_io_in_a = 32'hc0000000; // @[FloatingPointDesigns.scala 2553:21]
  assign FP_multiplier_10ccs_19_io_in_b = FP_reciprocal_newfpu_19_io_out_s; // @[FloatingPointDesigns.scala 2554:21]
  assign FP_reciprocal_newfpu_19_clock = clock;
  assign FP_reciprocal_newfpu_19_reset = reset;
  assign FP_reciprocal_newfpu_19_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2552:21]
endmodule
module FPReg_19(
  input         clock,
  input         reset,
  input  [31:0] io_in_Re,
  input  [31:0] io_in_Im,
  output [31:0] io_out_Re,
  output [31:0] io_out_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_0_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_0_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_1_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_1_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_2_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_2_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_3_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_3_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_4_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_4_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_5_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_5_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_6_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_6_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_7_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_7_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_8_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_8_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_9_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_9_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_10_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_10_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_11_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_11_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_12_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_12_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_13_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_13_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_14_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_14_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_15_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_15_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_16_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_16_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_17_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_17_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_18_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_18_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_19_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_19_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_20_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_20_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_21_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_21_Im; // @[FPComplex.scala 936:22]
  reg [31:0] reg_22_Re; // @[FPComplex.scala 936:22]
  reg [31:0] reg_22_Im; // @[FPComplex.scala 936:22]
  assign io_out_Re = reg_22_Re; // @[FPComplex.scala 941:12]
  assign io_out_Im = reg_22_Im; // @[FPComplex.scala 941:12]
  always @(posedge clock) begin
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_0_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_0_Re <= io_in_Re; // @[FPComplex.scala 937:14]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_0_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_0_Im <= io_in_Im; // @[FPComplex.scala 937:14]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_1_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_1_Re <= reg_0_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_1_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_1_Im <= reg_0_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_2_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_2_Re <= reg_1_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_2_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_2_Im <= reg_1_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_3_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_3_Re <= reg_2_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_3_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_3_Im <= reg_2_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_4_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_4_Re <= reg_3_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_4_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_4_Im <= reg_3_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_5_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_5_Re <= reg_4_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_5_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_5_Im <= reg_4_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_6_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_6_Re <= reg_5_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_6_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_6_Im <= reg_5_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_7_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_7_Re <= reg_6_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_7_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_7_Im <= reg_6_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_8_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_8_Re <= reg_7_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_8_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_8_Im <= reg_7_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_9_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_9_Re <= reg_8_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_9_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_9_Im <= reg_8_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_10_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_10_Re <= reg_9_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_10_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_10_Im <= reg_9_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_11_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_11_Re <= reg_10_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_11_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_11_Im <= reg_10_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_12_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_12_Re <= reg_11_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_12_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_12_Im <= reg_11_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_13_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_13_Re <= reg_12_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_13_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_13_Im <= reg_12_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_14_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_14_Re <= reg_13_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_14_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_14_Im <= reg_13_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_15_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_15_Re <= reg_14_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_15_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_15_Im <= reg_14_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_16_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_16_Re <= reg_15_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_16_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_16_Im <= reg_15_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_17_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_17_Re <= reg_16_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_17_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_17_Im <= reg_16_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_18_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_18_Re <= reg_17_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_18_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_18_Im <= reg_17_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_19_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_19_Re <= reg_18_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_19_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_19_Im <= reg_18_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_20_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_20_Re <= reg_19_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_20_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_20_Im <= reg_19_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_21_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_21_Re <= reg_20_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_21_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_21_Im <= reg_20_Im; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_22_Re <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_22_Re <= reg_21_Re; // @[FPComplex.scala 939:16]
    end
    if (reset) begin // @[FPComplex.scala 936:22]
      reg_22_Im <= 32'h0; // @[FPComplex.scala 936:22]
    end else begin
      reg_22_Im <= reg_21_Im; // @[FPComplex.scala 939:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_0_Re = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  reg_0_Im = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  reg_1_Re = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  reg_1_Im = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  reg_2_Re = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  reg_2_Im = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  reg_3_Re = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  reg_3_Im = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  reg_4_Re = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  reg_4_Im = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  reg_5_Re = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  reg_5_Im = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  reg_6_Re = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  reg_6_Im = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  reg_7_Re = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  reg_7_Im = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  reg_8_Re = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  reg_8_Im = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  reg_9_Re = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  reg_9_Im = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  reg_10_Re = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  reg_10_Im = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  reg_11_Re = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  reg_11_Im = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  reg_12_Re = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  reg_12_Im = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  reg_13_Re = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  reg_13_Im = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  reg_14_Re = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  reg_14_Im = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  reg_15_Re = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  reg_15_Im = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  reg_16_Re = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  reg_16_Im = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  reg_17_Re = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  reg_17_Im = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  reg_18_Re = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  reg_18_Im = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  reg_19_Re = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  reg_19_Im = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  reg_20_Re = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  reg_20_Im = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  reg_21_Re = _RAND_42[31:0];
  _RAND_43 = {1{`RANDOM}};
  reg_21_Im = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  reg_22_Re = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  reg_22_Im = _RAND_45[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module axpy_dp_complex_19(
  input         clock,
  input         reset,
  input  [31:0] io_in_a_Re,
  input  [31:0] io_in_a_Im,
  input  [31:0] io_in_b_0_Re,
  input  [31:0] io_in_b_0_Im,
  input  [31:0] io_in_b_1_Re,
  input  [31:0] io_in_b_1_Im,
  input  [31:0] io_in_b_2_Re,
  input  [31:0] io_in_b_2_Im,
  input  [31:0] io_in_b_3_Re,
  input  [31:0] io_in_b_3_Im,
  input  [31:0] io_in_c_0_Re,
  input  [31:0] io_in_c_0_Im,
  input  [31:0] io_in_c_1_Re,
  input  [31:0] io_in_c_1_Im,
  input  [31:0] io_in_c_2_Re,
  input  [31:0] io_in_c_2_Im,
  input  [31:0] io_in_c_3_Re,
  input  [31:0] io_in_c_3_Im,
  output [31:0] io_out_s_0_Re,
  output [31:0] io_out_s_0_Im,
  output [31:0] io_out_s_1_Re,
  output [31:0] io_out_s_1_Im,
  output [31:0] io_out_s_2_Re,
  output [31:0] io_out_s_2_Im,
  output [31:0] io_out_s_3_Re,
  output [31:0] io_out_s_3_Im
);
  wire  FPComplexMult_v2_19_clock; // @[FPComplex.scala 1203:28]
  wire  FPComplexMult_v2_19_reset; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_io_in_a_Re; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_io_in_a_Im; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_io_in_b_Re; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_io_in_b_Im; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_io_out_s_Re; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_io_out_s_Im; // @[FPComplex.scala 1203:28]
  wire  FPComplexMult_v2_19_1_clock; // @[FPComplex.scala 1203:28]
  wire  FPComplexMult_v2_19_1_reset; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_1_io_in_a_Re; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_1_io_in_a_Im; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_1_io_in_b_Re; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_1_io_in_b_Im; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_1_io_out_s_Re; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_1_io_out_s_Im; // @[FPComplex.scala 1203:28]
  wire  FPComplexMult_v2_19_2_clock; // @[FPComplex.scala 1203:28]
  wire  FPComplexMult_v2_19_2_reset; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_2_io_in_a_Re; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_2_io_in_a_Im; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_2_io_in_b_Re; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_2_io_in_b_Im; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_2_io_out_s_Re; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_2_io_out_s_Im; // @[FPComplex.scala 1203:28]
  wire  FPComplexMult_v2_19_3_clock; // @[FPComplex.scala 1203:28]
  wire  FPComplexMult_v2_19_3_reset; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_3_io_in_a_Re; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_3_io_in_a_Im; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_3_io_in_b_Re; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_3_io_in_b_Im; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_3_io_out_s_Re; // @[FPComplex.scala 1203:28]
  wire [31:0] FPComplexMult_v2_19_3_io_out_s_Im; // @[FPComplex.scala 1203:28]
  wire  FPComplexAdder_v2_19_clock; // @[FPComplex.scala 1208:25]
  wire  FPComplexAdder_v2_19_reset; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_io_in_a_Re; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_io_in_a_Im; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_io_in_b_Re; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_io_in_b_Im; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_io_out_s_Re; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_io_out_s_Im; // @[FPComplex.scala 1208:25]
  wire  FPComplexAdder_v2_19_1_clock; // @[FPComplex.scala 1208:25]
  wire  FPComplexAdder_v2_19_1_reset; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_1_io_in_a_Re; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_1_io_in_a_Im; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_1_io_in_b_Re; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_1_io_in_b_Im; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_1_io_out_s_Re; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_1_io_out_s_Im; // @[FPComplex.scala 1208:25]
  wire  FPComplexAdder_v2_19_2_clock; // @[FPComplex.scala 1208:25]
  wire  FPComplexAdder_v2_19_2_reset; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_2_io_in_a_Re; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_2_io_in_a_Im; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_2_io_in_b_Re; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_2_io_in_b_Im; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_2_io_out_s_Re; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_2_io_out_s_Im; // @[FPComplex.scala 1208:25]
  wire  FPComplexAdder_v2_19_3_clock; // @[FPComplex.scala 1208:25]
  wire  FPComplexAdder_v2_19_3_reset; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_3_io_in_a_Re; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_3_io_in_a_Im; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_3_io_in_b_Re; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_3_io_in_b_Im; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_3_io_out_s_Re; // @[FPComplex.scala 1208:25]
  wire [31:0] FPComplexAdder_v2_19_3_io_out_s_Im; // @[FPComplex.scala 1208:25]
  wire  FPReg_19_clock; // @[FPComplex.scala 1215:17]
  wire  FPReg_19_reset; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_io_in_Re; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_io_in_Im; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_io_out_Re; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_io_out_Im; // @[FPComplex.scala 1215:17]
  wire  FPReg_19_1_clock; // @[FPComplex.scala 1215:17]
  wire  FPReg_19_1_reset; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_1_io_in_Re; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_1_io_in_Im; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_1_io_out_Re; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_1_io_out_Im; // @[FPComplex.scala 1215:17]
  wire  FPReg_19_2_clock; // @[FPComplex.scala 1215:17]
  wire  FPReg_19_2_reset; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_2_io_in_Re; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_2_io_in_Im; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_2_io_out_Re; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_2_io_out_Im; // @[FPComplex.scala 1215:17]
  wire  FPReg_19_3_clock; // @[FPComplex.scala 1215:17]
  wire  FPReg_19_3_reset; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_3_io_in_Re; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_3_io_in_Im; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_3_io_out_Re; // @[FPComplex.scala 1215:17]
  wire [31:0] FPReg_19_3_io_out_Im; // @[FPComplex.scala 1215:17]
  FPComplexMult_v2_19 FPComplexMult_v2_19 ( // @[FPComplex.scala 1203:28]
    .clock(FPComplexMult_v2_19_clock),
    .reset(FPComplexMult_v2_19_reset),
    .io_in_a_Re(FPComplexMult_v2_19_io_in_a_Re),
    .io_in_a_Im(FPComplexMult_v2_19_io_in_a_Im),
    .io_in_b_Re(FPComplexMult_v2_19_io_in_b_Re),
    .io_in_b_Im(FPComplexMult_v2_19_io_in_b_Im),
    .io_out_s_Re(FPComplexMult_v2_19_io_out_s_Re),
    .io_out_s_Im(FPComplexMult_v2_19_io_out_s_Im)
  );
  FPComplexMult_v2_19 FPComplexMult_v2_19_1 ( // @[FPComplex.scala 1203:28]
    .clock(FPComplexMult_v2_19_1_clock),
    .reset(FPComplexMult_v2_19_1_reset),
    .io_in_a_Re(FPComplexMult_v2_19_1_io_in_a_Re),
    .io_in_a_Im(FPComplexMult_v2_19_1_io_in_a_Im),
    .io_in_b_Re(FPComplexMult_v2_19_1_io_in_b_Re),
    .io_in_b_Im(FPComplexMult_v2_19_1_io_in_b_Im),
    .io_out_s_Re(FPComplexMult_v2_19_1_io_out_s_Re),
    .io_out_s_Im(FPComplexMult_v2_19_1_io_out_s_Im)
  );
  FPComplexMult_v2_19 FPComplexMult_v2_19_2 ( // @[FPComplex.scala 1203:28]
    .clock(FPComplexMult_v2_19_2_clock),
    .reset(FPComplexMult_v2_19_2_reset),
    .io_in_a_Re(FPComplexMult_v2_19_2_io_in_a_Re),
    .io_in_a_Im(FPComplexMult_v2_19_2_io_in_a_Im),
    .io_in_b_Re(FPComplexMult_v2_19_2_io_in_b_Re),
    .io_in_b_Im(FPComplexMult_v2_19_2_io_in_b_Im),
    .io_out_s_Re(FPComplexMult_v2_19_2_io_out_s_Re),
    .io_out_s_Im(FPComplexMult_v2_19_2_io_out_s_Im)
  );
  FPComplexMult_v2_19 FPComplexMult_v2_19_3 ( // @[FPComplex.scala 1203:28]
    .clock(FPComplexMult_v2_19_3_clock),
    .reset(FPComplexMult_v2_19_3_reset),
    .io_in_a_Re(FPComplexMult_v2_19_3_io_in_a_Re),
    .io_in_a_Im(FPComplexMult_v2_19_3_io_in_a_Im),
    .io_in_b_Re(FPComplexMult_v2_19_3_io_in_b_Re),
    .io_in_b_Im(FPComplexMult_v2_19_3_io_in_b_Im),
    .io_out_s_Re(FPComplexMult_v2_19_3_io_out_s_Re),
    .io_out_s_Im(FPComplexMult_v2_19_3_io_out_s_Im)
  );
  FPComplexAdder_v2_19 FPComplexAdder_v2_19 ( // @[FPComplex.scala 1208:25]
    .clock(FPComplexAdder_v2_19_clock),
    .reset(FPComplexAdder_v2_19_reset),
    .io_in_a_Re(FPComplexAdder_v2_19_io_in_a_Re),
    .io_in_a_Im(FPComplexAdder_v2_19_io_in_a_Im),
    .io_in_b_Re(FPComplexAdder_v2_19_io_in_b_Re),
    .io_in_b_Im(FPComplexAdder_v2_19_io_in_b_Im),
    .io_out_s_Re(FPComplexAdder_v2_19_io_out_s_Re),
    .io_out_s_Im(FPComplexAdder_v2_19_io_out_s_Im)
  );
  FPComplexAdder_v2_19 FPComplexAdder_v2_19_1 ( // @[FPComplex.scala 1208:25]
    .clock(FPComplexAdder_v2_19_1_clock),
    .reset(FPComplexAdder_v2_19_1_reset),
    .io_in_a_Re(FPComplexAdder_v2_19_1_io_in_a_Re),
    .io_in_a_Im(FPComplexAdder_v2_19_1_io_in_a_Im),
    .io_in_b_Re(FPComplexAdder_v2_19_1_io_in_b_Re),
    .io_in_b_Im(FPComplexAdder_v2_19_1_io_in_b_Im),
    .io_out_s_Re(FPComplexAdder_v2_19_1_io_out_s_Re),
    .io_out_s_Im(FPComplexAdder_v2_19_1_io_out_s_Im)
  );
  FPComplexAdder_v2_19 FPComplexAdder_v2_19_2 ( // @[FPComplex.scala 1208:25]
    .clock(FPComplexAdder_v2_19_2_clock),
    .reset(FPComplexAdder_v2_19_2_reset),
    .io_in_a_Re(FPComplexAdder_v2_19_2_io_in_a_Re),
    .io_in_a_Im(FPComplexAdder_v2_19_2_io_in_a_Im),
    .io_in_b_Re(FPComplexAdder_v2_19_2_io_in_b_Re),
    .io_in_b_Im(FPComplexAdder_v2_19_2_io_in_b_Im),
    .io_out_s_Re(FPComplexAdder_v2_19_2_io_out_s_Re),
    .io_out_s_Im(FPComplexAdder_v2_19_2_io_out_s_Im)
  );
  FPComplexAdder_v2_19 FPComplexAdder_v2_19_3 ( // @[FPComplex.scala 1208:25]
    .clock(FPComplexAdder_v2_19_3_clock),
    .reset(FPComplexAdder_v2_19_3_reset),
    .io_in_a_Re(FPComplexAdder_v2_19_3_io_in_a_Re),
    .io_in_a_Im(FPComplexAdder_v2_19_3_io_in_a_Im),
    .io_in_b_Re(FPComplexAdder_v2_19_3_io_in_b_Re),
    .io_in_b_Im(FPComplexAdder_v2_19_3_io_in_b_Im),
    .io_out_s_Re(FPComplexAdder_v2_19_3_io_out_s_Re),
    .io_out_s_Im(FPComplexAdder_v2_19_3_io_out_s_Im)
  );
  FPReg_19 FPReg_19 ( // @[FPComplex.scala 1215:17]
    .clock(FPReg_19_clock),
    .reset(FPReg_19_reset),
    .io_in_Re(FPReg_19_io_in_Re),
    .io_in_Im(FPReg_19_io_in_Im),
    .io_out_Re(FPReg_19_io_out_Re),
    .io_out_Im(FPReg_19_io_out_Im)
  );
  FPReg_19 FPReg_19_1 ( // @[FPComplex.scala 1215:17]
    .clock(FPReg_19_1_clock),
    .reset(FPReg_19_1_reset),
    .io_in_Re(FPReg_19_1_io_in_Re),
    .io_in_Im(FPReg_19_1_io_in_Im),
    .io_out_Re(FPReg_19_1_io_out_Re),
    .io_out_Im(FPReg_19_1_io_out_Im)
  );
  FPReg_19 FPReg_19_2 ( // @[FPComplex.scala 1215:17]
    .clock(FPReg_19_2_clock),
    .reset(FPReg_19_2_reset),
    .io_in_Re(FPReg_19_2_io_in_Re),
    .io_in_Im(FPReg_19_2_io_in_Im),
    .io_out_Re(FPReg_19_2_io_out_Re),
    .io_out_Im(FPReg_19_2_io_out_Im)
  );
  FPReg_19 FPReg_19_3 ( // @[FPComplex.scala 1215:17]
    .clock(FPReg_19_3_clock),
    .reset(FPReg_19_3_reset),
    .io_in_Re(FPReg_19_3_io_in_Re),
    .io_in_Im(FPReg_19_3_io_in_Im),
    .io_out_Re(FPReg_19_3_io_out_Re),
    .io_out_Im(FPReg_19_3_io_out_Im)
  );
  assign io_out_s_0_Re = FPComplexAdder_v2_19_io_out_s_Re; // @[FPComplex.scala 1224:19]
  assign io_out_s_0_Im = FPComplexAdder_v2_19_io_out_s_Im; // @[FPComplex.scala 1224:19]
  assign io_out_s_1_Re = FPComplexAdder_v2_19_1_io_out_s_Re; // @[FPComplex.scala 1224:19]
  assign io_out_s_1_Im = FPComplexAdder_v2_19_1_io_out_s_Im; // @[FPComplex.scala 1224:19]
  assign io_out_s_2_Re = FPComplexAdder_v2_19_2_io_out_s_Re; // @[FPComplex.scala 1224:19]
  assign io_out_s_2_Im = FPComplexAdder_v2_19_2_io_out_s_Im; // @[FPComplex.scala 1224:19]
  assign io_out_s_3_Re = FPComplexAdder_v2_19_3_io_out_s_Re; // @[FPComplex.scala 1224:19]
  assign io_out_s_3_Im = FPComplexAdder_v2_19_3_io_out_s_Im; // @[FPComplex.scala 1224:19]
  assign FPComplexMult_v2_19_clock = clock;
  assign FPComplexMult_v2_19_reset = reset;
  assign FPComplexMult_v2_19_io_in_a_Re = io_in_a_Re; // @[FPComplex.scala 1219:30]
  assign FPComplexMult_v2_19_io_in_a_Im = io_in_a_Im; // @[FPComplex.scala 1219:30]
  assign FPComplexMult_v2_19_io_in_b_Re = io_in_b_0_Re; // @[FPComplex.scala 1220:30]
  assign FPComplexMult_v2_19_io_in_b_Im = io_in_b_0_Im; // @[FPComplex.scala 1220:30]
  assign FPComplexMult_v2_19_1_clock = clock;
  assign FPComplexMult_v2_19_1_reset = reset;
  assign FPComplexMult_v2_19_1_io_in_a_Re = io_in_a_Re; // @[FPComplex.scala 1219:30]
  assign FPComplexMult_v2_19_1_io_in_a_Im = io_in_a_Im; // @[FPComplex.scala 1219:30]
  assign FPComplexMult_v2_19_1_io_in_b_Re = io_in_b_1_Re; // @[FPComplex.scala 1220:30]
  assign FPComplexMult_v2_19_1_io_in_b_Im = io_in_b_1_Im; // @[FPComplex.scala 1220:30]
  assign FPComplexMult_v2_19_2_clock = clock;
  assign FPComplexMult_v2_19_2_reset = reset;
  assign FPComplexMult_v2_19_2_io_in_a_Re = io_in_a_Re; // @[FPComplex.scala 1219:30]
  assign FPComplexMult_v2_19_2_io_in_a_Im = io_in_a_Im; // @[FPComplex.scala 1219:30]
  assign FPComplexMult_v2_19_2_io_in_b_Re = io_in_b_2_Re; // @[FPComplex.scala 1220:30]
  assign FPComplexMult_v2_19_2_io_in_b_Im = io_in_b_2_Im; // @[FPComplex.scala 1220:30]
  assign FPComplexMult_v2_19_3_clock = clock;
  assign FPComplexMult_v2_19_3_reset = reset;
  assign FPComplexMult_v2_19_3_io_in_a_Re = io_in_a_Re; // @[FPComplex.scala 1219:30]
  assign FPComplexMult_v2_19_3_io_in_a_Im = io_in_a_Im; // @[FPComplex.scala 1219:30]
  assign FPComplexMult_v2_19_3_io_in_b_Re = io_in_b_3_Re; // @[FPComplex.scala 1220:30]
  assign FPComplexMult_v2_19_3_io_in_b_Im = io_in_b_3_Im; // @[FPComplex.scala 1220:30]
  assign FPComplexAdder_v2_19_clock = clock;
  assign FPComplexAdder_v2_19_reset = reset;
  assign FPComplexAdder_v2_19_io_in_a_Re = FPComplexMult_v2_19_io_out_s_Re; // @[FPComplex.scala 1222:27]
  assign FPComplexAdder_v2_19_io_in_a_Im = FPComplexMult_v2_19_io_out_s_Im; // @[FPComplex.scala 1222:27]
  assign FPComplexAdder_v2_19_io_in_b_Re = FPReg_19_io_out_Re; // @[FPComplex.scala 1223:27]
  assign FPComplexAdder_v2_19_io_in_b_Im = FPReg_19_io_out_Im; // @[FPComplex.scala 1223:27]
  assign FPComplexAdder_v2_19_1_clock = clock;
  assign FPComplexAdder_v2_19_1_reset = reset;
  assign FPComplexAdder_v2_19_1_io_in_a_Re = FPComplexMult_v2_19_1_io_out_s_Re; // @[FPComplex.scala 1222:27]
  assign FPComplexAdder_v2_19_1_io_in_a_Im = FPComplexMult_v2_19_1_io_out_s_Im; // @[FPComplex.scala 1222:27]
  assign FPComplexAdder_v2_19_1_io_in_b_Re = FPReg_19_1_io_out_Re; // @[FPComplex.scala 1223:27]
  assign FPComplexAdder_v2_19_1_io_in_b_Im = FPReg_19_1_io_out_Im; // @[FPComplex.scala 1223:27]
  assign FPComplexAdder_v2_19_2_clock = clock;
  assign FPComplexAdder_v2_19_2_reset = reset;
  assign FPComplexAdder_v2_19_2_io_in_a_Re = FPComplexMult_v2_19_2_io_out_s_Re; // @[FPComplex.scala 1222:27]
  assign FPComplexAdder_v2_19_2_io_in_a_Im = FPComplexMult_v2_19_2_io_out_s_Im; // @[FPComplex.scala 1222:27]
  assign FPComplexAdder_v2_19_2_io_in_b_Re = FPReg_19_2_io_out_Re; // @[FPComplex.scala 1223:27]
  assign FPComplexAdder_v2_19_2_io_in_b_Im = FPReg_19_2_io_out_Im; // @[FPComplex.scala 1223:27]
  assign FPComplexAdder_v2_19_3_clock = clock;
  assign FPComplexAdder_v2_19_3_reset = reset;
  assign FPComplexAdder_v2_19_3_io_in_a_Re = FPComplexMult_v2_19_3_io_out_s_Re; // @[FPComplex.scala 1222:27]
  assign FPComplexAdder_v2_19_3_io_in_a_Im = FPComplexMult_v2_19_3_io_out_s_Im; // @[FPComplex.scala 1222:27]
  assign FPComplexAdder_v2_19_3_io_in_b_Re = FPReg_19_3_io_out_Re; // @[FPComplex.scala 1223:27]
  assign FPComplexAdder_v2_19_3_io_in_b_Im = FPReg_19_3_io_out_Im; // @[FPComplex.scala 1223:27]
  assign FPReg_19_clock = clock;
  assign FPReg_19_reset = reset;
  assign FPReg_19_io_in_Re = io_in_c_0_Re; // @[FPComplex.scala 1221:25]
  assign FPReg_19_io_in_Im = io_in_c_0_Im; // @[FPComplex.scala 1221:25]
  assign FPReg_19_1_clock = clock;
  assign FPReg_19_1_reset = reset;
  assign FPReg_19_1_io_in_Re = io_in_c_1_Re; // @[FPComplex.scala 1221:25]
  assign FPReg_19_1_io_in_Im = io_in_c_1_Im; // @[FPComplex.scala 1221:25]
  assign FPReg_19_2_clock = clock;
  assign FPReg_19_2_reset = reset;
  assign FPReg_19_2_io_in_Re = io_in_c_2_Re; // @[FPComplex.scala 1221:25]
  assign FPReg_19_2_io_in_Im = io_in_c_2_Im; // @[FPComplex.scala 1221:25]
  assign FPReg_19_3_clock = clock;
  assign FPReg_19_3_reset = reset;
  assign FPReg_19_3_io_in_Re = io_in_c_3_Re; // @[FPComplex.scala 1221:25]
  assign FPReg_19_3_io_in_Im = io_in_c_3_Im; // @[FPComplex.scala 1221:25]
endmodule
module hh_datapath_1(
  input          io_clk,
  input          io_rst,
  input  [15:0]  io_hh_cnt,
  input          io_d1_rdy,
  input          io_d1_vld,
  input          io_d2_vld,
  input          io_vk1_vld,
  input          io_d3_rdy,
  input          io_d3_vld,
  input          io_tk_vld,
  input          io_d4_rdy,
  input          io_d5_rdy,
  input          io_d5_vld,
  input          io_yj_sft,
  input          io_d4_sft,
  input  [255:0] io_hh_din,
  output [255:0] io_hh_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [25727:0] _RAND_0;
  reg [25727:0] _RAND_1;
  reg [255:0] _RAND_2;
  reg [255:0] _RAND_3;
  reg [255:0] _RAND_4;
  reg [255:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [8063:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  wire  FP_DDOT_dp_complex_19_clock; // @[hh_datapath_chisel.scala 313:21]
  wire  FP_DDOT_dp_complex_19_reset; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_a_0_Re; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_a_0_Im; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_a_1_Re; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_a_1_Im; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_a_2_Re; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_a_2_Im; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_a_3_Re; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_a_3_Im; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_b_0_Re; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_b_0_Im; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_b_1_Re; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_b_1_Im; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_b_2_Re; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_b_2_Im; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_b_3_Re; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_in_b_3_Im; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_out_s_Re; // @[hh_datapath_chisel.scala 313:21]
  wire [31:0] FP_DDOT_dp_complex_19_io_out_s_Im; // @[hh_datapath_chisel.scala 313:21]
  wire  FP_square_root_newfpu_19_clock; // @[hh_datapath_chisel.scala 326:22]
  wire  FP_square_root_newfpu_19_reset; // @[hh_datapath_chisel.scala 326:22]
  wire [31:0] FP_square_root_newfpu_19_io_in_a; // @[hh_datapath_chisel.scala 326:22]
  wire [31:0] FP_square_root_newfpu_19_io_out_s; // @[hh_datapath_chisel.scala 326:22]
  wire  hqr5_complex_19_clock; // @[hh_datapath_chisel.scala 360:20]
  wire  hqr5_complex_19_reset; // @[hh_datapath_chisel.scala 360:20]
  wire [31:0] hqr5_complex_19_io_in_a_Re; // @[hh_datapath_chisel.scala 360:20]
  wire [31:0] hqr5_complex_19_io_in_a_Im; // @[hh_datapath_chisel.scala 360:20]
  wire [31:0] hqr5_complex_19_io_in_b_Re; // @[hh_datapath_chisel.scala 360:20]
  wire [31:0] hqr5_complex_19_io_out_s_Re; // @[hh_datapath_chisel.scala 360:20]
  wire [31:0] hqr5_complex_19_io_out_s_Im; // @[hh_datapath_chisel.scala 360:20]
  wire  hqr7_19_clock; // @[hh_datapath_chisel.scala 369:20]
  wire  hqr7_19_reset; // @[hh_datapath_chisel.scala 369:20]
  wire [31:0] hqr7_19_io_in_a; // @[hh_datapath_chisel.scala 369:20]
  wire [31:0] hqr7_19_io_out_s; // @[hh_datapath_chisel.scala 369:20]
  wire  FPComplexMult_v2_19_clock; // @[hh_datapath_chisel.scala 406:21]
  wire  FPComplexMult_v2_19_reset; // @[hh_datapath_chisel.scala 406:21]
  wire [31:0] FPComplexMult_v2_19_io_in_a_Re; // @[hh_datapath_chisel.scala 406:21]
  wire [31:0] FPComplexMult_v2_19_io_in_a_Im; // @[hh_datapath_chisel.scala 406:21]
  wire [31:0] FPComplexMult_v2_19_io_in_b_Re; // @[hh_datapath_chisel.scala 406:21]
  wire [31:0] FPComplexMult_v2_19_io_in_b_Im; // @[hh_datapath_chisel.scala 406:21]
  wire [31:0] FPComplexMult_v2_19_io_out_s_Re; // @[hh_datapath_chisel.scala 406:21]
  wire [31:0] FPComplexMult_v2_19_io_out_s_Im; // @[hh_datapath_chisel.scala 406:21]
  wire  axpy_dp_complex_19_clock; // @[hh_datapath_chisel.scala 433:20]
  wire  axpy_dp_complex_19_reset; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_a_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_a_Im; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_b_0_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_b_0_Im; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_b_1_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_b_1_Im; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_b_2_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_b_2_Im; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_b_3_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_b_3_Im; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_c_0_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_c_0_Im; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_c_1_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_c_1_Im; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_c_2_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_c_2_Im; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_c_3_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_in_c_3_Im; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_out_s_0_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_out_s_0_Im; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_out_s_1_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_out_s_1_Im; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_out_s_2_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_out_s_2_Im; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_out_s_3_Re; // @[hh_datapath_chisel.scala 433:20]
  wire [31:0] axpy_dp_complex_19_io_out_s_3_Im; // @[hh_datapath_chisel.scala 433:20]
  reg [25727:0] yj_reg_vec_0; // @[hh_datapath_chisel.scala 72:25]
  reg [25727:0] yj_reg_vec_1; // @[hh_datapath_chisel.scala 72:25]
  reg [255:0] yj0; // @[hh_datapath_chisel.scala 73:18]
  wire [25727:0] _yj_reg_vec_0_T_1 = {io_hh_din,yj_reg_vec_0[25727:256]}; // @[Cat.scala 31:58]
  wire [25727:0] _yj_reg_vec_1_T_2 = {yj_reg_vec_0[255:0],yj_reg_vec_1[25727:256]}; // @[Cat.scala 31:58]
  reg [255:0] ddot_din_a_reg; // @[hh_datapath_chisel.scala 136:29]
  reg [255:0] ddot_din_b_reg; // @[hh_datapath_chisel.scala 137:29]
  reg [255:0] vk_reg; // @[hh_datapath_chisel.scala 138:21]
  reg [31:0] d1_reg; // @[hh_datapath_chisel.scala 139:21]
  reg [31:0] d3_reg; // @[hh_datapath_chisel.scala 140:21]
  reg [63:0] d4_update; // @[hh_datapath_chisel.scala 145:24]
  reg [63:0] x1_reg; // @[hh_datapath_chisel.scala 152:21]
  reg [31:0] d2_reg; // @[hh_datapath_chisel.scala 153:21]
  reg [63:0] vk1_reg; // @[hh_datapath_chisel.scala 154:22]
  reg [31:0] tk_reg; // @[hh_datapath_chisel.scala 155:21]
  reg [63:0] d4_reg; // @[hh_datapath_chisel.scala 156:21]
  reg [63:0] d5_reg; // @[hh_datapath_chisel.scala 157:21]
  wire [63:0] vk1_update = {hqr5_complex_19_io_out_s_Re,hqr5_complex_19_io_out_s_Im}; // @[Cat.scala 31:58]
  wire [63:0] vk1 = io_vk1_vld ? vk1_update : vk1_reg; // @[hh_datapath_chisel.scala 248:21 249:11 251:11]
  wire [15:0] _myNewVec_3_T_1 = io_hh_cnt + 16'h1; // @[hh_datapath_chisel.scala 287:55]
  wire [16:0] _myNewVec_3_T_2 = {{1'd0}, _myNewVec_3_T_1}; // @[hh_datapath_chisel.scala 287:60]
  wire [63:0] myVec_3 = io_hh_din[63:0]; // @[hh_datapath_chisel.scala 274:28]
  wire [63:0] myVec_2 = io_hh_din[127:64]; // @[hh_datapath_chisel.scala 274:28]
  wire [63:0] myVec_1 = io_hh_din[191:128]; // @[hh_datapath_chisel.scala 274:28]
  wire [63:0] myVec_0 = io_hh_din[255:192]; // @[hh_datapath_chisel.scala 274:28]
  wire [63:0] _GEN_43 = 2'h1 == _myNewVec_3_T_2[1:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 287:{37,37}]
  wire [63:0] _GEN_44 = 2'h2 == _myNewVec_3_T_2[1:0] ? myVec_2 : _GEN_43; // @[hh_datapath_chisel.scala 287:{37,37}]
  wire [63:0] myNewVec_3 = 2'h3 == _myNewVec_3_T_2[1:0] ? myVec_3 : _GEN_44; // @[hh_datapath_chisel.scala 287:{37,37}]
  wire [15:0] _myNewVec_2_T_3 = _myNewVec_3_T_1 + 16'h1; // @[hh_datapath_chisel.scala 287:60]
  wire [63:0] _GEN_47 = 2'h1 == _myNewVec_2_T_3[1:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 287:{37,37}]
  wire [63:0] _GEN_48 = 2'h2 == _myNewVec_2_T_3[1:0] ? myVec_2 : _GEN_47; // @[hh_datapath_chisel.scala 287:{37,37}]
  wire [63:0] myNewVec_2 = 2'h3 == _myNewVec_2_T_3[1:0] ? myVec_3 : _GEN_48; // @[hh_datapath_chisel.scala 287:{37,37}]
  wire [15:0] _myNewVec_1_T_3 = _myNewVec_3_T_1 + 16'h2; // @[hh_datapath_chisel.scala 287:60]
  wire [63:0] _GEN_51 = 2'h1 == _myNewVec_1_T_3[1:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 287:{37,37}]
  wire [63:0] _GEN_52 = 2'h2 == _myNewVec_1_T_3[1:0] ? myVec_2 : _GEN_51; // @[hh_datapath_chisel.scala 287:{37,37}]
  wire [63:0] myNewVec_1 = 2'h3 == _myNewVec_1_T_3[1:0] ? myVec_3 : _GEN_52; // @[hh_datapath_chisel.scala 287:{37,37}]
  wire [15:0] _myNewVec_0_T_3 = _myNewVec_3_T_1 + 16'h3; // @[hh_datapath_chisel.scala 287:60]
  wire [63:0] _GEN_55 = 2'h1 == _myNewVec_0_T_3[1:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 287:{37,37}]
  wire [63:0] _GEN_56 = 2'h2 == _myNewVec_0_T_3[1:0] ? myVec_2 : _GEN_55; // @[hh_datapath_chisel.scala 287:{37,37}]
  wire [63:0] myNewVec_0 = 2'h3 == _myNewVec_0_T_3[1:0] ? myVec_3 : _GEN_56; // @[hh_datapath_chisel.scala 287:{37,37}]
  wire [319:0] _vk_update_T = {vk1,myNewVec_3,myNewVec_2,myNewVec_1,myNewVec_0}; // @[Cat.scala 31:58]
  wire [22:0] _vk_update_T_3 = _myNewVec_3_T_1 * 7'h40; // @[hh_datapath_chisel.scala 295:57]
  wire [319:0] _vk_update_T_4 = _vk_update_T >> _vk_update_T_3; // @[hh_datapath_chisel.scala 295:39]
  wire [319:0] _GEN_58 = io_vk1_vld ? _vk_update_T_4 : 320'h0; // @[hh_datapath_chisel.scala 294:27 295:17 298:17]
  wire [319:0] _GEN_59 = io_rst ? 320'h0 : _GEN_58; // @[hh_datapath_chisel.scala 292:17 293:17]
  wire [255:0] vk_update = _GEN_59[255:0]; // @[hh_datapath_chisel.scala 135:25]
  wire [255:0] vk = io_vk1_vld ? vk_update : vk_reg; // @[hh_datapath_chisel.scala 207:21 208:10 210:10]
  wire [63:0] ddot_dout = {FP_DDOT_dp_complex_19_io_out_s_Re,FP_DDOT_dp_complex_19_io_out_s_Im}; // @[Cat.scala 31:58]
  wire [63:0] _GEN_37 = 2'h1 == io_hh_cnt[1:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 279:{17,17}]
  wire [63:0] _GEN_38 = 2'h2 == io_hh_cnt[1:0] ? myVec_2 : _GEN_37; // @[hh_datapath_chisel.scala 279:{17,17}]
  wire [63:0] _GEN_39 = 2'h3 == io_hh_cnt[1:0] ? myVec_3 : _GEN_38; // @[hh_datapath_chisel.scala 279:{17,17}]
  wire [63:0] _GEN_40 = io_d1_rdy ? _GEN_39 : 64'h0; // @[hh_datapath_chisel.scala 278:26 279:17 281:17]
  wire [63:0] x1_update = io_rst ? 64'h0 : _GEN_40; // @[hh_datapath_chisel.scala 276:17 277:17]
  wire [63:0] x1 = io_d1_rdy ? x1_update : x1_reg; // @[hh_datapath_chisel.scala 236:20 237:10 239:10]
  wire [31:0] d2_update = FP_square_root_newfpu_19_io_out_s; // @[hh_datapath_chisel.scala 142:25 329:15]
  wire [63:0] tk_update = {{32'd0}, hqr7_19_io_out_s}; // @[hh_datapath_chisel.scala 144:25 371:14]
  wire [63:0] _GEN_33 = io_tk_vld ? tk_update : {{32'd0}, tk_reg}; // @[hh_datapath_chisel.scala 254:20 255:10 257:10]
  wire [31:0] tk = _GEN_33[31:0]; // @[hh_datapath_chisel.scala 150:18]
  wire [63:0] d4 = io_d5_rdy ? d4_update : d4_reg; // @[hh_datapath_chisel.scala 260:20 261:10 263:10]
  wire [63:0] d5_update = {FPComplexMult_v2_19_io_out_s_Re,FPComplexMult_v2_19_io_out_s_Im}; // @[Cat.scala 31:58]
  reg [8063:0] d4_update_reg; // @[hh_datapath_chisel.scala 214:27]
  wire [8063:0] _d4_update_reg_T_1 = {FP_DDOT_dp_complex_19_io_out_s_Re,FP_DDOT_dp_complex_19_io_out_s_Im,d4_update_reg[
    8063:64]}; // @[Cat.scala 31:58]
  reg [63:0] myAxpyVec_0; // @[hh_datapath_chisel.scala 444:23]
  reg [63:0] myAxpyVec_1; // @[hh_datapath_chisel.scala 444:23]
  reg [63:0] myAxpyVec_2; // @[hh_datapath_chisel.scala 444:23]
  reg [63:0] myAxpyVec_3; // @[hh_datapath_chisel.scala 444:23]
  wire [63:0] _myAxpyVec_3_T = {axpy_dp_complex_19_io_out_s_0_Re,axpy_dp_complex_19_io_out_s_0_Im}; // @[Cat.scala 31:58]
  wire [63:0] _myAxpyVec_2_T = {axpy_dp_complex_19_io_out_s_1_Re,axpy_dp_complex_19_io_out_s_1_Im}; // @[Cat.scala 31:58]
  wire [63:0] _myAxpyVec_1_T = {axpy_dp_complex_19_io_out_s_2_Re,axpy_dp_complex_19_io_out_s_2_Im}; // @[Cat.scala 31:58]
  wire [63:0] _myAxpyVec_0_T = {axpy_dp_complex_19_io_out_s_3_Re,axpy_dp_complex_19_io_out_s_3_Im}; // @[Cat.scala 31:58]
  wire [127:0] io_hh_dout_lo = {myAxpyVec_1,myAxpyVec_0}; // @[hh_datapath_chisel.scala 453:29]
  wire [127:0] io_hh_dout_hi = {myAxpyVec_3,myAxpyVec_2}; // @[hh_datapath_chisel.scala 453:29]
  FP_DDOT_dp_complex_19 FP_DDOT_dp_complex_19 ( // @[hh_datapath_chisel.scala 313:21]
    .clock(FP_DDOT_dp_complex_19_clock),
    .reset(FP_DDOT_dp_complex_19_reset),
    .io_in_a_0_Re(FP_DDOT_dp_complex_19_io_in_a_0_Re),
    .io_in_a_0_Im(FP_DDOT_dp_complex_19_io_in_a_0_Im),
    .io_in_a_1_Re(FP_DDOT_dp_complex_19_io_in_a_1_Re),
    .io_in_a_1_Im(FP_DDOT_dp_complex_19_io_in_a_1_Im),
    .io_in_a_2_Re(FP_DDOT_dp_complex_19_io_in_a_2_Re),
    .io_in_a_2_Im(FP_DDOT_dp_complex_19_io_in_a_2_Im),
    .io_in_a_3_Re(FP_DDOT_dp_complex_19_io_in_a_3_Re),
    .io_in_a_3_Im(FP_DDOT_dp_complex_19_io_in_a_3_Im),
    .io_in_b_0_Re(FP_DDOT_dp_complex_19_io_in_b_0_Re),
    .io_in_b_0_Im(FP_DDOT_dp_complex_19_io_in_b_0_Im),
    .io_in_b_1_Re(FP_DDOT_dp_complex_19_io_in_b_1_Re),
    .io_in_b_1_Im(FP_DDOT_dp_complex_19_io_in_b_1_Im),
    .io_in_b_2_Re(FP_DDOT_dp_complex_19_io_in_b_2_Re),
    .io_in_b_2_Im(FP_DDOT_dp_complex_19_io_in_b_2_Im),
    .io_in_b_3_Re(FP_DDOT_dp_complex_19_io_in_b_3_Re),
    .io_in_b_3_Im(FP_DDOT_dp_complex_19_io_in_b_3_Im),
    .io_out_s_Re(FP_DDOT_dp_complex_19_io_out_s_Re),
    .io_out_s_Im(FP_DDOT_dp_complex_19_io_out_s_Im)
  );
  FP_square_root_newfpu_19 FP_square_root_newfpu_19 ( // @[hh_datapath_chisel.scala 326:22]
    .clock(FP_square_root_newfpu_19_clock),
    .reset(FP_square_root_newfpu_19_reset),
    .io_in_a(FP_square_root_newfpu_19_io_in_a),
    .io_out_s(FP_square_root_newfpu_19_io_out_s)
  );
  hqr5_complex_19 hqr5_complex_19 ( // @[hh_datapath_chisel.scala 360:20]
    .clock(hqr5_complex_19_clock),
    .reset(hqr5_complex_19_reset),
    .io_in_a_Re(hqr5_complex_19_io_in_a_Re),
    .io_in_a_Im(hqr5_complex_19_io_in_a_Im),
    .io_in_b_Re(hqr5_complex_19_io_in_b_Re),
    .io_out_s_Re(hqr5_complex_19_io_out_s_Re),
    .io_out_s_Im(hqr5_complex_19_io_out_s_Im)
  );
  hqr7_19 hqr7_19 ( // @[hh_datapath_chisel.scala 369:20]
    .clock(hqr7_19_clock),
    .reset(hqr7_19_reset),
    .io_in_a(hqr7_19_io_in_a),
    .io_out_s(hqr7_19_io_out_s)
  );
  FPComplexMult_v2_19 FPComplexMult_v2_19 ( // @[hh_datapath_chisel.scala 406:21]
    .clock(FPComplexMult_v2_19_clock),
    .reset(FPComplexMult_v2_19_reset),
    .io_in_a_Re(FPComplexMult_v2_19_io_in_a_Re),
    .io_in_a_Im(FPComplexMult_v2_19_io_in_a_Im),
    .io_in_b_Re(FPComplexMult_v2_19_io_in_b_Re),
    .io_in_b_Im(FPComplexMult_v2_19_io_in_b_Im),
    .io_out_s_Re(FPComplexMult_v2_19_io_out_s_Re),
    .io_out_s_Im(FPComplexMult_v2_19_io_out_s_Im)
  );
  axpy_dp_complex_19 axpy_dp_complex_19 ( // @[hh_datapath_chisel.scala 433:20]
    .clock(axpy_dp_complex_19_clock),
    .reset(axpy_dp_complex_19_reset),
    .io_in_a_Re(axpy_dp_complex_19_io_in_a_Re),
    .io_in_a_Im(axpy_dp_complex_19_io_in_a_Im),
    .io_in_b_0_Re(axpy_dp_complex_19_io_in_b_0_Re),
    .io_in_b_0_Im(axpy_dp_complex_19_io_in_b_0_Im),
    .io_in_b_1_Re(axpy_dp_complex_19_io_in_b_1_Re),
    .io_in_b_1_Im(axpy_dp_complex_19_io_in_b_1_Im),
    .io_in_b_2_Re(axpy_dp_complex_19_io_in_b_2_Re),
    .io_in_b_2_Im(axpy_dp_complex_19_io_in_b_2_Im),
    .io_in_b_3_Re(axpy_dp_complex_19_io_in_b_3_Re),
    .io_in_b_3_Im(axpy_dp_complex_19_io_in_b_3_Im),
    .io_in_c_0_Re(axpy_dp_complex_19_io_in_c_0_Re),
    .io_in_c_0_Im(axpy_dp_complex_19_io_in_c_0_Im),
    .io_in_c_1_Re(axpy_dp_complex_19_io_in_c_1_Re),
    .io_in_c_1_Im(axpy_dp_complex_19_io_in_c_1_Im),
    .io_in_c_2_Re(axpy_dp_complex_19_io_in_c_2_Re),
    .io_in_c_2_Im(axpy_dp_complex_19_io_in_c_2_Im),
    .io_in_c_3_Re(axpy_dp_complex_19_io_in_c_3_Re),
    .io_in_c_3_Im(axpy_dp_complex_19_io_in_c_3_Im),
    .io_out_s_0_Re(axpy_dp_complex_19_io_out_s_0_Re),
    .io_out_s_0_Im(axpy_dp_complex_19_io_out_s_0_Im),
    .io_out_s_1_Re(axpy_dp_complex_19_io_out_s_1_Re),
    .io_out_s_1_Im(axpy_dp_complex_19_io_out_s_1_Im),
    .io_out_s_2_Re(axpy_dp_complex_19_io_out_s_2_Re),
    .io_out_s_2_Im(axpy_dp_complex_19_io_out_s_2_Im),
    .io_out_s_3_Re(axpy_dp_complex_19_io_out_s_3_Re),
    .io_out_s_3_Im(axpy_dp_complex_19_io_out_s_3_Im)
  );
  assign io_hh_dout = {io_hh_dout_hi,io_hh_dout_lo}; // @[hh_datapath_chisel.scala 453:29]
  assign FP_DDOT_dp_complex_19_clock = io_clk;
  assign FP_DDOT_dp_complex_19_reset = io_rst;
  assign FP_DDOT_dp_complex_19_io_in_a_0_Re = ddot_din_a_reg[255:224]; // @[hh_datapath_chisel.scala 316:103]
  assign FP_DDOT_dp_complex_19_io_in_a_0_Im = ddot_din_a_reg[223:192] ^ 32'h80000000; // @[hh_datapath_chisel.scala 318:117]
  assign FP_DDOT_dp_complex_19_io_in_a_1_Re = ddot_din_a_reg[191:160]; // @[hh_datapath_chisel.scala 316:103]
  assign FP_DDOT_dp_complex_19_io_in_a_1_Im = ddot_din_a_reg[159:128] ^ 32'h80000000; // @[hh_datapath_chisel.scala 318:117]
  assign FP_DDOT_dp_complex_19_io_in_a_2_Re = ddot_din_a_reg[127:96]; // @[hh_datapath_chisel.scala 316:103]
  assign FP_DDOT_dp_complex_19_io_in_a_2_Im = ddot_din_a_reg[95:64] ^ 32'h80000000; // @[hh_datapath_chisel.scala 318:117]
  assign FP_DDOT_dp_complex_19_io_in_a_3_Re = ddot_din_a_reg[63:32]; // @[hh_datapath_chisel.scala 316:103]
  assign FP_DDOT_dp_complex_19_io_in_a_3_Im = ddot_din_a_reg[31:0] ^ 32'h80000000; // @[hh_datapath_chisel.scala 318:117]
  assign FP_DDOT_dp_complex_19_io_in_b_0_Re = ddot_din_b_reg[255:224]; // @[hh_datapath_chisel.scala 317:103]
  assign FP_DDOT_dp_complex_19_io_in_b_0_Im = ddot_din_b_reg[223:192]; // @[hh_datapath_chisel.scala 319:103]
  assign FP_DDOT_dp_complex_19_io_in_b_1_Re = ddot_din_b_reg[191:160]; // @[hh_datapath_chisel.scala 317:103]
  assign FP_DDOT_dp_complex_19_io_in_b_1_Im = ddot_din_b_reg[159:128]; // @[hh_datapath_chisel.scala 319:103]
  assign FP_DDOT_dp_complex_19_io_in_b_2_Re = ddot_din_b_reg[127:96]; // @[hh_datapath_chisel.scala 317:103]
  assign FP_DDOT_dp_complex_19_io_in_b_2_Im = ddot_din_b_reg[95:64]; // @[hh_datapath_chisel.scala 319:103]
  assign FP_DDOT_dp_complex_19_io_in_b_3_Re = ddot_din_b_reg[63:32]; // @[hh_datapath_chisel.scala 317:103]
  assign FP_DDOT_dp_complex_19_io_in_b_3_Im = ddot_din_b_reg[31:0]; // @[hh_datapath_chisel.scala 319:103]
  assign FP_square_root_newfpu_19_clock = io_clk;
  assign FP_square_root_newfpu_19_reset = io_rst;
  assign FP_square_root_newfpu_19_io_in_a = io_d1_vld ? ddot_dout[63:32] : d1_reg; // @[hh_datapath_chisel.scala 224:20 225:10 227:10]
  assign hqr5_complex_19_clock = io_clk;
  assign hqr5_complex_19_reset = io_rst;
  assign hqr5_complex_19_io_in_a_Re = x1[63:32]; // @[hh_datapath_chisel.scala 361:22]
  assign hqr5_complex_19_io_in_a_Im = x1[31:0]; // @[hh_datapath_chisel.scala 362:22]
  assign hqr5_complex_19_io_in_b_Re = io_d2_vld ? d2_update : d2_reg; // @[hh_datapath_chisel.scala 242:20 243:10 245:10]
  assign hqr7_19_clock = io_clk;
  assign hqr7_19_reset = io_rst;
  assign hqr7_19_io_in_a = io_d3_vld ? ddot_dout[63:32] : d3_reg; // @[hh_datapath_chisel.scala 230:20 231:10 233:10]
  assign FPComplexMult_v2_19_clock = io_clk;
  assign FPComplexMult_v2_19_reset = io_rst;
  assign FPComplexMult_v2_19_io_in_a_Re = d4[63:32]; // @[hh_datapath_chisel.scala 408:23]
  assign FPComplexMult_v2_19_io_in_a_Im = d4[31:0]; // @[hh_datapath_chisel.scala 409:23]
  assign FPComplexMult_v2_19_io_in_b_Re = _GEN_33[31:0]; // @[hh_datapath_chisel.scala 150:18]
  assign FPComplexMult_v2_19_io_in_b_Im = 32'h0; // @[hh_datapath_chisel.scala 411:18]
  assign axpy_dp_complex_19_clock = io_clk;
  assign axpy_dp_complex_19_reset = io_rst;
  assign axpy_dp_complex_19_io_in_a_Re = d5_reg[63:32]; // @[hh_datapath_chisel.scala 434:26]
  assign axpy_dp_complex_19_io_in_a_Im = d5_reg[31:0]; // @[hh_datapath_chisel.scala 435:26]
  assign axpy_dp_complex_19_io_in_b_0_Re = vk[255:224]; // @[hh_datapath_chisel.scala 437:89]
  assign axpy_dp_complex_19_io_in_b_0_Im = vk[223:192]; // @[hh_datapath_chisel.scala 438:89]
  assign axpy_dp_complex_19_io_in_b_1_Re = vk[191:160]; // @[hh_datapath_chisel.scala 437:89]
  assign axpy_dp_complex_19_io_in_b_1_Im = vk[159:128]; // @[hh_datapath_chisel.scala 438:89]
  assign axpy_dp_complex_19_io_in_b_2_Re = vk[127:96]; // @[hh_datapath_chisel.scala 437:89]
  assign axpy_dp_complex_19_io_in_b_2_Im = vk[95:64]; // @[hh_datapath_chisel.scala 438:89]
  assign axpy_dp_complex_19_io_in_b_3_Re = vk[63:32]; // @[hh_datapath_chisel.scala 437:89]
  assign axpy_dp_complex_19_io_in_b_3_Im = vk[31:0]; // @[hh_datapath_chisel.scala 438:89]
  assign axpy_dp_complex_19_io_in_c_0_Re = yj0[255:224]; // @[hh_datapath_chisel.scala 440:90]
  assign axpy_dp_complex_19_io_in_c_0_Im = yj0[223:192]; // @[hh_datapath_chisel.scala 441:90]
  assign axpy_dp_complex_19_io_in_c_1_Re = yj0[191:160]; // @[hh_datapath_chisel.scala 440:90]
  assign axpy_dp_complex_19_io_in_c_1_Im = yj0[159:128]; // @[hh_datapath_chisel.scala 441:90]
  assign axpy_dp_complex_19_io_in_c_2_Re = yj0[127:96]; // @[hh_datapath_chisel.scala 440:90]
  assign axpy_dp_complex_19_io_in_c_2_Im = yj0[95:64]; // @[hh_datapath_chisel.scala 441:90]
  assign axpy_dp_complex_19_io_in_c_3_Re = yj0[63:32]; // @[hh_datapath_chisel.scala 440:90]
  assign axpy_dp_complex_19_io_in_c_3_Im = yj0[31:0]; // @[hh_datapath_chisel.scala 441:90]
  always @(posedge io_clk) begin
    if (io_rst) begin // @[hh_datapath_chisel.scala 75:17]
      yj_reg_vec_0 <= 25728'h0; // @[hh_datapath_chisel.scala 78:22]
    end else if (io_yj_sft) begin // @[hh_datapath_chisel.scala 79:25]
      yj_reg_vec_0 <= _yj_reg_vec_0_T_1; // @[hh_datapath_chisel.scala 82:21]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 75:17]
      yj_reg_vec_1 <= 25728'h0; // @[hh_datapath_chisel.scala 78:22]
    end else if (io_yj_sft) begin // @[hh_datapath_chisel.scala 79:25]
      yj_reg_vec_1 <= _yj_reg_vec_1_T_2; // @[hh_datapath_chisel.scala 85:20]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 75:17]
      yj0 <= 256'h0; // @[hh_datapath_chisel.scala 76:11]
    end else if (io_yj_sft) begin // @[hh_datapath_chisel.scala 79:25]
      yj0 <= yj_reg_vec_1[255:0]; // @[hh_datapath_chisel.scala 80:11]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 161:18]
      ddot_din_a_reg <= 256'h0; // @[hh_datapath_chisel.scala 162:22]
    end else if (io_d1_rdy) begin // @[hh_datapath_chisel.scala 187:20]
      ddot_din_a_reg <= io_hh_din; // @[hh_datapath_chisel.scala 188:18]
    end else if (io_d3_rdy) begin // @[hh_datapath_chisel.scala 189:26]
      ddot_din_a_reg <= vk; // @[hh_datapath_chisel.scala 190:18]
    end else if (io_d4_rdy) begin // @[hh_datapath_chisel.scala 191:26]
      ddot_din_a_reg <= vk; // @[hh_datapath_chisel.scala 192:18]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 161:18]
      ddot_din_b_reg <= 256'h0; // @[hh_datapath_chisel.scala 163:22]
    end else if (io_d1_rdy) begin // @[hh_datapath_chisel.scala 197:20]
      ddot_din_b_reg <= io_hh_din; // @[hh_datapath_chisel.scala 198:18]
    end else if (io_d3_rdy) begin // @[hh_datapath_chisel.scala 199:26]
      if (io_vk1_vld) begin // @[hh_datapath_chisel.scala 207:21]
        ddot_din_b_reg <= vk_update; // @[hh_datapath_chisel.scala 208:10]
      end else begin
        ddot_din_b_reg <= vk_reg; // @[hh_datapath_chisel.scala 210:10]
      end
    end else if (io_d4_rdy) begin // @[hh_datapath_chisel.scala 201:26]
      ddot_din_b_reg <= io_hh_din; // @[hh_datapath_chisel.scala 202:18]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 161:18]
      vk_reg <= 256'h0; // @[hh_datapath_chisel.scala 164:14]
    end else if (io_vk1_vld) begin // @[hh_datapath_chisel.scala 207:21]
      vk_reg <= vk_update; // @[hh_datapath_chisel.scala 208:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 161:18]
      d1_reg <= 32'h0; // @[hh_datapath_chisel.scala 165:14]
    end else if (io_d1_vld) begin // @[hh_datapath_chisel.scala 224:20]
      d1_reg <= ddot_dout[63:32]; // @[hh_datapath_chisel.scala 225:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 161:18]
      d3_reg <= 32'h0; // @[hh_datapath_chisel.scala 166:14]
    end else if (io_d3_vld) begin // @[hh_datapath_chisel.scala 230:20]
      d3_reg <= ddot_dout[63:32]; // @[hh_datapath_chisel.scala 231:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 215:17]
      d4_update <= 64'h0; // @[hh_datapath_chisel.scala 216:17]
    end else if (io_d4_sft) begin // @[hh_datapath_chisel.scala 218:26]
      d4_update <= d4_update_reg[63:0]; // @[hh_datapath_chisel.scala 219:17]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 161:18]
      x1_reg <= 64'h0; // @[hh_datapath_chisel.scala 167:14]
    end else if (io_d1_rdy) begin // @[hh_datapath_chisel.scala 236:20]
      if (io_rst) begin // @[hh_datapath_chisel.scala 276:17]
        x1_reg <= 64'h0; // @[hh_datapath_chisel.scala 277:17]
      end else if (io_d1_rdy) begin // @[hh_datapath_chisel.scala 278:26]
        x1_reg <= _GEN_39; // @[hh_datapath_chisel.scala 279:17]
      end else begin
        x1_reg <= 64'h0; // @[hh_datapath_chisel.scala 281:17]
      end
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 161:18]
      d2_reg <= 32'h0; // @[hh_datapath_chisel.scala 168:14]
    end else if (io_d2_vld) begin // @[hh_datapath_chisel.scala 242:20]
      d2_reg <= d2_update; // @[hh_datapath_chisel.scala 243:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 161:18]
      vk1_reg <= 64'h0; // @[hh_datapath_chisel.scala 169:15]
    end else if (io_vk1_vld) begin // @[hh_datapath_chisel.scala 248:21]
      vk1_reg <= vk1_update; // @[hh_datapath_chisel.scala 249:11]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 161:18]
      tk_reg <= 32'h0; // @[hh_datapath_chisel.scala 170:14]
    end else begin
      tk_reg <= tk; // @[hh_datapath_chisel.scala 182:14]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 161:18]
      d4_reg <= 64'h0; // @[hh_datapath_chisel.scala 171:14]
    end else if (io_d5_rdy) begin // @[hh_datapath_chisel.scala 260:20]
      d4_reg <= d4_update; // @[hh_datapath_chisel.scala 261:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 161:18]
      d5_reg <= 64'h0; // @[hh_datapath_chisel.scala 172:14]
    end else if (io_d5_vld) begin // @[hh_datapath_chisel.scala 266:20]
      d5_reg <= d5_update; // @[hh_datapath_chisel.scala 267:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 215:17]
      d4_update_reg <= 8064'h0; // @[hh_datapath_chisel.scala 217:21]
    end else if (io_d4_sft) begin // @[hh_datapath_chisel.scala 218:26]
      d4_update_reg <= _d4_update_reg_T_1; // @[hh_datapath_chisel.scala 221:21]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 445:16]
      myAxpyVec_0 <= 64'h0; // @[hh_datapath_chisel.scala 447:38]
    end else begin
      myAxpyVec_0 <= _myAxpyVec_0_T; // @[hh_datapath_chisel.scala 450:40]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 445:16]
      myAxpyVec_1 <= 64'h0; // @[hh_datapath_chisel.scala 447:38]
    end else begin
      myAxpyVec_1 <= _myAxpyVec_1_T; // @[hh_datapath_chisel.scala 450:40]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 445:16]
      myAxpyVec_2 <= 64'h0; // @[hh_datapath_chisel.scala 447:38]
    end else begin
      myAxpyVec_2 <= _myAxpyVec_2_T; // @[hh_datapath_chisel.scala 450:40]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 445:16]
      myAxpyVec_3 <= 64'h0; // @[hh_datapath_chisel.scala 447:38]
    end else begin
      myAxpyVec_3 <= _myAxpyVec_3_T; // @[hh_datapath_chisel.scala 450:40]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {804{`RANDOM}};
  yj_reg_vec_0 = _RAND_0[25727:0];
  _RAND_1 = {804{`RANDOM}};
  yj_reg_vec_1 = _RAND_1[25727:0];
  _RAND_2 = {8{`RANDOM}};
  yj0 = _RAND_2[255:0];
  _RAND_3 = {8{`RANDOM}};
  ddot_din_a_reg = _RAND_3[255:0];
  _RAND_4 = {8{`RANDOM}};
  ddot_din_b_reg = _RAND_4[255:0];
  _RAND_5 = {8{`RANDOM}};
  vk_reg = _RAND_5[255:0];
  _RAND_6 = {1{`RANDOM}};
  d1_reg = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  d3_reg = _RAND_7[31:0];
  _RAND_8 = {2{`RANDOM}};
  d4_update = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  x1_reg = _RAND_9[63:0];
  _RAND_10 = {1{`RANDOM}};
  d2_reg = _RAND_10[31:0];
  _RAND_11 = {2{`RANDOM}};
  vk1_reg = _RAND_11[63:0];
  _RAND_12 = {1{`RANDOM}};
  tk_reg = _RAND_12[31:0];
  _RAND_13 = {2{`RANDOM}};
  d4_reg = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  d5_reg = _RAND_14[63:0];
  _RAND_15 = {252{`RANDOM}};
  d4_update_reg = _RAND_15[8063:0];
  _RAND_16 = {2{`RANDOM}};
  myAxpyVec_0 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  myAxpyVec_1 = _RAND_17[63:0];
  _RAND_18 = {2{`RANDOM}};
  myAxpyVec_2 = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  myAxpyVec_3 = _RAND_19[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module hh_core(
  input          io_clk,
  input          io_rst,
  input  [15:0]  io_hh_cnt,
  input          io_d1_rdy,
  input          io_d1_vld,
  input          io_d2_vld,
  input          io_vk1_vld,
  input          io_d3_rdy,
  input          io_d3_vld,
  input          io_tk_vld,
  input          io_d4_rdy,
  input          io_d5_rdy,
  input          io_d5_vld,
  input          io_yj_sft,
  input          io_d4_sft,
  input          io_hh_st,
  input          io_dmx0_mem_ena,
  input  [15:0]  io_dmx0_mem_wea,
  input          io_dmx0_mem_addra,
  input  [127:0] io_dmx0_mem_dina,
  input          io_dmx0_mem_enb,
  input          io_dmx0_mem_addrb,
  output [127:0] io_dmx0_mem_doutb,
  input          io_dmx1_mem_ena,
  input  [15:0]  io_dmx1_mem_wea,
  input          io_dmx1_mem_addra,
  input  [127:0] io_dmx1_mem_dina,
  input          io_dmx1_mem_enb,
  input          io_dmx1_mem_addrb,
  output [127:0] io_dmx1_mem_doutb,
  input          io_rtri_mem_ena,
  input  [15:0]  io_rtri_mem_wea,
  input          io_rtri_mem_addra,
  input  [127:0] io_rtri_mem_dina,
  input          io_rtri_mem_enb,
  input          io_rtri_mem_addrb,
  output [127:0] io_rtri_mem_doutb,
  output [255:0] io_hh_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [255:0] _RAND_2;
  reg [255:0] _RAND_3;
  reg [255:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire  simple_dual_19_io_clka; // @[hh_core.scala 185:31]
  wire  simple_dual_19_io_clkb; // @[hh_core.scala 185:31]
  wire  simple_dual_19_io_ena; // @[hh_core.scala 185:31]
  wire  simple_dual_19_io_enb; // @[hh_core.scala 185:31]
  wire [15:0] simple_dual_19_io_wea; // @[hh_core.scala 185:31]
  wire  simple_dual_19_io_addra; // @[hh_core.scala 185:31]
  wire  simple_dual_19_io_addrb; // @[hh_core.scala 185:31]
  wire [127:0] simple_dual_19_io_dina; // @[hh_core.scala 185:31]
  wire [127:0] simple_dual_19_io_doutb; // @[hh_core.scala 185:31]
  wire  simple_dual_19_1_io_clka; // @[hh_core.scala 197:31]
  wire  simple_dual_19_1_io_clkb; // @[hh_core.scala 197:31]
  wire  simple_dual_19_1_io_ena; // @[hh_core.scala 197:31]
  wire  simple_dual_19_1_io_enb; // @[hh_core.scala 197:31]
  wire [15:0] simple_dual_19_1_io_wea; // @[hh_core.scala 197:31]
  wire  simple_dual_19_1_io_addra; // @[hh_core.scala 197:31]
  wire  simple_dual_19_1_io_addrb; // @[hh_core.scala 197:31]
  wire [127:0] simple_dual_19_1_io_dina; // @[hh_core.scala 197:31]
  wire [127:0] simple_dual_19_1_io_doutb; // @[hh_core.scala 197:31]
  wire  simple_dual_19_2_io_clka; // @[hh_core.scala 208:31]
  wire  simple_dual_19_2_io_clkb; // @[hh_core.scala 208:31]
  wire  simple_dual_19_2_io_ena; // @[hh_core.scala 208:31]
  wire  simple_dual_19_2_io_enb; // @[hh_core.scala 208:31]
  wire [15:0] simple_dual_19_2_io_wea; // @[hh_core.scala 208:31]
  wire  simple_dual_19_2_io_addra; // @[hh_core.scala 208:31]
  wire  simple_dual_19_2_io_addrb; // @[hh_core.scala 208:31]
  wire [127:0] simple_dual_19_2_io_dina; // @[hh_core.scala 208:31]
  wire [127:0] simple_dual_19_2_io_doutb; // @[hh_core.scala 208:31]
  wire  u_hh_datapath_io_clk; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_rst; // @[hh_core.scala 219:38]
  wire [15:0] u_hh_datapath_io_hh_cnt; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_d1_rdy; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_d1_vld; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_d2_vld; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_vk1_vld; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_d3_rdy; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_d3_vld; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_tk_vld; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_d4_rdy; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_d5_rdy; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_d5_vld; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_yj_sft; // @[hh_core.scala 219:38]
  wire  u_hh_datapath_io_d4_sft; // @[hh_core.scala 219:38]
  wire [255:0] u_hh_datapath_io_hh_din; // @[hh_core.scala 219:38]
  wire [255:0] u_hh_datapath_io_hh_dout; // @[hh_core.scala 219:38]
  reg  hh0_din_rdy; // @[hh_core.scala 100:34]
  reg  hh1_din_rdy; // @[hh_core.scala 101:34]
  reg [255:0] hh_din_reg; // @[hh_core.scala 103:33]
  reg [255:0] hh_din; // @[hh_core.scala 106:29]
  wire  _T = hh0_din_rdy | hh1_din_rdy; // @[hh_core.scala 122:30]
  wire [16:0] _myTriMemVec2_1_T = {{1'd0}, io_hh_cnt}; // @[hh_core.scala 149:74]
  wire [63:0] myTriMemVec_1 = io_rtri_mem_doutb[63:0]; // @[hh_core.scala 144:52]
  wire [63:0] myTriMemVec_0 = io_rtri_mem_doutb[127:64]; // @[hh_core.scala 144:52]
  wire [63:0] myTriMemVec2_1 = _myTriMemVec2_1_T[0] ? myTriMemVec_1 : myTriMemVec_0; // @[hh_core.scala 149:{54,54}]
  wire [15:0] _myTriMemVec2_0_T_1 = 16'h1 + io_hh_cnt; // @[hh_core.scala 149:74]
  wire [63:0] myTriMemVec2_0 = _myTriMemVec2_0_T_1[0] ? myTriMemVec_1 : myTriMemVec_0; // @[hh_core.scala 149:{54,54}]
  wire [127:0] myTriMemWire = {myTriMemVec2_1,myTriMemVec2_0}; // @[hh_core.scala 153:42]
  wire [22:0] _hh_din_update_T = io_hh_cnt * 7'h40; // @[hh_core.scala 156:65]
  wire [127:0] _hh_din_update_T_1 = myTriMemWire >> _hh_din_update_T; // @[hh_core.scala 156:52]
  wire [127:0] _GEN_5 = hh1_din_rdy ? io_dmx1_mem_doutb : 128'h0; // @[hh_core.scala 135:36 136:31 138:31]
  wire [127:0] dmx_mem_doutb = hh0_din_rdy ? io_dmx0_mem_doutb : _GEN_5; // @[hh_core.scala 133:30 134:31]
  wire [255:0] _hh_din_update_T_2 = {_hh_din_update_T_1,dmx_mem_doutb}; // @[Cat.scala 31:58]
  reg [255:0] hh_dout_update_REG; // @[hh_core.scala 180:42]
  wire [255:0] _hh_dout_update_T_1 = hh_dout_update_REG >> _hh_din_update_T; // @[hh_core.scala 180:57]
  wire [255:0] _GEN_29 = io_hh_st ? _hh_dout_update_T_1 : hh_din_reg; // @[hh_core.scala 179:33 180:32 182:32]
  wire [63:0] myHhdoutVec_0 = io_hh_dout[255:192]; // @[hh_core.scala 166:45]
  wire [63:0] myHhdoutVec_1 = io_hh_dout[191:128]; // @[hh_core.scala 166:45]
  wire [63:0] myHhdoutVec_2 = io_hh_dout[127:64]; // @[hh_core.scala 166:45]
  wire [63:0] myHhdoutVec_3 = io_hh_dout[63:0]; // @[hh_core.scala 166:45]
  wire [16:0] _myHhdoutVec2_3_T_2 = {{1'd0}, _myTriMemVec2_1_T[15:0]}; // @[hh_core.scala 171:84]
  wire [63:0] _GEN_14 = 2'h1 == _myHhdoutVec2_3_T_2[1:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 171:{52,52}]
  wire [63:0] _GEN_15 = 2'h2 == _myHhdoutVec2_3_T_2[1:0] ? myHhdoutVec_2 : _GEN_14; // @[hh_core.scala 171:{52,52}]
  wire [63:0] myHhdoutVec2_3 = 2'h3 == _myHhdoutVec2_3_T_2[1:0] ? myHhdoutVec_3 : _GEN_15; // @[hh_core.scala 171:{52,52}]
  wire [16:0] _myHhdoutVec2_2_T_2 = {{1'd0}, _myTriMemVec2_0_T_1}; // @[hh_core.scala 171:84]
  wire [63:0] _GEN_18 = 2'h1 == _myHhdoutVec2_2_T_2[1:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 171:{52,52}]
  wire [63:0] _GEN_19 = 2'h2 == _myHhdoutVec2_2_T_2[1:0] ? myHhdoutVec_2 : _GEN_18; // @[hh_core.scala 171:{52,52}]
  wire [63:0] myHhdoutVec2_2 = 2'h3 == _myHhdoutVec2_2_T_2[1:0] ? myHhdoutVec_3 : _GEN_19; // @[hh_core.scala 171:{52,52}]
  wire [15:0] _myHhdoutVec2_1_T_1 = 16'h2 + io_hh_cnt; // @[hh_core.scala 171:72]
  wire [16:0] _myHhdoutVec2_1_T_2 = {{1'd0}, _myHhdoutVec2_1_T_1}; // @[hh_core.scala 171:84]
  wire [63:0] _GEN_22 = 2'h1 == _myHhdoutVec2_1_T_2[1:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 171:{52,52}]
  wire [63:0] _GEN_23 = 2'h2 == _myHhdoutVec2_1_T_2[1:0] ? myHhdoutVec_2 : _GEN_22; // @[hh_core.scala 171:{52,52}]
  wire [63:0] myHhdoutVec2_1 = 2'h3 == _myHhdoutVec2_1_T_2[1:0] ? myHhdoutVec_3 : _GEN_23; // @[hh_core.scala 171:{52,52}]
  wire [15:0] _myHhdoutVec2_0_T_1 = 16'h3 + io_hh_cnt; // @[hh_core.scala 171:72]
  wire [16:0] _myHhdoutVec2_0_T_2 = {{1'd0}, _myHhdoutVec2_0_T_1}; // @[hh_core.scala 171:84]
  wire [63:0] _GEN_26 = 2'h1 == _myHhdoutVec2_0_T_2[1:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 171:{52,52}]
  wire [63:0] _GEN_27 = 2'h2 == _myHhdoutVec2_0_T_2[1:0] ? myHhdoutVec_2 : _GEN_26; // @[hh_core.scala 171:{52,52}]
  wire [63:0] myHhdoutVec2_0 = 2'h3 == _myHhdoutVec2_0_T_2[1:0] ? myHhdoutVec_3 : _GEN_27; // @[hh_core.scala 171:{52,52}]
  wire [127:0] myHhdoutWire_lo = {myHhdoutVec2_1,myHhdoutVec2_0}; // @[hh_core.scala 175:42]
  wire [127:0] myHhdoutWire_hi = {myHhdoutVec2_3,myHhdoutVec2_2}; // @[hh_core.scala 175:42]
  wire [255:0] hh_dout = u_hh_datapath_io_hh_dout; // @[hh_core.scala 243:21 98:27]
  simple_dual_19 simple_dual_19 ( // @[hh_core.scala 185:31]
    .io_clka(simple_dual_19_io_clka),
    .io_clkb(simple_dual_19_io_clkb),
    .io_ena(simple_dual_19_io_ena),
    .io_enb(simple_dual_19_io_enb),
    .io_wea(simple_dual_19_io_wea),
    .io_addra(simple_dual_19_io_addra),
    .io_addrb(simple_dual_19_io_addrb),
    .io_dina(simple_dual_19_io_dina),
    .io_doutb(simple_dual_19_io_doutb)
  );
  simple_dual_19 simple_dual_19_1 ( // @[hh_core.scala 197:31]
    .io_clka(simple_dual_19_1_io_clka),
    .io_clkb(simple_dual_19_1_io_clkb),
    .io_ena(simple_dual_19_1_io_ena),
    .io_enb(simple_dual_19_1_io_enb),
    .io_wea(simple_dual_19_1_io_wea),
    .io_addra(simple_dual_19_1_io_addra),
    .io_addrb(simple_dual_19_1_io_addrb),
    .io_dina(simple_dual_19_1_io_dina),
    .io_doutb(simple_dual_19_1_io_doutb)
  );
  simple_dual_19 simple_dual_19_2 ( // @[hh_core.scala 208:31]
    .io_clka(simple_dual_19_2_io_clka),
    .io_clkb(simple_dual_19_2_io_clkb),
    .io_ena(simple_dual_19_2_io_ena),
    .io_enb(simple_dual_19_2_io_enb),
    .io_wea(simple_dual_19_2_io_wea),
    .io_addra(simple_dual_19_2_io_addra),
    .io_addrb(simple_dual_19_2_io_addrb),
    .io_dina(simple_dual_19_2_io_dina),
    .io_doutb(simple_dual_19_2_io_doutb)
  );
  hh_datapath_1 u_hh_datapath ( // @[hh_core.scala 219:38]
    .io_clk(u_hh_datapath_io_clk),
    .io_rst(u_hh_datapath_io_rst),
    .io_hh_cnt(u_hh_datapath_io_hh_cnt),
    .io_d1_rdy(u_hh_datapath_io_d1_rdy),
    .io_d1_vld(u_hh_datapath_io_d1_vld),
    .io_d2_vld(u_hh_datapath_io_d2_vld),
    .io_vk1_vld(u_hh_datapath_io_vk1_vld),
    .io_d3_rdy(u_hh_datapath_io_d3_rdy),
    .io_d3_vld(u_hh_datapath_io_d3_vld),
    .io_tk_vld(u_hh_datapath_io_tk_vld),
    .io_d4_rdy(u_hh_datapath_io_d4_rdy),
    .io_d5_rdy(u_hh_datapath_io_d5_rdy),
    .io_d5_vld(u_hh_datapath_io_d5_vld),
    .io_yj_sft(u_hh_datapath_io_yj_sft),
    .io_d4_sft(u_hh_datapath_io_d4_sft),
    .io_hh_din(u_hh_datapath_io_hh_din),
    .io_hh_dout(u_hh_datapath_io_hh_dout)
  );
  assign io_dmx0_mem_doutb = simple_dual_19_io_doutb; // @[hh_core.scala 195:31]
  assign io_dmx1_mem_doutb = simple_dual_19_1_io_doutb; // @[hh_core.scala 206:31]
  assign io_rtri_mem_doutb = simple_dual_19_2_io_doutb; // @[hh_core.scala 217:31]
  assign io_hh_dout = io_rst ? 256'h0 : hh_dout; // @[hh_core.scala 244:25 245:27 247:24]
  assign simple_dual_19_io_clka = io_clk; // @[hh_core.scala 187:25]
  assign simple_dual_19_io_clkb = io_clk; // @[hh_core.scala 192:25]
  assign simple_dual_19_io_ena = io_dmx0_mem_ena; // @[hh_core.scala 188:24]
  assign simple_dual_19_io_enb = io_dmx0_mem_enb; // @[hh_core.scala 193:24]
  assign simple_dual_19_io_wea = io_dmx0_mem_wea; // @[hh_core.scala 189:24]
  assign simple_dual_19_io_addra = io_dmx0_mem_addra; // @[hh_core.scala 190:26]
  assign simple_dual_19_io_addrb = io_dmx0_mem_addrb; // @[hh_core.scala 194:26]
  assign simple_dual_19_io_dina = io_dmx0_mem_dina; // @[hh_core.scala 191:25]
  assign simple_dual_19_1_io_clka = io_clk; // @[hh_core.scala 198:25]
  assign simple_dual_19_1_io_clkb = io_clk; // @[hh_core.scala 203:25]
  assign simple_dual_19_1_io_ena = io_dmx1_mem_ena; // @[hh_core.scala 199:24]
  assign simple_dual_19_1_io_enb = io_dmx1_mem_enb; // @[hh_core.scala 204:24]
  assign simple_dual_19_1_io_wea = io_dmx1_mem_wea; // @[hh_core.scala 200:24]
  assign simple_dual_19_1_io_addra = io_dmx1_mem_addra; // @[hh_core.scala 201:26]
  assign simple_dual_19_1_io_addrb = io_dmx1_mem_addrb; // @[hh_core.scala 205:26]
  assign simple_dual_19_1_io_dina = io_dmx1_mem_dina; // @[hh_core.scala 202:25]
  assign simple_dual_19_2_io_clka = io_clk; // @[hh_core.scala 209:25]
  assign simple_dual_19_2_io_clkb = io_clk; // @[hh_core.scala 214:25]
  assign simple_dual_19_2_io_ena = io_rtri_mem_ena; // @[hh_core.scala 210:24]
  assign simple_dual_19_2_io_enb = io_rtri_mem_enb; // @[hh_core.scala 215:24]
  assign simple_dual_19_2_io_wea = io_rtri_mem_wea; // @[hh_core.scala 211:24]
  assign simple_dual_19_2_io_addra = io_rtri_mem_addra; // @[hh_core.scala 212:26]
  assign simple_dual_19_2_io_addrb = io_rtri_mem_addrb; // @[hh_core.scala 216:26]
  assign simple_dual_19_2_io_dina = io_rtri_mem_dina; // @[hh_core.scala 213:25]
  assign u_hh_datapath_io_clk = io_clk; // @[hh_core.scala 221:34]
  assign u_hh_datapath_io_rst = io_rst; // @[hh_core.scala 222:34]
  assign u_hh_datapath_io_hh_cnt = io_hh_cnt; // @[hh_core.scala 223:37]
  assign u_hh_datapath_io_d1_rdy = io_d1_rdy; // @[hh_core.scala 224:37]
  assign u_hh_datapath_io_d1_vld = io_d1_vld; // @[hh_core.scala 225:37]
  assign u_hh_datapath_io_d2_vld = io_d2_vld; // @[hh_core.scala 227:37]
  assign u_hh_datapath_io_vk1_vld = io_vk1_vld; // @[hh_core.scala 229:38]
  assign u_hh_datapath_io_d3_rdy = io_d3_rdy; // @[hh_core.scala 230:37]
  assign u_hh_datapath_io_d3_vld = io_d3_vld; // @[hh_core.scala 231:37]
  assign u_hh_datapath_io_tk_vld = io_tk_vld; // @[hh_core.scala 233:37]
  assign u_hh_datapath_io_d4_rdy = io_d4_rdy; // @[hh_core.scala 234:37]
  assign u_hh_datapath_io_d5_rdy = io_d5_rdy; // @[hh_core.scala 236:37]
  assign u_hh_datapath_io_d5_vld = io_d5_vld; // @[hh_core.scala 237:37]
  assign u_hh_datapath_io_yj_sft = io_yj_sft; // @[hh_core.scala 240:37]
  assign u_hh_datapath_io_d4_sft = io_d4_sft; // @[hh_core.scala 241:37]
  assign u_hh_datapath_io_hh_din = hh_din; // @[hh_core.scala 242:37]
  always @(posedge io_clk) begin
    if (io_rst) begin // @[hh_core.scala 108:25]
      hh0_din_rdy <= 1'h0; // @[hh_core.scala 109:29]
    end else begin
      hh0_din_rdy <= io_dmx0_mem_enb & io_rtri_mem_enb; // @[hh_core.scala 114:29]
    end
    if (io_rst) begin // @[hh_core.scala 108:25]
      hh1_din_rdy <= 1'h0; // @[hh_core.scala 110:29]
    end else begin
      hh1_din_rdy <= io_dmx1_mem_enb & io_rtri_mem_enb; // @[hh_core.scala 115:29]
    end
    if (io_rst) begin // @[hh_core.scala 108:25]
      hh_din_reg <= 256'h0; // @[hh_core.scala 111:28]
    end else if (hh0_din_rdy | hh1_din_rdy) begin // @[hh_core.scala 122:44]
      if (_T) begin // @[hh_core.scala 155:44]
        hh_din_reg <= _hh_din_update_T_2; // @[hh_core.scala 156:31]
      end else if (io_rst) begin // @[hh_core.scala 157:31]
        hh_din_reg <= 256'h0; // @[hh_core.scala 158:31]
      end
    end else if (io_hh_st) begin // @[hh_core.scala 124:33]
      if (io_rst) begin // @[hh_core.scala 177:25]
        hh_din_reg <= 256'h0; // @[hh_core.scala 178:32]
      end else begin
        hh_din_reg <= _GEN_29;
      end
    end
    if (io_rst) begin // @[hh_core.scala 108:25]
      hh_din <= 256'h0; // @[hh_core.scala 111:28]
    end else if (hh0_din_rdy | hh1_din_rdy) begin // @[hh_core.scala 122:44]
      if (_T) begin // @[hh_core.scala 155:44]
        hh_din <= _hh_din_update_T_2; // @[hh_core.scala 156:31]
      end else if (io_rst) begin // @[hh_core.scala 157:31]
        hh_din <= 256'h0; // @[hh_core.scala 158:31]
      end else begin
        hh_din <= hh_din_reg; // @[hh_core.scala 160:31]
      end
    end else if (io_hh_st) begin // @[hh_core.scala 124:33]
      if (io_rst) begin // @[hh_core.scala 177:25]
        hh_din <= 256'h0; // @[hh_core.scala 178:32]
      end else begin
        hh_din <= _GEN_29;
      end
    end else begin
      hh_din <= hh_din_reg; // @[hh_core.scala 128:29]
    end
    hh_dout_update_REG <= {myHhdoutWire_hi,myHhdoutWire_lo}; // @[hh_core.scala 175:42]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  hh0_din_rdy = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  hh1_din_rdy = _RAND_1[0:0];
  _RAND_2 = {8{`RANDOM}};
  hh_din_reg = _RAND_2[255:0];
  _RAND_3 = {8{`RANDOM}};
  hh_din = _RAND_3[255:0];
  _RAND_4 = {8{`RANDOM}};
  hh_dout_update_REG = _RAND_4[255:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module tsqr_st4_c1(
  input          clk,
  input          rst,
  input          tsqr_en,
  input  [15:0]  tile_no,
  input  [2:0]   dma_mem_ena,
  input  [15:0]  dma_mem_wea,
  input          dma_mem_addra,
  input  [127:0] dma_mem_dina,
  input  [2:0]   dma_mem_enb,
  input          dma_mem_addrb,
  output [127:0] dma_mem_doutb,
  output         mem0_fi_c_0,
  output         mem1_fi_c_0,
  output         tsqr_fi
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  fsms_0_clk; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_rst; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_tsqr_en; // @[tsqr_mc.scala 1855:46]
  wire [15:0] fsms_0_tile_no; // @[tsqr_mc.scala 1855:46]
  wire [15:0] fsms_0_hh_cnt; // @[tsqr_mc.scala 1855:46]
  wire [15:0] fsms_0_mx_cnt; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_d1_rdy; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_d1_vld; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_d2_vld; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_vk1_vld; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_d3_rdy; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_d3_vld; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_tk_vld; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_d4_rdy; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_d5_rdy; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_d5_vld; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_yj_sft; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_d4_sft; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_hh_st; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_mem0_fi; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_mem1_fi; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_tsqr_fi; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_dmx0_mem_ena; // @[tsqr_mc.scala 1855:46]
  wire [15:0] fsms_0_dmx0_mem_wea; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_dmx0_mem_addra; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_dmx0_mem_enb; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_dmx0_mem_addrb; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_dmx1_mem_ena; // @[tsqr_mc.scala 1855:46]
  wire [15:0] fsms_0_dmx1_mem_wea; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_dmx1_mem_addra; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_dmx1_mem_enb; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_dmx1_mem_addrb; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_rtri_mem_ena; // @[tsqr_mc.scala 1855:46]
  wire [15:0] fsms_0_rtri_mem_wea; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_rtri_mem_addra; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_rtri_mem_enb; // @[tsqr_mc.scala 1855:46]
  wire  fsms_0_rtri_mem_addrb; // @[tsqr_mc.scala 1855:46]
  wire  hh_core_io_clk; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_rst; // @[tsqr_mc.scala 1856:47]
  wire [15:0] hh_core_io_hh_cnt; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_d1_rdy; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_d1_vld; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_d2_vld; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_vk1_vld; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_d3_rdy; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_d3_vld; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_tk_vld; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_d4_rdy; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_d5_rdy; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_d5_vld; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_yj_sft; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_d4_sft; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_hh_st; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_dmx0_mem_ena; // @[tsqr_mc.scala 1856:47]
  wire [15:0] hh_core_io_dmx0_mem_wea; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_dmx0_mem_addra; // @[tsqr_mc.scala 1856:47]
  wire [127:0] hh_core_io_dmx0_mem_dina; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_dmx0_mem_enb; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_dmx0_mem_addrb; // @[tsqr_mc.scala 1856:47]
  wire [127:0] hh_core_io_dmx0_mem_doutb; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_dmx1_mem_ena; // @[tsqr_mc.scala 1856:47]
  wire [15:0] hh_core_io_dmx1_mem_wea; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_dmx1_mem_addra; // @[tsqr_mc.scala 1856:47]
  wire [127:0] hh_core_io_dmx1_mem_dina; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_dmx1_mem_enb; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_dmx1_mem_addrb; // @[tsqr_mc.scala 1856:47]
  wire [127:0] hh_core_io_dmx1_mem_doutb; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_rtri_mem_ena; // @[tsqr_mc.scala 1856:47]
  wire [15:0] hh_core_io_rtri_mem_wea; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_rtri_mem_addra; // @[tsqr_mc.scala 1856:47]
  wire [127:0] hh_core_io_rtri_mem_dina; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_rtri_mem_enb; // @[tsqr_mc.scala 1856:47]
  wire  hh_core_io_rtri_mem_addrb; // @[tsqr_mc.scala 1856:47]
  wire [127:0] hh_core_io_rtri_mem_doutb; // @[tsqr_mc.scala 1856:47]
  wire [255:0] hh_core_io_hh_dout; // @[tsqr_mc.scala 1856:47]
  wire [15:0] _tile_no_c_0_T = tile_no / 1'h1; // @[tsqr_mc.scala 231:48]
  wire [15:0] _tile_no_c_0_T_2 = _tile_no_c_0_T - 16'h1; // @[tsqr_mc.scala 231:62]
  wire [16:0] _tile_no_c_0_T_3 = {{1'd0}, _tile_no_c_0_T_2}; // @[tsqr_mc.scala 231:67]
  reg  tsqr_fi_REG; // @[tsqr_mc.scala 252:27]
  wire  fsm_rtri_mem_ena_c_0 = fsms_0_rtri_mem_ena; // @[tsqr_mc.scala 1897:31 198:35]
  wire  fsm_dmx0_mem_ena_c_0 = fsms_0_dmx0_mem_ena; // @[tsqr_mc.scala 188:35 1887:31]
  wire  fsm_dmx1_mem_ena_c_0 = fsms_0_dmx1_mem_ena; // @[tsqr_mc.scala 1892:31 193:35]
  wire [15:0] fsm_rtri_mem_wea_c_0 = fsms_0_rtri_mem_wea; // @[tsqr_mc.scala 1898:31 199:35]
  wire [15:0] fsm_dmx0_mem_wea_c_0 = fsms_0_dmx0_mem_wea; // @[tsqr_mc.scala 1888:31 189:35]
  wire [15:0] fsm_dmx1_mem_wea_c_0 = fsms_0_dmx1_mem_wea; // @[tsqr_mc.scala 1893:31 194:35]
  wire  fsm_rtri_mem_addra_c_0 = fsms_0_rtri_mem_addra; // @[tsqr_mc.scala 1899:33 200:37]
  wire  fsm_dmx0_mem_addra_c_0 = fsms_0_dmx0_mem_addra; // @[tsqr_mc.scala 1889:33 190:37]
  wire  fsm_dmx1_mem_addra_c_0 = fsms_0_dmx1_mem_addra; // @[tsqr_mc.scala 1894:33 195:37]
  wire [255:0] hh_dout_c_0 = hh_core_io_hh_dout; // @[tsqr_mc.scala 1945:22 203:26]
  wire [127:0] _GEN_8 = fsm_rtri_mem_ena_c_0 ? hh_dout_c_0[255:128] : 128'h0; // @[tsqr_mc.scala 1265:42 1266:32 1268:32]
  wire [127:0] _GEN_10 = fsm_dmx0_mem_ena_c_0 ? hh_dout_c_0[127:0] : 128'h0; // @[tsqr_mc.scala 1288:56 1289:58 1291:46]
  wire [127:0] _GEN_12 = fsm_dmx1_mem_ena_c_0 ? hh_dout_c_0[127:0] : 128'h0; // @[tsqr_mc.scala 1514:56 1515:58 1517:46]
  wire  fsm_rtri_mem_enb_c_0 = fsms_0_rtri_mem_enb; // @[tsqr_mc.scala 1900:31 201:35]
  wire  fsm_dmx0_mem_enb_c_0 = fsms_0_dmx0_mem_enb; // @[tsqr_mc.scala 1890:31 191:35]
  wire  fsm_dmx1_mem_enb_c_0 = fsms_0_dmx1_mem_enb; // @[tsqr_mc.scala 1895:31 196:35]
  wire  fsm_rtri_mem_addrb_c_0 = fsms_0_rtri_mem_addrb; // @[tsqr_mc.scala 1901:33 202:37]
  wire  fsm_dmx0_mem_addrb_c_0 = fsms_0_dmx0_mem_addrb; // @[tsqr_mc.scala 1891:33 192:37]
  wire  fsm_dmx1_mem_addrb_c_0 = fsms_0_dmx1_mem_addrb; // @[tsqr_mc.scala 1896:33 197:37]
  wire [127:0] dmx1_mem_doutb_c_0 = hh_core_io_dmx1_mem_doutb; // @[tsqr_mc.scala 1768:32 1948:29]
  wire [127:0] _GEN_17 = dma_mem_enb[0] ? dmx1_mem_doutb_c_0 : 128'h0; // @[tsqr_mc.scala 1788:43 1789:27 1791:27]
  wire [127:0] dmx0_mem_doutb_c_0 = hh_core_io_dmx0_mem_doutb; // @[tsqr_mc.scala 1767:32 1947:29]
  wire [127:0] _GEN_18 = dma_mem_enb[1] ? dmx0_mem_doutb_c_0 : _GEN_17; // @[tsqr_mc.scala 1786:40 1787:27]
  wire [127:0] rtri_mem_doutb_c_0 = hh_core_io_rtri_mem_doutb; // @[tsqr_mc.scala 1766:32 1946:29]
  wire [127:0] _GEN_19 = dma_mem_enb[2] ? rtri_mem_doutb_c_0 : _GEN_18; // @[tsqr_mc.scala 1784:43 1785:27]
  fsm fsms_0 ( // @[tsqr_mc.scala 1855:46]
    .clk(fsms_0_clk),
    .rst(fsms_0_rst),
    .tsqr_en(fsms_0_tsqr_en),
    .tile_no(fsms_0_tile_no),
    .hh_cnt(fsms_0_hh_cnt),
    .mx_cnt(fsms_0_mx_cnt),
    .d1_rdy(fsms_0_d1_rdy),
    .d1_vld(fsms_0_d1_vld),
    .d2_vld(fsms_0_d2_vld),
    .vk1_vld(fsms_0_vk1_vld),
    .d3_rdy(fsms_0_d3_rdy),
    .d3_vld(fsms_0_d3_vld),
    .tk_vld(fsms_0_tk_vld),
    .d4_rdy(fsms_0_d4_rdy),
    .d5_rdy(fsms_0_d5_rdy),
    .d5_vld(fsms_0_d5_vld),
    .yj_sft(fsms_0_yj_sft),
    .d4_sft(fsms_0_d4_sft),
    .hh_st(fsms_0_hh_st),
    .mem0_fi(fsms_0_mem0_fi),
    .mem1_fi(fsms_0_mem1_fi),
    .tsqr_fi(fsms_0_tsqr_fi),
    .dmx0_mem_ena(fsms_0_dmx0_mem_ena),
    .dmx0_mem_wea(fsms_0_dmx0_mem_wea),
    .dmx0_mem_addra(fsms_0_dmx0_mem_addra),
    .dmx0_mem_enb(fsms_0_dmx0_mem_enb),
    .dmx0_mem_addrb(fsms_0_dmx0_mem_addrb),
    .dmx1_mem_ena(fsms_0_dmx1_mem_ena),
    .dmx1_mem_wea(fsms_0_dmx1_mem_wea),
    .dmx1_mem_addra(fsms_0_dmx1_mem_addra),
    .dmx1_mem_enb(fsms_0_dmx1_mem_enb),
    .dmx1_mem_addrb(fsms_0_dmx1_mem_addrb),
    .rtri_mem_ena(fsms_0_rtri_mem_ena),
    .rtri_mem_wea(fsms_0_rtri_mem_wea),
    .rtri_mem_addra(fsms_0_rtri_mem_addra),
    .rtri_mem_enb(fsms_0_rtri_mem_enb),
    .rtri_mem_addrb(fsms_0_rtri_mem_addrb)
  );
  hh_core hh_core ( // @[tsqr_mc.scala 1856:47]
    .io_clk(hh_core_io_clk),
    .io_rst(hh_core_io_rst),
    .io_hh_cnt(hh_core_io_hh_cnt),
    .io_d1_rdy(hh_core_io_d1_rdy),
    .io_d1_vld(hh_core_io_d1_vld),
    .io_d2_vld(hh_core_io_d2_vld),
    .io_vk1_vld(hh_core_io_vk1_vld),
    .io_d3_rdy(hh_core_io_d3_rdy),
    .io_d3_vld(hh_core_io_d3_vld),
    .io_tk_vld(hh_core_io_tk_vld),
    .io_d4_rdy(hh_core_io_d4_rdy),
    .io_d5_rdy(hh_core_io_d5_rdy),
    .io_d5_vld(hh_core_io_d5_vld),
    .io_yj_sft(hh_core_io_yj_sft),
    .io_d4_sft(hh_core_io_d4_sft),
    .io_hh_st(hh_core_io_hh_st),
    .io_dmx0_mem_ena(hh_core_io_dmx0_mem_ena),
    .io_dmx0_mem_wea(hh_core_io_dmx0_mem_wea),
    .io_dmx0_mem_addra(hh_core_io_dmx0_mem_addra),
    .io_dmx0_mem_dina(hh_core_io_dmx0_mem_dina),
    .io_dmx0_mem_enb(hh_core_io_dmx0_mem_enb),
    .io_dmx0_mem_addrb(hh_core_io_dmx0_mem_addrb),
    .io_dmx0_mem_doutb(hh_core_io_dmx0_mem_doutb),
    .io_dmx1_mem_ena(hh_core_io_dmx1_mem_ena),
    .io_dmx1_mem_wea(hh_core_io_dmx1_mem_wea),
    .io_dmx1_mem_addra(hh_core_io_dmx1_mem_addra),
    .io_dmx1_mem_dina(hh_core_io_dmx1_mem_dina),
    .io_dmx1_mem_enb(hh_core_io_dmx1_mem_enb),
    .io_dmx1_mem_addrb(hh_core_io_dmx1_mem_addrb),
    .io_dmx1_mem_doutb(hh_core_io_dmx1_mem_doutb),
    .io_rtri_mem_ena(hh_core_io_rtri_mem_ena),
    .io_rtri_mem_wea(hh_core_io_rtri_mem_wea),
    .io_rtri_mem_addra(hh_core_io_rtri_mem_addra),
    .io_rtri_mem_dina(hh_core_io_rtri_mem_dina),
    .io_rtri_mem_enb(hh_core_io_rtri_mem_enb),
    .io_rtri_mem_addrb(hh_core_io_rtri_mem_addrb),
    .io_rtri_mem_doutb(hh_core_io_rtri_mem_doutb),
    .io_hh_dout(hh_core_io_hh_dout)
  );
  assign dma_mem_doutb = rst ? 128'h0 : _GEN_19; // @[tsqr_mc.scala 1782:14 1783:23]
  assign mem0_fi_c_0 = fsms_0_mem0_fi; // @[tsqr_mc.scala 1884:22]
  assign mem1_fi_c_0 = fsms_0_mem1_fi; // @[tsqr_mc.scala 1885:22]
  assign tsqr_fi = tsqr_en & tsqr_fi_REG; // @[tsqr_mc.scala 251:23 252:17 254:17]
  assign fsms_0_clk = clk; // @[tsqr_mc.scala 1859:21]
  assign fsms_0_rst = rst; // @[tsqr_mc.scala 1860:21]
  assign fsms_0_tsqr_en = tsqr_en; // @[tsqr_mc.scala 222:34]
  assign fsms_0_tile_no = tsqr_en ? _tile_no_c_0_T_3[15:0] : 16'h0; // @[tsqr_mc.scala 226:29 231:36 247:28]
  assign hh_core_io_clk = clk; // @[tsqr_mc.scala 1903:22]
  assign hh_core_io_rst = rst; // @[tsqr_mc.scala 1904:22]
  assign hh_core_io_hh_cnt = fsms_0_hh_cnt; // @[tsqr_mc.scala 167:25 1863:21]
  assign hh_core_io_d1_rdy = fsms_0_d1_rdy; // @[tsqr_mc.scala 168:25 1865:21]
  assign hh_core_io_d1_vld = fsms_0_d1_vld; // @[tsqr_mc.scala 169:25 1866:21]
  assign hh_core_io_d2_vld = fsms_0_d2_vld; // @[tsqr_mc.scala 171:25 1868:21]
  assign hh_core_io_vk1_vld = fsms_0_vk1_vld; // @[tsqr_mc.scala 173:26 1870:22]
  assign hh_core_io_d3_rdy = fsms_0_d3_rdy; // @[tsqr_mc.scala 174:25 1871:21]
  assign hh_core_io_d3_vld = fsms_0_d3_vld; // @[tsqr_mc.scala 175:25 1872:21]
  assign hh_core_io_tk_vld = fsms_0_tk_vld; // @[tsqr_mc.scala 177:25 1874:21]
  assign hh_core_io_d4_rdy = fsms_0_d4_rdy; // @[tsqr_mc.scala 178:25 1875:21]
  assign hh_core_io_d5_rdy = fsms_0_d5_rdy; // @[tsqr_mc.scala 180:25 1877:21]
  assign hh_core_io_d5_vld = fsms_0_d5_vld; // @[tsqr_mc.scala 181:25 1878:21]
  assign hh_core_io_yj_sft = fsms_0_yj_sft; // @[tsqr_mc.scala 184:25 1881:21]
  assign hh_core_io_d4_sft = fsms_0_d4_sft; // @[tsqr_mc.scala 185:25 1882:21]
  assign hh_core_io_hh_st = fsms_0_hh_st; // @[tsqr_mc.scala 186:24 1883:20]
  assign hh_core_io_dmx0_mem_ena = dma_mem_ena[1] | fsm_dmx0_mem_ena_c_0; // @[tsqr_mc.scala 270:88]
  assign hh_core_io_dmx0_mem_wea = dma_mem_ena[1] ? dma_mem_wea : fsm_dmx0_mem_wea_c_0; // @[tsqr_mc.scala 366:61 367:45 369:45]
  assign hh_core_io_dmx0_mem_addra = dma_mem_ena[1] ? dma_mem_addra : fsm_dmx0_mem_addra_c_0; // @[tsqr_mc.scala 824:61 825:47 827:47]
  assign hh_core_io_dmx0_mem_dina = dma_mem_ena[1] ? dma_mem_dina : _GEN_10; // @[tsqr_mc.scala 1286:61 1287:46]
  assign hh_core_io_dmx0_mem_enb = dma_mem_enb[1] | fsm_dmx0_mem_enb_c_0; // @[tsqr_mc.scala 1732:68]
  assign hh_core_io_dmx0_mem_addrb = dma_mem_enb[1] ? dma_mem_addrb : fsm_dmx0_mem_addrb_c_0; // @[tsqr_mc.scala 1751:50 1752:33 1754:33]
  assign hh_core_io_dmx1_mem_ena = dma_mem_ena[0] | fsm_dmx1_mem_ena_c_0; // @[tsqr_mc.scala 311:80]
  assign hh_core_io_dmx1_mem_wea = dma_mem_ena[0] ? dma_mem_wea : fsm_dmx1_mem_wea_c_0; // @[tsqr_mc.scala 588:59 589:45 591:45]
  assign hh_core_io_dmx1_mem_addra = dma_mem_ena[0] ? dma_mem_addra : fsm_dmx1_mem_addra_c_0; // @[tsqr_mc.scala 1046:59 1047:47 1049:47]
  assign hh_core_io_dmx1_mem_dina = dma_mem_ena[0] ? dma_mem_dina : _GEN_12; // @[tsqr_mc.scala 1512:59 1513:46]
  assign hh_core_io_dmx1_mem_enb = dma_mem_enb[0] | fsm_dmx1_mem_enb_c_0; // @[tsqr_mc.scala 1733:70]
  assign hh_core_io_dmx1_mem_addrb = dma_mem_enb[0] ? dma_mem_addrb : fsm_dmx1_mem_addrb_c_0; // @[tsqr_mc.scala 1759:52 1760:33 1762:33]
  assign hh_core_io_rtri_mem_ena = dma_mem_ena[2] | fsm_rtri_mem_ena_c_0; // @[tsqr_mc.scala 259:68]
  assign hh_core_io_rtri_mem_wea = dma_mem_ena[2] ? dma_mem_wea : fsm_rtri_mem_wea_c_0; // @[tsqr_mc.scala 349:50 350:31 352:31]
  assign hh_core_io_rtri_mem_addra = dma_mem_ena[2] ? dma_mem_addra : fsm_rtri_mem_addra_c_0; // @[tsqr_mc.scala 805:50 806:33 808:33]
  assign hh_core_io_rtri_mem_dina = dma_mem_ena[2] ? dma_mem_dina : _GEN_8; // @[tsqr_mc.scala 1263:50 1264:32]
  assign hh_core_io_rtri_mem_enb = dma_mem_enb[2] | fsm_rtri_mem_enb_c_0; // @[tsqr_mc.scala 1731:68]
  assign hh_core_io_rtri_mem_addrb = dma_mem_enb[2] ? dma_mem_addrb : fsm_rtri_mem_addrb_c_0; // @[tsqr_mc.scala 1743:50 1744:33 1746:33]
  always @(posedge clk) begin
    tsqr_fi_REG <= fsms_0_tsqr_fi; // @[tsqr_mc.scala 187:26 1886:22]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  tsqr_fi_REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

