import sys
import random
import funciones_objetivo as fo
import copy
import numpy as np
import matplotlib.pyplot as plt
from leer_instancias import read_data_XLSX
import xlsxwriter
import time
from print_XLSX import print_results_XLSX

class Solucion:
    def __init__(self, sec = None, makespan = None, tardanza = None):
        self.secuencia = sec
        self.makespan = makespan
        self.tardanza = tardanza
    #fed
    def __str__(self):
        return "{Sec: %s, Makespan: %s, Tardiness: %s}" % (self.secuencia, self.makespan, self.tardanza)
    #fed
    def __repr__(self):
        return str(self)
    #fed
#ssalc

def solucion_aleatoria( n ):
    sol = []
    verifica = [False] * n
    for _ in range(n):
        x = random.randint(1, n)
        while( verifica[x-1] == True ):
            x = random.randint(1, n)
        #elihw
        sol.append(x)
        verifica[x-1] = True
    
    return(sol)
#fed

def mutar(c, i, j):
    m = copy.deepcopy(c)
    aux = m[i]
    m[i] = m[j]
    m[j] = aux
    return m
#fed


def domina(s1, s2, TP, due_date):
    fo1_s1 = fo.calcular_makespan_blocking_secuencia(s1, TP)
    fo2_s1 = fo.calcular_tardanza_blocking_secuencia(s1, TP, due_date)
    fo1_s2 = fo.calcular_makespan_blocking_secuencia(s2, TP)
    fo2_s2 = fo.calcular_tardanza_blocking_secuencia(s2, TP, due_date)
    #print("x: ", fo1_x, fo2_x, "; y: ", fo1_y, fo2_y)
    s1_domina_s2 = False
    if(( fo1_s1 <= fo1_s2 and fo2_s1 < fo2_s2 ) or ( fo1_s1 < fo1_s2 and fo2_s1 <= fo2_s2 )):
        s1_domina_s2 = True
    
    return s1_domina_s2
#fed

def Graficar_Archivo(arch):
    x = [a.makespan for a in arch]
    y = [a.tardanza for a in arch]
    
    ## Cuadrícula
    if( len(x) > 1):
        fig = plt.figure()
        ax = fig.gca()
        ax.set_xticks(np.arange(min(x), max(x)+1, (max(x)-min(x))/5 ))
        ax.set_yticks(np.arange(min(y), max(y)+1, (max(y)-min(y))/5 ))
        plt.grid()
    else:
        fig = plt.figure()
        ax = fig.gca()
        ax.set_xticks(np.arange(min(x), max(x)+1))
        ax.set_yticks(np.arange(min(y), max(y)+1))
        plt.grid()
    
        
    ## Graficar
    plt.scatter(x, y)
    
    ## Títulos
    plt.title('MAKESPAN vs TARDINESS')
    plt.xlabel("Makespan")
    plt.ylabel("Tardiness")
    
    ## Nombre de los puntos
    for i in range(len(x)):
        plt.annotate(str(i)+": ("+str(x[i])+","+str(y[i])+")", (x[i]+.2, y[i]))
    
        
    plt.show()

#fed

