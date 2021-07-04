/**
 * Multiline
 */
 let lorem =
 'Mollit ea veniam ad magna. Voluptate qui commodo do commodo elit officia. \n' +
 'Sit quis mollit esse quis reprehenderit labore esse nisi.';
console.log('Before ES6 -> ', lorem);

// es6
let loremES6 = `Velit aliqua culpa nisi aute nulla sit.
Reprehenderit deserunt id officia excepteur excepteur
adipisicing ut sit enim dolor laboris nulla exercitation.`;
console.log(`After ES6 -> ${loremES6}`);

/**
* Destructuring
*/
let person = {
 name: 'Oscar',
 age: '32',
 country: 'MX'
};
console.log('Before ES6 -> ', person.name, person.age, person.country);

// es6
let { name, age, country } = person;
console.log(`After ES6 -> ${name} ${age} ${country}`);

/**
* Spread Operator
*/
let team1 = ['Oscar', 'Julián', 'Ricardo'];
let team2 = ['Valeria', 'Yeasica', 'Camila'];
let education = ['David', 'Oscar', 'Julián', 'Ricardo', 'Valeria', 'Yeasica', 'Camila'];
console.log('Before ES6 -> ', education);

let educationES6 = ['David', ...team1, ...team2];
console.log(`After ES6 -> ${educationES6}`);

/**
* Var, Let and Const
*/

// Cuando una variable se delara con var queda global pero si se declara con let solo se puede usar en la función
{
    var globalVar = 'Global Var';
    let globalLet = 'Global Let';
    const globalConst = 'Global Const';
    console.log(`globalLet -> ${globalLet}`);
    console.log(`globalConst -> ${globalConst}`);
}
console.log(`globalVar -> ${globalVar}`);<