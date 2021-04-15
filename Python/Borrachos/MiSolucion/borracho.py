import random
from coordenada import Coordenada

class Borracho:

    def __init__(self, coordenada_0):
        self.pos_actual_x = coordenada_0.x
        self.pos_actual_y = coordenada_0.y
        self.ruta = [coordenada_0]

    def camina(self):
        delta = random.choice([(0, 1), (0, -1), (1, 0), (-1, 0)])
        self.pos_actual_x = self.pos_actual_x + delta[0]
        self.pos_actual_y = self.pos_actual_y + delta[1]
        coord = Coordenada(self.pos_actual_x, self.pos_actual_y)

        self.ruta.append(coord)

    def posicion_actual(self):
        return [self.pos_actual_x, self.pos_actual_y]