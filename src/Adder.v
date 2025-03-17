module Adder (
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [31:0] sum
);
    // Adder computes sum = a + b
    // The module is useful when accumulating PC (Program Counter)

    // TODO: implement your Adder here
    // Hint: you can use operator to implement (just add it)
    reg signed [31:0] out;
    assign sum = out;
    always @(*) begin
        out = a + b;
    end

endmodule

