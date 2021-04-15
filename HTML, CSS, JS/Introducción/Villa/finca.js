var vp = document.getElementById("villaplatzi");
var papel = vp.getContext("2d");

//Al canvas no se le pude solo asignar la imagen por eso debemos crear un objeto
//Image(): es un objeto completo. La I está en mayuscula porque es un evento completo.
//Por eso a Image() se le llama clase
//Para poder pasarle la ruta de la imagen, se la debemos pasar por src
//.src es una variable dentro de la clase Image()

//--------------------------PONER LAS IMAGENES EN EL CANVAS-----------------------------
var fondo = {url: "Tile.png", cargaOk: false};
var vaca = {url: "vaca.png", cargaOk: false};
var pollo = {url: "pollo.png", cargaOk: false};
var cerdo = {url: "cerdo.png", cargaOk: false};

//Como la variable fondo ya está creada, y aunque tenga solo dos atributos,
//cuando se le agraga un atributo aunque este no esté declarado desde un principio,
//JAVASCRIPT lo creará automáticamente

fondo.imagen = new Image();
fondo.imagen.src = fondo.url;
fondo.imagen.addEventListener("load",cargar_Tile);
function cargar_Tile(){
  fondo.cargaOk = true;
  dibujar();
}

vaca.imagen = new Image();
vaca.imagen.src = vaca.url;
vaca.imagen.addEventListener("load",cargar_vaca);
function cargar_vaca(){
  vaca.cargaOk = true;
  dibujar();
}

pollo.imagen = new Image();
pollo.imagen.src = pollo.url;
pollo.imagen.addEventListener("load",cargar_pollo);
function cargar_pollo(){
  pollo.cargaOk = true;
  dibujar();
}

cerdo.imagen = new Image();
cerdo.imagen.src = cerdo.url;
cerdo.imagen.addEventListener("load",cargar_cerdo);
function cargar_cerdo(){
  cerdo.cargaOk = true;
  dibujar();
}
//-------------------------------------------------------------------------------------

//-------------------------------------------FUNCIÓN DIBUJAR---------------------------------------------
//Esta fución se crea porque inicialmente para insertar las 4 imágnes se hacía de esta manera:
//var pollo = new Image();
//pollo.src = "pollo.pgn";
//pollo.addEventListener("load",dibujar_pollo);
//function dibujar_pollo(){
  //papel.drawImage(pollo,0,0)
//}
//El problema con eso es que en .addEventListener el eveto "load", que es cargar la página,
//se ejecuta al timpo para las 4 imágenes, y como canvas dibuja como una imágen encima de otra,
//pueden quedar imágenes mas pequeñas detrás de las más grandes. Es decir, que hay que programar
//el dibujo de cada imágen en el orden que se desee.
var xv; var yv; var xp; var yp; var xc; var yc; var cantv; var cantp;

//-------POSICIÓN VACAS------------
cantv = aleatorio(5,15);
var vecv_x = new Array(cantv);
var vecv_y = new Array(cantv);
for(var i=0;i<vecv_x.length;i++){
  vecv_x[i]=aleatorio(0,7) * 60;
  vecv_y[i]=aleatorio(0,7) * 60;
}
//---------------------------------

//-------POSICIÓN POLLOS------------
cantp = aleatorio(5,15);
var vecp_x = new Array(cantp);
var vecp_y = new Array(cantp);
for(var i=0;i<cantp;i++){
  vecp_x[i]=aleatorio(0,7) * 60;
  vecp_y[i]=aleatorio(0,7) * 60;
}
//---------------------------------

xc = aleatorio(0,7) * 60;
yc = aleatorio(0,7) * 60;

function dibujar(){
  //El orden en que estén las imágenes en esta función, es el orden en que apareceran
  //if (fondo.cargaOk == true){ Esto es equivalente a lo de abajo

    if (fondo.cargaOk){
      papel.drawImage(fondo.imagen,0,0);
    }

    if (vaca.cargaOk){
      for (i=0;i<cantv;i++){
        xv = vecv_x[i];
        yv = vecv_y[i];
        papel.drawImage(vaca.imagen,xv,yv);
      }
    }

    if (pollo.cargaOk){
      for (i=0;i<cantp;i++){
        xp = vecp_x[i];
        yp = vecp_y[i];
        papel.drawImage(pollo.imagen,xp,yp);
      }
    }

    if (cerdo.cargaOk){
        papel.drawImage(cerdo.imagen,xc,yc);
    }
}
//------------------------------------------------------------------------------------------------------


//----------FUNCIÓN MOVER EL CERDO CON TECLADO-------------------
document.addEventListener("keydown",dibujarTeclado);
var teclas = {UP:38,DOWN:40,LEFT:37,RIGHT:39};

function dibujarTeclado(evento){
  var movimiento = 10;
  switch (evento.keyCode) {
    case teclas.UP:
      yc = yc - movimiento;
      dibujar();
    break;
    case teclas.DOWN:
      yc = yc + movimiento;
      dibujar();
    break;
    case teclas.RIGHT:
      xc = xc + movimiento;
      dibujar();
    break;
    case teclas.LEFT:
      xc = xc - movimiento;
      dibujar();
    break;
    default:
      console.log("Otra tecla");
    break;
  }
}
//------------------------------------------------------------------

//------------------------FUNCIÓN ALEATORIO---------------------------
function aleatorio(min,max){
  var resultado;
  resultado = Math.floor(Math.random()*(max - min +1)) + min;
  return resultado;
}
//--------------------------------------------------------------------
