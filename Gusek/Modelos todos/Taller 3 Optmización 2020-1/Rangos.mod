/*PROBLEMA 12. PROBLEMA DE TRANSPORTE CIUDADES A ALMACENES CON COSTO FIJO Y VARIABLE*/
/*Una compa��a considera la apertura de almacenes en cuatro ciudades: Nueva York, Los �ngeles, Chicago y Atlanta. Cada almac�n puede enviar 100 unidades a la semana. El costo semanal fijo para mantener abierto cada almac�n es de 400 d�lares en Nueva York, de 500 d�lares en Los �ngeles, de 300 d�lares en Chicago y de 150 d�lares en Atlanta. La regi�n 1 del pa�s demanda semanalmente 80 unidades; la regi�n 2, 70 unidades; y la regi�n 3, 40 unidades. En la tabla Costo_Variable se muestran los costos (incluyendo los costos de producci�n y de env�o) para enviar una unidad desde cada almac�n hasta cada regi�n. En el caso que se presenten faltantes, se generan unos costos adicionales para la empresa que se comportar�a de la siguiente manera: entre 0-10 faltantes a un costo de 50$/u. Entre 11-30 faltantes los primeros 10 a 50$/u y el resto 60$/u,. Entre 31-80 faltantes los primeros 10 a 50$/u, los siguientes 20 a 60$/u y el resto a 70$/u. Finalmente, para mayor a 81 faltantes, los primeros 10 a 50$/u, los siguientes 20 a 60$/u, los siguientes 50 a 70$/u, y el resto a 80$/u. Se desean satisfacer las demandas semanales a un costo m�nimo, sujetas a la informaci�n anterior y a las restricciones siguientes: a) Si se abre el almac�n en Nueva York, entonces hay que abrir el almac�n en Los �ngeles. b) Se pueden abrir a lo m�s dos almacenes. c) Hay que abrir el almac�n en Atlanta o en Los �ngeles*/

/*CONJUNTOS*/
set C:={1,2,3,4};        /*Ciudades: 1-New York, 2-Los �ngeles, 3-Chicago y 4-Atlanta*/
set R:={1,2,3};          /*Regiones: 1, 2 y 3*/
set K:={1,2,3,4};        /*Tipos de precios de compra de tramos*/

/*PAR�METROS*/
param Costo_Fijo{C};               /*Costo semanal fijo de la ciudad c*/
param Costo_Variable{C,R};         /*Costo de producci�n y de env�o de una unidad desde la ciudad i a la regi�n r*/
param Demanda{R};                  /*Demanda semanal de la regi�n r*/
param Costo_Adicional{K};          /*Costo adicional por faltantes*/
param LS{K};                       /*L�mite superior de unidades para cada tipo de precio de k in K*/
param LI{K};                       /*L�mite inferior de unidades para cada tipo de precio de k in K*/

/*VARIABLES*/
var x{C},binary;                  /*Si abro local en la ciudad c*/
var y{C,R},integer >= 0;          /*Cantidad enviada desde la ciudad i a la regi�n r*/
var z{K}, integer>=0;             /*Cantidad de faltantes que se paga a un costo k*/
var w{K},binary;                  /*Si se paga el costo k*/
var Falt{R}, integer>=0;          /*Cantidad de faltantes en la regi�n r*/
var COSTOS_FIJOS_TOTALES;
var COSTOS_VARIABLES_TOTALES;
var COSTOS_FALTANTES_TOTALES;
var COSTOS_TOTALES;

/*FUNCI�N OBJETIVO*/
minimize FO:COSTOS_TOTALES;

/*RESTRICCIONES*/

