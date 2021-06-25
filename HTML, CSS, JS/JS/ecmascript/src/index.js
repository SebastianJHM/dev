// Así era como antes se inicializabn valores por defeto de una función. Es decir que tomara
// el valor de el parámetro o del string
function newFunction(name, age, country) {
    var name = name || 'Oscar';
    var age = age || 32;
    var country = country || 'MX';
    console.log(name, age, country);
}
newFunction();
newFunction('Ricardo', 23, 'Colombia');

// Así se inicializa en ES6
function newFunctionES6(name = 'Oscar', age = 32, country = 'MX') {
    console.log(name, age, country);
}

newFunctionES6();
newFunctionES6('Ricardo', 23, 'Colombia');

/**
 * Concatenation - Template Literals
 */
let hello = 'Hello';
let world = 'World';
let epicPhrase = hello + ' ' + world + '!';

// es6
let epicPhraseES6 = `${hello} ${world}!`;

console.log(epicPhrase);
console.log(epicPhraseES6);

