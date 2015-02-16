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
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input [3:0] KEY;
	output [9:0] LEDR;
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
	wire [31:0] hex5_hex0;
	wire [31:0] hex_led;
	
	//assign HEX0 = ~hex_led[6:0];
	//assign HEX1 = ~hex_led[14:8];
	//assign HEX2 = ~hex_led[22:16];
	//assign HEX3 = ~hex_led[30:24];
	//assign HEX4 = ~hex_led[6:0];
	//assign HEX5 = ~hex_led[14:8];
	
	//assign HEX0 = ~hex5_hex0[6:0];
	//assign HEX1 = ~hex5_hex0[14:8];
	//assign HEX2 = ~hex5_hex0[22:16];
	//assign HEX3 = ~hex5_hex0[30:24];
	//assign HEX4 = ~hex_led[6:0];
	//assign HEX5 = ~hex_led[14:8];
	
	hex_7seg (hex5_hex0[3:0], HEX0);
	hex_7seg (hex5_hex0[7:4], HEX1);
	hex_7seg (hex5_hex0[11:8], HEX2);
	hex_7seg (hex5_hex0[15:12], HEX3);
	hex_7seg (hex5_hex0[19:16], HEX4);
	hex_7seg (hex5_hex0[23:20], HEX5);
	
assign LEDR[7:0] = hex_led[31:24];	
	
    mysystem u0 (
        .system_ref_clk_clk     (CLOCK_50),     //   system_ref_clk.clk
        .system_ref_reset_reset (KEY[0]), // system_ref_reset.reset
        .sdram_clk_clk          (DRAM_CLK),          //        sdram_clk.clk
        
		  .memory_mem_a       (HPS_DDR3_ADDR),       //      memory.mem_a
        .memory_mem_ba      (HPS_DDR3_BA),      //            .mem_ba
        .memory_mem_ck      (HPS_DDR3_CK_P),      //            .mem_ck
        .memory_mem_ck_n    (HPS_DDR3_CK_N),    //            .mem_ck_n
        .memory_mem_cke     (HPS_DDR3_CKE),     //            .mem_cke
        .memory_mem_cs_n    (HPS_DDR3_CS_N),    //            .mem_cs_ n
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
		  
        .to_hex_to_led_export   (hex_led),   //    to_hex_to_led.export
        .pushbutton_export     (~KEY[3:1]),     //      pushbuttons.export
        .hex5_0bus_export       (hex5_hex0)        //        hex5_hex0.export
    );
	 

	 
endmodule 

module hex_7seg(
	input[3:0]hex,
	output reg[0:6] seg
	);

	//	012_3456(segments are active-low)
	parameter ZERO = 7'b000_0001;
	parameter ONE = 7'b100_1111;
	parameter TWO = 7'b001_0010;
	parameter THREE = 7'b000_0110;
	parameter FOUR = 7'b100_1100;
	parameter FIVE = 7'b010_0100;
	parameter SIX = 7'b010_0000;
	parameter SEVEN = 7'b000_1111;
	parameter EIGHT = 7'b000_0000;
	parameter NINE = 7'b000_1100;
	parameter A = 7'b000_0010;
	parameter B = 7'b110_0000;
	parameter C = 7'b011_0001;
	parameter D = 7'b100_0010;
	parameter E = 7'b011_0000;
	//etc.
	parameter F = 7'b011_1000;

	always @(hex)

	case(hex)
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

//.to_hex_to_led_export   (hex5_hex0[31:24]),   //    to_hex_to_led.export
     //   .pushbutton_export     (~KEY[3:1]),     //      pushbuttons.export
     //   .hex5_0bus_export       (hex5_hex0[23:0])        //        hex5_hex0.export