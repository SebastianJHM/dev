//Las clases sirven para asociar e identificar objetos con las mismas características o atributos.
//Para este proyecto crearemos tres avatares: cauchin(vaca), pocacho(pollo), tocinauro(cerdo).
//Los tres avatares(objetos) tienen elementos en comun: noombre, vida y ataque.
//Como tienen elementos en comunes se las asociaremos a la clase Pakiman. Esto es porque cada
//avatar es un Pakiman.
//En ejemplos anteriores cuando hacíamos "var im = new Image()" es por Image() es una clase, lo mismo pasa con Array
//Para crear los atributos de las clases debemos usar una la función constructor.

class Pakiman{
  //Para crar un atributo no basta con poner el nombre de la variable
  //hay que poner this.variable
  //La función constructor es propia de JAVASCRIPT para declarar atributos
  constructor(n, v, a){
    this.imagen = new Image(); //En este caso el atributo es otra clase.
    this.nombre = n;
    this.vida = v;
    this.ataque = a;

    this.imagen.src = imagenes[this.nombre];
  }

  //hablar es una función creada por nosotros a diferencia de constructor.
  //Como estamos dentro de una clase, no necesitamos escribir function, aunque no sea una función.
  hablar(){
    alert(this.nombre);
  }

  mostrar(){
    document.body.appendChild(this.imagen);
    document.write("<br /><strong>" + this.nombre + "</strong><br />");
    document.write("Ataque: " + this.ataque + "<br />");
    document.write("Vida: " + this.vida + "<hr />");
  }
}
