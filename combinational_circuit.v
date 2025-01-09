// BASIC GATE AND THEIR OPERATIONS

module gates_2023uee0154(
  input a,
  input b,
  output y1,y2,y3,y4,y5,y6,y7
);
  assign y1=a&b;//AND gate
  assign y2=a|b;//OR gate
  assign y3=a^b;
  assign y4=~a;
  assign y5=~(a|b);
  assign y6=~(a&B);
  assign y7=~(a^b);
endmodule

module gates_with_if_else_2023uee0154 (
    input wire [2:0] sel,   // Select lines to choose the operation
    input wire a,          
    input wire b,           
    output reg result      
);

    always @(*) begin
        if (sel == 3'b000) begin
            result = a & b;       // AND operation
        end else if (sel == 3'b001) begin
            result = a | b;       // OR operation
        end else if (sel == 3'b010) begin
            result = a ^ b;       // XOR operation
        end else if (sel == 3'b011) begin
            result = ~a;          // NOT operation 
        end else if (sel == 3'b100) begin
            result = ~(a & b);    // NAND operation
        end else if (sel == 3'b101) begin
            result = ~(a | b);    // NOR operation
        end else if (sel == 3'b110) begin
            result = ~(a ^ b);    // XNOR operation
        end else begin
            result = 1'b0;        // Default case for invalid `sel`
        end
    end
endmodule


//FULL ADDER IMPLEMENTAION
// USING OR and AND Gates
module full_adder_and_or_2023uee0154 (
    input wire a,       
    input wire b,     
    input wire cin,    
    output wire sum,      
    output wire cout      
);
    wire w1, w2, w3, w4;
  // Sum = (A XOR B) XOR Cin
    assign w1 = a & ~b | ~a & b;   /
    assign sum = w1 & ~cin | ~w1 & cin; 
 // Carry-out = (A AND B) OR (B AND Cin) OR (Cin AND A)
    assign w2 = a & b;
    assign w3 = b & cin;
    assign w4 = cin & a;
    assign cout = w2 | w3 | w4;
endmodule


//Using XOR gate
module full_adder_xor_2023uee0154 (
    input wire a,        
    input wire b,        
    input wire cin,    
    output wire sum,     
    output wire cout      
);
    wire w1, w2, w3;
 // Sum = (A XOR B) XOR Cin
    assign w1 = a ^ b;    
    assign sum = w1 ^ cin; 
// Carry-out = (A AND B) OR (B AND Cin) OR (Cin AND A)
    assign w2 = a & b;
    assign w3 = w1 & cin; 
    assign cout = w2 | w3; 
endmodule




// Code for Real and Integer Data Assignment

//code for 4-BIT HALF ADDER 
module half_adder_4bit_2023uee0154 (
    input wire [3:0] a,     
    input wire [3:0] b,     
    output wire [3:0] sum,   
    output wire carry        
);
    wire [3:0] carry_out;    // Internal carry bits

   
    assign sum[0] = a[0] ^ b[0];         
    assign carry_out[0] = a[0] & b[0]; 

    assign sum[1] = a[1] ^ b[1];       
    assign carry_out[1] = a[1] & b[1];  

    assign sum[2] = a[2] ^ b[2];        
    assign carry_out[2] = a[2] & b[2];  

    assign sum[3] = a[3] ^ b[3];        
    assign carry_out[3] = a[3] & b[3];  

    // Final carry-out 
    assign carry = carry_out[0] | carry_out[1] | carry_out[2] | carry_out[3];

endmodule


//code for 4-BIT FULL ADDER
module full_adder_4bit_2023uee0154 (
    input wire [3:0] a,      
    input wire [3:0] b,     
    input wire cin,          
    output wire [3:0] sum,   
    output wire cout       
);
    wire [3:0] carry;     

    // Full Adder for each bit
    assign sum[0] = a[0] ^ b[0] ^ cin;        
    assign carry[0] = (a[0] & b[0]) | (cin & (a[0] ^ b[0])); 
    assign sum[1] = a[1] ^ b[1] ^ carry[0];  
    assign carry[1] = (a[1] & b[1]) | (carry[0] & (a[1] ^ b[1])); 

    assign sum[2] = a[2] ^ b[2] ^ carry[1];    
    assign carry[2] = (a[2] & b[2]) | (carry[1] & (a[2] ^ b[2])); 

    assign sum[3] = a[3] ^ b[3] ^ carry[2];   
    assign carry[3] = (a[3] & b[3]) | (carry[2] & (a[3] ^ b[3])); 

    assign cout = carry[3];                    // Final carry-out

endmodule



//Code for 4X1 MUX with gates
module muxwithgates_2023UEE0154(
    input a,                // Input 0
    input b,                // Input 1
    input c,                // Input 2
    input d,                // Input 3
    input [1:0] sel,        // 2-bit select signal
    output y                // Output
);
    wire w0, w1, w2, w3;    // Intermediate wires

    // Generate intermediate signals
    assign w0 = a & ~sel[1] & ~sel[0]; 
    assign w1 = b & ~sel[1] & sel[0];  
    assign w2 = c & sel[1] & ~sel[0]; 
    assign w3 = d & sel[1] & sel[0];   

    // Final output
    assign y = w0 | w1 | w2 | w3;      // MUX output
endmodule

//using if-else statement
module mux_4x1_if_else_2023uee0154 (
    input wire a,            // Input 0
    input wire b,            // Input 1
    input wire c,            // Input 2
    input wire d,            // Input 3
    input wire [1:0] sel,    // 2-bit select signal
    output reg y             // Output
);
    always @(*) begin
        if (sel == 2'b00) begin
            y = a;         
        end else if (sel == 2'b01) begin
            y = b;           
        end else if (sel == 2'b10) begin
            y = c;         
        end else if (sel == 2'b11) begin
            y = d;           
        end
    end
endmodule

//using case statement
module mux_case_2023uee0154 (
    input wire a,            // Input 0
    input wire b,            // Input 1
    input wire c,            // Input 2
    input wire d,            // Input 3
    input wire [1:0] sel,    // 2-bit select signal
    output reg y             // Output
);
    always @(*) begin
        case (sel)
            2'b00: y = a;   
            2'b01: y = b;    
            2'b10: y = c;   
            2'b11: y = d;   
            default: y = 0;  
        endcase
    end
endmodule


//DEMUX
module demux_2023uee0154 (
    input wire data,     
    input wire [1:0] sel, 
    output reg [3:0] out  
);

always @(*) begin
   
    out = 4'b0000;

    
    case(sel)
        2'b00: out[0] = data; 
        2'b01: out[1] = data; 
        2'b10: out[2] = data; 
        2'b11: out[3] = data; 
        default: out = 4'b0000; 
    endcase
  end
endmodule


//4-bit comparator
module comparator_4_bit_2023uee0154 (
    input wire [3:0] A,   
    input wire [3:0] B,   
    output reg eq,        
    output reg lt,         // Output: less than (1 if A < B)
    output reg gt          // Output: greater than (1 if A > B)
);

always @(*) begin
    // Default all outputs to 0
    eq = 0;
    lt = 0;
    gt = 0;

    // Compare the values of A and B
    if (A == B) begin
        eq = 1;
    end else if (A < B) begin
        lt = 1; 
    end else begin
        gt = 1;  
    end
end

endmodule



