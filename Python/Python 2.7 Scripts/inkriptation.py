#!/usr/bin/python

import math
import sys


def main( argv ):
    
    cadena=input( "Digite la cadena: " )
    abc=["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    cadena2=""
    x=0
    for i in range ( len(cadena) ):
        if (cadena[i]==" "):
            cadena2+=" "
        
        for j in range ( len(abc) ):
            if (cadena[i]==abc[j] and j<=12):
                x=(j)%13+13
                cadena2+=abc[x]
            
            if (cadena[i]==abc[j] and j>12):
                x=j-13
                cadena2+=abc[x]
                    
        
    
    print(cadena2)






if __name__ == "__main__":
    main( sys.argv )
# fi

## eof - programa_prueba.py
