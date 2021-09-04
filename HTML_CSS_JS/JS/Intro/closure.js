// let result = 0;

// function addn(n) {
//     result = result + n;
//     return result;
// }

// r = addn(3);
// console.log(r);

// r = addn(4);
// console.log(r);

// r = addn(10);
// console.log(r);



// function addn(n) {
//     let result = 0;
//     result = result + n;
//     return result;
// }

// r = addn(3);
// console.log(r);

// r = addn(4);
// console.log(r);

// r = addn(10);
// console.log(r);



function init_addn(valor_inicial) {
    let result = valor_inicial;
    // const closure_function = function(n) {
    //     result = result + n;
    //     return result;
    // }
    // const closure_function = (n) => {
    //     result = result + n;
    //     return result;
    // }
    function closure_function(n) {
        result = result + n;
        return result;
    }
    return closure_function;
}

const addn = init_addn(5);

r = addn(3);
console.log(r);

r = addn(4);
console.log(r);

r = addn(10);
console.log(r);