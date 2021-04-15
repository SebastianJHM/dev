
// La forma de declarar las clases en JS es la siguiente. Como se explica en el curso
// de platzi está desactualizado respecto al estandar EcmaScript6.
// El metodo contructor funciona como self en python. Allí se le pasan los valores
class Rectangulo {
    constructor (alto, ancho) {
        this.alto = alto;
        this.ancho = ancho;
    }
    
    // Getter
    get area() {
        return this.calcArea();
    }

    // Método
    calcArea () {
        return this.alto * this.ancho;
    }
}

const cuadrado = new Rectangulo(10, 10);
console.log("El area del rectangulo es:", cuadrado.area);

const cuadrado2 = new Rectangulo();
cuadrado2.alto = 10;
cuadrado2.ancho = 10;
console.log(cuadrado2.calcArea)

class Punto {
    constructor ( x , y ){
      this.x = x;
      this.y = y;
    }
  
    static distancia ( a , b) {
      const dx = a.x - b.x;
      const dy = a.y - b.y;
  
      return Math.sqrt ( dx * dx + dy * dy );
    }
  }
  
  const p1 = new Punto(5, 5);
  const p2 = new Punto(10, 10);
  
  console.log (Punto.distancia(p1, p2)); // 7.0710678118654755