def concurrido( arch, c, m ):
    
    print("**************************************************************")
    # Graficar_Archivo(arch)
    makespan_list = [a.makespan for a in arch]
    tardiness_list= [a.tardanza for a in arch]
    print(makespan_list, tardiness_list)
    
    ## Obtener el makespan y la tardanza de c y de m
    for a in arch:
        if( a.secuencia == c ):
            makespan_c = a.makespan
            tardanza_c = a.tardanza
        
        if( a.secuencia == m):
            makespan_m = a.makespan
            tardanza_m = a.tardanza
        
    
    
    ## Obtener sup_makespan_c y inf_makespan_c
    if(makespan_c == max(makespan_list)):
        menores = []
        for a in arch:
            if(a.makespan<makespan_c):
                menores.append(a.makespan)
            
        
        sup_makespan_c = makespan_c
        inf_makespan_c = max(menores)
    elif(makespan_c == min(makespan_list)):
        mayores = []
        for a in arch:
            if(a.makespan>makespan_c):
                mayores.append(a.makespan)
            
        
        sup_makespan_c = min(mayores)
        inf_makespan_c = makespan_c
    else:
        menores = []
        mayores = []
        for a in arch:
            if(a.makespan>makespan_c):
                mayores.append(a.makespan)
            
            if(a.makespan<makespan_c):
                menores.append(a.makespan)
            
        
        sup_makespan_c = min(mayores)
        inf_makespan_c = max(menores)
    
    
    ## Obtener sup_tardanza_c y inf_tardanza_c
    if(tardanza_c == max(tardiness_list)):
        menores = []
        for a in arch:
            if(a.tardanza<tardanza_c):
                menores.append(a.tardanza)
            
        
        sup_tardanza_c = tardanza_c
        inf_tardanza_c = max(menores)
    elif(tardanza_c == min(tardiness_list)):
        mayores = []
        for a in arch:
            if(a.tardanza>tardanza_c):
                mayores.append(a.tardanza)
            
        
        sup_tardanza_c = min(mayores)
        inf_tardanza_c = tardanza_c
    else:
        menores = []
        mayores = []
        for a in arch:
            if(a.tardanza>tardanza_c):
                mayores.append(a.tardanza)
            
            if(a.tardanza<tardanza_c):
                menores.append(a.tardanza)
            
        
        sup_tardanza_c = min(mayores)
        inf_tardanza_c = max(menores)
    
    
    ## Obtener sup_makespan_m y inf_makespan_m
    if(makespan_m == max(makespan_list)):
        menores = []
        for a in arch:
            if(a.makespan<makespan_m):
                menores.append(a.makespan)
            
        
        sup_makespan_m = makespan_m
        inf_makespan_m = max(menores)
    elif(makespan_m == min(makespan_list)):
        mayores = []
        for a in arch:
            if(a.makespan>makespan_m):
                mayores.append(a.makespan)
            
        
        sup_makespan_m = min(mayores)
        inf_makespan_m = makespan_m
    else:
        menores = []
        mayores = []
        for a in arch:
            if(a.makespan>makespan_m):
                mayores.append(a.makespan)
            
            if(a.makespan<makespan_m):
                menores.append(a.makespan)
            
        
        sup_makespan_m = min(mayores)
        inf_makespan_m = max(menores)
    
    
    ## Obtener sup_tardanza_m y inf_tardanza_m
    if(tardanza_m == max(tardiness_list)):
        menores = []
        for a in arch:
            if(a.tardanza<tardanza_m):
                menores.append(a.tardanza)
            
        
        sup_tardanza_m = tardanza_m
        inf_tardanza_m = max(menores)
    elif(tardanza_m == min(tardiness_list)):
        mayores = []
        for a in arch:
            if(a.tardanza>tardanza_m):
                mayores.append(a.tardanza)
            
        
        sup_tardanza_m = min(mayores)
        inf_tardanza_m = tardanza_m
    else:
        menores = []
        mayores = []
        for a in arch:
            if(a.tardanza>tardanza_m):
                mayores.append(a.tardanza)
            
            if(a.tardanza<tardanza_m):
                menores.append(a.tardanza)
            
        
        sup_tardanza_m = min(mayores)
        inf_tardanza_m = max(menores)
    
    
    
    print("c--> make:",makespan_c," tard:", tardanza_c)
    print("(", sup_makespan_c, inf_makespan_c,"),(",sup_tardanza_c,inf_tardanza_c,")")
    print("m--> make:",makespan_m," tard:", tardanza_m)
    print("(", sup_makespan_m, inf_makespan_m,"),(",sup_tardanza_m,inf_tardanza_m,")")
    
    concurrencia_c = (sup_makespan_c-inf_makespan_c)/(max(makespan_list)-min(makespan_list)) + (sup_tardanza_c-inf_tardanza_c)/(max(tardiness_list)-min(tardiness_list))
    concurrencia_m = (sup_makespan_m-inf_makespan_m)/(max(makespan_list)-min(makespan_list)) + (sup_tardanza_m-inf_tardanza_m)/(max(tardiness_list)-min(tardiness_list))
    print(concurrencia_c, concurrencia_m)
    if(concurrencia_m < concurrencia_c):
        return(True)
    else:
        return(False)
    
