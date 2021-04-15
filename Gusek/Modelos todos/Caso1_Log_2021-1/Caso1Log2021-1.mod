/*CONJUNTOS*/
set PE;             #Proveedores Externos
set PI;             #Proveedores Internos
set PROV;           #Proveedores Externos y Proveedores Internos
set LAB;            #Laboratorios
set CD;             #Posibles Centros de Distribución
set FAR;            #Farmaceuticas
set EPS;            #EPS's
set HOS;            #Hospitales
set CLI;            #Farmaceuticas, EPS y Hospitales
set NODOS;          #Todos los nodos de la red

set PA;             #Principios Activos
set MP;             #Principios Activos y Excipientes
set MED;            #Medicamentos

set TIPO;           #Tipo de Centro de Distribución

/*PARÁMETROS */
param Distancia{NODOS,NODOS};                    #Distancia entre los nodos de la red

param Oferta{PROV,MP};                           #Oferta de materia prima de un proveedor(kg)
param Costo_MP{PROV,MP};                         #Costo por kilo de materia prima ($/kg)

param Costo_Adq_LAB{LAB};                        #Costo de adquir el laboratorio($)
param Costo_Prod_MED{LAB,MED};                   #Costo de producir medicamento($/kg)
param Capac_Recep_LAB_MP{LAB};                   #Capaidad de recepcion de materia prima por un laboratorio(Kg)
param Req_Med_LAB{MP,MED,LAB};                   #Requerimiento Médico de materia prima para hacer un kg de medicamento en un laboratorio

param Tipo1{CD};                                 #Si el centro puede ser tipo 1
param Tipo2{CD};                                 #Si el centro puede ser tipo 2
param Costo_Aper_CD{CD,TIPO};                    #Costo de apertur de un centro de distribución según tipo
param Costo_No_Aper_CD{CD};                      #Costo de No abrir un centro de distribución
param Costo_Emp_CD{CD,MED,TIPO};                 #Costo de empaquetar en un centro de distribución cierto tipo de medicamento degún el tipo
param Capac_CD{TIPO};                            #Capacidad de los centros de distribución segín tipo

param Demanda{CLI,MED};                          #Demanda de un cliente de un tipo de medicamento

/*VARIABLES DE DESICIÓN*/
var x_CD_T{CD,TIPO}, binary;                     #1 Si abro un centro de distribución de cierto tipo. 0 dlc
var x_CD{CD}, binary;                            #1 Si abro un centro de distribución
var x_LAB{LAB}, binary;                          #1 Si abro un laboratorio. 0 dlc

var z_PROV_LAB{PROV,LAB}, binary;                #1 Si envío de un proveedor. 0 dlc
var y_PROV_LAB{PROV,LAB,MP}, >=0;                #Cantidad enviada de un proveedor a un laboratorio de materia prima

var z_LAB_CD{LAB,CD}, binary;                    #1 Si envío  de un laboratorio a un centro de distribución
var y_LAB_CD{LAB,CD,MED}, >=0;                   #Cantidad enviada de un centro de distribución a un lab
var pro_LAB{LAB,MED}, >=0;                       #Producción de un laboratorio de cierto mediamento
var rec_LAB{LAB,MP}, >=0;                        #Cantidad recibida por un laboratorio de materia prima

var z_CD_CLI_T{CD,CLI,TIPO},binary;              #1 Si envío de un centro de distribución de cierto tipo a un cliente. 0 dlc.
var z_CD_CLI{CD,CLI},binary;                     #1 Si envío de un centro de distribución a un cliente. 0 dlc.
var y_CD_CLI_T{CD,CLI,MED,TIPO},>=0;             #Cantidad de medicamento enviada de un centro de distribucion de cierto tipo a un cliente
var y_CD_CLI{CD,CLI,MED},>=0;                    #Cantidad de medicamento enviada de un centro de distribucion a un cliente
var Aux_CD{CD,MED,TIPO};                         #Cantidad enviada de uin centro de distribución de un tipo de medicamento de cierto tipo

