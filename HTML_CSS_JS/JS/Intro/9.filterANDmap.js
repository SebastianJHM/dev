var articulos = [
	{ nombre: 'π±', precio: 1000 },
	{ nombre: 'π»', precio: 1500 },
	{ nombre: 'π₯', precio: 2000 },
	{ nombre: 'β¨οΈ', precio: 100 },
	{ nombre: 'π±', precio: 70 },
	{ nombre: 'π', precio: 30000 },
];

//filter Genera un nuevo array
var articulosFiltrados = articulos.filter(function(articulo) {
	return articulo.precio <= 500 && articulo.precio >=80;
}).l;
console.log(articulosFiltrados);

//map Ayuda a mapear ciertos elementos de los articulos, es necesario generar nuevo array
var nombreArticulos = articulos.map(function(articulo){
    return articulo.nombre;
});
console.log(nombreArticulos);

//find Ayuda a encontrar algo dentro del array articulos
var encuentraArticulo = articulos.find(function(articulo){
    return articulo.nombre === 'π';
});
console.log(encuentraArticulo);

console.log("-------");
//forEach No es necesario generar nuevo array, se utiliza para realizar un recorrido de un array principal
articulos.forEach(function(articulo){
    console.log(articulo.nombre + articulo.nombre);
});
console.log("-------");

//some:nos dice si algΓΊn articulo tiene precio menor a 700
var articulosBaratos = articulos.some(function(articulo){
    return articulo.precio <= 700;
});
console.log(articulosBaratos);