#fed
    
def Dominancia(archivo_paes, TP, due_date):
    frontera_PAES = []
    for sol in archivo_paes:
        s1 = sol.secuencia
        queda_s1 = True
        for x in archivo_paes:
            s2 = x.secuencia
            if( domina(s2, s1, TP, due_date) == True ):
                queda_s1 = False
            
        
        if( queda_s1 == True ):
            frontera_PAES.append(sol)
        
    
    return(frontera_PAES)
#def

def Remover_c(archivo_paes, c):
    for a in archivo_paes:
        if( a.secuencia == c ):
            archivo_paes.remove(a)
        
    
    return(archivo_paes)
#fed

def repeticion_m(archivo_paes,m,TP,due_date):
    
    makespan_m = fo.calcular_makespan_blocking_secuencia(m, TP)
    tardanza_m = fo.calcular_tardanza_blocking_secuencia(m, TP, due_date)
    b1 = False
    b2 = False
    for a in archivo_paes:
        if( a.secuencia == m ):
            b1 = True
        
        if( a.makespan == makespan_m and a.tardanza == tardanza_m):
            b2 = True
        
    
    if(b1 == False and b2 == False):
        return(False)
    else:
        return(True)
    
#fed

def PAES(TP, due_date, num_iteraciones):

    ## Obtener número de trabajos  
    num_trabajos = len(TP)
    
    ## Crear Archivo PAES vacío inicialmente. Crear c como una solución aleatoria.
    ## Calcular Makespan y Tardanza de c. Agregar c al archivo
    archivo_paes = []
    c = solucion_aleatoria( num_trabajos )
    makespan_c = fo.calcular_makespan_blocking_secuencia(c, TP)
    tardanza_c = fo.calcular_tardanza_blocking_secuencia(c, TP, due_date)
    archivo_paes.append(Solucion(c, makespan_c, tardanza_c))
    print("Solución inicial: ", c)
    
    ## Inicializar posiciones de las que se harán el cambio. Inicializar iteraciones
    i = 0
    j = 1
    iteraciones = 1
    
    ## Mientras que se hagan todos los posibles cambios dos a dos en una solución actual
    ## o sigan habiendo iteraciones
    while( i < num_trabajos - 1 and iteraciones <= num_iteraciones ):
        print("\n============== ITERACIÓN ", iteraciones," ===============")
        ## Obtener una mutación de c y guardar en m. La mutación se realiza cambiando
        ## la posición i con j en c
        m = mutar(c,i,j)
        print("c: ",c," ; m: ", m, "pos1: ", i, "pos2: ", j)
        
        ## Ya está m en el archivo?
        ## Si m está en el archivo, entonces descartar.
        ## Si m tiene las mismas funciones objetivos que otro elemento del archivo, entonces descartar
        esta_m_Archivo_PAES = repeticion_m(archivo_paes,m,TP,due_date)
        if(esta_m_Archivo_PAES == True):
            print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
            m_domina_c = False
            pass
        else:
            ## Calcular si c domina a m
            ## Calcular si m domina a c
            ## Calcular si algún elemento del archivo domina a m
            c_domina_m = domina(c,m,TP,due_date)
            m_domina_c = domina(m,c,TP,due_date)
            arch_domina_m = False
            for x in archivo_paes:
                d = domina(x.secuencia,m,TP,due_date)
                if( d == True ):
                    arch_domina_m = True
                
            
            print("c domina a m?: ",c_domina_m, " ; m domina a c?: ",m_domina_c," ; el archivo domina a m?: ",arch_domina_m)
            
            ## Primera condición: si c domina a m, se descarta m
            ## Segunda condición: si m domina a c, se agrega m al archivo y se eleimina todos los elementos a los que también domina m
            ## Tercera condición: si alguún elemento del archivo domina a m, se descarta m.
            ## Cuarta condición: se agraga m al archivo y se revisa si m es menos concurrido que c
            if( c_domina_m == True ): ## Primera condición
                pass
            elif( m_domina_c == True ): ## Segunda condición
                makespan_m = fo.calcular_makespan_blocking_secuencia(m, TP)
                tardanza_m = fo.calcular_tardanza_blocking_secuencia(m, TP, due_date)
                archivo_paes.append(Solucion(m, makespan_m, tardanza_m))
                archivo_paes = Dominancia(archivo_paes, TP, due_date)
                c = m
                i = 0
                j = 1
            elif( arch_domina_m == True ): ## Tercera condición
                pass
            else: ## Cuarta condición
                makespan_m = fo.calcular_makespan_blocking_secuencia(m, TP)
                tardanza_m = fo.calcular_tardanza_blocking_secuencia(m, TP, due_date)
                archivo_paes.append(Solucion(m, makespan_m, tardanza_m))
                archivo_paes = Dominancia(archivo_paes, TP, due_date)
                
                ## Si m es menos concurrido que c, se convierte en la nueva solución
                conc = concurrido(archivo_paes, c, m)
                if( conc == True ):
                    print("m es la solucion actual")
                    c = m
                    i = 0
                    j = 1
                
            
        
        
        print("------------ Archivo Paes -------------")
        print(np.array(archivo_paes))

        iteraciones += 1
        if( m_domina_c != True or esta_m_Archivo_PAES == True):
            if( j < num_trabajos - 1 ):
                j = j + 1
            elif( i < num_trabajos - 1 ):
                i = i + 1
                j = i + 1
            else:
                i = i + 1
            
        
        
    #elihw
    
    ## Gráficar archivo PAES final
    Graficar_Archivo(archivo_paes)
    
    return(archivo_paes)
