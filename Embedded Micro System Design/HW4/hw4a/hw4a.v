module hw4a (LOAD, DATA_A, DATA_B, clk, DATA_C, DATA_D, CLR, ENP, ENT, Q_A, Q_B, Q_C, Q_D, RC0);
    input   LOAD;
	input	DATA_A;
	input	DATA_B;
	input	clk;
	input	DATA_C;
	input	DATA_D;
	input	CLR;
	input	ENP;
	input	ENT;
		
	inout	Q_A;
	inout	Q_B;
	inout	Q_C;
	inout	Q_D;
		
	output	RC0;

	reg[5:0] a;
	reg[5:0] b;
	reg[5:0] c;
	reg[5:0] d;

	reg[3:0] temp;
	reg first;

//JK Flip Flops	
always @(negedge clk)
begin
    // Combinational Logic
	first = (ENP & ENT);
	
	//For Q_A
	a[0] = (~ LOAD) | (~ CLR);
	a[1] = ~(a[0] & a[3]);
	a[2] = first | a[0];
	a[3] = ~(~(DATA_A & CLR) & a[0]);
	a[4] = a[1] & a[2];
	a[5] = a[2] & a[3];
	
	//For Q_B
	b[0] = Q_A & first;
	b[1] = ~(a[0] & b[3]);
	b[2] = b[0] | a[0];
	b[3] = ~(~(DATA_B & CLR) & a[0]);
	b[4] = b[1] & b[2];
	b[5] = b[2] & b[3];
	
	//For Q_C
	c[0] = Q_B & Q_A & first;
	c[1] = ~(a[0] & c[3]);
	c[2] = c[0] | a[0];
	c[3] = ~(~(DATA_C & CLR) & a[0]);
	c[4] = c[1] & c[2];
	c[5] = c[2] & c[3];
	
	//For Q_D
	d[0] = Q_C & Q_B & Q_A & first;
	d[1] = ~(a[0] & d[3]);
	d[2] = a[0] | d[0];
	d[3] = ~(~(DATA_D & CLR) & a[0]);
	d[4] = d[1] & d[2];
	d[5] = d[2] & d[3];
	
	
    //a(4) is J and a(5) is K
    if (a[4] & ~a[5])
        temp[0] = 1;
    else if (~a[4] & a[5])
        temp[0] = 0;
    else if (a[4] & a[5])
        temp[0] = ~temp[0];

    //b(4) is J and b(5) is K
    if (b[4] & ~b[5])
        temp[1] = 1;
    else if (~b[4] & b[5])
        temp[1] = 0;
    else if (b[4] & b[5])
        temp[1] = ~temp[1];
               
    //c(4) is J and c(5) is K
    if (c[4] & ~c[5])
        temp[2] = 1;
    else if (~c[4] & c[5])
        temp[2] = 0;
    else if (c[4] & c[5])
        temp[2] = ~temp[2];
               
    //d(4) is J and d(5) is K
    if (d[4] & ~d[5])
        temp[3] = 1;
    else if (~d[4] & d[5])
        temp[3] = 0;
    else if (d[4] & d[5])
        temp[3] = ~temp[3];   
end
    
//Outputs
wire Q_A = temp[0];
wire Q_B = temp[1];
wire Q_C = temp[2];
wire Q_D = temp[3];
wire RC0 =	Q_D & Q_C & Q_B & Q_A & ENT;

endmodule
