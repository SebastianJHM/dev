/*CONJUNTOS*/
set I:={1..8};

/*PAR�METROS */
param Probabilidad{I, I};
param Existe{i in I, j in I} := if Probabilidad[i,j] = 0 then 0 else 1;
param LN_Probabilidad{i in I, j in I} := if Probabilidad[i,j] = 0 then 0 else log(Probabilidad[i,j]);


/*VARIABLES DE DESICI�N*/
var x{I, I}, binary;

/*FUNCI�N OBJETIVO*/

## Considerando que la funci�n objetivo deber�a ser la funci�n de las problabilidades de los arcos con valor 1, hacemos una transformaci�n que es
## sumar los logaritmos naturales de las probabilidades. Por las las propiedades de los logariemos despuws haremos e(FO) y eso nos dar� el resultado
## de la multiplicaci�n de los arcos

maximize FO: sum{i in I, j in I} x[i,j] * LN_Probabilidad[i,j];

s.t. res1{i in I, j in I}: x[i,j] <= Existe[i,j];
s.t. res2: sum{j in I}x[1,j] = 1;
s.t. res3: sum{i in I}x[i,8] = 1;
s.t. res4{i in I: i<>1 and i<>8}: sum{j in I}x[i,j] = sum{k in I}x[k,i];

solve;
printf: "\n";
printf: "\n";
printf: "-----------------------------------------\n";
printf: "          SOLUCI�N DEL EJERCICIO\n";
printf: "        ------------------------------ \n";

printf: "\nFunci�n objetivo: "&FO.val;
printf: "\nProbabilidad Total: "&exp(FO.val)&"\n\n";

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


data;
param Probabilidad:	
	1	2	3	4	5	6	7	8:=
1	0	0.8	0.35	0.67	0	0	0	0
2	0	0	0	0.9	0	0.5	0	0.64
3	0	0	0	0	0.95	0	0.88	0
4	0	0	0.85	0	0	0.7	0.6	0
5	0	0	0	0	0	0	0.91	0.78
6	0	0	0	0	0	0	0.6	0.81
7	0	0	0	0	0	0	0	0.9
8	0	0	0	0	0	0	0	0;





end;