/*CONJUNTOS*/
set SUC:={1,2,3};
set PRO:={1..8};

/*PARÁMETROS */
param Min_Fondos{SUC};
param Max_Fondos{SUC};
param Tasa_Gan{PRO};
param ALPHA{SUC, PRO}; # 1 si la sucursal realiza el proyecto

/*VARIABLES DE DESICIÓN*/
var x{SUC, PRO},>=0;

/*FUNCIÓN OBJETIVO*/
maximize FO: sum{suc in SUC, pro in PRO}Tasa_Gan[pro]*x[suc,pro];

s.t. r1{suc in SUC, pro in PRO}: x[suc,pro] <= 100*ALPHA[suc,pro];
s.t. r2{suc in SUC}: sum{pro in PRO}x[suc,pro] >= Min_Fondos[suc];
s.t. r3{suc in SUC}: sum{pro in PRO}x[suc,pro] <= Max_Fondos[suc];
s.t. r4: sum{pro in PRO}Tasa_Gan[pro]*x[1,pro] >= 0.3 * sum{pro in PRO}Tasa_Gan[pro]*x[2,pro];

solve;
display x, FO;

data;

param Min_Fondos:=
1	3
2	5
3	8;

param Max_Fondos:=
1	17
2	15
3	15;

param Tasa_Gan:=
1	0.08
2	0.06
3	0.07
4	0.05
5	0.08
6	0.09
7	0.1
8	0.06;

param ALPHA:
	1	2	3	4	5	6	7	8:=
1	1	1	1	0	0	0	0	0
2	0	0	0	1	1	1	0	0
3	0	0	0	0	0	0	1	1;


end;