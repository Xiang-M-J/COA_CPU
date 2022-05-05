// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Tue May  3 21:07:24 2022
// Host        : LAPTOP-REN5KNQ7 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top control_memory_rom -prefix
//               control_memory_rom_ control_memory_rom_stub.v
// Design      : control_memory_rom
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.1" *)
module control_memory_rom(clka, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[5:0],douta[26:0]" */;
  input clka;
  input [5:0]addra;
  output [26:0]douta;
endmodule