var Costo_T_MP, >=0;                             #Costo total de compra de materia prima
var Costo_T_Ad_LAB, >=0;                         #Costo total  de adquirir laboratorios
var Costo_T_Prod_LAB, >=0;                       #Costo total de producción en los laboratorios
var Costo_T_Aper_CD, >=0;                        #Costo total de apertura de centros de distribución
var Costo_T_No_Aper_CD, >=0;                     #Costo total de no apertura de centros de distribución
var Costo_T_Emp_CD, >=0;                         #Costo total de empaquetamiento en un centro de distribución
var Costo_T_Transporte, >=0;                     #Costo total de transporte
var Costo_T_Viaje, >=0;                          #Costo total de viaje

var CT1, >=0;var CT2, >=0;var CT3, >=0;          #Costos de transpor
var CV1, >=0;var CV2, >=0;var CV3, >=0;          #Costos de Viaje

var NV1{PROV,LAB}, integer, >=0;                 #Número de viajes de un proveedor a un laboratorio
var NV2{LAB,CD}, integer, >=0;                   #Número de viajes de un laboratorio a un centro de distribución
var NV3{CD,CLI}, integer, >=0;                   #Número de viajes de un centro de distribución a un cliente

/*FUNCIÓN OBJETIVO*/
minimize FO: Costo_T_MP+Costo_T_Ad_LAB+Costo_T_Prod_LAB+Costo_T_Aper_CD+Costo_T_No_Aper_CD+Costo_T_Emp_CD+Costo_T_Transporte+Costo_T_Viaje;

#Costos de función objetivo
s.t. c1: Costo_T_MP = sum{prov in PROV, mp in MP,lab in LAB}Costo_MP[prov,mp]*y_PROV_LAB[prov,lab,mp];
s.t. c2: Costo_T_Ad_LAB = sum{lab in LAB}Costo_Adq_LAB[lab] * x_LAB[lab];
s.t. c3: Costo_T_Prod_LAB = sum{lab in LAB,med in MED}Costo_Prod_MED[lab,med]*pro_LAB[lab,med];
s.t. c4: Costo_T_Aper_CD = sum{cd in CD,tipo in TIPO} Costo_Aper_CD[cd,tipo]*x_CD_T[cd,tipo];
s.t. c5: Costo_T_No_Aper_CD = sum{cd in CD} Costo_No_Aper_CD[cd]*x_CD[cd];
s.t. c6: Costo_T_Emp_CD = sum{cd in CD,med in MED,tipo in TIPO}Costo_Emp_CD[cd,med,tipo]*Aux_CD[cd,med,tipo];
s.t. c7: Costo_T_Transporte = CT1 + CT2 +CT3;
s.t. c8: Costo_T_Viaje = CV1 + CV2 + CV3;
 
#Costos de trasnporte
s.t. t1: CT1 = sum{prov in PROV,lab in LAB,mp in MP}25*y_PROV_LAB[prov,lab,mp]*Distancia[prov,lab];
s.t. t2: CT2 = sum{lab in LAB,cd in CD,med in MED}35*y_LAB_CD[lab,cd,med]*Distancia[lab,cd];
s.t. t3: CT3 = sum{cd in CD,cli in CLI,med in MED}35*y_CD_CLI[cd,cli,med]*Distancia[cd,cli];

#Número de viajes
s.t. nv1{prov in PROV,lab in LAB}: NV1[prov,lab] >=  (sum{mp in MP}y_PROV_LAB[prov,lab,mp])/1200;
s.t. nv2{lab in LAB,cd in CD}: NV2[lab,cd] >= (sum{med in MED}y_LAB_CD[lab,cd,med])/1200;
s.t. nv3{cd in CD,cli in CLI}: NV3[cd,cli] >= (sum{med in MED}y_CD_CLI[cd,cli,med])/1200;

