
//---------------------------------Array asociativos---------------------------------
//var imagenes = {Cauchin:"vaca.png", Pokacho:"pollo.png", Tocinauro:"cerdo.png"}
//El siguiente Array asociativo es equivalente a lo anterior.
var imagenes = [];
imagenes["Cauchin"] = "vaca.png";
imagenes["Pokacho"] = "pollo.png";
imagenes["Tocinauro"] = "cerdo.png";
//------------------------------------------------------------------------------------

//-------------DECLARACIÓN UNO POR UNO----------------
//var cauchin = new Pakiman("Cauchin", 100, 30);
//var pokacho = new Pakiman("Pokacho", 80, 50);
//var tocinauro = new Pakiman("Tocinauro", 120, 40);
//---------------------------------------------------

//--------FORMA ALTERNATIVA DE PONER PARÁMETROS----------
//cauchin.nombre = "Cauchin";
//cauchin.vida = 100;
//cauchin.ataque = 30;
//cauchin.imagen.src = imagenes[cauchin.nombre];
//--------------------------------------------------------


var coleccion = [];
coleccion.push(new Pakiman("Cauchin", 100, 30));
coleccion.push(new Pakiman("Pokacho", 80, 50));
coleccion.push(new Pakiman("Tocinauro", 120, 40));

for(var i in coleccion){
  coleccion[i].mostrar();
}
