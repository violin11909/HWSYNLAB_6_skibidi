module ALU (
    input [3:0] ALUctl,                     // This will be used to select the operation of ALU
    input brLt,                             // Branch Less Than (for branching instruction)
    input brEq,                             // Branch Equal (for branching instruction)
    input signed [31:0] A,B,                // Operands
    output reg signed [31:0] ALUOut         // Output of ALU
);
    // ALU has two operand, it execute different operator based on ALUctl wire

    // TODO: implement your ALU here
    // Hint: you can use operator to implement
    always @(*) begin
        //4 branch
        if (ALUctl == 4'b0101) begin
            if (brEq) begin
                ALUOut = A + B;
            end else begin
                ALUOut = A + 32'd4;
            end
        end else if (ALUctl == 4'b0110) begin
            if (!brEq) begin
                ALUOut = A + B;
            end else begin
                ALUOut = A + 32'd4;
            end
        end else if (ALUctl == 4'b0111) begin
            if (brLt) begin
                ALUOut = A + B;
            end else begin
                ALUOut = A + 32'd4;
            end
        end else if (ALUctl == 4'b1000) begin
            if (!brLt) begin
                ALUOut = A + B;
            end else begin
                ALUOut = A + 32'd4;
            end
        end else if (ALUctl == 4'b0000) begin
            ALUOut = A + B;
        end else if (ALUctl == 4'b0001) begin
            ALUOut = A - B;
        end else if (ALUctl == 4'b0010) begin
            ALUOut = A & B;
        end else if (ALUctl == 4'b0011) begin
            ALUOut = A | B;
        end else if (ALUctl == 4'b1001) begin
            ALUOut = (A + B)&(~1);
        end else if (ALUctl == 4'b0100) begin
            ALUOut = (A < B) ? 32'd1 : 32'd0;
        end
    end
    
endmodule
