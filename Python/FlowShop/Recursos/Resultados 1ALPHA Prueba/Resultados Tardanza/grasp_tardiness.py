import copy
import fo_tardiness as fo
import random

def busqueda_local_GRASP( secuencia, TP, due_date, num_iteraciones ):
    minimo = 100000000000
    for iteraciones in range(num_iteraciones):
        for i in range(len(secuencia)):
            for j in range(i+1,len(secuencia)):
                s = copy.deepcopy(secuencia)
                aux = s[i]
                s[i] = s[j]
                s[j] = aux
                #print(s, calcular_makespan_blocking_secuencia(s,TP)) 
                
                f = fo.calcular_tardanza_blocking_secuencia( s ,TP, due_date )
                if( f < minimo ):
                    minimo = f
                    secuencia_aux = s
                #fi
            #rof
        #rof
        secuencia = copy.deepcopy(secuencia_aux)
        #print(minimo, secuencia_aux)
    #rof
    return(secuencia, fo.calcular_tardanza_blocking_secuencia( secuencia ,TP, due_date ))
#fed


def construccion_GRASP( TP, due_date, ALPHA ):

    ## Número de trabajos
    num_trabajos = len(TP)

    solucion = []             ## Secuencia final que será retornada
    solucion_TP = []          ## Tiempos de procesamiento de cada elemento que se guarde en solucion
    
    ## Conjunto de candidatos a ser seleccionados. Si se selecciona un candidato se removerá de candidatos
    ## y se agregará al conjunto solución. Inicialmente en candidatos estarán todos los trabajos i.e. 
    ## candidatos = {1,...,num_trabajos}
    candidatos = [ i for i in range(1,num_trabajos+1) ] 
    t = 0  ## Parámetro para mdd

    ## Pj: parámetro usado en mdd. Suma para cada trabajo el tiempo de procesamiento de cada máquina
    P = []
    for i in range(num_trabajos):
        P.append(sum(TP[i]))
    #rof
        
    # print("P: ", P, "Due date: ", due_date)
    
    ## El siguiente ciclo selecciona en cada iteración un posible trabajo para agregarlo a la solución
    ## Paso 1: Determinar conjunto de mdd para cada trabajo candidato, el mínimo de los mdd = min_mdd
    ##         y el máximo de los mdd = max_mdd
    ## Paso 2: Determinar conjunto RCL = {c in candidatos: makespan(c) < indicador}; indicador = min_mp + ALPHA * ( max_mp - min_mp )
    ## Paso 3: Seleccionar aleatoriamente un trabajo del RCL
    ## Paso 4: Agregrar el trabajo escogido a solución, agregar los tiempos de procesamiento del trabajo
    ## escogido a solucion_TP y remover el elemento de candidatos
    for it in range(num_trabajos):
        MMD = []  ## conjunto donde se almacenará el MMD de cada trabajo candidato
        min_mdd = 100000000000     ## variable que guardará el mínimo de los makespan
        max_mdd = 0                ## variable que guardará el máximo de los makespan
        
        ## Paso1
        for candidato in candidatos:
            y = max( P[candidato-1], due_date[candidato-1] - t )
            MMD.append(y)
            ## Determinar mínimo makespan
            if ( y < min_mdd ):
                min_mdd = y
            #fi
            ## Determinar máximo makespan
            if ( y > max_mdd ):
                max_mdd = y
            #fi
        #rof
        
        # print("====== Iteración ", it + 1," ======")
        # print("Candidatos: ", candidatos, "MMD: ", MMD, "Min: ", min_mdd, "Max: ", max_mdd)

        ## Paso2: Determinar RCL
        indicador = min_mdd + ALPHA * ( max_mdd - min_mdd )
        RCL = []
        trabajo = 0
        for m in MMD:
            if ( m <= indicador ):                ## Si el makespan es menor que el indicador
                RCL.append(candidatos[trabajo])        ## guardar el trabajo en RCL
            #fi
            trabajo += 1
        #rof
        # print("RCL: ", RCL,"... Menor que: ", indicador)

        ## Paso 3: seleccionar aleatoriamente un trabajo del RCL
        pos = random.randint( 1, len(RCL) )   ## Obtener una posicion aleatoria del RCL(funcion aleatorio entre arriba)
        seleccion = RCL[pos-1]                 ## Obtener un trabajo del RCL
        # print("Seleccionado: ", seleccion)

        ## Paso 4
        solucion.append(seleccion)                 ## Agregrar el trabajo escogido a solución
        candidatos.remove(seleccion)               ## escogido a solucion_TP y remover el elemento de candidatos
        solucion_TP.append(TP[seleccion-1])        ## agregar los tiempos de procesamiento del trabajo escogido a solucion_TP
        t = fo.calcular_makespan_blocking(solucion_TP)
        # print("Solucion: ", solucion, "Candidatos: ", candidatos)
        # print("t: ", t)
    #rof
    return(solucion, fo.calcular_tardanza_blocking_secuencia( solucion ,TP, due_date ))
#fed


def GRASP_Tardiness( TP, DD, ALPHA, num_iteraciones ):
    ## Etapa de construcción de solución
    secuencia, tardanza = construccion_GRASP(TP, DD, ALPHA)
    # print("Secuencia construcción GRASP: ", secuencia, "; Tardanza: ", tardanza, "; Makespan: ", fo.calcular_makespan_blocking_secuencia(secuencia, TP3))
    
    ## Etapa de busqueda local
    secuencia_bl, makespan_bl = busqueda_local_GRASP( secuencia, TP, DD, num_iteraciones )
    # print("Secuencia busqueda local GRASP: ", secuencia_bl, "; Tardanza: ", makespan_bl, "; Makespan: ", fo.calcular_makespan_blocking_secuencia(secuencia_bl, TP3))
    return(secuencia, secuencia_bl)
#fed

