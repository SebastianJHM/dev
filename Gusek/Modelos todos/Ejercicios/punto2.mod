Ejercicio 2
Una empresa que produce cuadernos cuenta con 3 plantas y 2 clientes y desea planear la producción en inventarios de las próximas 12 semanas. La capacidad de producción de cada planta por semana (cap), la demanda de cada cliente en cada semana (d), la capacidad de almacenamiento de cada planta (a), el costo unitario semanal de inventario en cada planta (h), el costo de producción unitario en cada planta (p) y el costo de transporte por unidad desde cada planta a cada cliente (t) se presentan a continuación (puede copiar y pegar directamente los parámetros en gusek). Formule el modelo que permita cubrir las demandas minimizando los costos totales, sabiendo que en cada semana la planta 3 debe suplir al menos el 30% de las unidades totales demandadas. Al inicio de la primera semana no se cuenta con inventario de cuadernos.

/*CONJUNTOS*/
set PL:={1,2,3};
set CLI:={1,2};
set SEM:={1..12};

/*PARÁMETROS */
param cap{PL};
param d{SEM,CLI};
param a{PL};
param h{PL};
param p{PL};
param t{PL,CLI};
param r:=0.3;

/*VARIABLES DE DESICIÓN*/
var inv_f{PL,SEM}, >= 0, integer; /*Inventario al final de la semana en un planta*/
var inv_f_c{PL,CLI,SEM}, integer;
var prod_t{PL,SEM}, >= 0, integer; /*Producción total de una planta en una semana*/
var prod_enviar{PL,CLI,SEM}, integer;
var prod_extra{PL,SEM}, integer;
var envio{PL,CLI,SEM}, >=0, integer; /*Cantidad enviada de la planta al cliente*/


/*FUNCIÓN OBJETIVO*/
minimize FO: sum{pl in PL,sem in SEM}h[pl]*inv_f[pl,sem] + sum{pl in PL,cli in CLI,sem in SEM}t[pl,cli]*envio[pl,cli,sem] +sum{pl in PL,sem in SEM}p[pl]*prod_t[pl,sem];

s.t. r1{pl in PL,sem in SEM}: prod_t[pl,sem] = sum{cli in CLI}prod_enviar[pl,cli,sem] + prod_extra[pl,sem];
s.t. r2{pl in PL,sem in SEM}: prod_t[pl,sem] <= cap[pl];

s.t. r3{pl in PL}: inv_f[pl,1] = prod_extra[pl,1];
s.t. r4{pl in PL,sem in SEM: sem > 1}: inv_f[pl,sem] = inv_f[pl,sem-1] + prod_t[pl,sem] - sum{cli in CLI}envio[pl,cli,sem];

s.t. r5{pl in PL,cli in CLI}: envio[pl,cli,1] <= prod_enviar[pl,cli,1];
s.t. r6{pl in PL,cli in CLI,sem in SEM: sem > 1}: envio[pl,cli,sem] <= prod_enviar[pl,cli,sem] + inv_f_c[pl,cli,sem-1] + 2000;

s.t. r7{cli in CLI,sem in SEM}: sum{pl in PL}envio[pl,cli,sem] >= d[sem,cli];

s.t. r8{pl in PL,sem in SEM}: inv_f[pl,sem] = sum{cli in CLI}inv_f_c[pl,cli,sem];
s.t. r9{sem in SEM}: sum{cli in CLI} envio[3,cli,sem] >= 0.3 * sum{pl in PL,cli in CLI} envio[pl,cli,sem];


solve;

for{sem in SEM}{
	printf: "------- Semana "&sem&" -------\n";
	for{pl in PL}{
		for {cli in CLI:envio[pl,cli,sem]>0}{
			printf: "La planta "&pl&" envía al cliente "&cli&" la cantidad de "&envio[pl,cli,sem]&"\n";
		}
	}
	printf: "\n";
	for{pl in PL}{
		printf: "Planta "&pl&": Prod_T = "&prod_t[pl,sem]&"; Envío = "&sum{cli in CLI}envio[pl,cli,sem]&"; Inv_F = "&inv_f[pl,sem]&"\n";
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
param h:=
1 33
2 39
3 27;

param cap:=
1 300
2 450
3 600;

param d: 
   1 2:=
1 425 737
2 736 474
3 773 855
4 309 455
5 667 932
6 790 766
7 688 820
8 827 529
9 453 773
10 876 312
11 363 395
12 341 982;

param p:=
1 30
2 20
3 28;

param t: 
  1 2:=
1 5 8
2 12 4
3 8 14;

param a:=
1 200
2 200
3 400;

end;