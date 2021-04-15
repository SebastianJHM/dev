/*CONJUNTOS*/
set BOD:={1..9};
set CLI:={1..9};
set MES:={1..6};
set PLA:={1,2,3};

/*PARÁMETROS */
param b{BOD,CLI};
param CostoBC{BOD,CLI};
param km{BOD,CLI};
param CostoB{BOD};
param DemC{CLI,MES};
param CapB{BOD};
param CapP{PLA};

/*VARIABLES DE DESICIÓN*/
var x{BOD},binary;
var y{BOD,CLI},binary;
var z{BOD,CLI,MES},>=0;

var w{PLA,BOD},binary;
var t{PLA,BOD},>=0;

/*FUNCIÓN OBJETIVO*/
minimize FO: sum{bod in BOD}CostoB[bod]*x[bod] + sum{bod in BOD, cli in CLI}CostoBC[bod,cli]*km[bod,cli]*y[bod,cli]+ sum{bod in BOD, cli in CLI,mes in MES}0.5*km[bod,cli]*z[bod,cli,mes];

s.t. r1{bod in BOD, cli in CLI}: y[bod,cli] <= x[bod];
#s.t. r2{bod in BOD, cli in CLI}: y[bod,cli] <= b[bod,cli];
#s.t. r3{cli in CLI}: sum{bod in BOD}y[bod,cli] = 2;
s.t. r4{bod in BOD, cli in CLI, mes in MES}: z[bod,cli,mes] <= 1000*y[bod,cli];
s.t. r5{cli in CLI, mes in MES}: sum{bod in BOD}z[bod,cli,mes] = DemC[cli,mes];
s.t. r6{bod in BOD, mes in MES}: sum{cli in CLI}z[bod,cli,mes] <= CapB[bod];

s.t. r7{bod in BOD,cli in CLI,mes in MES}: z[bod,cli,mes] <= 0.5 * DemC[cli,mes] * y[bod,cli];



solve;

display x;

printf: "\n";
printf: "\n";
printf: "-----------------------------------------\n";
printf: "          SOLUCIÓN DEL EJERCICIO\n";
printf: "        ------------------------------ \n";

printf: "\nFunción objetivo: "&FO.val&"\n\n";

for{mes in MES}{
	printf: "\nMes: "&mes&"\n";
	for{cli in CLI}{
	for {bod in BOD:z[bod,cli,mes]>0}{
		printf: "De la bodega "&bod&" al cliente "&cli&" la cantidad de "&z[bod,cli,mes]&"\n";
	}
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

param CapP:=
1 950
2 1000
3 900;


param b:
  1 2 3 4 5 6 7 8 9:=
1 1 0 1 0 1 0 1 0 0
2 0 1 0 1 0 1 0 0 0
3 1 0 1 0 0 0 1 1 1
4 0 1 0 1 0 0 1 0 0
5 1 0 0 0 1 1 1 0 0
6 0 1 0 0 1 1 0 1 0
7 1 0 1 0 1 0 1 0 0
8 0 1 1 0 0 1 0 1 1
9 0 0 1 0 0 0 0 1 1;

param CostoB:=
1 10200
2 15800
3 18100
4 13000
5 11200
6 12700
7 14100
8 13500
9 13600;

param km: 1 2 3 4 5 6 7 8 9:=
1 22 52 36 52 29 59 39 64 67
2 66 43 60 50 70 38 69 68 64
3 28 58 33 67 60 54 28 46 46
4 55 46 72 47 69 51 24 71 62
5 45 71 55 52 24 24 28 53 67
6 59 49 71 54 42 39 57 44 52
7 20 51 31 61 24 52 35 53 63
8 54 36 48 66 67 20 54 26 47
9 58 51 33 54 72 65 51 25 39;

param CapB:=
1 1154
2 1111
3 1066
4 1316
5 1076
6 1026
7 1475
8 1444
9 1360;

param DemC:1 2 3 4 5 6:=
1 201 250 142 123 262 271
2 397 454 318 325 483 467
3 239 319 198 184 304 294
4 226 280 166 147 292 303
5 227 275 178 177 290 311
6 238 288 158 178 302 320
7 299 367 230 244 380 353
8 261 313 203 190 320 324
9 352 412 296 263 428 437;

param CostoBC: 1 2 3 4 5 6 7 8 9:=
1 0.8 0.05 0.45 0.1 0.25 0.15 0.25 0.15 0.35
2 0.25 0.5 0.2 0.2 0.35 0.1 0.2 0.45 0.35
3 0.3 0.5 0.25 0.25 0.25 0.4 0.5 0.5 0.1
4 0.3 0.3 0.15 0.5 0.3 0.5 0.4 0.35 0.15
5 0.25 0.4 0.1 0.3 0.45 0.4 0.25 0.5 0.3
6 0.1 0.5 0.15 0.1 0.25 0.4 0.35 0.25 0.5
7 0.15 0.05 0.4 0.45 0.35 0.15 0.25 0.45 0.4
8 0.5 0.5 0.2 0.35 0.35 0.35 0.1 0.05 0.15
9 0.45 0.1 0.15 0.05 0.25 0.25 0.3 0.15 0.15;
end;