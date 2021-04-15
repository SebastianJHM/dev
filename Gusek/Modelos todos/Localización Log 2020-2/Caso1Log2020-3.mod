/*CASO 1 DE LOGÍSTICA 2020-2*/

/*CONJUNTOS*/
set PR_EMP;     /*Productores de alimentos empaquetados*/
set PR_FRE;     /*Productores de alimentos frescos*/
set PR_ASE;     /*Productores de puctos aseo*/
set CD;         /*Centros de distribución*/
set CL;         /*Clusteres*/
set PR;         /*Productos*/
set NODOS;      /*Todos los nodos de la red*/

/*PARÁMETROS */
param Costo_Apertura{CD};                     /*Costo apertura del CD*/
param Costo_No_Apertura{CD};                  /*Costo de no apertura del CD*/
param Costo_Recoleccion{CD,PR};               /*Costo de recolección del PR en el CD*/
param Capacidad_Recepcion_Frescos{CD};        /*Capacidad de recepción de estibas de productos de alimentos frescos en el CD*/
param Capacidad_Recepcion_EmpAse{CD};         /*Capacidad de recepción de estibas de productos de alimentos empaquetados y productos de aseo en el CD*/
param Oferta_Frescos{PR_FRE};                 /*Capacidad de oferta en estibas del PR_FRE*/
param Oferta_Aseo{PR_ASE};                    /*Capacidad de oferta en estibas del PR_ASE*/
param Oferta_Empaquetados{PR_EMP};            /*Capacidad de oferta en estibas del PR_EMP*/
param Costo_Frescos{PR_FRE};                  /*Costo por una estiba del PR_FRE*/
param Costo_Aseo{PR_ASE};                     /*Costo por una estiba del PR_ASE*/
param Costo_Empaquetados{PR_EMP};             /*Costo por una estiba del PR_EMP*/
param Demanda_Cluster{CL,PR};                 /*Unidades requeridas en el CL*/
param Pedidos_Cluster{CL};                    /*Cantidad de pedidos en el CL*/
param ValorPromedio_Cluster{CL};              /*Valor promedio de compra de pedido en el CL*/
param Distancia{NODOS,NODOS};                /*Distancia entre los nodos de la red*/


/*VARIABLES*/
/*Variable recepción*/
var x_CD{CD},binary;                        /*1 si el centro de distribución se abre, 0 DLC */

/*Variables Envío Productores de alimentos empaquetados*/
var z_EMP_CD{PR_EMP,CD},binary;             /*1 si el productor de alimentos de empaque emp in PR_EMP le envía al cd in CD */
var y_EMP_CD{PR_EMP,CD},>=0,integer;                /*Cantidad enviada del productor de alimentos de empaque emp in PR_EMP al cd in CD */

/*Variables Envío Productores de alimentos frescos*/
var z_FRE_CD{PR_FRE,CD},binary;             /*1 si el productor de alimentos frescos fre in PR_FRE le envía al cd in CD */
var y_FRE_CD{PR_FRE,CD},>=0,integer;                /*Cantidad enviada del productor de alimentos frescos fre in PR_FRE al cd in CD */

/*Variables Envío Productores de productos aseo*/
var z_ASE_CD{PR_ASE,CD},binary;             /*1 si el productor de productos de aseo ase in PR_ASE le envía al cd in CD */
var y_ASE_CD{PR_ASE,CD},>=0,integer;                /*Cantidad enviada del productor de productos de aseo ase in PR_ASE al cd in CD */

/*Variables Envío Centros de distribución*/
var z_CD_CL{CD,CL},binary;                  /*1 si el centro de distribución cd in CD le envía al cliente cl in CL */
var y_CD_CL{CD,CL,PR},>=0;                     /*Cantidad enviada del centro de distribución cd in CD al cliente cl in CL */

/*Variables Envío Costos*/
var Ingresos;
var Costos_Totales;

var Costos_T_Apertura;
var Costos_T_NO_Apertura;
var Costos_T_Transporte;
var Costos_T_Alistamiento;
var Costos_T_Politica_Social;
var Costos_T_Adquisicion;

var Costo_T_VAR_Transporte;
var Costo_T_Viajes;


/*Costos variables de transporte*/
var CT1;
var CT2;
var CT3;
var CT4;

