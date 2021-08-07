const natalia = {
    name: "Natalia",
    age: 20,
    cursosAprobados: [
        "Curso Definitivo de HTML y CSS",
        "Curso Práctico de HTML y CSS",
    ],
    aprobarCurso(nuevoCursito) {
        this.cursosAprobados.push(nuevoCursito);
    },
};

console.log(natalia)
natalia.aprobarCurso("CSS Grid");



function Student(name, age, cursosAprobados) {
    this.name = name;
    this.age = age;
    this.cursosAprobados = cursosAprobados;
}

Student.prototype.aprobarCurso = function (nuevoCursito) {
    this.cursosAprobados.push(nuevoCursito);
}

const juanita = new Student(
    "Juanita Alejandra",
    15,
    [
        "Curso de Introducción a la Producción de Videojuegos",
        "Curso de Creación de Personajes",
    ],
);

console.log(juanita);
juanita.aprobarCurso("CSS Grid");





class Student_ECS6 {
    constructor(name, age, cursosAprobados) {
        this.name = name;
        this.age = age;
        this.cursosAprobados = cursosAprobados;
    }
    aprobarCurso(nuevoCursito) {
        this.cursosAprobados.push(nuevoCursito);
    }
}

const sofia = new Student(
    "Sofía María",
    17,
    [
        "Curso de Introducción a la Producción de Videojuegos",
        "Curso de Creación de Personajes",
    ],
);

console.log(sofia);
sofia.aprobarCurso("CSS Grid");
