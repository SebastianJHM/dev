/*PROBLEMA 12. PROBLEMA DE TRANSPORTE CIUDADES A ALMACENES CON COSTO FIJO Y VARIABLE*/
/*Una compañía considera la apertura de almacenes en cuatro ciudades: Nueva York, Los Ángeles, Chicago y Atlanta. Cada almacén puede enviar 100 unidades a la semana. El costo semanal fijo para mantener abierto cada almacén es de 400 dólares en Nueva York, de 500 dólares en Los Ángeles, de 300 dólares en Chicago y de 150 dólares en Atlanta.  La región 1 del país demanda semanalmente 80 unidades; la región 2, 70 unidades; y la región 3, 40 unidades. En la tabla Costo_Variable se muestran los costos (incluyendo los costos de producción y de envío) para enviar una unidad desde cada almacén hasta cada región. Considere que cada región sólo puede ser abastecida por ciertos posibles centros de distribución de un conjunto de centros de distibuciones posibles. Cada centro de distribución cuenta con una capacidad máxima de recepción de unidades. Los almacenes de cada ciudad envían producto a los centros de distribución sin restricción. Se desea satisfacer las demandas semanales a un costo mínimo, sujetas a la información anterior y a las restricciones siguientes: a) Si se abre el almacén en Nueva York, entonces hay que abrir el almacén en Los Ángeles. b) Se pueden abrir a lo más dos almacenes. c) Hay que abrir el almacén en Atlanta o en Los Ángeles*/

/*CONJUNTOS*/
set C:={1,2,3,4};        /*Ciudades: 1-New York, 2-Los Ángeles, 3-Chicago y 4-Atlanta*/
set R:={1,2,3};          /*Regiones: 1, 2 y 3*/

set CD:={1,2,3,4,5};     /*Centros de distribución*/
set CD_R{r in R};        /*Sub conjunto de posibles centros de distribución que pueden abastecer a una región*/

/*PARÁMETROS*/
param Costo_Fijo{C};                  /*Costo semanal fijo de la ciudad c in C*/
param Costo_Envio_C_CD{C,CD};         /*Costo de envío del almacén de la ciudad c in C al centro de distribución cd in CD*/
param Costo_Envio_CD_R{CD,R};         /*Costo de envío del centro de distribución cd in CD a la región r in R*/
param Demanda{R};                     /*Demanda semanal de la región r in R*/

param Capacidad{CD};                  /*Capacidad del centro de distribución cd in CD*/

/*VARIABLES*/
var x{C},binary;                  /*1 Si abro local en la ciudad c in C; 0 dlc*/
var y{C,CD},integer >= 0;          /*Cantidad enviada desde la ciudad c in C al centro de distribución cd in CD*/
var w{CD,R},integer >= 0;          /*Cantidad enviada desde el centro de distribución cd in CD a la región r in R*/

var COSTOS_FIJOS_TOTALES;
var COSTOS_C_CD;
var COSTOS_CD_R;
var COSTOS_TOTALES;

/*FUNCIÓN OBJETIVO*/
minimize FO:COSTOS_TOTALES;

/*RESTRICCIONES*/
/*Cada almacén puede enviar máximo 100 unidades*/
s.t. res1{c in C}: sum{cd in CD}y[c,cd] <= 100;
/*Sólo puedo enviar unidades desde los locales que están abiertos*/
s.t. res2{c in C,cd in CD}:y[c,cd]<=100000*x[c];
/*Si se abre el almcacén en Nueva York, entonces hay que abrir el almacén en Los Ángeles*/
s.t. res3: x[1] <= x[2];
/*Se pueden abrir a lo más dos almacenes*/
s.t. res4: sum{c in C}x[c] <= 2;
/*Hay que abrir el almacén en Atlanta o en Los Ángeles*/
s.t. res5: x[2] + x[4] >= 1;

/*Subconjuntos*/
/*La cantidad enviada de todos los centros de distribución posibles a una región, tiene que ser igual a la demanda de la región*/
s.t. res6{r in R}:sum{cd_r in CD_R[r]} w[cd_r,r]=Demanda[r];
/*Para cada centro de distribución, la cantidad enviada desde todas las ciudades al centro debe ser igual a lo que el centro le envía a todas las regiones */
s.t. res7{cd in CD}:sum{c in C} y[c,cd]=sum{r in R}w[cd,r];
/*La cantidad enviada a los centros de distribución desde las ciudades debe ser menor igual a la capacidad del cd in CD*/
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
printf: "\         SOLUCIÓN DEL EJERCICIO\n";
printf: "\        ------------------------ \n";
printf: "\nCOSTOS:\n";
printf: "\Costos Fijos: "&COSTOS_FIJOS_TOTALES&"\n";
printf: "\Costos Total de Envío de Ciudades a Centros de Distribución: "&COSTOS_C_CD&"\n";
printf: "\Costos Total de Envío de Centros de Distribución a las regiones: "&COSTOS_CD_R&"\n";
printf: "\COSTOS TOTALES: "&COSTOS_TOTALES&"\n";
printf: "------------------------\n";
printf: "\nALMACENES ABIERTOS:";
for{c in C:x[c]=1}{
	printf: "\nSe abre el almacen "&c;
}
printf: "\n--------------------------\n";
printf: "\nCANTIDADES RECIBIDAS CD:";
for{cd in CD}{
	printf: "\nCentro de distibución "&cd&":\n";
	for{c in C:y[c,cd]>0}{
		printf: "El centro de distribución "&cd&" recibe la cantidad de "&y[c,cd]&" de la ciudad "&c&"\n";
	}
}
printf: "\n--------------------------\n";
printf: "\nCANTIDADES RECIBIDAS REGIÓN:";
for{r in R}{
	printf: "\nRegión "&r&":\n";
	for{cd in CD:w[cd,r]>0}{
		printf: "La región "&r&" recibe la cantidad de "&w[cd,r]&" del centro de distribución "&cd&"\n";
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