/*Costos de viaje*/
var CV1;
var CV2;
var CV3;
var CV4;

/*Número de viaje*/
var NV1{PR_EMP,CD},integer;
var NV2{PR_FRE,CD},integer;
var NV3{PR_ASE,CD},integer;
var NV4{CD,CL},integer;

/*Número de viaje*/
var Cantidad_Mercados;
var Distancia_Recorrida;

/*FUNCIÓN OBJETIVO*/
maximize FO: Ingresos - Costos_Totales;

s.t. r1: Ingresos = sum{cl in CL}Pedidos_Cluster[cl]*ValorPromedio_Cluster[cl];
s.t. r2: Costos_Totales = Costos_T_Apertura + Costos_T_NO_Apertura + Costos_T_Transporte + Costos_T_Alistamiento + Costos_T_Politica_Social + Costos_T_Adquisicion;

s.t. r3: Costos_T_Apertura = sum{cd in CD}Costo_Apertura[cd]*x_CD[cd];
s.t. r4: Costos_T_NO_Apertura = sum{cd in CD}Costo_No_Apertura[cd]*(1-x_CD[cd]);
s.t. r5: Costos_T_Transporte = Costo_T_VAR_Transporte + Costo_T_Viajes;
s.t. r6: Costos_T_Alistamiento = sum{cd in CD, cl in CL, pr in PR}Costo_Recoleccion[cd,pr]*y_CD_CL[cd,cl,pr];
s.t. r7: Costos_T_Politica_Social = 260000*Cantidad_Mercados;
s.t. r8: Costos_T_Adquisicion = sum{emp in PR_EMP,cd in CD}Costo_Empaquetados[emp]*y_EMP_CD[emp,cd] + sum{fre in PR_FRE,cd in CD}Costo_Frescos[fre]*y_FRE_CD[fre,cd] + sum{ase in PR_ASE,cd in CD}Costo_Aseo[ase]*y_ASE_CD[ase,cd];

s.t. r9: Costo_T_VAR_Transporte = CT1+ CT2 + CT3 + CT4;
/*El costo de transporte es el valor del costo por la distancia entre cada nodo por la cantidad enviada entre cada nodo*/
s.t. r10: CT1 = sum{emp in PR_EMP,cd in CD}28*Distancia[emp,cd]*y_EMP_CD[emp,cd];
s.t. r11: CT2 = sum{fre in PR_FRE,cd in CD}28*Distancia[fre,cd]*y_FRE_CD[fre,cd];
s.t. r12: CT3 = sum{ase in PR_ASE,cd in CD}28*Distancia[ase,cd]*y_ASE_CD[ase,cd];
s.t. r13: CT4 = sum{cd in CD,cl in CL}6*Distancia[cd,cl]*z_CD_CL[cd,cl]*Pedidos_Cluster[cl];

s.t. r14: Costo_T_Viajes = CV1 + CV2 + CV3 + CV4;
/*El costo de viajes es el valor del viaje por la cantidad de viajes realizados entre cada nodo*/
s.t. r15: CV1 = sum{emp in PR_EMP,cd in CD}4500*NV1[emp,cd];
s.t. r16: CV2 = sum{fre in PR_FRE,cd in CD}4500*NV2[fre,cd];
s.t. r17: CV3 = sum{ase in PR_ASE,cd in CD}4500*NV3[ase,cd];
s.t. r18: CV4 = sum{cd in CD,cl in CL}3200*NV4[cd,cl];

/*El número de viajes es la cantidad enviada de cada proveedor a los cd dividido la capacidad del camión*/
s.t. r19{emp in PR_EMP,cd in CD}: NV1[emp,cd] >= y_EMP_CD[emp,cd]/12;
s.t. r20{fre in PR_FRE,cd in CD}: NV2[fre,cd] >= y_FRE_CD[fre,cd]/12;
s.t. r21{ase in PR_ASE,cd in CD}: NV3[ase,cd] >= y_ASE_CD[ase,cd]/12;
/*El número de viajes es la cantidad enviada de cada cd a los cluster dividido la capacidad del camión*/
s.t. r22{cd in CD,cl in CL}: NV4[cd,cl] >= z_CD_CL[cd,cl]*Pedidos_Cluster[cl]/25;

