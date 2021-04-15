/*Condición primaria*/
var x, binary;
var y, binary;
var ALPHA, binary;

s.t. r1: x = 1;
s.t. r2: y = 1;

s.t. res1: 2*ALPHA <= x + y;
s.t. res2: ALPHA >= x + y - 1;



/*Si mayor*/
var yy;
var OMEGA1, binary;
var OMEGA2, binary;
param num:= 63; 

s.t. r3: yy = 63.1;

#OP1
s.t. res3: 100*OMEGA1 <= 100 + ( yy - num );
s.t. res4: 100*OMEGA1 >= yy - num + (1/100);

#OP2
s.t. res5: num*OMEGA2 <= yy;
s.t. res6: 100*OMEGA2 + num*(1-OMEGA2) >= yy + (1/100);




/*Valor Absoluto*/
var xxx{1..5};
var yyy{1..5};
var zzz{1..5};
var BETA{1..5}, binary;

s.t. r4: xxx[1] = -6;
s.t. r5: xxx[2] = 166;
s.t. r6: xxx[3] = -1;
s.t. r7: xxx[4] = 0;
s.t. r8: xxx[5] = -100;

#OP1
s.t. res7{ i in {1..5}}: 1000*BETA[i] <= 1000 + xxx[i];
s.t. res8{ i in {1..5}}: 1000*BETA[i] >= xxx[i];

s.t. res10{ i in {1..5}}: yyy[i] <= xxx[i] + 1000*(1-BETA[i]);
s.t. res11{ i in {1..5}}: yyy[i] >= xxx[i] - 1000*(1-BETA[i]);
s.t. res12{ i in {1..5}}: yyy[i] <= -xxx[i] + 1000*(BETA[i]);
s.t. res13{ i in {1..5}}: yyy[i] >= -xxx[i] - 1000*(BETA[i]);

#OP2
minimize FO:sum{i in {1..5}}zzz[i];
s.t. res14{ i in {1..5}}: zzz[i] >= xxx[i];
s.t. res15{ i in {1..5}}: zzz[i] >= -xxx[i];


solve;
display ALPHA, OMEGA1, OMEGA2, yyy, zzz;

end;