#fed


def principal( argv, workbook ):
    ## CREATE EXCEL FILE AND PRINT RESULTS WITH 'XLSXWRITER'
    
    INSTANCIAS = read_data_XLSX()
    for inst in INSTANCIAS:
        tp = inst.tiempos_procesamiento
        dd = inst.due_dates
        
        archivo_PAES = []
        repeticiones = 10
        ti = time.time()
        for _ in range(repeticiones):
            num_iteraciones = 10000
            arch = PAES(tp, dd, num_iteraciones)
            archivo_PAES = archivo_PAES + arch
        
        Graficar_Archivo(archivo_PAES)
        archivo_PAES = Dominancia(archivo_PAES, tp, dd)
        tiempo_ejecucion = time.time() - ti
        Graficar_Archivo(archivo_PAES)
        nombre_hoja = "Inst"+str(INSTANCIAS.index(inst)+1)
        print_results_XLSX( workbook, nombre_hoja, archivo_PAES, tiempo_ejecucion )
    
    print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
#fed

if __name__ == "__main__":
    
    ## Crear Libro de resultados
    workbook = xlsxwriter.Workbook('Results_PAES.xlsx')
    
    ti = time.time()
    principal( sys.argv, workbook )
    tt = time.time() - ti
    
    worksheet = workbook.add_worksheet("TIEMPO TOTAL")
    worksheet.merge_range(1, 1, 1, 3, "Tiempo total de ejecución")
    worksheet.merge_range(1, 4, 1, 5, round(tt,2))
    workbook.close()
