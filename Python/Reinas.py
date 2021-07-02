import sys


def solucionValida(solucion):
    
    decisor1 = True
    for i in range(0, len(solucion)):
        for j in range(i+1, len(solucion)):
            if ( solucion[i] != -1 and solucion[j] != -1 ):
                if ( solucion[i] == solucion[j] ):
                    decisor1 = False
                
            
        
    
    
    decisor2 = True
    for i in range(0, len(solucion)):
        for j in range(i+1, len(solucion)):
            if ( solucion[i] != -1 and solucion[j] != -1 ):
                x = abs( i - j )
                y = abs( solucion[i] - solucion[j] )
                if ( x == y ):
                    decisor2 = False
                
            
        
    
    
    if ( decisor1 == True and decisor2 == True ):
        decisorFinal = True
    else:
        decisorFinal = False
    
    
    return( decisorFinal )


def asignarReina(solucion, etapa, n):
    print(etapa)
    verifica = False
    
    while ( etapa < n ):
        solucion[etapa] = solucion[etapa] + 1
        verifica = solucionValida( solucion )
        if ( verifica == True ):
            asignarReina(solucion, etapa + 1, n)
        else:
            solucion[etapa] = solucion[etapa] + 1
        
    #elihw
    return( solucion )

    
def principal(argv):
    n = 4
    solucion = [-1] * n
    etapa = 0
    # solucion = asignarReina(solucion, etapa, n)
    print( solucion )
    
    solucion = [1, -1, -1, -1]
    verifica = solucionValida( solucion )
    print( verifica )

    
if __name__ == "__main__":
    principal(sys.argv)
