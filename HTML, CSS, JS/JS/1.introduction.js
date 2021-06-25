console.log("hola mundo");

var nombre = "Eldo";
var apellido = "Ble";
var edad = 7;
var elementos = ["elemento1", true, 7]

console.log(nombre+" "+apellido+" tiene "+edad+" años.");

// Imprimir los tipos de datos de los elemntos de una lista
console.log(typeof(elementos))
for (e of elementos) {
    console.log(e + ": " + typeof(e));
}

// Crear un objeto como variable
var persona = {
    nombre: "Diego",
    edad: 38
}

console.log(persona)
console.log(persona.edad);