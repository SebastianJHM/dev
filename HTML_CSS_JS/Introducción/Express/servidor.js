//La variable exppress me registra la librería.
//require(): trae el librería que instalamos en npm.// COMBAK:
//en la variable aplicacion metemos la variable exppress

var x = require("express");
var aplicacion = x();

//aplicacion.get(): es como addEventListener() pero en lugar de un evento, este registra
//la dirección del sitio y luego dispara la función.

aplicacion.get("/", inicio);
aplicacion.get("/cursos",cursos)

//peticion es lo que el navegador le esta pidiendo al servidor.
//resultado es lo que el servidor le quiere mandar al navegador
function inicio(peticion,resultado){
  resultado.send("Este es el <strong>home</strong> genial!!!");
}

function cursos(peticion,resultado){
  resultado.send("Estos son los <strong>cursos</strong>");
}

//el servidor se corre con el método listen
aplicacion.listen(8989);