/*La cantidad de mercados es el total de la distancia recorrida divido en 20 km*/
s.t. r23: Cantidad_Mercados >= Distancia_Recorrida/20;
/*La distancia recorrida es la suma de la ida y vuelta de todos los nodos*/
s.t. r24: Distancia_Recorrida = sum{emp in PR_EMP,cd in CD} z_EMP_CD[emp,cd]*Distancia[emp,cd] + sum{emp in PR_EMP,cd in CD} z_EMP_CD[emp,cd]*Distancia[cd,emp] + sum{fre in PR_FRE,cd in CD} z_FRE_CD[fre,cd]*Distancia[fre,cd] + sum{fre in PR_FRE,cd in CD} z_FRE_CD[fre,cd]*Distancia[cd,fre] + sum{ase in PR_ASE,cd in CD} z_ASE_CD[ase,cd]*Distancia[ase,cd] + sum{ase in PR_ASE,cd in CD} z_ASE_CD[ase,cd]*Distancia[cd,ase] + sum{cd in CD, cl in CL} z_CD_CL[cd,cl]*Distancia[cd,cl] + sum{cd in CD, cl in CL} z_CD_CL[cd,cl]*Distancia[cl,cd];

/*Restricciones Productores Empaquetados*/
/*Solo se puede enviar si el cd está abierto*/
/*La cantidad a enviar depende de si se envía del proveedor al cd*/
/*El proveedor máximo puede enviar a 3 cd*/
/*La cantidad enviada debe ser menor igual a la capacidad de oferta del proveedor*/
s.t. r25{emp in PR_EMP, cd in CD}: z_EMP_CD[emp,cd] <= x_CD[cd];
s.t. r26{emp in PR_EMP, cd in CD}: y_EMP_CD[emp,cd] <= 1000*z_EMP_CD[emp,cd];
s.t. r27{emp in PR_EMP}: sum{cd in CD}z_EMP_CD[emp,cd] <= 3;
s.t. r28{emp in PR_EMP}: sum{cd in CD}y_EMP_CD[emp,cd] <= Oferta_Empaquetados[emp];

/*Restricciones Productores Frescos*/
/*Solo se puede enviar si el cd está abierto*/
/*La cantidad a enviar depende de si se envía del proveedor al cd*/
/*El proveedor máximo puede enviar a 3 cd*/
/*La cantidad enviada debe ser menor igual a la capacidad de oferta del proveedor*/
s.t. r29{fre in PR_FRE, cd in CD}: z_FRE_CD[fre,cd] <= x_CD[cd];
s.t. r30{fre in PR_FRE, cd in CD}: y_FRE_CD[fre,cd] <= 1000*z_FRE_CD[fre,cd];
s.t. r31{fre in PR_FRE}: sum{cd in CD}z_FRE_CD[fre,cd] <= 3;
s.t. r32{fre in PR_FRE}: sum{cd in CD}y_FRE_CD[fre,cd] <= Oferta_Frescos[fre];

/*Restricciones Productores Aseo*/
/*Solo se puede enviar si el cd está abierto*/
/*La cantidad a enviar depende de si se envía del proveedor al cd*/
/*El proveedor máximo puede enviar a 3 cd*/
/*La cantidad enviada debe ser menor igual a la capacidad de oferta del proveedor*/
s.t. r33{ase in PR_ASE, cd in CD}: z_ASE_CD[ase,cd] <= x_CD[cd];
s.t. r34{ase in PR_ASE, cd in CD}: y_ASE_CD[ase,cd] <= 1000*z_ASE_CD[ase,cd];
s.t. r35{ase in PR_ASE}: sum{cd in CD}z_ASE_CD[ase,cd] <= 3;
s.t. r36{ase in PR_ASE}: sum{cd in CD}y_ASE_CD[ase,cd] <= Oferta_Aseo[ase];

/*Restricciones Capacidad Centro de Distribución*/
/*La cantidad enviada de todos los proveedores de aseo y empaquetados debe ser menor igual a la capacidad de recepción del cd*/
/*La cantidad enviada de los proveedores de alimentos frescos debe ser menor igual a la capacidad de recepción del cd*/
s.t. r37{cd in CD}: sum{emp in PR_EMP}y_EMP_CD[emp,cd] + sum{ase in PR_ASE}y_ASE_CD[ase,cd] <= Capacidad_Recepcion_EmpAse[cd];
s.t. r38{cd in CD}: sum{fre in PR_FRE}y_FRE_CD[fre,cd] <= Capacidad_Recepcion_Frescos[cd];

