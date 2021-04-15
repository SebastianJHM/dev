import random

class Borracho:

    def __init__(self, nombre):
        self.nombre = nombre

    def camina(self):
        return random.choice([(0, 1), (0, -1), (1, 0), (-1, 0)])