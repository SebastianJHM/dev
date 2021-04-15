from coordenada import Coordenada
from borracho import  Borracho
from bokeh.plotting import figure, show

def graficar(ruta):
    x = [nodo.x for nodo in ruta]
    y = [nodo.y for nodo in ruta]
    plot = figure(title='Camino aleatorio', 
                     x_axis_label='pasos', 
                     y_axis_label='distancia')
    plot.line(x, y, legend_label='Recorrido')
    plot.circle(ruta[0].x, ruta[0].y, legend_label='Origen', color="red", size = 7)
    plot.circle(ruta[-1].x, ruta[-1].y, legend_label='Destino', color="green", size = 7)
    show(plot)

def principal():
    origen = Coordenada(0, 0)
    pasos = [10, 100, 1000, 10000]

    for p in pasos:
        distancias = []
        for num_repeticiones in range(100):
            el_borracho = Borracho(origen)
            for _ in range(p):
                el_borracho.camina()
            distancias.append(el_borracho.ruta[0].distancia(el_borracho.ruta[-1]))

        distancia_media = round(sum(distancias) / len(distancias), 4)
        distancia_maxima = max(distancias)
        distancia_minima = min(distancias)

        print("======== Numero de pasos: ", p, " =========")
        print(f"Media = {distancia_media}")
        print(f"Max = {distancia_maxima}")
        print(f"Min = {distancia_minima}")

    graficar(el_borracho.ruta)
    # print(el_borracho.posicion_actual())
    # print(el_borracho.ruta)
    # print(el_borracho.ruta[0].distancia(el_borracho.ruta[-1]))

if __name__ == '__main__':
    principal()