/*PROBLEMA 12. PROBLEMA DE TRANSPORTE CIUDADES A ALMACENES CON COSTO FIJO Y VARIABLE*/
/*Una compa??a considera la apertura de almacenes en cuatro ciudades: Nueva York, Los ?ngeles, Chicago y Atlanta. Cada almac?n puede enviar 100 unidades a la semana. El costo semanal fijo para mantener abierto cada almac?n es de 400 d?lares en Nueva York, de 500 d?lares en Los ?ngeles, de 300 d?lares en Chicago y de 150 d?lares en Atlanta. La regi?n 1 del pa?s demanda semanalmente 80 unidades; la regi?n 2, 70 unidades; y la regi?n 3, 40 unidades. En la tabla Costo_Variable se muestran los costos (incluyendo los costos de producci?n y de env?o) para enviar una unidad desde cada almac?n hasta cada regi?n. Se busca maximizar el m?nimo valor enviado entre los almacenes de ciudades y las regiones, sujetas a la informaci?n anterior y a las restricciones siguientes: a) Si se abre el almac?n en Nueva York, entonces hay que abrir el almac?n en Los ?ngeles. b) Se pueden abrir a lo m?s dos almacenes. c) Hay que abrir el almac?n en Atlanta o en Los ?ngeles*/


/*CONJUNTOS*/
set C:={1,2,3,4};        /*Ciudades: 1-New York, 2-Los ?ngeles, 3-Chicago y 4-Atlanta*/
set R:={1,2,3};          /*Regiones: 1, 2 y 3*/


/*PAR?METROS*/
param Costo_Fijo{C};               /*Costo semanal fijo de la ciudad c in C*/
param Costo_Variable{C,R};         /*Costo de producci?n y de env?o de una unidad desde la ciudad c in C a la regi?n r in R*/
param Demanda{R};                  /*Demanda semanal de la regi?n r in R*/

/*VARIABLES*/
var x{C},binary;                  /*1 Si abro local en la ciudad c in C; 0 dlc*/
var y{C,R},integer >= 0;          /*Cantidad enviada desde la ciudad i a la regi?n r*/
var z{C,R},binary >= 0;           /*1 Si env?a producto del almace?n de la ciudad c in C.0 dlc*/
var w{C,R};                       /*y[c,r] si se env?a de c in C a r in R. M si no se env?a*/
var minimo_enviado;               /*M?nimo valor enviado entre todas las ciudades y todas las regiones*/

var COSTOS_FIJOS_TOTALES;
var COSTOS_VARIABLES_TOTALES;
var COSTOS_TOTALES;

/*FUNCI?N OBJETIVO*/
maximize FO:minimo_enviado;

/*RESTRICCIONES*/
/*Cada almac?n puede enviar m?ximo 100 unidades*/
s.t. res1{c in C}: sum{r in R}y[c,r] <= 100;
/*S?lo puedo enviar unidades desde los locales que est?n abiertos*/
s.t. res2{c in C,r in R}:y[c,r]<=100000*x[c];
/*La cantidad enviada de los locales a cada regi?n debe ser igual a la demanda de cada una de ellas*/
s.t. res3{r in R}: sum{c in C}y[c,r] = Demanda[r];
/*Si se abre el almcac?n en Nueva York, entonces hay que abrir el almac?n en Los ?ngeles*/
s.t. res4: x[1] <= x[2];
/*Se pueden abrir a lo m?s dos almacenes*/
s.t. res5: sum{c in C}x[c] <= 2;
/*Hay que abrir el almac?n en Atlanta o en Los ?ngeles*/
s.t. res6: x[2] + x[4] = 1;

/*Codificaci?n de z[c,r]: 1 Si env?a producto del almac?n de la ciudad c in C.0 dlc*/
s.t. res7{c in C,r in R}:z[c,r]<=y[c,r];
s.t. res8{c in C,r in R}:100000*z[c,r]>=y[c,r];

/*Codificaci?n de w[c,r]: y[c,r] si se env?a de c in C a r in R. M si no se env?a*/
/*Aclaraci?n: para la restricci?n 11 y 12 se usan dos valores distintos como gran M. El primero es de 100, que es valor que tomar? w si si z[c,r]=0. La raz?n de este valor es porque es mayor a toda demanda. El segundo valor de gran M es 1000, que ser?n los valores de cota superior e inferior cuando z[c,r]=1. Es importante que M1 < M2, teniendo en cuenta las utilidades que tienen en las restricciones*/
s.t. res9{c in C,r in R}:w[c,r]<=y[c,r]+1000*(1-z[c,r]);
s.t. res10{c in C,r in R}:w[c,r]>=y[c,r]-1000*(1-z[c,r]);
s.t. res11{c in C,r in R}:w[c,r]<=100+1000*(z[c,r]);
s.t. res12{c in C,r in R}:w[c,r]>=100-1000*(z[c,r]);

/*Codificaci?n de minimo_enviado: menor que todos los valores de w[c,r]. De esta forma, como se est? m?nimo enviado, se hace exactamente igual*/
s.t. res13{c in C,r in R}:minimo_enviado<=w[c,r];

/*Relaciones de costos del problema*/
s.t. c1: COSTOS_FIJOS_TOTALES = sum{c in C}Costo_Fijo[c]*x[c];
s.t. c2: COSTOS_VARIABLES_TOTALES = sum{c in C, r in R}Costo_Variable[c,r]*y[c,r];
s.t. c3: COSTOS_TOTALES = COSTOS_FIJOS_TOTALES + COSTOS_VARIABLES_TOTALES;

solve;
printf: "\n";
printf: "\n";
printf: "\-----------------------------------------\n";
printf: "\         SOLUCI?N DEL EJERCICIO\n";
printf: "\        ------------------------ \n";
printf: "\nM?NIMA CANTIDAD ENVIADA: "&round(minimo_enviado)&"\n";
printf: "------------------------\n";
printf: "\nCOSTOS:\n";
printf: "\Costos Fijos: "&COSTOS_FIJOS_TOTALES&"\n";
printf: "\Costos Variables: "&COSTOS_VARIABLES_TOTALES&"\n";
printf: "\COSTOS TOTALES: "&COSTOS_TOTALES&"\n";
printf: "------------------------\n";
printf: "\nALMACENES ABIERTOS:";
for{c in C:x[c]=1}{
printf: "\nSe abre el almacen "&c;
}
printf: "\n--------------------------\n";
printf: "\nCANTIDADES RECIBIDAS:";
for{r in R}{
	printf: "\nRegi?n "&r&":\n";
	for{c in C:y[c,r]>0}{
		printf: "La regi?n "&r&" recibe la cantidad de "&y[c,r]&" de la ciudad "&c&"\n";
	}
}
printf: "\------------------------------------------\n";
printf: "\n";
printf: "\n";
printf: "\n";

data;

param Costo_Fijo:= 
1	400
2	500
3	300
4	150;

param Costo_Variable: 
	1	2	3:=
1	20	40	50
2	48	15	26
3	26	35	18
4	24	50	35;

param Demanda:= 
1	80
2	70
3	40;
end;