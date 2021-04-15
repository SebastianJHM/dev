class Campo:

    def __init__(self): #contructor
        self.coordenadas_de_borrachos = {} #crea un diccionario de las coordenadas de los borrachos.

    def añadir_borracho(self, borracho, coordenada): #que borracho queremos recibir y donde estara
        self.coordenadas_de_borrachos[borracho] = coordenada #se guarda dentro del diccionario, y se designa esta operacion a coordenada

    def mover_borracho(self, borracho): #que borracho vamos a mover
        delta_x, delta_y = borracho.camina() #cuando camina el borracho regresa una tupla, aleatorio.
        coordenada_actual = self.coordenadas_de_borrachos[borracho] #la coordenada actual guardada en el diccionario
        nueva_coordenada = coordenada_actual.mover(delta_x, delta_y) #con la coordenada actual le decimos que se mueva con el delta x, y el delta y.

        self.coordenadas_de_borrachos[borracho] = nueva_coordenada #guardamos nuevamente la coordenada del borracho en el diccionario.

    def obtener_coordenada(self, borracho):  #consulta de donde anda un borracho al final del programa.
        return self.coordenadas_de_borrachos[borracho] #devuelve el valor actual en el diccionario.