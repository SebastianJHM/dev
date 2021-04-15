set I; /* Nodos*/

/*Declaracion de la variable*/

var x{i in I, j in I}, binary; /* 1 si toma la ruta del nodo i al j */

/*Declaracion de los parametros*/
param T {i in I, j in I}; /* Tiempo de trasporte de ir del nodo i al nodo j*/
param A {i in I, j in I}:= if T[i,j] = 100 then 0 else 1; /* Parametro Binario 1 si existe la ruta, 0 de lo contrario */

/*Funcion Objetivo*/
minimize FO: sum{i in I, j in I} x[i,j]*T[i,j]; /* Tiempos totales*/

/*Restricciones*/
s.t.  res1 {i in I,j in I}: x[i,j]<=A[i,j]; /* Anula la varibale en los casos que la ruta no existe*/
s.t. res2: sum{j in I}x["Bog",j] = 1 ; /*Obliga a tomar una sola ruta de las tres iniciales posibles*/
s.t. res3: sum{i in I}x[i,"Frank"] = 1; /*Obliga a tomar una sola ruta de las tres finales posibles*/
s.t. res4{i in I: i<>"Bog" and i<>"Frank"}: sum{j in I}x[i,j] = sum{k in I}x[k,i];

s.t. res5{i in I}: x["D",i] = 0;
solve;

printf: "\n";
printf: "\n";
printf: "-----------------------------------------\n";
printf: "          SOLUCIÓN DEL EJERCICIO\n";
printf: "        ------------------------------ \n";

printf: "\nFunción objetivo: "&FO.val&"\n";

for{i in I}{
	for {j in I:x[i,j]=1}{
		printf: "Del nodo "&i&" al nodo "&j&"\n";
	}
}

printf: "\-------------------------------------\n";
printf: "\n";
printf: "\n";
printf: "\n";
printf: "\n";
printf: "\n";
printf: "\n";
printf: "\n";

/*declaracion de parametros*/
data;

set I:="Bog"	"A"	"B"	"C"	"D"	"E"	"F"	"G"	"Frank";

param T :
	Bog	A	B	C	D	E	F	G	Frank:=
Bog	100	4.4	4.7	4.2	100	100	100	100	100
A	100	100	100	100	3.5	3.4	100	100	100
B	100	100	100	100	3.6	3.2	3.8	100	100
C	100	100	100	100	100	4.5	3.4	3.9	100
D	100	100	100	100	100	100	100	100	3.4
E	100	100	100	100	100	100	100	100	3.6
F	100	100	100	100	100	100	100	100	4.1
G	100	100	100	100	100	100	100	100	4.3
Frank	100	100	100	100	100	100	100	100	100;


end;