#Costo de hacer un viaje
s.t. v1: CV1 = sum{prov in PROV,lab in LAB}100*NV1[prov,lab]*Distancia[prov,lab];
s.t. v2: CV2 = sum{lab in LAB,cd in CD}100*NV2[lab,cd]*Distancia[lab,cd];
s.t. v3: CV3 = sum{cd in CD,cli in CLI}100*NV3[cd,cli]*Distancia[cd,cli];

#Restricciones de apertura
#Solo se puede abrir un cd de tipo 1 si es permitido
#Solo se puede abrir un cd de tipo 2 si es permitido
#Solo se puede abrir un centro de distribución de uno de dos tipos
#Asignación: si se abre un centro en un punto
s.t. r1{cd in CD}: x_CD_T[cd,1] <= Tipo1[cd];
s.t. r2{cd in CD}: x_CD_T[cd,2] <= Tipo2[cd];
s.t. r3{cd in CD}: x_CD_T[cd,1] + x_CD_T[cd,2] <= 1;
s.t. r4{cd in CD}: x_CD[cd] = x_CD_T[cd,1] + x_CD_T[cd,2];

#Envío de Proveedores a Laboratorios
#No puedo enviar de un proveedor a un laboratorio si no he abierto el laboratorio
#No puedo enviar nada de un proveedor a un laboratorio si no exite la decición de envío
#Si no se envía materia prima de ningún proveedor a ningún a un laboratorio entonces la decición de envío es 0
#Lo que envió desde un proveedor a todos los laboratorios de materia prima debe ser menor a la oferta
#Un proveedor le puede enviar a máximo tres centros de distribución
s.t. r5{prov in PROV, lab in LAB}: z_PROV_LAB[prov,lab] <= x_LAB[lab];
s.t. r6{prov in PROV, lab in LAB, mp in MP}: y_PROV_LAB[prov,lab,mp] <= 100000*z_PROV_LAB[prov,lab];
s.t. r0{prov in PROV, lab in LAB}: z_PROV_LAB[prov,lab] <= sum{mp in MP}y_PROV_LAB[prov,lab,mp];
s.t. r7{prov in PROV, mp in MP}: sum{lab in LAB} y_PROV_LAB[prov,lab,mp] <= Oferta[prov,mp];
s.t. r8{prov in PROV}: sum{lab in LAB}z_PROV_LAB[prov,lab] <= 3;

#Recepción y Fabricación en Laboratorios
#Lo que recibe un laboratorio de todos los proveedores de todas las materia prima debe ser menor a la capacidad del camión
#Asignación: recepcióon de materia prima de un laboratorio
#Calculo entre lo producido de materia prima y lo producido de medicamento
s.t. r9{lab in LAB}: sum{prov in PROV,mp in MP} y_PROV_LAB[prov,lab,mp] <= Capac_Recep_LAB_MP[lab];
s.t. r10{lab in LAB, mp in MP}: rec_LAB[lab,mp] = sum{prov in PROV} y_PROV_LAB[prov,lab,mp];
s.t. r11{lab in LAB, mp in MP}: rec_LAB[lab,mp] = sum{med in MED} Req_Med_LAB[mp,med,lab] * pro_LAB[lab,med];

#Envío de Laboratorios a Centros de Distribuciones
#No puedo enviar de un laboratorio a un centro de distribución si no he abierto el laboratorio
#No puedo enviar de un laboratorio a un centro de distribución si no he abierto el centro de distribución
#No puedo enviar nada de un laboratorio a un centro de distribución si no exite la decición de envío
#Si no se envía nada de un laboratorio a un centro de distribución entonces la deción de envión no debe existir
#Lo que se envía de un laboratorio a todos los centros de distribución de cierto medicameento debe ser lo mismo que se produce de ese medicamento
s.t. r12{lab in LAB, cd in CD}: z_LAB_CD[lab,cd] <= x_LAB[lab];
s.t. r13{lab in LAB, cd in CD}: z_LAB_CD[lab,cd] <= x_CD[cd];
s.t. r14{lab in LAB, cd in CD, med in MED}: y_LAB_CD[lab,cd,med] <= 100000*z_LAB_CD[lab,cd];
s.t. r15{lab in LAB, cd in CD}: z_LAB_CD[lab,cd] <= sum{med in MED}y_LAB_CD[lab,cd,med];
s.t. r16{lab in LAB, med in MED}: sum{cd in CD}y_LAB_CD[lab,cd,med] = pro_LAB[lab,med];

