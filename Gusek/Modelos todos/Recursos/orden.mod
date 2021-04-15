
set I:={1..10};

/*Parámatros*/
param Datos{I};

var y{I};
var x{I};
var BETA{I,I}, binary;
var MIU{I}, integer;#Cantidad de número de los que y[i] es mayor o igual
var ALPHA{I,I}, binary; #Auxiliar de valor absoluto
var A{I,I}, integer; #Valor absoluto de MIU[j]-i
var PHI{I,I}, binary;
minimize FO:sum{j in I, i in I}A[j,i];

s.t. r1{i in I}: y[i]=Datos[i];

s.t. res1{i in I,j in I}: 10000*BETA[i,j]<=10000+(y[i]-y[j]);
s.t. res2{i in I,j in I}: 10000*BETA[i,j]>=y[i]-y[j];
s.t. res3{i in I}: BETA[i,i]=1;

s.t. res4{i in I}: MIU[i]=sum{j in I}BETA[i,j];


/* s.t. res5{i in I, j in I}:10000*ALPHA[j,i]<= 10000+(MIU[j]-i);
s.t. res6{i in I, j in I}:10000*ALPHA[j,i]>=MIU[j]-i;
s.t. res7{i in I, j in I}:A[j,i]<=(MIU[j]-i)+10000*(1-ALPHA[j,i]);
s.t. res8{i in I, j in I}:A[j,i]>=(MIU[j]-i)-10000*(1-ALPHA[j,i]);
s.t. res9{i in I, j in I}:A[j,i]<=(i-MIU[j])+10000*(ALPHA[j,i]);
s.t. res10{i in I, j in I}:A[j,i]>=(i-MIU[j])-10000*(ALPHA[j,i]); */

s.t. res200{i in I, j in I}:A[j,i]>=(i-MIU[j]);
s.t. res201{i in I, j in I}:A[j,i]>=-(i-MIU[j]);

s.t. res11{i in I, j in I}:(1-PHI[j,i])<=A[j,i];
s.t. res12{i in I, j in I}:10000*(1-PHI[j,i])>=A[j,i];

s.t. res13{i in I, j in I}:x[i]<=y[j]+100000000000*(1-PHI[j,i]);
s.t. res14{i in I, j in I}:x[i]>=y[j]-100000000000*(1-PHI[j,i]);
solve;

for {i in I}{
	printf: "x["&i&"]: "&x[i]&"\n";
}


data;

param Datos:=
1	15
2	4
3	5
4	87
5	7
6	12
7	14
8	8
9	9
10	44;
end;