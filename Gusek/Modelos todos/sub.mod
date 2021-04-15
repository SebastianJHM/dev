set P := {1..2};
set CD := {1..5};
set CLI := {1..3};
set A{cli in CLI};

param Demanda{CLI};
param Capac{CD};

var x{P,CD}>=0;
var y{P,CD}, binary;

var z{CD,CLI}>=0;
var w{CD,CLI}, binary;

var dis{CD}, binary;

minimize FO:sum{cd in CD, cli in CLI} z[cd,cli];

s.t. r1{p in P, cd in CD}: x[p,cd] <= 100000000*y[p,cd];
s.t. r2{cd in CD, cli in CLI}: z[cd,cli] <= 100000000*w[cd,cli];

s.t. r4{cd in CD}: sum{p in P}x[p,cd] = sum{cli in CLI}z[cd,cli];

s.t. r5{cd in CD}: sum{cli in CLI}z[cd,cli] <= Capac[cd];
s.t. r3{cli in CLI}: sum{a in A[cli]}z[a,cli] >= Demanda[cli];

s.t. r8{cd in CD}: sum{cli in CLI}z[cd,cli] <= 25 + 10000000000000000*(1-dis[cd]); 
s.t. r9: sum{cd in CD} dis[cd] = 2;


solve;
display z, dis;

data;
set A[1]:= 2 3;
set A[2]:= 1 4;
set A[3]:= 1 3 5;

param Demanda:=
1	45
2	12
3	76;

param Capac:=
1	50
2	30
3	30
4	30
5	30;

end;