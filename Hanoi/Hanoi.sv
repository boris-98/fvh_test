`timescale 1ns / 1ps

module Hanoi
    #(
        parameter S = 3
    )
    (
        input clk,
        input rst,
        input [1 : 0] fr,
        input [1 : 0] to,
        // Dummy izlaz kako bih elaborirao
        output logic [$clog2(S) : 0] sp_o [3],
        output logic [S * $clog2(S) - 1 : 0] stick_o [3]
    );

logic [S * $clog2(S) - 1 : 0] stick [3]; // 01|10|11, 00|00|00, 00|00|00
logic [$clog2(S) : 0] stack_pointer [3]; // 11       ,00       ,00

// Prva varijanta
// 0 -> 2
// 01|10|11, 00|00|00, 00|00|01
// 10       ,00       ,01

// Druga varijanta
// 0 -> 2
// 00|10|11, 00|00|00, 00|00|01
// 0 -> 2
// 00|00|11, 00|00|00, 00|10|01

logic [S * $clog2(S) - 1 : 0] dest_read, src_read, dest_write, src_write;
logic [$clog2(S) : 0] dest_sp_read, src_sp_read, dest_sp_write, src_sp_write;
logic [$clog2(S) - 1 : 0] data;
logic [$clog2(S) - 1 : 0] split_src [S];
logic [S - 1 : 0] change_vec;
genvar j;

//// Alternativa medika
//always_comb begin
//    logic [$clog2(S) - 1 : 0] src, dest;
    
//    // ------------------ READ & WRITE ------------------ //
    
//    // Source
//    // Ovo je kada je stap prazan
//    src = 0;
    
//    src_write = src_read;
//    // Ovde gledamo ako stap ima jos kandidata
//    for(int i = 0;  i < S; i++) begin
//        if(src_read[(i + 1) * $clog2(S) - 1 -: $clog2(S)] != 0) begin
//            src_write = src_read;
//            src_write[(i + 1) * $clog2(S) - 1 -: $clog2(S)] = 0;
//            src = src_read[(i + 1) * $clog2(S) - 1 -: $clog2(S)];
//        end
//    end
    
//    // Destination
//    // Ovo je kada je stap pun
//    dest = 0;
//    dest_write = dest_read;
    
//    // Ovde gledamo ako stap ima jos kandidata
//    for(int i = S;  i > 0; i--) begin
//        if(dest_read[i * $clog2(S) - 1 -: $clog2(S)] == 0) begin
//            dest_write = dest_read;
//            dest_write[i * $clog2(S) - 1 -: $clog2(S)] = src;
//            if(i != 1) begin
//                dest = dest_read[(i - 1) * $clog2(S) - 1 -: $clog2(S)];
//            end
//        end
//    end
    
//    // ------------------ Property ------------------ //
    
//    // restrict : dest < src when dest != 0;
//    // cover : stick[2] = 011011;
//    // restrict : to = fr;
    
//end

always_ff@(posedge clk) begin
    
    if(rst) begin
        
        // 01|10|11
        for(int i = 0; i < S; i++) begin
            stick[0][((i + 1) * $clog2(S) - 1)-: $clog2(S)] <= S - i;
        end
        stick[1] <= 0;
        stick[2] <= 0;
        stack_pointer[0] <= S;
        stack_pointer[1] <= 0;
        stack_pointer[2] <= 0;
        
    end
    else begin
    
        // stick[fr] <=  src_write;
        stick[to] <= dest_write;
        stack_pointer[to] <= dest_sp_write;
        stack_pointer[fr] <= src_sp_write; 
        
    end    
end

assign dest_read = stick[to];
assign src_read = stick[fr];
assign dest_sp_read = stack_pointer[to];
assign src_sp_read = stack_pointer[fr];

// Primer:
/*
    sticks: [0, 0, 3], [0, 1, 2], [0, 0, 0]
    sp:     1,          2,         0
    sp ima jedno stanje vise od broja obruca
    kada je sp 0 to znaci da je stap prazan
*/
     
always_comb begin
    
    for(int i = 0; i < S; i++) begin
        split_src[i] = src_read[((i + 1) * $clog2(S) - 1)-: $clog2(S)];
    end
    
    data = split_src[src_sp_read - 1];
    
    change_vec = 1 << dest_sp_read; // 010
    dest_sp_write = dest_sp_read + 1;
    src_sp_write = src_sp_read - 1;
    
end

generate
    for(j = 0; j < S; j++) begin
        assign dest_write[(j + 1) * $clog2(S) - 1 : j * $clog2(S)] = change_vec[j] ? data : dest_read[(j + 1) * $clog2(S) - 1: j * $clog2(S)];
    end
endgenerate;

assign sp_o = stack_pointer;
assign stick_o = stick;

endmodule