#Recepción y envío centros de distribución
#No se puede enviar de un centro de distribución a un cliente si no se abre el centro de distribución
#No puedo enviar nada de un centro de distribución a un cliente si no exite la decición de envío
#Asignación: si se decide enviar de un centro de distribución a un cliente
#Asignación: cantidad enviada de un centro de distribución a un cliente de cierto medicamento
#Para cada centro de distribución, lo que se envía a todos lo clientes de todos los medicamentos debe respetar la capacidad del tipo del centro de distribución
#Un cliente solo puede recibir de un centro de distribución
#Se debe satisfacer la demanda de cada cliente por medicamento
#Para cada centro de distribución lo que se envía a todos lo cliente de cada medicamento es lo mismo que se recibe de todos los laboratorios
#Variable Para calcular el costo de empaquetamiento
s.t. r17{cd in CD, cli in CLI,tipo in TIPO}: z_CD_CLI_T[cd,cli,tipo] <= x_CD_T[cd,tipo];
s.t. r18{cd in CD, cli in CLI, med in MED,tipo in TIPO}: y_CD_CLI_T[cd,cli,med,tipo] <= 100000*z_CD_CLI_T[cd,cli,tipo];
s.t. r19{cd in CD, cli in CLI}: z_CD_CLI[cd,cli] = sum{tipo in TIPO}z_CD_CLI_T[cd,cli,tipo];
s.t. r20{cd in CD, cli in CLI,med in MED}: y_CD_CLI[cd,cli,med] = sum{tipo in TIPO}y_CD_CLI_T[cd,cli,med,tipo];
s.t. r21{cd in CD, tipo in TIPO}: sum{cli in CLI,med in MED}y_CD_CLI_T[cd,cli,med,tipo] <= Capac_CD[tipo];
s.t. r22{cli in CLI}: sum{cd in CD}z_CD_CLI[cd,cli] = 1;
s.t. r23{cli in CLI, med in MED}: sum{cd in CD}y_CD_CLI[cd,cli,med] >= Demanda[cli,med];
s.t. r24{cd in CD,med in MED}: sum{cli in CLI}y_CD_CLI[cd,cli,med] = sum{lab in LAB}y_LAB_CD[lab,cd,med];
s.t. r25{cd in CD,med in MED,tipo in TIPO}: Aux_CD[cd,med,tipo] = sum{cli in CLI}y_CD_CLI_T[cd,cli,med,tipo];

solve;

printf: "\n";
printf: "\n";
printf: "\-----------------------------------------\n";
printf: "\         SOLUCIÓN DE LA RED LOGISTICA\n";
printf: "\        ------------------------------ \n";
printf: "Costos totales: "&FO&"\n";
printf: "------------------------\n";
printf: "\nCOSTOS:\n";
printf: "Costos de compra materia prima laboratorios: "&Costo_T_MP&"\n";
printf: "Costos de adquirir laboratorios: "&Costo_T_Ad_LAB&"\n";
printf: "Costos de producción laboratorios: "&Costo_T_Prod_LAB&"\n";
printf: "Costos de apertura centros de distribución: "&Costo_T_Aper_CD&"\n";
printf: "Costos de no apertura centros de distribución: "&Costo_T_No_Aper_CD&"\n";
printf: "Costos de empaquetamiento centros de distribución: "&Costo_T_Emp_CD&"\n";
printf: "Costos total de transporte: "&Costo_T_Transporte&"\n";
printf: "Costos total de viajes: "&Costo_T_Viaje&"\n";

