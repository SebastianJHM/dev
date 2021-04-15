// Canvas es una etiqueta, el id es "dibujito"
// En JavaScript hay que obtener la etiqueta y luego el área
// A la variable d, le asignaremos el id del canvas
// A lienzo le asignaremos el espacio de Dibujo

//----------------------------------------
var texto = document.getElementById("Texto_lineas");
var boton = document.getElementById("Botoncito");
var d = document.getElementById("dibujito");// getElementById(): obtiene el Id de un elemento
var lienzo = d.getContext("2d");// getElementById(): función del objeto canvas. Permite ver el área donde voy a dibujar
boton.addEventListener("click",dibujo_por_click);//addEventListener(): añdirle al botón una función que se ejecute cuando
                                                 //ocurra un evento. En este caso el evento es click. Hay muchos tipos de
                                                 //eventos, como pararse sobre el botón. Click, se refiere al click del mouse
                                                 //La función dibujo_por_click no lleva () porque esta respondiendo a un evento
//-----------------------------------------------------------------------

//--------------------CÓDIGO DIBUJO LINEA EN CANVAS--------------------
//lienzo.beginPath();//beginPath(): comenzar un trazo un trazo
//lienzo.strokeStyle = "blue"; //strokeStyle: color de la línea
//lienzo.moveTo(51,23); //moveTo(,): pararse en una coordenada del canvas
//lienzo.lineTo(2,99) ; //lineTo(,): moverse a esa coordeanda del canvas
//lienzo.stroke(); //lineTo(,): dibuja en el formato que le dimos.
//lienzo.closePath();//closePath(): terminar el trazo
//-----------------------------------------------------------------------

//--------------------FUNCIÓN DIBUJO LINEA EN CANVAS--------------------
function dibujar_linea(color,x_inicial,y_inicial,x_final,y_final){
  lienzo.beginPath();
  lienzo.strokeStyle = color;
  lienzo.moveTo(x_inicial,y_inicial);
  lienzo.lineTo(x_final,y_final) ;
  lienzo.stroke();
  lienzo.closePath();
}
//-----------------------------------------------------------------------


function dibujo_por_click(){
  var lineas = parseInt(texto.value);
  var ancho = d.width;
  var espacios = ancho/lineas;
  var x;
  var y;
  var l;


  //------------LIMPIAR LIENZO--------------------
  lienzo = d.getContext("2d");//
  lienzo.clearRect(0, 0, d.width, d.height);//clearRect(a,b,c,d): Del canvas seleccionado, limpia de a a c en x, y de a a d en y.
  //-------------------------------------------------

  //--------------------DIBUJO--------------------
  dibujar_linea("#20707D",1,1,1,299);
  dibujar_linea("#20707D",299,1,299,299);
  dibujar_linea("#20707D",1,1,299,1);
  dibujar_linea("#20707D",1,299,299,299);
  for (l = 0;l < lineas; l++){
    x = espacios*l
    y = espacios*(l+1)
    dibujar_linea("#20707D",0,x,y,300);
    x = espacios*l;
    y = 300-espacios*(l+1);
    dibujar_linea("#20707D",x,300,300,y);
    x = espacios*l;
    y = espacios*(l+1);
    dibujar_linea("#20707D",x,0,300,y);
    x = 300 - espacios*l;
    y = espacios*(l+1);
    dibujar_linea("#20707D",0,x,y,0);
  }
  //-------------------------------------------------

}
