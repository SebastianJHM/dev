# En el siguiente problema se analiza el problema respecto a unos rangos de valores

set R:= {1,2,3,4};

param Costo_Adicional{R};
param LI{R};
param LS{R};

var F;
var z{R}>=0;
var w{R}, binary;

minimize FO:sum{r in R} Costo_Adicional[r]*z[r];

s.t. r1: F = 30;

s.t. r2: sum{r in R} z[r] = F;
s.t. r3{r in R}: z[r] <= w[r] * (LS[r]-LI[r]);
s.t. r4{r in R:r>1}: z[r-1] >= w[r] * (LS[r-1]-LS[r-1]);

solve;
display z;

data;

param Costo_Adicional:= 
1 50
2 60
3 70
4 80;

param LI:=
1	0
2	10
3	30
4	80;

param LS:=
1	10
2	30
3	80
4	10000000000;

end;
