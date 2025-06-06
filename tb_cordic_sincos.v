// //CORDIC Testbench for sine and cosine for Final Project 

// //Claire Barnes

// `timescale 1ns / 1ps

// ////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer:
// //
// // Create Date:   09:39:33 03/17/2018
// // Design Name:   cordic
// // Module Name:   /home/josh/cordic_fft/cordic_tb.v
// // Project Name:  cordic_fft
// // Target Device:  
// // Tool versions:  
// // Description: 
// //
// // Verilog Test Fixture created by ISE for module: cordic
// //
// // Dependencies:
// // 
// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:
// // 
// ////////////////////////////////////////////////////////////////////////////////

// //CORDIC Testbench for sine and cosine for Final Project 

// //Claire Barnes

// module tb_cordic_sincos;

//   localparam width = 16; //width of x and y

//   // Inputs
//   reg [width-1:0] Xin, Yin;
//   reg [31:0] angle;
//   reg clk;
//   reg signed [63:0] i;

//   wire [width-1:0] COSout, SINout;

//   localparam An = 32000/1.647;

//   always #5 clk = ~clk;
//   initial begin

//     //set initial values
//     angle = 'b00110101010101010101010101010101;
//     Xin = An;     // Xout = 32000*cos(angle)
//     Yin = 0;      // Yout = 32000*sin(angle)
//     clk = 0;

//     #50

//     // Test 1
//     #10                                           
//     angle = 'b00100000000000000000000000000000;    // example: 45 deg = 45/360 * 2^32 = 32'b00100000000000000000000000000000 = 45.000 degrees -> atan(2^0)

//     // Test 2
//     #10
//     angle = 'b00101010101010101010101010101010; // 60 deg

//     // Test 3
//     #10
//     angle = 'b10000111000111000111000111000111; // 190 deg

//     // Test 4
//     // #10000
//     // angle = 'b00110101010101010101010101010101; // 75 deg

//    #1000
//    $write("Simulation has finished");
//    $stop;

//   end

//   top TEST_RUN(clk, COSout, SINout, Xin, Yin, angle);

//   // Monitor the output
//   initial
//   $monitor($time, , COSout, , SINout, , angle);

// endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Advanced Digital Systems Inc.
// Engineer: JapKimChaw
//
// Create Date: 06/06/2025 04:55:24 UTC
// Design Name: CORDIC Sine/Cosine Testbench (Radian Input)
// Module Name: tb_cordic_sincos
// Project Name: High-Precision Trigonometric Function Generator
// Target Device: Xilinx 7-Series and UltraScale+
// Tool Versions: Vivado 2023.2
// Description: Comprehensive testbench for CORDIC sine/cosine generator module.
//              Uses RADIAN input format: (2^32 * θ) / 2π where θ is in radians
//              Tests multiple angle values and verifies output accuracy against
//              expected mathematical results.
//
// Dependencies: cordic_sincos.v
// 
// Revision:
// Revision 0.01 - File Created - Basic angle testing
// Revision 0.02 - Added comprehensive test vectors and verification
// Revision 0.03 - Updated to match new cordic_sincos module interface
// Revision 0.04 - CORRECTED: Using radian input format instead of degrees
// 
// Additional Comments:
// - Input format: (2^32 * angle_in_radians) / (2π)
// - Full circle (2π rad) = 2^32 = 0x100000000
// - Half circle (π rad) = 2^31 = 0x80000000
// - Quarter circle (π/2 rad) = 2^30 = 0x40000000
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: JapKimChaw
// 
// Create Date: 06/06/2025 04:57:19 UTC
// Design Name: 
// Module Name: tb_cordic_sincos
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Simple testbench for CORDIC sine/cosine module
// 
// Dependencies: cordic_sincos.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// Input format: (2^32 * angle_in_radians) / (2π)
//////////////////////////////////////////////////////////////////////////////////

module tb_cordic_sincos;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg enable;
    reg start;
    reg signed [31:0] angle_in;
    wire signed [15:0] sine_out;
    wire signed [15:0] cosine_out;
    wire data_valid;

    // Clock generation - 100MHz
    always #5 clk = ~clk;

    // DUT instantiation
    cordic_sincos dut (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .start(start),
        .angle_in(angle_in),
        .sine_out(sine_out),
        .cosine_out(cosine_out),
        .data_valid(data_valid)
    );

    // Test sequence
    initial begin
        // Initialize
        clk = 0;
        rst_n = 0;
        enable = 0;
        start = 0;
        angle_in = 0;

        // Reset
        #50;
        rst_n = 1;
        enable = 1;
        #30;

        // Test 1: 0 radians (0 degrees)
        angle_in = 32'h00000000;
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        wait(data_valid);
        $display("0 rad: sin=%d, cos=%d", sine_out, cosine_out);
        #20;

        // Test 2: π/4 radians (45 degrees)
        angle_in = 32'h20000000;
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        wait(data_valid);
        $display("π/4 rad: sin=%d, cos=%d", sine_out, cosine_out);
        #20;

        // Test 3: π/2 radians (90 degrees)
        angle_in = 32'h40000000;
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        wait(data_valid);
        $display("π/2 rad: sin=%d, cos=%d", sine_out, cosine_out);
        #20;

        // Test 4: π radians (180 degrees)
        angle_in = 32'h80000000;
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        wait(data_valid);
        $display("π rad: sin=%d, cos=%d", sine_out, cosine_out);
        #20;

        // Test 5: 3π/2 radians (270 degrees)
        angle_in = 32'hC0000000;
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        wait(data_valid);
        $display("3π/2 rad: sin=%d, cos=%d", sine_out, cosine_out);
        #20;

        // Test 6: 60 degree
        angle_in = 32'b00101010101010101010101010101010;
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        wait(data_valid);
        $display("3π/2 rad: sin=%d, cos=%d", sine_out, cosine_out);
        #20;

        // Test 7: 190 degree
        angle_in = 32'b10000111000111000111000111000111;
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        wait(data_valid);
        $display("3π/2 rad: sin=%d, cos=%d", sine_out, cosine_out);
        #20;

        // Test 8: 75 degree (5π/12)
        angle_in = 32'd894784853;
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        wait(data_valid);
        $display("3π/2 rad: sin=%d, cos=%d", sine_out, cosine_out);
        #20;

        $display("Simulation completed");
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time: %0t | angle: 0x%08X | sin: %d | cos: %d | valid: %b", 
                 $time, angle_in, sine_out, cosine_out, data_valid);
    end

endmodule