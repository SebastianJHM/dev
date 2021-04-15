# El siguiente problema evalua que habilidad de cada jugador esté dentro de tres pposibles rangos

set J:={1..5};
set R:={1,2,3};

param LI{R};
param LS{R};
param G{R};

var HAB{J};
var w{J,R}, binary;
var Ganancia{J};

minimize FO:sum{j in J}Ganancia[j];

s.t. h1: HAB[1] = 8;
s.t. h2: HAB[2] = 6;
s.t. h3: HAB[3] = 9;
s.t. h4: HAB[4] = 7;
s.t. h5: HAB[5] = 12;

s.t. r6{j in J, r in R}: 100*w[j,r] <= 100 + (LS[r]-HAB[j]);
s.t. r7{j in J, r in R}: 100*w[j,r] <= 100 + (HAB[j]-LI[r]);
s.t. r8{j in J}: sum{r in R} w[j,r] = 1;

s.t. r9{j in J}: Ganancia[j] = sum{r in R} w[j,r]*G[r];
solve;
display w, Ganancia;

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
end;