printf: "\n------------------------\n";
printf: "\nCENTROS DE DISTRIBUCIÓN A ABRIR:\n";
for{tipo in TIPO}{
	for{cd in CD:x_CD_T[cd,tipo]=1}{
		printf: "Se abre centro de distribución en "&cd&" de tipo "&tipo&"\n";
	}
}
printf: "\nLABORATORIOS A ABRIR:\n";
for{lab in LAB:x_LAB[lab]=1}{
	printf: "Se abre laboratorio en "&lab&"\n";
}
printf: "\n------------------------\n";
printf: "\nENVÍO PROVEEDORES A LABORATORIOS:\n";
for{prov in  PROV}{
	for{lab in LAB:z_PROV_LAB[prov,lab]=1}{
		printf: prov&" ----> "&lab&": \n";
		for{mp in MP}{
			printf: mp&": "&y_PROV_LAB[prov,lab,mp]&" kilos\n";
		}
		printf: "\n";
	}
}
printf: "\n------------------------\n";
printf: "\nRECEPCIÓN Y FABRICACIÓN LABORATORIOA\n";
for{lab in LAB:x_LAB[lab]=1}{
	printf: "Laboratorio "&lab&": ";
	printf: "\nRecepción: ";
	for{mp in MP}{
		printf: mp&": "&rec_LAB[lab,mp]&" kilos ... ";
	}
	printf: "\nFabricación: ";
	for{med in MED}{
		printf: med&": "&pro_LAB[lab,med]&" kilos ... ";
	}
	printf: "\n";
	printf: "\n";
}
printf: "\n------------------------\n";
printf: "\nENVÍO LABORATORIOS A CENTROS DE DISTRIBUCIÓN:\n";
for{lab in LAB}{
	for{cd in CD:z_LAB_CD[lab,cd]=1}{
		printf: lab&" ----> "&cd&": \n";
		for{med in MED}{
			printf: med&": "&y_LAB_CD[lab,cd,med]&" kilos\n";
		}
		printf: "\n";
	}
}
printf: "\n------------------------\n";
printf: "\nENVÍO CENTROS DE DISTRIBUCIÓN A CLIENTES:\n";
for{cd in CD}{
	for{cli in CLI:z_CD_CLI[cd,cli]=1}{
		printf: cd&" ----> "&cli&": \n";
		for{med in MED}{
			printf: med&": "&y_CD_CLI[cd,cli,med]&" kilos\n";
		}
		printf: "\n";
	}
}
printf: "\n------------------------\n";
printf: "\n";
printf: "\n";
printf: "\n";

data;

set PE:=	P_Car	P_Buen	A_Dor;
set PI:=	Ecar	Qui_Va	Discol_T;
set PROV:=	P_Car	P_Buen	A_Dor	Ecar	Qui_Va	Discol_T;
set LAB:=	Eu	Laf	Aox	L_Del;
set CD:=	B_Sib	B_Man	B_Buc	B_Pop	B_Ib;
set FAR:=	Caf_Cu	CV_Dui	Caf_Env;
set EPS:=	San_Med	Med_Nei	Audi_Bog;
set HOS:=	Hos_Nar	Cli_Med;
set CLI:=	Caf_Cu	CV_Dui	Caf_Env	San_Med	Med_Nei	Audi_Bog	Hos_Nar	Cli_Med;
set NODOS:= P_Car	P_Buen	A_Dor	Ecar	Qui_Va	Discol_T	Eu	Laf	Aox	L_Del	B_Sib	B_Man	B_Buc	B_Pop	B_Ib	Caf_Cu	CV_Dui	Caf_Env	San_Med	Med_Nei	Audi_Bog	Hos_Nar	Cli_Med;

set PA:=	 Ana  Ant  Ane;
set MP:=	 Ana  Ant  Ane   Exci;
set MED:= Com  Tab  Cap;
set TIPO:=	1	2;

