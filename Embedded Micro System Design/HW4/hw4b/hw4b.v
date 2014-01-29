module hw4b(a, b, s, f); 
    input[3:0] a;
    input[3:0] b;
    input[3:0] s;
    output[3:0] f;

reg[3:0] f;
always@(a or b or s)
begin
        case(s)
		    4'b0000:
		        f = ~a;
		    4'b0001:
		        f = ~(a & b);
		    4'b0010:
		        f = ~a | b;
		    4'b0011:
		        f = "0001";
		    4'b0100:
		        f = ~(a | b);
		    4'b0101:
		        f = ~b;
		    4'b0110:
		        f = ~(a ^ b);
		    4'b0111:
		        f = a | ~b;
		    4'b1000:
		        f = ~a & b;
		    4'b1001:
		        f = a ^ b;
		    4'b1010:
		        f = b;
		    4'b1011:
		        f = a | b;
		    4'b1100:
		        f = "0000";
		    4'b1101:
		        f <= a & ~b;
		    4'b1110:
		        f = a & b;
		    4'b1111:
		        f = a;
		endcase
    end
endmodule
