Una empresa productora de lácteos está planeando la instalación
 de nuevas plantas de producción. La empresa ha identificado 10 posibles ubicaciones para construir las plantas que van a cubrir a sus 11 clientes (grandes superficies). Se conocen las ubicaciones de las plantas que podrían atender a cada cliente (b). Las capacidades de producción en litros de producto lácteo que tendrían las plantas de cada ubicación están dadas por el parámetro CP, y la demanda exacta en litros de producto lácteo de cada cliente es D. Adicionalmente, si se instala una planta en la ubicación 1 se debe instalar también la una planta en la ubicación 4. Por tanto, la empresa desea determinar la mínima cantidad de plantas nuevas a instalar para cubrir a los nuevos clientes y cuánto debe enviar de producto cada planta instalada a cada cliente. A continuación se presentan todos los parámetros los cuales puede copiar/pegar directamente en Gusek:

/*CONJUNTOS*/
set PL := {1..10};
set CLI := {1..11};

/*PARÁMETROS */
param M:=1000000000;
param b{PL,CLI};
param CP{PL};
param D{CLI};

/*VARIABLES DE DESICIÓN*/
var x{PL}, binary; /*Si abro la planta*/
var z{PL,CLI}, >=0, integer; /*Cantidad enviada*/

/*FUNCIÓN OBJETIVO*/
minimize FO:sum{pl in PL}x[pl];

s.t. r1{pl in PL, cli in CLI}: z[pl,cli] <= M * x[pl];
s.t. r3{pl in PL, cli in CLI}: z[pl,cli] <= M * b[pl,cli];


s.t. r4{cli in CLI}: sum{pl in PL}z[pl,cli] = D[cli];
s.t. r5{pl in PL}: sum{cli in CLI}z[pl,cli] <= CP[pl];
s.t. r6: x[4] >=  x[1];

s.t. r7{cli in CLI}: sum{pl in PL}z[pl,cli] >= 1;
s.t. r8{pl in PL}: x[pl] <= sum{cli in CLI}z[pl,cli];

solve;

printf: "\n";
printf: "\n";
printf: "-----------------------------------------\n";
printf: "          SOLUCIÓN DEL EJERCICIO\n";
printf: "        ------------------------------ \n";

printf: "\nNúmero de plantas abiertas: "&FO.val&"\n\n";

for{pl in PL}{
	for {cli in CLI:z[pl,cli]>0}{
		printf: "La planta "&pl&" envía al cliente "&cli&" la cantidad de "&z[pl,cli]&"\n";
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

param b:
  1 2 3 4 5 6 7 8 9 10 11:= 
1 1 0 1 0 1 0 1 0 0 1 0 
2 0 1 0 1 0 1 0 0 0 0 0 
3 1 0 1 0 0 0 1 0 1 0 1 
4 0 1 0 1 0 0 1 0 0 1 0 
5 1 0 0 0 1 0 1 0 0 0 1 
6 0 1 0 0 0 1 0 1 0 1 0 
7 1 0 1 0 1 0 1 0 0 0 0 
8 0 1 0 0 0 1 0 1 0 0 1 
9 0 0 1 0 0 0 0 1 1 0 0 
10 1 0 0 1 0 0 1 0 0 0 1;

param CP:=
1 29000
2 18000
3 27000
4 33000
5 41000
6 38000
7 47000
8 32000
9 18000
10 42000;

param D:=
1 4400
2 11600
3 11200
4 4800
5 8000
6 4400
7 4800
8 5200
9 9600
10 6000
11 6800;



end;