param Oferta:	Ana	Ant	Ane	Exci:=
		P_Car	4900	2300	2200	12900
		P_Buen	5000	1900	2100	13800
		A_Dor	4500	1700	1300	10700
		Ecar	3980	1530	120	13228
		Qui_Va	4460	1840	160	11140
		Discol_T	3740	1700	230	9682;

param Costo_MP:	Ana	Ant	Ane	Exci:=
		P_Car	2025	2475	2325	1950
		P_Buen	2175	2025	2400	1875
		A_Dor	2100	2400	2475	1500
		Ecar	2400	2475	1875	1875
		Qui_Va	1950	1950	2400	1875
		Discol_T	2250	2400	2400	1575;





param Costo_Adq_LAB:=
Eu	127472357
Laf	122091276
Aox	137736165
L_Del	134297519;

param Costo_Prod_MED:	Com	Tab	Cap:=
				Eu	750	710	720
				Laf	840	840	890
				Aox	740	760	710
				L_Del	770	730	730;

param Capac_Recep_LAB_MP:=
Eu	25000
Laf	22000
Aox	21000
L_Del	25000;

param Req_Med_LAB:=
	[*,*,Eu]:	Com	Tab	Cap:=
		Exci	0.62	0.7	0.55
		Ana	0.38	0.23	0.25
		Ant	0	0	0.2
		Ane	0	0.07	0
	[*,*,Laf]:	Com	Tab	Cap:=
		Exci	0.62	0.7	0.55
		Ana	0.38	0.23	0.25
		Ant	0	0	0.2
		Ane	0	0.07	0
	[*,*,Aox]:	Com	Tab	Cap:=
		Exci	0.62	0.7	0.55
		Ana	0.38	0.23	0.25
		Ant	0	0	0.2
		Ane	0	0.07	0
	[*,*,L_Del]:	Com	Tab	Cap:=
		Exci	0.65	0.75	0.5
		Ana	0.35	0.2	0.24
		Ant	0	0	0.26
		Ane	0	0.05	0;










param Tipo1:=
B_Sib	1
B_Man	1
B_Buc	0
B_Pop	1
B_Ib	1;

param Tipo2:=
B_Sib	0
B_Man	0
B_Buc	1
B_Pop	1
B_Ib	1;

param Costo_Aper_CD:	1	2:=
		B_Sib	116360000	0
		B_Man	107080000	0
		B_Buc	0	174210000
		B_Pop	105420000	164830000
		B_Ib	112610000	158590000;

param Costo_No_Aper_CD:=
B_Sib	9132000
B_Man	9383000
B_Buc	9432000
B_Pop	11321000
B_Ib	11393000;

param Costo_Emp_CD:=
	[*,*,1]:	Com	Tab	Cap:=
		B_Sib	320	320	350
		B_Man	180	180	210
		B_Buc	0	0	0
		B_Pop	245	245	280
		B_Ib	210	210	250
	[*,*,2]:	Com	Tab	Cap:=
		B_Sib	0	0	0
		B_Man	0	0	0
		B_Buc	200	200	240
		B_Pop	165	165	180
		B_Ib	170	170	190;

param Capac_CD:=
1	18000
2	25500;







param Demanda:
		Com	Tab	Cap:=
Caf_Cu	2000	2400	2100
CV_Dui	1700	2100	2100
Caf_Env	1700	2500	2100
San_Med	2100	2500	2100
Med_Nei	1900	1800	2900
Audi_Bog	1900	2200	2900
Hos_Nar	1900	2100	2400
Cli_Med	1900	2400	2400;







