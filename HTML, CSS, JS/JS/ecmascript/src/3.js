/**
 * Parameters in Objects
 */
let name = 'Oscar';
let age = 32;

const obj = {
name: name,
age: age
};
console.log('Before ES6 -> ', obj);

// es6
const objES6 = { name, age };
console.log(`After ES6 -> `, objES6);

/**
 * Arrow Functions
 */
const names = [
{ name, age },
{ name: 'Yesica', age: 27 }
];

let listOfNames = names.map(function(item) {
console.log('Before ES6 -> ', item.name);
});

// es6
let listOfNamesES6 = names.map(item => console.log(`After ES6 -> ${item.name}`));

const ArrowFunction = (name, age) => {
    console.log(`${name} ${age}`);
}
ArrowFunction("hola", 5)
/**
 * Promises
 */
const helloPromise = foo => {
    return new Promise((resolve, reject) => {
        if (foo) {
            resolve('Hey!');
        } else {
            reject('Upss!');
        }
    });
};

const foo = false;
helloPromise(foo)
.then(response => console.log('response -> ', response))
.then(() => console.log('message -> Hello World!'))
.catch(error => console.log('error -> ', error));

const html_code = `<div class="card-modal">
                        <h2 class="title-modal draw">It's draw</h2>
                        <p class="selection-user">You choose</p>
                        <p class="selection-cpu">The cpu choose</p>
                        <button class="button-modal" id="button-modal" onclick="modal.style.display='none'">CLOSE</button>
                    </div>`

console.log(html_code)




function* helloWorld() {
    if (true) {
        yield 'Hello, ';
    }
    if (true) {
        yield 'World';
    }       
    
}

const generatorHello = helloWorld();

console.log(generatorHello.next()); // 'Hello, '
console.log(generatorHello.next()); // 'World'
console.log(generatorHello.next());