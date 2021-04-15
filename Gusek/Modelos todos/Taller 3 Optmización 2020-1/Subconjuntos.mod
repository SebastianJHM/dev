/*PROBLEMA 12. PROBLEMA DE TRANSPORTE CIUDADES A ALMACENES CON COSTO FIJO Y VARIABLE*/
/*Una compa��a considera la apertura de almacenes en cuatro ciudades: Nueva York, Los �ngeles, Chicago y Atlanta. Cada almac�n puede enviar 100 unidades a la semana. El costo semanal fijo para mantener abierto cada almac�n es de 400 d�lares en Nueva York, de 500 d�lares en Los �ngeles, de 300 d�lares en Chicago y de 150 d�lares en Atlanta.  La regi�n 1 del pa�s demanda semanalmente 80 unidades; la regi�n 2, 70 unidades; y la regi�n 3, 40 unidades. En la tabla Costo_Variable se muestran los costos (incluyendo los costos de producci�n y de env�o) para enviar una unidad desde cada almac�n hasta cada regi�n. Considere que cada regi�n s�lo puede ser abastecida por ciertos posibles centros de distribuci�n de un conjunto de centros de distibuciones posibles. Cada centro de distribuci�n cuenta con una capacidad m�xima de recepci�n de unidades. Los almacenes de cada ciudad env�an producto a los centros de distribuci�n sin restricci�n. Se desea satisfacer las demandas semanales a un costo m�nimo, sujetas a la informaci�n anterior y a las restricciones siguientes: a) Si se abre el almac�n en Nueva York, entonces hay que abrir el almac�n en Los �ngeles. b) Se pueden abrir a lo m�s dos almacenes. c) Hay que abrir el almac�n en Atlanta o en Los �ngeles*/

/*CONJUNTOS*/
set C:={1,2,3,4};        /*Ciudades: 1-New York, 2-Los �ngeles, 3-Chicago y 4-Atlanta*/
set R:={1,2,3};          /*Regiones: 1, 2 y 3*/

set CD:={1,2,3,4,5};     /*Centros de distribuci�n*/
set CD_R{r in R};        /*Sub conjunto de posibles centros de distribuci�n que pueden abastecer a una regi�n*/

/*PAR�METROS*/
param Costo_Fijo{C};                  /*Costo semanal fijo de la ciudad c in C*/
param Costo_Envio_C_CD{C,CD};         /*Costo de env�o del almac�n de la ciudad c in C al centro de distribuci�n cd in CD*/
param Costo_Envio_CD_R{CD,R};         /*Costo de env�o del centro de distribuci�n cd in CD a la regi�n r in R*/
param Demanda{R};                     /*Demanda semanal de la regi�n r in R*/

param Capacidad{CD};                  /*Capacidad del centro de distribuci�n cd in CD*/

/*VARIABLES*/
var x{C},binary;                  /*1 Si abro local en la ciudad c in C; 0 dlc*/
var y{C,CD},integer >= 0;          /*Cantidad enviada desde la ciudad c in C al centro de distribuci�n cd in CD*/
var w{CD,R},integer >= 0;          /*Cantidad enviada desde el centro de distribuci�n cd in CD a la regi�n r in R*/

var COSTOS_FIJOS_TOTALES;
var COSTOS_C_CD;
var COSTOS_CD_R;
var COSTOS_TOTALES;

/*FUNCI�N OBJETIVO*/
minimize FO:COSTOS_TOTALES;

/*RESTRICCIONES*/
/*Cada almac�n puede enviar m�ximo 100 unidades*/
s.t. res1{c in C}: sum{cd in CD}y[c,cd] <= 100;
/*S�lo puedo enviar unidades desde los locales que est�n abiertos*/
s.t. res2{c in C,cd in CD}:y[c,cd]<=100000*x[c];
/*Si se abre el almcac�n en Nueva York, entonces hay que abrir el almac�n en Los �ngeles*/
s.t. res3: x[1] <= x[2];
/*Se pueden abrir a lo m�s dos almacenes*/
s.t. res4: sum{c in C}x[c] <= 2;
/*Hay que abrir el almac�n en Atlanta o en Los �ngeles*/
s.t. res5: x[2] + x[4] >= 1;

