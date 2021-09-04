from django.db import models

## python3 manage.py check gestionPedidos
## python3 manage.py makemigrations -> [ID]
## python3 manage.py sqlmigrate [nameAPP] [ID]
## python3 manage.py migrate


class Clientes(models.Model):
    nombre = models.CharField(max_length=30)
    direccion = models.CharField(max_length=50)
    email = models.EmailField()
    telefono = models.CharField(max_length=10)

class Articulos(models.Model): 
    nombre = models.CharField(max_length=30)
    seccion = models.CharField(max_length=20)
    precio = models.IntegerField()

    def __str__(self) -> str:
        return f"[Nombre: {self.nombre}, Seccion: {self.seccion}, Precio: {self.precio}]"

class Pedidos(models.Model):
    numero = models.IntegerField()
    fecha = models.DateField()
    entregado = models.BooleanField()


## Para usar la base de datos en la consola usamos vamos a la carpeta raíz
## y usamos los siguientes comandos
# python3 manage.py shell
# >>> from gestionPedidos.models import Articulos
## GUARDAR REGISTRO
# >>> art = Articulos(nombre="Mesa", seccion="Decoración", precio=90)
# >>> art.save()
## ACTUALIZAR REGISTRO
# >>> art.precio = 95
# >>> art.save()
## OBTENER ARTÍCULO
# >>> get_art = Articulos.objects.get(id=3)
## ELIMINAR REGISTRO
# >>> get_art.delete()
## CONSULTAR
# >>> Articulos.objects.filter(seccion='deportes');
# <QuerySet [<Articulos: Articulos object (6)>, <Articulos: Articulos object (7)>]>
## CONSULTA: IDs mayores a 5 y seccion igual ferreteria
# >>> Articulos.objects.filter(id__gte=5,seccion='ferreteria');
## ORDENAR
# >>> Articulos.objects.filter(id__gte=5).order_by('precio');
## DESC
# >>> Articulos.objects.filter(id__gte=5).order_by('precio')[::-1];

# __gte: greater than or equal to... o sea >=
# __gt: greater than... o sea >
# __lte: least than or equal
# __le: least than