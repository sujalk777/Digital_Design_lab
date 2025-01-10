module SR_latch_NAND(
  input S,R
  output Q,Qn
);

  assign Q=~(R&Qn);
  assign Qn=~(S&Q);
endmodule

module SR_Latch_2023uee0158(
  input s,
  input r,
  output Q,Qn
);
  assign Q=(~r)&(s|Q);
  assign Qn=~s&(r|~Q);
endmodule

//LATCH-CLOCK CODE
module latch_clock_2023uee0154(
  input s,r,clk,
  output reg Q,
  output reg Qn
);
  always@(posedge clk)
  begin
    if(s& clk &~r)begin
      Q<=1;
      Qn<=0;
    end
    else if(r & clk & ~s) begin
      Q<=0;
      Qn<=1;
    end
    else if(~s & ~r) begin
      Q<=Q;
      Qn<=Qn;
    end
  end
endmodule


//D LATCH 
module d_latch_2023UEE0154 (
    input wire D,      
    input wire En,     
    output reg Q        
);

always @(*) begin
    if (En) 
        Q = D; // When enabled, Q follows D
  end
endmodule

//SERIAL IN SERIAL OUT SHIFT REGISTER
module siso_register_2023uee0154 (
    input wire clk,        
    input wire reset,    
    input wire serial_in, 
    output wire serial_out 
);

reg [3:0] shift_reg; // 4-bit shift register

always @(posedge clk or posedge reset) begin
    if (reset) begin
        shift_reg <= 4'b0000; // Clear the shift register on reset
    end else begin
        shift_reg <= {shift_reg[2:0], serial_in}; // Shift left and load new bit
    end
end

assign serial_out = shift_reg[3]; // Output the MSB

endmodule

//d_flipflop
module d_flip_flop (
    input wire D,       
    input wire clk,    
    input wire reset,   
    output reg Q        
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        Q <= 1'b0;      // Reset the output to 0
    end else begin
        Q <= D;         // On clock edge, store the input D
    end
end

endmodule

//JK FLIPFLOP
module jk_flip_flop (
    input wire J,
    input wire K,       
    input wire clk,   
    input wire reset,  
    output reg Q        
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        Q <= 1'b0;     
    end else begin
        case ({J, K})
            2'b00: Q <= Q;       // No change
            2'b01: Q <= 1'b0;    // Reset
            2'b10: Q <= 1'b1;    // Set
            2'b11: Q <= ~Q;      // Toggle
        endcase
    end
end

endmodule



module sr_flip_flop_2023uee0154 (
    input wire S,      
    input wire R,       
    input wire clk,    
    input wire reset,  
    output reg Q      
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        Q <= 1'b0;      // Reset the output to 0
    end else begin
        case ({S, R})
            2'b00: Q <= Q;       // No change
            2'b01: Q <= 1'b0;    // Reset
            2'b10: Q <= 1'b1;    // Set
            2'b11: Q <= 1'bx;    // Invalid state (both S and R high)
        endcase
    end
end

endmodule


module t_flip_flop_2023uee0154 (
    input wire T,       
    input wire clk,     
    input wire reset,  
    output reg Q    
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        Q <= 1'b0;      
    end else if (T) begin
        Q <= ~Q;       
    end else begin
        Q <= Q;         // Hold the current state if T is low
    end
end

endmodule


//coutner using d flipflop
module d_flip_flop (
    input wire D,       // Data input
    input wire clk,     // Clock input
    input wire reset,   // Asynchronous reset
    output reg Q        // Flip-flop output
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        Q <= 1'b0;      // Reset the output to 0
    end else begin
        Q <= D;         // On clock edge, store the input D
    end
end

endmodule
module counter_2023uee0154 (
    input wire clk,     // Clock input
    input wire reset,   // Asynchronous reset
    output wire [3:0] Q // 4-bit counter output
);

wire [3:0] D; // Wires for D inputs of flip-flops

assign D[0] = ~Q[0];             
assign D[1] = Q[0] ^ Q[1];        
assign D[2] = Q[1] & Q[0] ^ Q[2];  
assign D[3] = Q[2] & Q[1] & Q[0] ^ Q[3]; 


d_flip_flop ff0 (.D(D[0]), .clk(clk), .reset(reset), .Q(Q[0]));
d_flip_flop ff1 (.D(D[1]), .clk(clk), .reset(reset), .Q(Q[1]));
d_flip_flop ff2 (.D(D[2]), .clk(clk), .reset(reset), .Q(Q[2]));
d_flip_flop ff3 (.D(D[3]), .clk(clk), .reset(reset), .Q(Q[3]));

endmodule


//synchronous counter using d-flipflop
module sync_counter_2023uee0154 (
    input wire clk,     
    input wire reset,   
    output wire [3:0] Q 
);

wire [3:0] D; 
assign D[0] = ~Q[0];                  
assign D[1] = Q[0] ^ Q[1];           
assign D[2] = (Q[1] & Q[0]) ^ Q[2];     
assign D[3] = (Q[2] & Q[1] & Q[0]) ^ Q[3]; 

// Instantiate 4 D flip-flops
d_flip_flop ff0 (.D(D[0]), .clk(clk), .reset(reset), .Q(Q[0]));
d_flip_flop ff1 (.D(D[1]), .clk(clk), .reset(reset), .Q(Q[1]));
d_flip_flop ff2 (.D(D[2]), .clk(clk), .reset(reset), .Q(Q[2]));
d_flip_flop ff3 (.D(D[3]), .clk(clk), .reset(reset), .Q(Q[3]));

endmodule


//johnson counter
module johnson_2023uee0154 (
    input wire clk,     
    input wire reset,   
    output reg [3:0] Q  
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        Q <= 4'b0000;   // Reset the counter to 0
    end else begin
        Q <= {~Q[3], Q[3:1]}; // Shift right and complement MSB into LSB
    end
end

endmodule




