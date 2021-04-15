/*CONJUNTOS*/
set TURNO:={1,2,3,4};
set TURNO2:={1,2,3};
set A:={1,2};

/*PARÁMETROS */
param min_Asesores{TURNO};


/*VARIABLES DE DESICIÓN*/
var x{TURNO,A},>=0, integer;
var y{TURNO2},>=0, integer; 

/*FUNCIÓN OBJETIVO*/
minimize FO: 320 * sum{t2 in TURNO2}y[t2] + 170 * sum{t in TURNO} x[t,2];

s.t. r1{t in TURNO}: sum{a in A}x[t,a] >= min_Asesores[t];
s.t. r2: x[1,1] = y[1];
s.t. r3: x[2,1] = y[1] + y[2];
s.t. r4: x[3,1] = y[2] + y[3];
s.t. r5: x[4,1] = y[3];
s.t. r6{t in TURNO}: x[t,1] >= 2 * x[t,2];


solve;

display FO, x, y;
data;

param min_Asesores:=
1	4
2	8
3	14
4	6;


end;