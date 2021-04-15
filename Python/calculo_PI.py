import random
import math
import statistics
from bokeh.plotting import figure, show

def esta_circulo(x, y):
    dist = math.sqrt(x**2 + y**2)
    if dist <= 1:
        return True
    return False

def estimar_pi(num_puntos):
    cont_circulos = 0
    dentro_circ = []
    fuera_circ = []
    for _ in range(num_puntos):
        x = random.random() * random.choice([1, -1])
        y = random.random() * random.choice([1, -1])
        if esta_circulo(x, y) == True:
            cont_circulos += 1
            dentro_circ.append([x, y])
        else:
            fuera_circ.append([x,y])
    
    pi = 4 * cont_circulos / num_puntos
    return pi, dentro_circ, fuera_circ
            
def graficar(num_puntos):
    
    pi, dentro_circ, fuera_circ = estimar_pi(num_puntos)
    
    dentro_circ_x = [p[0] for p in dentro_circ]
    dentro_circ_y = [p[1] for p in dentro_circ]
    fuera_circ_x = [p[0] for p in fuera_circ]
    fuera_circ_y = [p[1] for p in fuera_circ]
    
    plot = figure(title='Calculo de pi')
    plot.circle(dentro_circ_x, dentro_circ_y, size=5, color="red", alpha=0.5)
    plot.circle(fuera_circ_x, fuera_circ_y, size=5, color="blue", alpha=0.5)
    show(plot)
    
def construir_muestra(num_puntos, num_muestra):
    muestra = []
    for _ in range(num_muestra):
        pi, dentro_circ, fuera_circ = estimar_pi(num_puntos)
        muestra.append(pi)
    
    mean = statistics.mean(muestra)
    desv = statistics.stdev(muestra)
    
    return mean, desv

def principal(num_puntos, num_muestra, precision):
    
    desv = float("inf")
    
    while desv >= precision / 1.96:
        print("=======", num_puntos, "===========")
        mean, desv = construir_muestra(num_puntos, num_muestra)
        num_puntos *= 2
        print("pi: ", mean)
        print("desv: ", desv)
        
    graficar(10000)
    


if __name__ == '__main__':
    principal(1000, 100, 0.01)