/*Restricciones CD a Cluster*/
/*Solo se puede enviar al cluster si el cd está abierto*/
/*La cantidad a enviar depende de si se envía del cd al cluster*/
/*Solo un cd puede atender al cluster*/
/*La cantidad a enviar debe ser mayor igual a la demanda del cluster*/
s.t. r39{cd in CD, cl in CL}: z_CD_CL[cd,cl] <= x_CD[cd];
s.t. r40{cd in CD, cl in CL, pr in PR}: y_CD_CL[cd,cl,pr] <= 10000*z_CD_CL[cd,cl];
s.t. r41{cl in CL}: sum{cd in CD}z_CD_CL[cd,cl] = 1;
s.t. r42{cl in CL, pr in PR}: sum{cd in CD}y_CD_CL[cd,cl,pr] >= Demanda_Cluster[cl,pr];

/*Restricciones de Equilibrio*/
/*La cantidad enviada al cluster debe ser menor igual a la cantidad de unidades que lleva la estiba por la cantidad de estibas enviadas de los proveedores al cd*/
s.t. r43{cd in CD}: sum{cl in CL}y_CD_CL[cd,cl,"Emp"] <= 240*sum{emp in PR_EMP}y_EMP_CD[emp,cd];
s.t. r44{cd in CD}: sum{cl in CL}y_CD_CL[cd,cl,"Fre"] <= 200*sum{fre in PR_FRE}y_FRE_CD[fre,cd];
s.t. r45{cd in CD}: sum{cl in CL}y_CD_CL[cd,cl,"Ase"] <= 360*sum{ase in PR_ASE}y_ASE_CD[ase,cd];

/*Solo se puede abrir uno de los cd 1A y B*/
s.t. r46: x_CD["Bo1A"] + x_CD["Bo1B"] <= 1;


solve;

printf: "\n";
printf: "\n";
printf: "\-----------------------------------------\n";
printf: "\         SOLUCIÓN DE LA RED LOGISTICA\n";
printf: "\        ------------------------------ \n";

printf: "\nUtilidades totales: "&Ingresos - Costos_Totales&"\n";
printf: "Ingresos totales: "&Ingresos&"\n";
printf: "Costos totales: "&Costos_Totales&"\n";
printf: "------------------------\n";
printf: "\nCOSTOS:\n";
printf: "\Costos de apertura: "&Costos_T_Apertura&"\n";
printf: "\Costos de no apertura: "&Costos_T_NO_Apertura&"\n";
printf: "\Costos de transporte: "&Costos_T_Transporte&"\n";
printf: "\Costos de alistamiento: "&Costos_T_Alistamiento&"\n";
printf: "\Costos de política social: "&Costos_T_Politica_Social&"\n";
printf: "\Costos de Adquisición: "&Costos_T_Adquisicion&"\n";
printf: "\n------------------------\n";
printf: "\nCENTROS DE DISTRIBUCIÓN A ABRIR:\n";
for{cd in CD:x_CD[cd]=1}{
	printf: "Se abre centro de distribución en "&cd&"\n";
}
printf: "\n------------------------\n";
printf: "\nENVÍO PRODUCTORES DE ALIMENTOS EMPAQUETADOS:\n";
for{emp in PR_EMP}{
	for{cd in CD:z_EMP_CD[emp,cd]=1}{
		printf: emp&" ----> "&cd&": ";
		printf: y_EMP_CD[emp,cd]&" estibas .... ";
		printf: NV1[emp,cd]&" viajes\n";
	}
}
printf: "\n------------------------\n";
printf: "\nENVÍO PRODUCTORES DE ALIMENTOS FRESCOS:\n";
for{fre in PR_FRE}{
	for{cd in CD:z_FRE_CD[fre,cd]=1}{
		printf: fre&" ----> "&cd&": ";
		printf: y_FRE_CD[fre,cd]&" estibas .... ";
		printf: NV2[fre,cd]&" viajes\n";
	}
}
printf: "\n------------------------\n";
printf: "\nENVÍO PRODUCTORES DE PRODUCTOS DE ASEO:\n";
for{ase in PR_ASE}{
	for{cd in CD:z_ASE_CD[ase,cd]=1}{
		printf: ase&" ----> "&cd&": ";
		printf: y_ASE_CD[ase,cd]&" estibas .... ";
		printf: NV3[ase,cd]&" viajes\n";
	}
}
printf: "\n------------------------\n";
printf: "\nENVÍO A ClUSTERES:\n";
for{cl in CL}{
	printf: "\nCluster "&cl&". D:"&Pedidos_Cluster[cl];
	for{cd in CD:z_CD_CL[cd,cl]=1}{
		printf: " V:"&NV4[cd,cl]&"\n";
		for{pr in PR}{
			printf: pr&": ";
			printf: cd&" ----> "&cl&": ";
			printf: y_CD_CL[cd,cl,pr]&" unidades\n";
		}
	}
}
printf: "\n------------------------\n";
printf: "\n";
printf: "\n";
printf: "\n";



