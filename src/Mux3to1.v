module Mux3to1 #(
    parameter size = 32
) 
(
    input [1:0] sel,                // Selector (2 bits)
    input signed [size-1:0] s0,     // Input 0
    input signed [size-1:0] s1,     // Input 1
    input signed [size-1:0] s2,     // Input 2
    output signed [size-1:0] out    // Output
);
    // TODO: implement your 3to1 multiplexer here
    reg signed [size-1:0] Out;
    assign out = Out;
    always @(*) begin
        case(sel)
            2'b00: Out = s0;
            2'b01: Out = s1;
            2'b10: Out = s2;
            default: Out = 0;
        endcase
    end
    
endmodule

