#Conjuntos
set A;
set B;
set C;
set D;
set E;
set F;
set G;
set H;

#Parámetros
param P1{E,E};
param P2{A,F};
param P3{A,F};
param P4{B};
param P5{B,G};
param P6{B};
param P7{F,G,B};
param P8{C};
param P9{C};
param P10{C,H};
param P11{C};
param P12{C,G,H};
param P13{H};
param P14{D,G};

#Variables
var x{C,H},binary;
var y{C},binary;
var z{B},binary;
var pl1{A,B},binary;
var pl2{A,B,F},>=0,integer;
var lc1{B,C},binary;
var lc2{B,C,G},>=0;
var lc3{B,G},>=0;
var lc4{B,F},>=0;
var cc1{C,D,H},binary;
var cc2{C,D},binary;
var cc3{C,D,G,H},>=0;
var cc4{C,D,G},>=0;
var cc5{C,G,H};
var c1,>=0;
var c2,>=0;
var c3,>=0;
var c4,>=0;
var c5,>=0;
var c6,>=0;
var c7,>=0;
var c8,>=0;
var v1{A,B}, integer, >=0;
var v2{B,C}, integer, >=0;
var v3{C,D}, integer, >=0;

#Función de objetivo
minimize FO: c1+c2+c3+c4+c5+c6+c7+c8;

#Costos de función objetivo
subj to res100: c1 = sum{a in A, f in F,b in B}P3[a,f]*pl2[a,b,f];
subj to res101: c2 = sum{b in B}P4[b] * z[b];
subj to res102: c3 = sum{b in B,g in G}P5[b,g]*lc3[b,g];
subj to res103: c4 = sum{c in C,h in H} P10[c,h]*x[c,h];
subj to res104: c5 = sum{c in C} P11[c]*y[c];
subj to res105: c6 = sum{c in C,g in G,h in H}P12[c,g,h]*cc5[c,g,h];
subj to res106: c7 = sum{a in A,b in B,f in F}25*pl2[a,b,f]*P1[a,b] +  sum{b in B,c in C,g in G}35*lc2[b,c,g]*P1[b,c] + sum{c in C,d in D,g in G}35*cc4[c,d,g]*P1[c,d];
subj to res107: c8 = sum{a in A,b in B}100*v1[a,b]*P1[a,b] + sum{b in B,c in C}100*v2[b,c]*P1[b,c] + sum{c in C,d in D}100*v3[c,d]*P1[c,d];
subj to res1071{a in A,b in B}: v1[a,b] >=  (sum{f in F}pl2[a,b,f])/1200;
subj to res1072{b in B,c in C}: v2[b,c] >= (sum{g in G}lc2[b,c,g])/1200;
subj to res1073{c in C,d in D}:v3[c,d] >= (sum{g in G}cc4[c,d,g])/1200;

subj to res1{c in C}: x[c,1] <= P8[c];
subj to res2{c in C}: x[c,2] <= P9[c];
subj to res3{c in C}: x[c,1] + x[c,2] <= 1;
subj to res4{c in C}: y[c] = x[c,1] + x[c,2];
subj to res5{a in A, b in B}: pl1[a,b] <= z[b];
subj to res6{a in A, b in B, f in F}: pl2[a,b,f] <= 99999*pl1[a,b];
subj to res7{a in A, b in B}: pl1[a,b] <= sum{f in F}pl2[a,b,f];
subj to res8{a in A, f in F}: sum{b in B} pl2[a,b,f] <= P2[a,f];
subj to res9{a in A}: sum{b in B}pl1[a,b] <= 3;
subj to res10{b in B}: sum{a in A,f in F} pl2[a,b,f] <= P6[b];
subj to res12{b in B, f in F}: lc4[b,f] = sum{a in A} pl2[a,b,f];
subj to res13{b in B, f in F}: lc4[b,f] = sum{g in G} P7[f,g,b] * lc3[b,g];
subj to res14{b in B, c in C}: lc1[b,c] <= z[b];
subj to res15{b in B, c in C}: lc1[b,c] <= y[c];
subj to res16{b in B, c in C, g in G}: lc2[b,c,g] <= 99999*lc1[b,c];
subj to res17{b in B, c in C}: lc1[b,c] <= sum{g in G}lc2[b,c,g];
subj to res18{b in B, g in G}: sum{c in C}lc2[b,c,g] = lc3[b,g];
subj to res19{c in C, d in D,h in H}: cc1[c,d,h] <= x[c,h];
subj to res20{c in C, d in D, g in G,h in H}: cc3[c,d,g,h] <= 99999*cc1[c,d,h];
subj to res21{c in C, d in D}: cc2[c,d] = sum{h in H}cc1[c,d,h];
subj to res22{c in C, d in D,g in G}: cc4[c,d,g] = sum{h in H}cc3[c,d,g,h];
subj to res23{c in C, h in H}: sum{d in D,g in G}cc3[c,d,g,h] <= P13[h];
subj to res24{d in D}: sum{c in C}cc2[c,d] = 1;
subj to res25{d in D, g in G}: sum{c in C}cc4[c,d,g] >= P14[d,g];
subj to res26{c in C,g in G}: sum{d in D}cc4[c,d,g] = sum{b in B}lc2[b,c,g];
subj to res27{c in C,g in G,h in H}: cc5[c,g,h] = sum{d in D}cc3[c,d,g,h];