/*Cada almac�n puede enviar m�ximo 100 unidades*/
s.t. res1{c in C}: sum{r in R}y[c,r] <= 100;
/*S�lo puedo enviar unidades desde los locales que est�n abiertos*/
s.t. res2{c in C,r in R}:y[c,r]<=100000*x[c];
/*La cantidad enviada de los locales a cada regi�n debe ser igual a la demanda de cada una de ellas*/
s.t. res3{r in R}: sum{c in C}y[c,r] + Falt[r]= Demanda[r];
/*Si se abre el almcac�n en Nueva York, entonces hay que abrir el almac�n en Los �ngeles*/
s.t. res4: x[1] <= x[2];
/*Se pueden abrir a lo m�s dos almacenes*/
s.t. res5: sum{c in C}x[c] <= 2;
/*Hay que abrir el almac�n en Atlanta o en Los �ngeles*/
s.t. res6: x[2] + x[4] = 1;


/*La cantidad de unidades a pedir debe ser igual a los faltantes*/
s.t. res8: sum{k in K} z[k] = sum{r in R}Falt[r];
/*Si hay faltantes, la cantidad comprada debe ser mayor igual al factor multiplicativo de cambio de rango */
s.t. res9{k in K:k>1}: z[k-1] >= w[k]*(LS[k-1]-LI[k-1]);
/*La cantidad a pedir debe ser menor igual al factor multiplicativo del cambio de rango*/
s.t. res10{k in K}: z[k]<= w[k]*(LS[k]-LI[k]);

/*Relaciones de costos del problema*/
s.t. c1: COSTOS_FIJOS_TOTALES = sum{c in C}Costo_Fijo[c]*x[c];
s.t. c2: COSTOS_VARIABLES_TOTALES = sum{c in C, r in R}Costo_Variable[c,r]*y[c,r];
s.t. c3: COSTOS_FALTANTES_TOTALES = sum{k in K}Costo_Adicional[k]*z[k];
s.t. c4: COSTOS_TOTALES = COSTOS_FIJOS_TOTALES + COSTOS_VARIABLES_TOTALES + COSTOS_FALTANTES_TOTALES;

solve;
printf: "\n";
printf: "\n";
printf: "\-----------------------------------------\n";
printf: "\         SOLUCI�N DEL EJERCICIO\n";
printf: "\        ------------------------ \n";
printf: "\nCOSTOS:\n";
printf: "\Costos Fijos: "&COSTOS_FIJOS_TOTALES&"\n";
printf: "\Costos Variables: "&COSTOS_VARIABLES_TOTALES&"\n";
printf: "\Costos Faltantes: "&COSTOS_FALTANTES_TOTALES&"\n";
printf: "\COSTOS TOTALES: "&COSTOS_TOTALES&"\n";
printf: "-----------------------\n";
printf: "\nCANTIDAD DE FALTANTES POR TIPO DE PRECIO:";
for{k in K:z[k]>0}{
	printf: "\nUnidades a precio de "&Costo_Adicional[k]&": "&z[k]&" --> Total: "&Costo_Adicional[k]*z[k];
}
printf: "\n--------------------------\n";
printf: "\nALMACENES ABIERTOS:";
for{c in C:x[c]=1}{
	printf: "\nSe abre el almacen "&c;
}
printf: "\n--------------------------\n";
printf: "\nCANTIDADES RECIBIDAS:";
for{r in R}{
	printf: "\nRegi�n "&r&":\n";
	for{c in C:y[c,r]>0}{
		printf: "La regi�n "&r&" recibe la cantidad de "&y[c,r]&" de la ciudad "&c&"\n";
	}
	printf: "La regi�n "&r&" tiene "&Falt[r]&" faltantes\n";
}
printf: "\------------------------------------------\n";
printf: "\n";
printf: "\n";
printf: "\n";

data;

param Costo_Fijo:= 
1 400
2 500
3 300
4 150;

param Costo_Variable: 
1 2 3:=
1 20 40 50
2 48 15 26
3 26 35 18
4 24 50 35;

param Costo_Adicional:= 
1 50
2 60
3 70
4 80;

param Demanda:= 
1 80
2 170
3 40;

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