from django.http import HttpResponse
import datetime
import scipy.stats
import matplotlib.pyplot as plt
from django.template import Template, Context, loader
import os
from django.shortcuts import render
import json

## Cada función que se crea en el archivo view.py corresponde a una vista
def saludo(request):
    documento = """
        <html>
			<head>
				<title>Un saludito desde Django</title>
			</head>
			<body>
				<h1>Buenas noches para la muchachada</h1>
				<p>trmendo html JAJAJAJAJAJA!</p>
			</body>
		</html>
    """
    return HttpResponse(documento)

def despedida(request):
    return HttpResponse("chao muchachos")




class Persona:
    def __init__(self, nombre_i, apellido_i) -> None:
        self.nombre = nombre_i
        self.apellido = apellido_i

def plantillando(request):

    p1 = Persona("José Joaquin", "Paternina")
    ahora = datetime.datetime.now()

    ## METHOD 1
    # documento_externo = os.path.dirname(os.path.realpath(__file__)) + '/templates/despedida.html'
    # plantilla = Template(documento_externo.read())
    # documento_externo.close()
    # contexto = Context({"nombre_usuario": p1.nombre, "apellido_usuario": p1.apellido, "fecha_actual": ahora})
    # documento = plantilla.render(contexto)
    # return HttpResponse(documento)

    contexto = {
        "nombre_usuario": p1.nombre,
        "apellido_usuario": p1.apellido,
        "fecha_actual": ahora,
        "textos_html": ["e"+str(i) for i in range(4)],
        "textos_js": json.dumps(["e"+str(i) for i in range(4)]),
        "numeros": [10.1, 2, 3, 4],
        "json_html": {"a": 5, "b": [{"at1": "a1", "at2": [1]}, {"at1": "a2", "at2": [5, 6]}]},
        "json_js": json.dumps({"a": 5, "b": [{"at1": "a1", "at2": [1]}, {"at1": "a2", "at2": [5, 6]}]})         
    }

    ## METHOD 2
    # documento_externo = loader.get_template("plantilla1.html")
    # documento = documento_externo.render(contexto)
    # return HttpResponse(documento)

    ## METHOD 3
    return render(request, "templates1/plantilla1.html", contexto)


def heredando(request):
    fa = datetime.datetime.now()
    contexto = {
        "fecha_actual": fa
    }
    return render(request, "herencia/page1.html", contexto)


    

def librerias_python(request):
    fa = datetime.datetime.now()
    v = scipy.stats.norm.cdf(32, 30, 4)
    documento = f"""
        <html>
			<head>
				<title>Un saludito desde Django</title>
			</head>
			<body>
				<h1>Fecha actual: {fa}</h1>
				<p id="scipy-value">Usando Scipy: {v}</p>
			</body>
		</html>
    """
    return HttpResponse(documento)

def usando_js(request):
    name = "RAT"
    documento = f"""
        <html>
			<head>
				<title>Un saludito a {name}</title>
			</head>
			<body>
				<h1 id='title'>Soy el título modificado con JS</h1>
                <h2 id='subtitle'>Vacío</h2>

                <script>
                    console.log("{request}");

                    el = document.getElementById('title');
                    console.log(el);
                    console.log(el.attributes)
                    el.style.color = 'red';

                    el2 = document.getElementById('subtitle');
                    console.log(el2);
                    el2.innerText = "hola {name}";
                </script>
			</body>
		</html>
    """
    return HttpResponse(documento)

def calcular_edad(request, edad_actual, anno):
    periodo = anno - 2021
    edad_futura = edad_actual + periodo

    documento = f"""
        <html>
			<head>
				<title>Url como parámetro</title>
			</head>
			<body>
				<h1>En el año {anno} tendrás {edad_futura}</h1>
			</body>
		</html>
    """
    
    return HttpResponse(documento)