solve;
printf: "\n\n";
printf: "FO: "&FO&"\n\n";
printf: "c1: "&c1&"\n";
printf: "c2: "&c2&"\n";
printf: "c3: "&c3&"\n";
printf: "c4: "&c4&"\n";
printf: "c5: "&c5&"\n";
printf: "c6: "&c6&"\n";
printf: "c7: "&c7&"\n";
printf: "c8: "&c8&"\n";

printf: "\n\n";
for{h in H}{
	for{c in C:x[c,h]=1}{
		printf: "x["&c&","&h&"]=1\n";
	}
}
printf: "\n\n";
for{b in B:z[b]=1}{
	printf: "z["&b&"]\n";
}
printf: "\n\n";
for{a in  A}{
	for{b in B:pl1[a,b]=1}{
		printf: "pl1["&a&","&b&"]=1\n";
		for{f in F}{
			printf: "pl2["&a&","&b&","&f&"] = "&pl2[a,b,f]&"\n";
		}
		printf: "\n";
	}
}
printf: "\n\n";
for{b in B}{
	for{c in C:lc1[b,c]=1}{
		printf: "lc1["&b&","&c&"]=1\n";
		for{g in G}{
			printf: "lc2["&b&","&c&","&g&"] = "&lc2[b,c,g]&"\n";
		}
		printf: "\n";
	}
}
printf: "\n\n";
for{c in C}{
	for{d in D:cc2[c,d]=1}{
		printf: "cc2["&c&","&d&"]=1\n";
		for{g in G}{
			printf: "cc4["&c&","&d&","&g&"] = "&cc4[c,d,g]&"\n";
		}
		printf: "\n";
	}
}
printf: "\n------------------------\n";
printf: "\n";
printf: "\n";
printf: "\n";

data;

set A:=	PuertoCartagena	PuertoBuenaventura	AeropuertoElDorado	Ecar	QuimicosDelValle	DiscolmedicaTunja;
set B:=	Eurofarma	Lafrancol	Aoxlab	LaboratoriosDelfos;
set C:=	BodegaSiberia	BodegaManizales	BodegaBucaramanga	BodegaPopayan	BodegaIbague;
set D:=	CafamCucuta	CruzVerdeDuitama	CafamEnvigado	SanitasMedellin	MedimasNeiva	AudifarmaBogota	HospitalNarino	ClinicaMedicadiz;
set E:= PuertoCartagena	PuertoBuenaventura	AeropuertoElDorado	Ecar	QuimicosDelValle	DiscolmedicaTunja	Eurofarma	Lafrancol	Aoxlab	LaboratoriosDelfos	BodegaSiberia	BodegaManizales	BodegaBucaramanga	BodegaPopayan	BodegaIbague	CafamCucuta	CruzVerdeDuitama	CafamEnvigado	SanitasMedellin	MedimasNeiva	AudifarmaBogota	HospitalNarino	ClinicaMedicadiz;
set F:=	 Analgesicos  Antibioticos  Anestesicos   Excipientes;
set G:= Comprimidos  Tabletas  Capsulas;
set H:=	1	2;

