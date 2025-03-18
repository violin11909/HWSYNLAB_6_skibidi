module ALUCtrl (
    input [2:0] ALUOp,          // ALU operation
    input funct7,               // funct7 field of instruction (only 30th bit of instruction)
    input [2:0] funct3,         // funct3 field of instruction
    output reg [3:0] ALUCtl     // ALU control signal
);

    // TODO: implement your ALU control here
    // For testbench verifying, Do not modify input and output pin
    // For funct7, we care only 30th bit of instruction. Why?
    // See all R-type instructions in the lab and observe.

    // Hint: using ALUOp, funct7, funct3 to select exact operation
    //A + B  // ALUCTL == 0000
    //A - B  // ALUCTL == 0001
    //A && B // ALUCTL == 0010
    //A || B // ALUCTL == 0011
    //A < B  // ALUCTL == 0100
    //A + B  but branch
    //beq 0101
    //bne 0110
    //blt 0111
    //bge 1000
    always @(*) begin
        if (ALUOp == 3'b000) begin
            if (funct3 == 3'b000) begin
                if (funct7) begin
                    ALUCtl = 4'b0001;
                end else begin
                    ALUCtl = 4'b0000;
                end
            end else if (funct3 == 3'b111) begin
                ALUCtl = 4'b0010;
            end else if (funct3 == 3'b110) begin
                ALUCtl = 4'b0011;
            end else if (funct3 == 3'b010) begin
                ALUCtl = 4'b0100;
            end
            
            
        end else if (ALUOp == 3'b001) begin
            if (funct3 == 3'b000) begin
                ALUCtl = 4'b0000;
            end else if (funct3 == 3'b111) begin
                ALUCtl = 4'b0010;
            end else if (funct3 == 3'b110) begin
                ALUCtl = 4'b0011;
            end else if (funct3 == 3'b010) begin
                ALUCtl = 4'b0100;
            end
            
            
        end else if (ALUOp == 3'b010) begin
            //lw for sure
            ALUCtl = 4'b0000;
            
            
        end else if (ALUOp == 3'b011) begin
            //sw for sure 
            ALUCtl = 4'b0000;
            
            
        end else if (ALUOp == 3'b100) begin
            if (funct3 == 3'b000) begin
                ALUCtl = 4'b0101;
            end else if (funct3 == 3'b001) begin
                ALUCtl = 4'b0110;
            end else if (funct3 == 3'b100) begin
                ALUCtl = 4'b0111;
            end else if (funct3 == 3'b101) begin
                ALUCtl = 4'b1000;
            end
            
            
        end else if (ALUOp == 3'b101) begin
            ALUCtl = 4'b0000;
        //jalr special case not only normal A+B
        
        
        end else if (ALUOp == 3'b110) begin
            ALUCtl = 4'b1001;
        end
    end


endmodule