data;

set PR_EMP:= Em1  Em2  Em5  Em6;
set PR_FRE:= Fr1  Fr3  Fr5;
set PR_ASE:= As2  As3  As4;
set CD:= Bo1A  Bo1B  Bo4  Bo8  Bo9;
set CL:= Cl1  Cl4  Cl5  Cl7  Cl10  Cl13;
set PR:=Emp Fre Ase;
set NODOS:=Cl1  Cl4  Cl5  Cl7  Cl10  Cl13  Em1  Em2  Em5  Em6  Fr1  Fr3  Fr5  As2  As3  As4  Bo1A  Bo1B  Bo4  Bo8  Bo9;

param Costo_Apertura:=
Bo1A	108798500
Bo1B	140783300
Bo4	100657000
Bo8	94791000
Bo9	117408000;

param Costo_No_Apertura:=
Bo1A	5926000
Bo1B	4196000
Bo4	8187200
Bo8	8155000
Bo9	8034600;

param Costo_Recoleccion: 
Fre	Emp	Ase	:=
Bo1A	15	16	11
Bo1B	21	18	23
Bo4	10	10	14
Bo8	15	15	16
Bo9	11	9	9;

param Capacidad_Recepcion_Frescos:=
Bo1A	31
Bo1B	42
Bo4	31
Bo8	30
Bo9	30;

param Capacidad_Recepcion_EmpAse:=
Bo1A	50
Bo1B	70
Bo4	49
Bo8	53
Bo9	52;

param Oferta_Frescos:=
Fr1	110
Fr3	100
Fr5	105;

param Oferta_Aseo:=
As2	95
As3	100
As4	105;

param Oferta_Empaquetados:=
Em1	165
Em2	135
Em5	140
Em6	170;

param Costo_Frescos:=
Fr1	869000
Fr3	984000
Fr5	945000;

param Costo_Aseo:=
As2	816000
As3	1020000
As4	897000;

param Costo_Empaquetados:=
Em1	1035000
Em2	1165000
Em5	1086000
Em6	1088000;

param Demanda_Cluster:
Fre	Emp	Ase	:=
Cl1	1332	1520	2102
Cl4	1886	1640	1380
Cl5	2170	1757	1894
Cl7	2433	2019	1654
Cl10	2739	1996	1827
Cl13	2124	1470	2235;

param Pedidos_Cluster:=
Cl1	219
Cl4	182
Cl5	160
Cl7	181
Cl10	217
Cl13	175;

param ValorPromedio_Cluster:=
Cl1	371000
Cl4	413000
Cl5	371000
Cl7	384000
Cl10	370000
Cl13	392000;

param Distancia:
	Cl1	Cl4	Cl5	Cl7	Cl10	Cl13	Em1	Em2	Em5	Em6	Fr1	Fr3	Fr5	As2	As3	As4	Bo1A	Bo1B	Bo4	Bo8	Bo9:=
