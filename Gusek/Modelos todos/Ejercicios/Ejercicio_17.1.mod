/*CONJUNTOS*/
set COL := {1,2,3};
set SEM := {1..4};

/*PARÁMETROS */
param D{COL,SEM};
param P{COL};
param N{COL};
param F{COL};


/*VARIABLES DE DESICIÓN*/
var x{COL,SEM},>=0;/*Producción de la columna*/
var ec{COL,SEM},>=0,integer;/*Empleados completos para hacer la columna col*/
var ep{COL,SEM},>=0,integer;/*Empleados parciales para hacer la columna col*/

/*FUNCIÓN OBJETIVO*/
minimize FO: sum{col in COL, sem in SEM}F[col]*x[col,sem] + 300000*sum{col in COL, sem in SEM}ec[col,sem] + 200000*sum{col in COL, sem in SEM}ep[col,sem];

s.t. r1{col in COL, sem in SEM}: x[col,sem] = (40*(60/P[col]))*ec[col,sem] + (20*(60/P[col]))*ep[col,sem];
s.t. r2{col in COL, sem in SEM}: x[col,sem] <= 50;
s.t. r3{col in COL, sem in SEM}: x[col,sem] >= N[col];
s.t. r4{sem in SEM}: sum{col in COL}ec[col,sem] >= 0.2 * (sum{col in COL}(ec[col,sem] + ep[col,sem]));

solve;
display ec,ep,FO.val, x;

data;

param D:
	1	2	3	4:=
1	20	18	21	17
2	20	22	18	25
3	25	23	28	24;

param N:=
1	5
2	10
3	3;

param F:=
1	100
2	200
3	50;

param P:=
1	120
2	60
3	180;

end;