param P2:	Analgesicos	Antibioticos	Anestesicos	Excipientes:=
		PuertoCartagena	4900	2300	2200	12900
		PuertoBuenaventura	5000	1900	2100	13800
		AeropuertoElDorado	4500	1700	1300	10700
		Ecar	3980	1530	120	13228
		QuimicosDelValle	4460	1840	160	11140
		DiscolmedicaTunja	3740	1700	230	9682;

param P3:	Analgesicos	Antibioticos	Anestesicos	Excipientes:=
		PuertoCartagena	2025	2475	2325	1950
		PuertoBuenaventura	2175	2025	2400	1875
		AeropuertoElDorado	2100	2400	2475	1500
		Ecar	2400	2475	1875	1875
		QuimicosDelValle	1950	1950	2400	1875
		DiscolmedicaTunja	2250	2400	2400	1575;

param P4:=
Eurofarma	127472357
Lafrancol	122091276
Aoxlab	137736165
LaboratoriosDelfos	134297519;

param P5:	Comprimidos	Tabletas	Capsulas:=
				Eurofarma	750	710	720
				Lafrancol	840	840	890
				Aoxlab	740	760	710
				LaboratoriosDelfos	770	730	730;

param P6:=
Eurofarma	25000
Lafrancol	22000
Aoxlab	21000
LaboratoriosDelfos	25000;

param P7:=
	[*,*,Eurofarma]:	Comprimidos	Tabletas	Capsulas:=
		Excipientes	0.62	0.7	0.55
		Analgesicos	0.38	0.23	0.25
		Antibioticos	0	0	0.2
		Anestesicos	0	0.07	0
	[*,*,Lafrancol]:	Comprimidos	Tabletas	Capsulas:=
		Excipientes	0.62	0.7	0.55
		Analgesicos	0.38	0.23	0.25
		Antibioticos	0	0	0.2
		Anestesicos	0	0.07	0
	[*,*,Aoxlab]:	Comprimidos	Tabletas	Capsulas:=
		Excipientes	0.62	0.7	0.55
		Analgesicos	0.38	0.23	0.25
		Antibioticos	0	0	0.2
		Anestesicos	0	0.07	0
	[*,*,LaboratoriosDelfos]:	Comprimidos	Tabletas	Capsulas:=
		Excipientes	0.65	0.75	0.5
		Analgesicos	0.35	0.2	0.24
		Antibioticos	0	0	0.26
		Anestesicos	0	0.05	0;










param P8:=
BodegaSiberia	1
BodegaManizales	1
BodegaBucaramanga	0
BodegaPopayan	1
BodegaIbague	1;

param P9:=
BodegaSiberia	0
BodegaManizales	0
BodegaBucaramanga	1
BodegaPopayan	1
BodegaIbague	1;

param P10:	1	2:=
		BodegaSiberia	116360000	0
		BodegaManizales	107080000	0
		BodegaBucaramanga	0	174210000
		BodegaPopayan	105420000	164830000
		BodegaIbague	112610000	158590000;

param P11:=
BodegaSiberia	9132000
BodegaManizales	9383000
BodegaBucaramanga	9432000
BodegaPopayan	11321000
BodegaIbague	11393000;

param P12:=
	[*,*,1]:	Comprimidos	Tabletas	Capsulas:=
		BodegaSiberia	320	320	350
		BodegaManizales	180	180	210
		BodegaBucaramanga	0	0	0
		BodegaPopayan	245	245	280
		BodegaIbague	210	210	250
	[*,*,2]:	Comprimidos	Tabletas	Capsulas:=
		BodegaSiberia	0	0	0
		BodegaManizales	0	0	0
		BodegaBucaramanga	200	200	240
		BodegaPopayan	165	165	180
		BodegaIbague	170	170	190;

param P13:=
1	18000
2	25500;

param P14:
		Comprimidos	Tabletas	Capsulas:=
CafamCucuta	2000	2400	2100
CruzVerdeDuitama	1700	2100	2100
CafamEnvigado	1700	2500	2100
SanitasMedellin	2100	2500	2100
MedimasNeiva	1900	1800	2900
AudifarmaBogota	1900	2200	2900
HospitalNarino	1900	2100	2400
ClinicaMedicadiz	1900	2400	2400;

