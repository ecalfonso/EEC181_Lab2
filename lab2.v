module lab2(
	// Lab 2 input/outputs
	
	// Clock pins
	CLOCK_50,
	
	// 7seg displays
	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
	
	// Pushbuttons
	KEY,
	
	// LEDs
	LEDR,
	
	// Switches
	SW,
	
	// HPS Pins
	// DDR3 SDRAM
	HPS_DDR3_ADDR,
	HPS_DDR3_BA,
	HPS_DDR3_CAS_N,
	HPS_DDR3_CKE,
	HPS_DDR3_CK_N,
	HPS_DDR3_CK_P,
	HPS_DDR3_CS_N,
	HPS_DDR3_DM,
	HPS_DDR3_DQ,
	HPS_DDR3_DQS_N,
	HPS_DDR3_DQS_P,
	HPS_DDR3_ODT,
	HPS_DDR3_RAS_N,
	HPS_DDR3_RESET_N,
	HPS_DDR3_RZQ,
	HPS_DDR3_WE_N
); 

	// FPGA Pins
	input CLOCK_50;
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input [3:0] KEY;
	output [7:0] LEDR;
	input [9:0] SW;
	
	// HPS DDR3 Pins
	output [14:0] HPS_DDR3_ADDR;
	output [2:0] HPS_DDR3_BA;
	output HPS_DDR3_CAS_N;
	output HPS_DDR3_CKE;
	output HPS_DDR3_CK_N;
	output HPS_DDR3_CK_P;
	output HPS_DDR3_CS_N;
	output [3:0] HPS_DDR3_DM;
	inout [31:0] HPS_DDR3_DQ;	
	inout [3:0] HPS_DDR3_DQS_N;
	inout [3:0] HPS_DDR3_DQS_P;
	output HPS_DDR3_ODT;
	output HPS_DDR3_RAS_N;
	output HPS_DDR3_RESET_N;
	input HPS_DDR3_RZQ;
	output HPS_DDR3_WE_N;
	
	// REG/WIRE declarations
	wire [31:0] hex;
	wire [7:0] led;

	hex_7seg(hex[3:0], HEX0);
	hex_7seg(hex[7:4], HEX1);
	hex_7seg(hex[11:8], HEX2);
	hex_7seg(hex[15:12], HEX3);
	hex_7seg(hex[19:16], HEX4);
	hex_7seg(hex[23:20], HEX5);
	
	assign LEDR[7:0]=led;

    mysystem u0 (
        .system_ref_clk_clk     (CLOCK_50),     //   system_ref_clk.clk
        .system_ref_reset_reset (~KEY[0]), // system_ref_reset.reset
        .sdram_clk_clk          (DRAM_CLK),          //        sdram_clk.clk
        
		  .memory_mem_a       (HPS_DDR3_ADDR),       //      memory.mem_a
        .memory_mem_ba      (HPS_DDR3_BA),      //            .mem_ba
        .memory_mem_ck      (HPS_DDR3_CK_P),      //            .mem_ck
        .memory_mem_ck_n    (HPS_DDR3_CK_N),    //            .mem_ck_n
        .memory_mem_cke     (HPS_DDR3_CKE),     //            .mem_cke
        .memory_mem_cs_n    (HPS_DDR3_CS_N),    //            .mem_cs_n
        .memory_mem_ras_n   (HPS_DDR3_RAS_N),   //            .mem_ras_n
        .memory_mem_cas_n   (HPS_DDR3_CAS_N),   //            .mem_cas_n
        .memory_mem_we_n    (HPS_DDR3_WE_N),    //            .mem_we_n
        .memory_mem_reset_n (HPS_DDR3_RESET_N), //            .mem_reset_n
        .memory_mem_dq      (HPS_DDR3_DQ),      //            .mem_dq
        .memory_mem_dqs     (HPS_DDR3_DQS_P),     //            .mem_dqs
        .memory_mem_dqs_n   (HPS_DDR3_DQS_N),   //            .mem_dqs_n
        .memory_mem_odt     (HPS_DDR3_ODT),     //            .mem_odt
        .memory_mem_dm      (HPS_DDR3_DM),      //            .mem_dm
        .memory_oct_rzqin   (HPS_DDR3_RZQ),   //            .oct_rzqin
		  
        .to_hex_to_led_export   ({led[7:0], hex}),   //    to_hex_to_led.export
        .pushbutton_export     (~KEY[3:1]),     //      pushbuttons.export
        .hex5_0bus_export       (hex5_hex0)        //        hex5_hex0.export
    );
	 
endmodule

module hex_7seg (hex, seg);
input [3:0] hex;
output reg [0:6] seg;

//	012_3456 (segments are active-low)
parameter ZERO = 7'b000_0001; //6 off
parameter ONE = 7'b100_1111; // 0,3,4,5,6 off
parameter TWO = 7'b001_0010;  // 2 off
parameter THREE = 7'b000_0110; // 4,5 off
parameter FOUR = 7'b100_1100; // 0,3,4 off
parameter FIVE = 7'b010_0100;
parameter SIX = 7'b010_0000;
parameter SEVEN = 7'b000_1111;
parameter EIGHT = 7'b000_0000;
parameter NINE = 7'b000_1100;
parameter A = 7'b000_0010; // lower-case a
parameter B = 7'b110_0000; // lower-case b
parameter C = 7'b011_0001; // C
parameter D = 7'b100_0010; // lower-case d
parameter E = 7'b011_0000; // E
parameter F = 7'b011_1000; // F

always @(hex)

case (hex)
0: seg = ZERO;
1: seg = ONE;
2: seg = TWO;
3: seg = THREE;
4: seg = FOUR;
5: seg = FIVE;
6: seg = SIX;
7: seg = SEVEN;
8: seg = EIGHT;
9: seg = NINE;
10: seg = A;
11: seg = B;
12: seg = C;
13: seg = D;
14: seg = E;
15: seg = F;
endcase

endmodule