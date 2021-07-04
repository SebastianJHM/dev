var a = 5;

var d = a == 5;
console.log(d)

var d = a === 5;
console.log(d)

a = Boolean();
console.log(typeof(a)+": "+a);

var x = 0
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);

var x = 1
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);

var x = -1
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);


var x = 10
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);

var x = "hola"
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);

var x = undefined
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);

var x = null
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);

var x = NaN
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);

var x = ""
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);

var x = " "
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);

var x = []
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);

var x = {}
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);

var x = function(){}
a = Boolean(x);
console.log(x +": "+typeof(a)+": "+a);

