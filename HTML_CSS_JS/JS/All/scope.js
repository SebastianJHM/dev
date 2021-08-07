function myFuncion() {
    let i = 1;
    i = 2;
    console.log(i)
}

myFuncion();
console.log("=========")

function functionLet(callback) {
	for(let i = 0; i < 10; i++) {
		setTimeout(function() {
			console.log(i);
		}, 1000);
	}
	callback();
}




function functionVar() {
	for(var i = 0; i < 10; i++) {
		setTimeout(function() {
			console.log(i);
			debugger;
		}, 1000);
	}
}

functionLet(function() {
	functionVar();
});