Cl1	0	23.51	23.296	27.5	31.425	31.395	27.41	5.82	32.455	32.638	27.92	10.194	20.61	33.344	36.322	33.894	32.906	32.906	37.506	18.897	24.772
Cl4	24.226	0	5.088	10.899	10.221	11.34	26.432	20.557	11.843	12.027	26.952	28.557	9.668	12.733	15.711	12.691	12.295	12.295	16.895	9.189	4.161
Cl5	24.594	4.6	0	8.465	10.939	9.35	22.94	20.925	10.424	10.607	23.46	28.924	7.003	11.313	14.291	13.408	10.875	10.875	15.475	6.524	2.863
Cl7	24.991	9.402	6.812	0	13.352	6.349	17.397	27.736	8.386	9.589	17.917	35.736	6.943	9.894	13.298	14.075	8.972	8.972	14.482	8.953	7.686
Cl10	32.149	10.542	13.017	12.675	0	8.65	29.026	28.48	8.21	8.394	24.724	36.479	15.313	9.1	10.435	3.949	7.065	7.065	11.128	17.326	10.072
Cl13	33.08	11.467	8.911	8.374	7.018	0	26.802	29.411	3.069	3.235	18.149	37.41	13.09	3.941	6.944	7.741	3.503	3.503	8.128	13.639	7.609
Em1	22.742	23.073	20.483	15.07	26.15	22.056	0	29.343	24.074	25.429	15.496	33.717	19.661	25.483	28.99	28.62	24.66	24.66	30.296	21.672	20.772
Em2	10.505	25.885	25.671	32.886	33.8	33.77	36.744	0	34.83	35.013	37.253	14.473	28.58	35.719	38.697	36.27	35.281	35.281	39.881	28.101	27.147
Em5	34.274	12.661	10.094	9.526	8.521	2.432	26.612	30.605	0	1.393	16.984	38.605	12.9	1.951	5.65	9.244	0.618	0.618	6.834	14.823	8.804
Em6	33.754	12.141	10.603	10.255	8.001	2.432	27.477	30.085	0.678	0	17.489	38.084	13.764	2.124	5.129	8.724	1.101	1.101	6.313	15.332	8.283
Fr1	24.558	24.896	22.306	16.893	21.995	16.422	16.974	31.16	15.253	16.273	0	35.534	21.485	15.54	19.167	21.846	16.262	16.262	20.351	23.495	22.595
Fr3	10.481	28.348	28.134	35.349	36.264	36.234	36.719	10.659	37.293	37.477	37.229	0	31.043	38.183	41.16	38.733	37.745	37.745	42.344	30.565	29.61
Fr5	20.218	10.186	4.438	5.342	14.602	10.508	20.833	25.442	12.526	13.88	21.353	33.441	0	13.934	17.441	17.071	13.112	13.112	18.748	2.159	8.269
As2	37.618	16.01	11.171	10.603	7.137	3.366	27.689	33.949	1.567	1.404	17.233	41.948	13.976	0	4.299	6.988	0.949	0.949	5.483	15.899	10.154
As3	39.089	17.086	14.495	13.934	10.632	8.181	31.013	35.42	6.105	6.684	20.895	43.419	17.301	6.668	0	10.483	6.534	6.534	2.663	19.224	14.122
As4	35.583	13.976	16.451	15.607	5.102	10.652	32.46	31.914	7.369	6.747	23.035	39.913	18.747	7.814	7.92	0	6.751	6.751	8.507	20.76	13.506
Bo1A	35.371	13.368	10.777	10.209	7.747	4.457	27.295	31.702	0.618	0.953	16.84	39.701	13.583	1.307	4.934	7.598	0	0	6.118	15.506	9.227
Bo1B	35.371	13.368	10.777	10.209	7.747	4.457	27.295	31.702	0.618	0.953	16.84	39.701	13.583	1.307	4.934	7.598	0	0	6.118	15.506	9.227
Bo4	40.793	19.186	17.065	16.503	10.312	10.751	33.583	37.124	8.685	9.264	23.477	45.123	19.87	9.25	3.769	9.78	9.114	9.114	0	21.793	16.701
Bo8	18.516	9.188	4.953	7.722	15.346	12.429	19.504	24.444	14.831	15.015	20.024	32.443	2.476	15.855	18.698	17.816	15.283	15.283	19.882	0	7.271
Bo9	26.133	4.52	4.731	8.174	8.334	8.615	23.015	22.464	9.119	9.303	23.534	30.463	8.747	10.008	12.986	10.803	9.571	9.571	14.17	8.269	0;



end;