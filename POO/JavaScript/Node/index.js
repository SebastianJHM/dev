const Square = require('./Square.js');
const mySquare = new Square(2);
console.log(`The area of mySquare is ${mySquare.area()}`);

const Car = require('./Car.js')
const myCar = new Car("BVB-006", "Andrés Paternina")
console.log(myCar)
console.log(myCar.license)
console.log("El conductor es", myCar.conductor)