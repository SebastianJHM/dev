class Rectangle {
    constructor(height, width) {
        this.name = 'Rectangle';
        this.height = height;
        this.width = width;
    }
    sayName() {
        console.log('Hi, I am a ', this.name + '.');
    }
    get area() {
        return this.height * this.width;
    }
    set area(value) {
        this.height = this.width = Math.sqrt(value);
    }
}

class Square extends Rectangle {
    constructor(length) {
        this.height; // ReferenceError, super necesita ser llamado primero!

        // Aquí, llama al constructor de la clase padre con las longitudes
        // previstas para el ancho y la altura de Rectangle
        super(length, length);

        // Nota: En las clases derivadas, se debe llamar a super() antes de
        // poder usar 'this'. Salir de esto provocará un error de referencia.
        this.name = 'Square';
    }
}