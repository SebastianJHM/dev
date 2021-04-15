var vec = [1,2,3,5,9];
var tamano = 3;
var vec2 = new Array(tamano);
vec.length = vec.length-1;

//vec2.unshift(15);
//vec2.push(11);


for(var i=0;i<vec2.length;i++){
  vec2[i]=i
}

vec.shift();
vec.push(11);
console.log(vec);
console.log(vec2);


//------------------------FUNCIÓN ALEATORIO---------------------------
function aleatorio(min,max){
  var resultado;
  resultado = Math.floor(Math.random()*(max - min +1)) + min;
  return resultado;
}
//--------------------------------------------------------------------
