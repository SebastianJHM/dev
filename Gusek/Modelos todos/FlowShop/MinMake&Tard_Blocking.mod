/*MULTIOBJETIVO: MINIMIZAR TARDANZA  y  MAKESPAN CON BLOCKING EN FLOWSHOP*/

param num_trabajos:= 5;
param num_maquinas:= 4;

/*Conjuntos*/
set J:={1..num_trabajos};         /*Trabajos*/
set M:={1..num_maquinas};         /*M?quinas*/
set P:=J;                         /*Posiciones de cada trabajo*/

/*Par?matros*/

param TP{J,M};                   /*Tiempos de procesamiento del trabajo j in J en la m?quina m in M*/
param Due_Date{J};                /*Tiempo de entrega m?ximo del trabajo j in J*/

/*Variables*/
var x{J,P},binary;               /*1 Si la m?quina j in J se asigna a la posici?n p in P*/
var T_Inicio{P,M};               /*Tiempo de inicio del trabajo en la posici?n p in P en la m?quina m in M*/
var T_Final{P,M};                /*Tiempo final del trabajo en la posici?n p in P en la m?quina m in M*/
var T_Terminacion{J}, >= 0;      /*Tiempo de terminaci?n del trabajo j in J*/
var Makespan;                    /*Tiempo final del trabajo j in J en la m?quina m in M*/
var Tardanza{J},>=0;             /*Tardanza del trabajo j in J*/
var Tardanza_Total;

/*Funci?n Objetivo*/
minimize FO:100000000*Tardanza_Total+Makespan;

/*Restricciones*/
s.t. res1 {p in P}: sum{j in J} x[j,p] = 1;
s.t. res2 {j in J}: sum{p in P} x[j,p] = 1;

s.t. res3 {p in P, m in M}: T_Final[p,m] = T_Inicio[p,m] + sum{j in J} x[j,p]*TP[j,m];
s.t. res4 {p in P, m in M: m > 1}: T_Inicio[p,m] = T_Final[p,m-1];
s.t. res5 {p in P, m in M: p > 1}: T_Inicio[p,m] >= T_Final[p-1,m];
s.t. res6: T_Inicio[1,1] = 0;
s.t. res7: Makespan = T_Final[card(P),card(M)];

s.t. res8 {j in J, p in P}: T_Terminacion[j] >= T_Final[p,card(M)] - 10000*(1-x[j,p]);
s.t. res9{j in J, p in P}: T_Terminacion[j] <= T_Final[p,card(M)] + 10000*(1-x[j,p]);
s.t. res10{j in J}: Tardanza[j] >= T_Terminacion[j] - Due_Date[j];
s.t. res11: Tardanza_Total = sum{j in J} Tardanza[j];

# s.t. res111: x[1,1] = 1;
# s.t. res112: x[4,2] = 1;
# s.t. res113: x[5,3] = 1;
# s.t. res114: x[2,4] = 1;
# s.t. res115: x[3,5] = 1;
solve;

printf: "\n";
printf: "\n";
printf: "\-------------------------------------\n";
printf: "\       SOLUCI?N DEL EJERCICIO\n";
printf: "\       ---------------------- \n";

printf: "\Makespan: "&Makespan&"\n";
printf: "\Tardanza: "&Tardanza_Total&"\n";

printf: "\nSecuencia: ";
for{p in P}{
	for {j in J:x[j,p]=1}{
		printf:j&"  ";
	}
}
printf: "\n";
printf: "\------------------------\n";
for{p in P}{
printf: "Posici?n: "&p;
for {j in J:x[j,p]=1}{
printf: " .... Trabajo: "&j&"\n";
}
for{m in M}{
printf: "Inicio m?quina "&m&": "&round(T_Inicio[p,m])&" --> Fin m?quina "&m&": "&round(T_Final[p,m])&"\n";
}
printf: "\n";
}
printf: "\-------------------------------------\n";
for {j in J}{
printf: "Trabajo "&j&": "&round(T_Terminacion[j])&" "&round(Tardanza[j])&"\n";
}
printf: "\n";
printf: "\n";
printf: "\n";


data;

param TP: 1 2 3 4:=
1 1 13 6 2
2 10 12 18 18
3 17 9 13 4
4 12 17 2 6
5 11 3 5 16;

param Due_Date:=
1 20
2 75
3 45
4 34
5 41;

end;