/*Subconjuntos*/
/*La cantidad enviada de todos los centros de distribuci�n posibles a una regi�n, tiene que ser igual a la demanda de la regi�n*/
s.t. res6{r in R}:sum{cd_r in CD_R[r]} w[cd_r,r]=Demanda[r];
/*Para cada centro de distribuci�n, la cantidad enviada desde todas las ciudades al centro debe ser igual a lo que el centro le env�a a todas las regiones */
s.t. res7{cd in CD}:sum{c in C} y[c,cd]=sum{r in R}w[cd,r];
/*La cantidad enviada a los centros de distribuci�n desde las ciudades debe ser menor igual a la capacidad del cd in CD*/
s.t. res8{cd in CD}:sum{c in C} y[c,cd]<=Capacidad[cd];

/*Relaciones de costos del problema*/
s.t. c1: COSTOS_FIJOS_TOTALES = sum{c in C}Costo_Fijo[c]*x[c];
s.t. c2: COSTOS_C_CD = sum{c in C,cd in CD}Costo_Envio_C_CD[c,cd]*y[c,cd];
s.t. c3: COSTOS_CD_R = sum{cd in CD,r in R}Costo_Envio_CD_R[cd,r]*w[cd,r];
s.t. c4: COSTOS_TOTALES = COSTOS_FIJOS_TOTALES + COSTOS_C_CD + COSTOS_CD_R;

solve;
printf: "\n";
printf: "\n";
printf: "\-----------------------------------------\n";
printf: "\         SOLUCI�N DEL EJERCICIO\n";
printf: "\        ------------------------ \n";
printf: "\nCOSTOS:\n";
printf: "\Costos Fijos: "&COSTOS_FIJOS_TOTALES&"\n";
printf: "\Costos Total de Env�o de Ciudades a Centros de Distribuci�n: "&COSTOS_C_CD&"\n";
printf: "\Costos Total de Env�o de Centros de Distribuci�n a las regiones: "&COSTOS_CD_R&"\n";
printf: "\COSTOS TOTALES: "&COSTOS_TOTALES&"\n";
printf: "------------------------\n";
printf: "\nALMACENES ABIERTOS:";
for{c in C:x[c]=1}{
	printf: "\nSe abre el almacen "&c;
}
printf: "\n--------------------------\n";
printf: "\nCANTIDADES RECIBIDAS CD:";
for{cd in CD}{
	printf: "\nCentro de distibuci�n "&cd&":\n";
	for{c in C:y[c,cd]>0}{
		printf: "El centro de distribuci�n "&cd&" recibe la cantidad de "&y[c,cd]&" de la ciudad "&c&"\n";
	}
}
printf: "\n--------------------------\n";
printf: "\nCANTIDADES RECIBIDAS REGI�N:";
for{r in R}{
	printf: "\nRegi�n "&r&":\n";
	for{cd in CD:w[cd,r]>0}{
		printf: "La regi�n "&r&" recibe la cantidad de "&w[cd,r]&" del centro de distribuci�n "&cd&"\n";
	}
}
printf: "\------------------------------------------\n";
printf: "\n";
printf: "\n";
printf: "\n";

data;

set CD_R[1]:= 1 2 5;
set CD_R[2]:= 2 3 4;
set CD_R[3]:= 3 4 5;

param Costo_Fijo:= 
1	400
2	500
3	300
4	150;

param Costo_Envio_C_CD: 
	1	2	3	4	5:=
1	42	59	93	77	69
2	70	86	49	42	35
3	86	40	60	51	74
4	81	56	72	63	63;

param Costo_Envio_CD_R: 
	1	2	3:=
1	115	101	146
2	164	137	115
3	122	141	156
4	131	183	149
5	190	170	182;

param Demanda:= 
1	80
2	70
3	40;

param Capacidad:=
1	60
2	10
3	15
4	80
5	100;

end;
