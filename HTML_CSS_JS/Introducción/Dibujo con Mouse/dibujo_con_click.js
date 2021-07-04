//Dibujo con mouse sobre el cuadro canvas
var d = document.getElementById("area_de_dibujo");
var papel = d.getContext("2d");
var xi;
var yi;
var hab = false;

//EVENTOS DEL MOUSE
//click: registra el click sobre un elemento como un botón
//mouseup: registra la soltada del mouse
//mousedown: registra la oprimida del mouse
//mousemove: registra el movimiento del mouse

d.addEventListener("mousedown",habilitar);
d.addEventListener("mouseup",deshabilitar);
d.addEventListener("mousemove",dibujarClick);

//-------FUNCIÓN HABILITA DIBUJO CUANDO SE OPRIME EL MOUSE--------
function habilitar(evento1){
  hab = true;
  xi = evento1.offsetX;
  yi = evento1.offsetY;
  console.log(xi, yi)
}
//----------------------------------------------------------------


//-------FUNCIÓN DESHABILITA DIBUJO CUANDO SE OPRIME EL MOUSE-----
function deshabilitar(evento2){
  hab = false;
}
//----------------------------------------------------------------


//-------FUNCIÓN DIBUJO LINEA EN CANVAS--------
//.which: registra el botón del mouse que se está usando. 1 click izquierdo, 2 scroll, 3 click derecho;
//.offsetX:da la posición del mouse dentro del objeto en x;
//.offsetY:da la posición del mouse dentro del objeto en y;
function dibujarClick(evento3){
  if (evento3.which == 1){
    if (hab == true){
      // console.log(evento3);
      xf = evento3.offsetX;
      yf = evento3.offsetY;
      dibujar_linea("red",xi,yi,xf,yf,papel);
      xi = xf;
      yi = yf;
    }
  }

}
//----------------------------------------------



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
