// class Course {
//     constructor({name, classes = []}) {
//         this._name = name;
//         this.classes = classes;
//     }

//     // Para encapsular un atributo  podemos ponerle un _ adelante al nombre
//     // de la variable. Esto no la hece inaccesible pero si le dice a los demás
//     // que no accedan a la variable 
//     get name() {
//         return this._name
//     }

//     set name(nuevoNombre) {
//         this._name = nuevoNombre
//     }

//     changeName(nuevoNombre) {
//         this._name = nuevoNombre
//     }
// }
class Course {
    // En ES2020 se introdujo la sintaxis campos privados en las clases.
    // Se hace uso de un numeral como prefijo del nombre de la variable.
    // ¿Cúal sería la ventaja de usar esto? Que no existe la posibilidad de que alguien 
    // odifique la variable privada desde la instancia a menos de que use el setter que le dimos.

    constructor({ name, classes = [] }) {
        this.#name = name;
        this.classes = classes;
    }

    get name() {
        return this.#name;
    }

    set name(nuevoNombrecito) {
        if (nuevoNombrecito === 'Curso Malito de Programación Básica') {
            console.error('Web... no');
        } else {
            this.#name = nuevoNombrecito;
        }
    }
}

const cursoDefinitivoHTML = new Course({
    name: "Curso Definitivo de HTML y CSS",
})

// Puesto que en la función estamos usando get, no hace falta llamar al tributo name como funcion
console.log(cursoDefinitivoHTML.name);
cursoDefinitivoHTML.changeName("Otro nombre");
console.log(cursoDefinitivoHTML.name);
cursoDefinitivoHTML.name = "Otro nombre con setter"
console.log(cursoDefinitivoHTML.name);
