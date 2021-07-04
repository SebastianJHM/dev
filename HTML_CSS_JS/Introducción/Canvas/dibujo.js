// Canvas es una etiqueta, el id es "dibujito"
// En JavaScript hay que obtener la etiqueta y luego el área
// A la variable d, le asignaremos el id del canvas
// A lienzo le asignaremos el espacio de Dibujo

var d = document.getElementById("dibujito");// getElementById(): obtiene el Id de un elemento
var lienzo = d.getContext("2d");// getElementById(): función del objeto canvas. Permite ver el área donde voy a dibujar
var l = 0
var x;
var y;

//---------------------------DIBUJO--------------------------------------
//lienzo.beginPath();//beginPath(): comenzar un trazo un trazo
//lienzo.strokeStyle = "blue"; //strokeStyle: color de la línea
//lienzo.moveTo(51,23); //moveTo(,): pararse en una coordenada del canvas
//lienzo.lineTo(2,99) ; //lineTo(,): moverse a esa coordeanda del canvas
//lienzo.stroke(); //lineTo(,): dibuja en el formato que le dimos.
//lienzo.closePath();//closePath(): terminar el trazo
//-----------------------------------------------------------------------

function dibujar_linea(color,x_inicial,y_inicial,x_final,y_final){
  lienzo.beginPath();
  lienzo.strokeStyle = color;
  lienzo.moveTo(x_inicial,y_inicial);
  lienzo.lineTo(x_final,y_final) ;
  lienzo.stroke();
  lienzo.closePath();
}

dibujar_linea("#20707D",1,1,1,300);
l = 0
while (l < 30){
  x = 10*l
  y = 10*(l+1)
  dibujar_linea("#20707D",0,x,y,300);
  l = l + 1
}

dibujar_linea("#20707D",1,300,300,300);
for (l = 0;l < 30; l++){
  x = 10*l
  y = 300-10*(l+1)
  dibujar_linea("#20707D",x,300,300,y);
}

dibujar_linea("#20707D",1,1,300,1);
for (l = 0;l < 30; l++){
  x = 10*l
  y = 10*(l+1)
  dibujar_linea("#20707D",x,0,300,y);
}

dibujar_linea("#20707D",300,1,300,300);
for (l = 0;l < 30; l++){
  x = 300 - 10*l
  y = 10*(l+1)
  dibujar_linea("#20707D",0,x,y,0);
}
