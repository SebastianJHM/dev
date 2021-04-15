set J:={1..10};
set R:={1,2,3};
set H:={1..4};

param LI{R};
param LS{R};
param G{R};
param Habilidades{J,H};

var HAB{J};
var w{J,R}, binary;
var Ganancia{J};
var x{J}, binary;

minimize FO:sum{j in J}Ganancia[j];

s.t. r2: sum{j in J} x[j] = 5;

s.t. r1{j in J}: HAB[j] = sum{h in H}Habilidades[j,h];
s.t. r6{j in J, r in R}: 100*w[j,r] <= 100 + (LS[r]-HAB[j]);
s.t. r7{j in J, r in R}: 100*w[j,r] <= 100 + (HAB[j]-LI[r]);
s.t. r8{j in J}: sum{r in R} w[j,r] = 1;


s.t. r9{j in J}: Ganancia[j] <= sum{r in R}w[j,r]*G[r] + 100000*(1-x[j]);
s.t. r10{j in J}: Ganancia[j] >= sum{r in R}w[j,r]*G[r] - 100000*(1-x[j]);
s.t. r11{j in J}: Ganancia[j] <= 3000 + 100000*(x[j]);
s.t. r12{j in J}: Ganancia[j] >= 3000 - 100000*(x[j]);

solve;
display w, x, Ganancia;

data;
param LI:=
1	4
2	7
3	10;

param LS:=
1	6
2	9
3	12;

param G:=
1	5000
2	7500
3	10000;

param Habilidades:	1	2	3	4:=
				1	3	3	1	3
				2	2	1	3	2
				3	2	3	2	2
				4	1	3	3	1
				5	3	3	3	3
				6	3	1	2	3
				7	3	2	2	1
				8	2	3	2	1
				9	1	2	1	1
				10	1	1	3	2;
end;