param Distancia:	P_Car	P_Buen	A_Dor	Ecar	Qui_Va	Discol_T	Eu	Laf	Aox	L_Del	B_Sib	B_Man	B_Buc	B_Pop	B_Ib	Caf_Cu	CV_Dui	Caf_Env	San_Med	Med_Nei	Audi_Bog	Hos_Nar	Cli_Med:=
P_Car	0	744.6590802	653.4021178	465.4005071	783.8717777	591.1688215	660.7268406	779.6460024	464.2216965	249.5391692	647.8890313	579.1917792	453.281917	894.8579535	668.9085263	436.6594214	578.9495952	471.6287676	465.2682713	832.2134357	659.3402532	1042.403369	667.1636441
P_Buen	744.6590802	0	336.8637432	308.2494719	79.31424512	452.1973249	338.5837503	78.44553364	308.002443	845.1731259	336.5380023	215.6909965	565.6671777	170.3279654	219.2648726	674.1079337	496.9847873	302.0556908	308.2245152	225.1508795	337.2676796	300.3790266	218.5719427
A_Dor	653.4021178	336.8637432	0	232.051414	299.4037897	129.6946502	7.560021744	295.7190804	234.5459078	650.3831187	5.540990468	174.9377306	291.2766683	371.0056906	117.6093887	398.9015597	176.2022159	228.8097421	232.3249257	233.8280044	5.963084213	521.3291104	118.2946528
Ecar	465.4005071	308.2494719	232.051414	0	328.2529509	257.0720408	239.3616171	323.8229894	2.651016628	537.5231498	226.9883443	113.9347053	288.7564732	436.7859631	207.2868266	387.2775393	284.4419475	6.464971144	0.28973094	367.7607938	237.50497	589.9788675	205.3941277
Qui_Va	783.8717777	79.31424512	299.4037897	328.2529509	0	424.0080367	299.4836481	4.481676233	328.6448205	863.0404569	300.3016827	220.2350959	556.7400286	111.1984158	185.9951164	667.0596008	470.3387344	321.794859	328.2978782	148.4368137	298.5017359	261.7295753	186.0256606
Discol_T	591.1688215	452.1973249	129.6946502	257.0720408	424.0080367	0	132.3937433	420.0809916	259.680678	547.8422737	127.1829616	256.6196635	174.8259873	500.3938429	238.1725851	276.1145778	46.69248389	257.0880503	257.3565173	362.2755648	132.6446801	651.0082038	238.2754753
Eu	660.7268406	338.5837503	7.560021744	239.3616171	299.4836481	132.3937433	0	295.8649441	241.8486716	656.4742111	13.06429079	180.5112237	296.1070354	369.148089	119.3986379	403.2720911	178.6573109	236.0719107	239.6343378	230.225531	1.922702528	518.747528	120.2017319
Laf	779.6460024	78.44553364	295.7190804	323.8229894	4.481676233	420.0809916	295.8649441	0	324.2204597	858.5642109	296.5707378	215.7540128	552.4163781	115.3317011	182.0089981	662.7215098	466.3832954	317.3642863	323.8685145	148.0801541	294.868414	266.1562838	182.0169593
Aox	464.2216965	308.002443	234.5459078	2.651016628	328.6448205	259.680678	241.8486716	324.2204597	0	537.5811266	229.4915131	115.0107875	290.5673499	437.3419543	208.9903737	388.7768756	286.9595848	7.436339831	2.361304958	369.1743527	239.990119	590.3743367	207.0900182
L_Del	249.5391692	845.1731259	650.3831187	537.5231498	863.0404569	547.8422737	656.4742111	858.5642109	537.5811266	0	645.4883053	642.9661022	375.1553298	968.0546954	707.4602928	300.504958	517.5487915	543.8484685	537.5256982	868.9386919	655.6843269	1123.575221	706.208905
B_Sib	647.8890313	336.5380023	5.540990468	226.9883443	300.3016827	127.1829616	13.06429079	296.5707378	229.4915131	645.4883053	0	171.583404	287.1940708	373.2475639	117.4283325	395.1034024	173.8025343	223.8036308	227.2627804	237.2766073	11.50398152	524.041393	118.0220592
B_Man	579.1917792	215.6909965	174.9377306	113.9347053	220.2350959	256.6196635	180.5112237	215.7540128	115.0107875	642.9661022	171.583404	0	350.5290729	325.8789831	103.0921068	458.4889264	297.026862	107.6308205	114.0526919	255.7211855	178.6320247	480.7586826	101.0476642
B_Buc	453.281917	565.6671777	291.2766683	288.7564732	556.7400286	174.8259873	296.1070354	552.4163781	290.5673499	375.1553298	287.1940708	350.5290729	0	647.5881137	376.4810212	110.5736887	142.4232793	292.6227258	288.9514334	523.1811279	295.7548694	802.5766867	375.8541795
B_Pop	894.8579535	170.3279654	371.0056906	436.7859631	111.1984158	500.3938429	369.148089	115.3317011	437.3419543	968.0546954	373.2475639	325.8789831	647.5881137	0	271.1275758	758.1110184	547.0438539	430.3220885	436.8490617	155.978184	368.6265086	156.2652016	271.7977489
B_Ib	668.9085263	219.2648726	117.6093887	207.2868266	185.9951164	238.1725851	119.3986379	182.0089981	208.9903737	707.4602928	117.4283325	103.0921068	376.4810212	271.1275758	0	487.0257489	284.3937469	201.6465118	207.4744536	164.6532008	118.0469193	426.5155674	2.050539165
Caf_Cu	436.6594214	674.1079337	398.9015597	387.2775393	667.0596008	276.1145778	403.2720911	662.7215098	388.7768756	300.504958	395.1034024	458.4889264	110.5736887	758.1110184	487.0257489	0	236.2091784	391.8621874	387.4381884	632.0247515	403.0684216	912.972456	486.4093178
CV_Dui	578.9495952	496.9847873	176.2022159	284.4419475	470.3387344	46.69248389	178.6573109	466.3832954	286.9595848	517.5487915	173.8025343	297.026862	142.4232793	547.0438539	284.3937469	236.2091784	0	285.3517491	284.7159762	408.0132005	178.9827005	697.3992633	284.4430951
Caf_Env	471.6287676	302.0556908	228.8097421	6.464971144	321.794859	257.0880503	236.0719107	317.3642863	7.436339831	543.8484685	223.8036308	107.6308205	292.6227258	430.3220885	201.6465118	391.8621874	285.3517491	0	6.528973653	361.7392052	234.2040372	583.5198078	199.7418304
San_Med	465.2682713	308.2245152	232.3249257	0.28973094	328.2978782	257.3565173	239.6343378	323.8685145	2.361304958	537.5256982	227.2627804	114.0526919	288.9514334	436.8490617	207.4744536	387.4381884	284.7159762	6.528973653	0	367.9172805	237.7774853	590.0246399	205.5809105
Med_Nei	832.2134357	225.1508795	233.8280044	367.7607938	148.4368137	362.2755648	230.225531	148.0801541	369.1743527	868.9386919	237.2766073	255.7211855	523.1811279	155.978184	164.6532008	632.0247515	408.0132005	361.7392052	367.9172805	0	230.1696116	292.5771379	166.2332023
Audi_Bog	659.3402532	337.2676796	5.963084213	237.50497	298.5017359	132.6446801	1.922702528	294.868414	239.990119	655.6843269	11.50398152	178.6320247	295.7548694	368.6265086	118.0469193	403.0684216	178.9827005	234.2040372	237.7774853	230.1696116	0	518.4182824	118.828473
Hos_Nar	1042.403369	300.3790266	521.3291104	589.9788675	261.7295753	651.0082038	518.747528	266.1562838	590.3743367	1123.575221	524.041393	480.7586826	802.5766867	156.2652016	426.5155674	912.972456	697.3992633	583.5198078	590.0246399	292.5771379	518.4182824	0	427.2766364
Cli_Med	667.1636441	218.5719427	118.2946528	205.3941277	186.0256606	238.2754753	120.2017319	182.0169593	207.0900182	706.208905	118.0220592	101.0476642	375.8541795	271.7977489	2.050539165	486.4093178	284.4430951	199.7418304	205.5809105	166.2332023	118.828473	427.2766364	0;

end;