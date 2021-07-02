#!/usr/bin/python
import sys

def main( argv ):
    msg = "Dabale arroz a la zorra el abad"
    cont=0
    a=[]
    b=[]
    for i in range (len(msg)):
        if (msg[i]==" "):
            a.append(i)
        
    
    x=""
    for i in range (len(a)):
        if (i==0):
            x=""
            for j in range (0,a[0],1):
                x=x+msg[j]
            
            b.append(x)
        
                
        if (i>0 and i<(len (a)-1)):
            x=""
            for j in range (a[i]+1,a[i+1],1):
                x=x+msg[j]
            
            b.append(x)
        

        if (i==(len(a)-1)):
            x=""
            for j in range (a[i]+1,len(msg),1):
                x=x+msg[j]
            
            b.append(x)
        
    
    print b




    
if __name__ == "__main__":
    main( sys.argv )
# fi

## eof - rot13.py

