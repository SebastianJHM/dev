//keydown: evento que registra que se está oprimiendo una letra. Se registra continuamente cuando se presiona.
//keyup: evento que registra que se está oprimiendo una letra. Se registra solo una vez por cada oprimida.

document.addEventListener("keydown",dibujarTeclado);//En este caso el objeto que recibirá el evento
                                                  //es todo el document. El evento será el pulso del teclado
                                                  // ya se con keyup o con keydown.

var teclas = {UP:38,DOWN:40,LEFT:37,RIGHT:39};
var cuadrito = document.getElementById("area_de_dibujo");
var papel = cuadrito.getContext("2d");
var x = 150;
var y = 150;

// Inicialmente las funciones que se ejecutan después de un evento no necesitan
//parámetros porque son opcionales. Pero si le asignamos una variale como parámetro,
//en este caso evento. En esta variable estan todos los datos relevantes de como ocurrió el
//evento. Si se hace con el click, la variable almacenará la posición del mouse. EN el
//evento de refrescar página(onload) va a salir donde cargó, como cargó, etc. En los eventos de
//teclado se registrará que letra se oprimió, el código, etc.

//--------------------FUNCIÓN DIBUJO LINEA EN CANVAS--------------------
function dibujar_linea(color,x_inicial,y_inicial,x_final,y_final,lienzo){
  lienzo.beginPath();
  lienzo.strokeStyle = color;
  lienzo.lineWidth = 3; //lineWidth: Ancho de línea;
  lienzo.moveTo(x_inicial,y_inicial);
  lienzo.lineTo(x_final,y_final) ;
  lienzo.stroke();
  lienzo.closePath();
}
//-----------------------------------------------------------------------


//----------------------------FUNCIÓN DE DIBUJO POR TECLADO------------------------------------
dibujar_linea("red",x-1,y-1,x+1,y+1,papel);
// Inicialmente las funciones que se ejecutan después de un evento no necesitan
//parámetros porque son opcionales. Pero si le asignamos una variale como parámetro,
//en este caso evento. En esta variable estan todos los datos relevantes de como ocurrió el
//evento. Si se hace con el click, la variable almacenará la posición del mouse. EN el
//evento de refrescar página(onload) va a salir donde cargó, como cargó, etc. En los eventos de
//teclado se registrará que letra se oprimió, el código, etc.
function dibujarTeclado(evento){
  //-----------FORMA DE HACERLO CON IF--------------
  //if (evento.keyCode == teclas.UP){
    //console.log("Vamo' pa arriba")
  //}
  //if (evento.keyCode == teclas.DOWN){
    //console.log("Vamo' pa abajo")
  //}
  //----------------------------------------------

  var colorcito = "red";
  var movimiento = 1;
  switch (evento.keyCode) {
    case teclas.UP:
      dibujar_linea(colorcito,x,y,x,y - movimiento,papel);
      y = y - movimiento;
    break;
    case teclas.DOWN:
      dibujar_linea(colorcito,x,y,x,y + movimiento,papel);
      y = y + movimiento;
    break;
    case teclas.RIGHT:
      dibujar_linea(colorcito,x,y,x + movimiento,y,papel);
      x = x + movimiento;
    break;
    case teclas.LEFT:
      dibujar_linea(colorcito,x,y,x - movimiento,y,papel);
      x = x - movimiento;
    break;
    default:
      console.log("Otra tecla");
    break;
  }
}
//-----------------------------------------------------------------------------------------------
