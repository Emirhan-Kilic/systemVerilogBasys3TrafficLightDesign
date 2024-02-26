`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2023 04:51:46 PM
// Design Name: 
// Module Name: trafficLightModule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module trafficLightModule(

    input clock,
    input Sb,
    input reset,
    input Sa,

    output reg [2:0] La,
    output reg [2:0] Lb

    );

    reg newClock;
    clockDivider3Seconds clkCreator (
        .originalClockInput(clock),
        .loadReset(reset),
        .dividedClock(newClock)
    );

    // 3'b000 -> S0
    // 3'b001 -> S1
    // 3'b010 -> S2
    // 3'b011 -> S3
    // 3'b100 -> S4
    // 3'b101 -> S5
    // 3'b110 -> S6
    // 3'b111 -> S7

    reg [2:0] nextState;
    reg [2:0] currentState;


    always_comb begin

        case (currentState)
            3'b000: if(Sa) nextState = 3'b000;
                    else nextState = 3'b001;
            3'b001: nextState = 3'b010;
            3'b010: nextState = 3'b011 ;
            3'b011: nextState = 3'b100 ;
            3'b100: if(Sb) nextState = 3'b100 ;
                    else nextState = 3'b101 ;
            3'b101: nextState = 3'b110 ;
            3'b110: nextState = 3'b111 ;
            3'b111: nextState = 3'b000 ;
                default: nextState = 3'b000;
        endcase
        
    end



    //Red = 3'b111
    //Green 3'b011
    //Yellow 3'b001

    
    always_comb begin

        case (currentState)
            3'b000: begin
                La = 3'b011;
                Lb = 3'b111;
            end
            3'b001: begin
                La = 3'b001;
                Lb = 3'b111;
            end
            3'b010: begin
                La = 3'b111;
                Lb = 3'b111;
            end
            3'b011: begin
                La = 3'b111;
                Lb = 3'b001;
            end
            3'b100: begin
                La = 3'b111;
                Lb = 3'b011;
            end
            3'b101: begin
                La = 3'b111;
                Lb = 3'b001;
            end
            3'b110:  begin
                La = 3'b111;
                Lb = 3'b111;
            end
            3'b111: begin
                La = 3'b001;
                Lb = 3'b111;
            end
        endcase
        
    end


    always_ff @(posedge newClock  or negedge reset ) begin
        if (!reset) begin
            currentState <= nextState;
        end 
        else begin
            currentState <= 3'b000;
        end
        
    end 




endmodule
