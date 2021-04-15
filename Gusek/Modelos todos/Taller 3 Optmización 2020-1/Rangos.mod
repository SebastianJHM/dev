/*PROBLEMA 12. PROBLEMA DE TRANSPORTE CIUDADES A ALMACENES CON COSTO FIJO Y VARIABLE*/
/*Una compañía considera la apertura de almacenes en cuatro ciudades: Nueva York, Los Ángeles, Chicago y Atlanta. Cada almacén puede enviar 100 unidades a la semana. El costo semanal fijo para mantener abierto cada almacén es de 400 dólares en Nueva York, de 500 dólares en Los Ángeles, de 300 dólares en Chicago y de 150 dólares en Atlanta. La región 1 del país demanda semanalmente 80 unidades; la región 2, 70 unidades; y la región 3, 40 unidades. En la tabla Costo_Variable se muestran los costos (incluyendo los costos de producción y de envío) para enviar una unidad desde cada almacén hasta cada región. En el caso que se presenten faltantes, se generan unos costos adicionales para la empresa que se comportaría de la siguiente manera: entre 0-10 faltantes a un costo de 50$/u. Entre 11-30 faltantes los primeros 10 a 50$/u y el resto 60$/u,. Entre 31-80 faltantes los primeros 10 a 50$/u, los siguientes 20 a 60$/u y el resto a 70$/u. Finalmente, para mayor a 81 faltantes, los primeros 10 a 50$/u, los siguientes 20 a 60$/u, los siguientes 50 a 70$/u, y el resto a 80$/u. Se desean satisfacer las demandas semanales a un costo mínimo, sujetas a la información anterior y a las restricciones siguientes: a) Si se abre el almacén en Nueva York, entonces hay que abrir el almacén en Los Ángeles. b) Se pueden abrir a lo más dos almacenes. c) Hay que abrir el almacén en Atlanta o en Los Ángeles*/

/*CONJUNTOS*/
set C:={1,2,3,4};        /*Ciudades: 1-New York, 2-Los Ángeles, 3-Chicago y 4-Atlanta*/
set R:={1,2,3};          /*Regiones: 1, 2 y 3*/
set K:={1,2,3,4};        /*Tipos de precios de compra de tramos*/

/*PARÁMETROS*/
param Costo_Fijo{C};               /*Costo semanal fijo de la ciudad c*/
param Costo_Variable{C,R};         /*Costo de producción y de envío de una unidad desde la ciudad i a la región r*/
param Demanda{R};                  /*Demanda semanal de la región r*/
param Costo_Adicional{K};          /*Costo adicional por faltantes*/
param LS{K};                       /*Límite superior de unidades para cada tipo de precio de k in K*/
param LI{K};                       /*Límite inferior de unidades para cada tipo de precio de k in K*/

/*VARIABLES*/
var x{C},binary;                  /*Si abro local en la ciudad c*/
var y{C,R},integer >= 0;          /*Cantidad enviada desde la ciudad i a la región r*/
var z{K}, integer>=0;             /*Cantidad de faltantes que se paga a un costo k*/
var w{K},binary;                  /*Si se paga el costo k*/
var Falt{R}, integer>=0;          /*Cantidad de faltantes en la región r*/
var COSTOS_FIJOS_TOTALES;
var COSTOS_VARIABLES_TOTALES;
var COSTOS_FALTANTES_TOTALES;
var COSTOS_TOTALES;

/*FUNCIÓN OBJETIVO*/
minimize FO:COSTOS_TOTALES;

/*RESTRICCIONES*/

/*Cada almacén puede enviar máximo 100 unidades*/
s.t. res1{c in C}: sum{r in R}y[c,r] <= 100;
/*Sólo puedo enviar unidades desde los locales que están abiertos*/
s.t. res2{c in C,r in R}:y[c,r]<=100000*x[c];
/*La cantidad enviada de los locales a cada región debe ser igual a la demanda de cada una de ellas*/
s.t. res3{r in R}: sum{c in C}y[c,r] + Falt[r]= Demanda[r];
/*Si se abre el almcacén en Nueva York, entonces hay que abrir el almacén en Los Ángeles*/
s.t. res4: x[1] <= x[2];
/*Se pueden abrir a lo más dos almacenes*/
s.t. res5: sum{c in C}x[c] <= 2;
/*Hay que abrir el almacén en Atlanta o en Los Ángeles*/
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
printf: "\         SOLUCIÓN DEL EJERCICIO\n";
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
	printf: "\nRegión "&r&":\n";
	for{c in C:y[c,r]>0}{
		printf: "La región "&r&" recibe la cantidad de "&y[c,r]&" de la ciudad "&c&"\n";
	}
	printf: "La región "&r&" tiene "&Falt[r]&" faltantes\n";
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