param P1:	PuertoCartagena	PuertoBuenaventura	AeropuertoElDorado	Ecar	QuimicosDelValle	DiscolmedicaTunja	Eurofarma	Lafrancol	Aoxlab	LaboratoriosDelfos	BodegaSiberia	BodegaManizales	BodegaBucaramanga	BodegaPopayan	BodegaIbague	CafamCucuta	CruzVerdeDuitama	CafamEnvigado	SanitasMedellin	MedimasNeiva	AudifarmaBogota	HospitalNarino	ClinicaMedicadiz:=
PuertoCartagena	0	744.6590802	653.4021178	465.4005071	783.8717777	591.1688215	660.7268406	779.6460024	464.2216965	249.5391692	647.8890313	579.1917792	453.281917	894.8579535	668.9085263	436.6594214	578.9495952	471.6287676	465.2682713	832.2134357	659.3402532	1042.403369	667.1636441
PuertoBuenaventura	744.6590802	0	336.8637432	308.2494719	79.31424512	452.1973249	338.5837503	78.44553364	308.002443	845.1731259	336.5380023	215.6909965	565.6671777	170.3279654	219.2648726	674.1079337	496.9847873	302.0556908	308.2245152	225.1508795	337.2676796	300.3790266	218.5719427
AeropuertoElDorado	653.4021178	336.8637432	0	232.051414	299.4037897	129.6946502	7.560021744	295.7190804	234.5459078	650.3831187	5.540990468	174.9377306	291.2766683	371.0056906	117.6093887	398.9015597	176.2022159	228.8097421	232.3249257	233.8280044	5.963084213	521.3291104	118.2946528
Ecar	465.4005071	308.2494719	232.051414	0	328.2529509	257.0720408	239.3616171	323.8229894	2.651016628	537.5231498	226.9883443	113.9347053	288.7564732	436.7859631	207.2868266	387.2775393	284.4419475	6.464971144	0.28973094	367.7607938	237.50497	589.9788675	205.3941277
QuimicosDelValle	783.8717777	79.31424512	299.4037897	328.2529509	0	424.0080367	299.4836481	4.481676233	328.6448205	863.0404569	300.3016827	220.2350959	556.7400286	111.1984158	185.9951164	667.0596008	470.3387344	321.794859	328.2978782	148.4368137	298.5017359	261.7295753	186.0256606
DiscolmedicaTunja	591.1688215	452.1973249	129.6946502	257.0720408	424.0080367	0	132.3937433	420.0809916	259.680678	547.8422737	127.1829616	256.6196635	174.8259873	500.3938429	238.1725851	276.1145778	46.69248389	257.0880503	257.3565173	362.2755648	132.6446801	651.0082038	238.2754753
Eurofarma	660.7268406	338.5837503	7.560021744	239.3616171	299.4836481	132.3937433	0	295.8649441	241.8486716	656.4742111	13.06429079	180.5112237	296.1070354	369.148089	119.3986379	403.2720911	178.6573109	236.0719107	239.6343378	230.225531	1.922702528	518.747528	120.2017319
Lafrancol	779.6460024	78.44553364	295.7190804	323.8229894	4.481676233	420.0809916	295.8649441	0	324.2204597	858.5642109	296.5707378	215.7540128	552.4163781	115.3317011	182.0089981	662.7215098	466.3832954	317.3642863	323.8685145	148.0801541	294.868414	266.1562838	182.0169593
Aoxlab	464.2216965	308.002443	234.5459078	2.651016628	328.6448205	259.680678	241.8486716	324.2204597	0	537.5811266	229.4915131	115.0107875	290.5673499	437.3419543	208.9903737	388.7768756	286.9595848	7.436339831	2.361304958	369.1743527	239.990119	590.3743367	207.0900182
LaboratoriosDelfos	249.5391692	845.1731259	650.3831187	537.5231498	863.0404569	547.8422737	656.4742111	858.5642109	537.5811266	0	645.4883053	642.9661022	375.1553298	968.0546954	707.4602928	300.504958	517.5487915	543.8484685	537.5256982	868.9386919	655.6843269	1123.575221	706.208905
BodegaSiberia	647.8890313	336.5380023	5.540990468	226.9883443	300.3016827	127.1829616	13.06429079	296.5707378	229.4915131	645.4883053	0	171.583404	287.1940708	373.2475639	117.4283325	395.1034024	173.8025343	223.8036308	227.2627804	237.2766073	11.50398152	524.041393	118.0220592
BodegaManizales	579.1917792	215.6909965	174.9377306	113.9347053	220.2350959	256.6196635	180.5112237	215.7540128	115.0107875	642.9661022	171.583404	0	350.5290729	325.8789831	103.0921068	458.4889264	297.026862	107.6308205	114.0526919	255.7211855	178.6320247	480.7586826	101.0476642
BodegaBucaramanga	453.281917	565.6671777	291.2766683	288.7564732	556.7400286	174.8259873	296.1070354	552.4163781	290.5673499	375.1553298	287.1940708	350.5290729	0	647.5881137	376.4810212	110.5736887	142.4232793	292.6227258	288.9514334	523.1811279	295.7548694	802.5766867	375.8541795
BodegaPopayan	894.8579535	170.3279654	371.0056906	436.7859631	111.1984158	500.3938429	369.148089	115.3317011	437.3419543	968.0546954	373.2475639	325.8789831	647.5881137	0	271.1275758	758.1110184	547.0438539	430.3220885	436.8490617	155.978184	368.6265086	156.2652016	271.7977489
BodegaIbague	668.9085263	219.2648726	117.6093887	207.2868266	185.9951164	238.1725851	119.3986379	182.0089981	208.9903737	707.4602928	117.4283325	103.0921068	376.4810212	271.1275758	0	487.0257489	284.3937469	201.6465118	207.4744536	164.6532008	118.0469193	426.5155674	2.050539165
CafamCucuta	436.6594214	674.1079337	398.9015597	387.2775393	667.0596008	276.1145778	403.2720911	662.7215098	388.7768756	300.504958	395.1034024	458.4889264	110.5736887	758.1110184	487.0257489	0	236.2091784	391.8621874	387.4381884	632.0247515	403.0684216	912.972456	486.4093178
CruzVerdeDuitama	578.9495952	496.9847873	176.2022159	284.4419475	470.3387344	46.69248389	178.6573109	466.3832954	286.9595848	517.5487915	173.8025343	297.026862	142.4232793	547.0438539	284.3937469	236.2091784	0	285.3517491	284.7159762	408.0132005	178.9827005	697.3992633	284.4430951
CafamEnvigado	471.6287676	302.0556908	228.8097421	6.464971144	321.794859	257.0880503	236.0719107	317.3642863	7.436339831	543.8484685	223.8036308	107.6308205	292.6227258	430.3220885	201.6465118	391.8621874	285.3517491	0	6.528973653	361.7392052	234.2040372	583.5198078	199.7418304
SanitasMedellin	465.2682713	308.2245152	232.3249257	0.28973094	328.2978782	257.3565173	239.6343378	323.8685145	2.361304958	537.5256982	227.2627804	114.0526919	288.9514334	436.8490617	207.4744536	387.4381884	284.7159762	6.528973653	0	367.9172805	237.7774853	590.0246399	205.5809105
MedimasNeiva	832.2134357	225.1508795	233.8280044	367.7607938	148.4368137	362.2755648	230.225531	148.0801541	369.1743527	868.9386919	237.2766073	255.7211855	523.1811279	155.978184	164.6532008	632.0247515	408.0132005	361.7392052	367.9172805	0	230.1696116	292.5771379	166.2332023
AudifarmaBogota	659.3402532	337.2676796	5.963084213	237.50497	298.5017359	132.6446801	1.922702528	294.868414	239.990119	655.6843269	11.50398152	178.6320247	295.7548694	368.6265086	118.0469193	403.0684216	178.9827005	234.2040372	237.7774853	230.1696116	0	518.4182824	118.828473
HospitalNarino	1042.403369	300.3790266	521.3291104	589.9788675	261.7295753	651.0082038	518.747528	266.1562838	590.3743367	1123.575221	524.041393	480.7586826	802.5766867	156.2652016	426.5155674	912.972456	697.3992633	583.5198078	590.0246399	292.5771379	518.4182824	0	427.2766364
ClinicaMedicadiz	667.1636441	218.5719427	118.2946528	205.3941277	186.0256606	238.2754753	120.2017319	182.0169593	207.0900182	706.208905	118.0220592	101.0476642	375.8541795	271.7977489	2.050539165	486.4093178	284.4430951	199.7418304	205.5809105	166.2332023	118.828473	427.2766364	0;
end;