class Billete{
  constructor(v,c,n_i){
    this.valor = v;
    this.cantidad = c;
    this.imagen = new Image();
    this.imagen.src = n_i;
  }
  mostrar(){
    this.imagen.width = 150;
    this.imagen.width = 70;
    document.body.appendChild(this.imagen);
  }
}


var caja = [];
caja.push(new Billete(50,30,"billete50.jpg"));
caja.push(new Billete(20,20,"billete20.jpg"));
caja.push(new Billete(10,20,"billete10.jpg"));

resultado = document.getElementById("resultado");
boton = document.getElementById("extraer");
boton.addEventListener("click",entregarDinero);

var dt = document.getElementById("actual");
var b50 = document.getElementById("b50");
var b20 = document.getElementById("b20");
var b10 = document.getElementById("b10");

var dinero_total = 0;
for(var i in caja){
  dinero_total = dinero_total + caja[i].valor*caja[i].cantidad;
}

dt.value = dinero_total;
b50.value = caja[0].cantidad;
b20.value = caja[1].cantidad;
b10.value = caja[2].cantidad;

var dinero = 0;
var div = 0;
var papeles = 0;
function entregarDinero(){
  var t = document.getElementById("numb");
  var dinero = parseInt(t.value);
  var entrega = new Array();
  var cant = new Array();
  resultado.innerHTML = "";

  //-------------CALCULO DINERO TOTAL EN EL BANCO------------------------
  dinero_total = 0;
  for(var i in caja){
    dinero_total = dinero_total + caja[i].valor*caja[i].cantidad;
  }
  console.log(dinero_total)
  //---------------------------------------------------------------------

  //----------------------------------ENTREGA DEL DINERO-----------------------------------------
  if (dinero <= dinero_total){
    for(var i in caja){
      if (dinero > 0){
        div = Math.floor(dinero/caja[i].valor);

        if (div >= caja[i].cantidad){
          papeles = caja[i].cantidad;
        }else{
          papeles = div;
        }
        cant.push(papeles);
        dinero = dinero - (caja[i].valor*papeles);
        for(var j=1; j<=papeles;j++){
          entrega.push(caja[i]);
        }
      }
    }
    if (dinero > 0){
      resultado.innerHTML = "No hay forma de entregarte esa cantidad.";
    }else{
      dt.value = dt.value - parseInt(t.value);
      b50.value -= cant[0];
      b20.value -= cant[1];
      b10.value -= cant[2];

      for(i in caja){
        caja[i].cantidad -= cant[i];
      }

      for(i=0;i<entrega.length;i++){
        if (i<entrega.length -1 ){
          if (entrega[i].valor == entrega[i+1].valor){
            resultado.innerHTML = resultado.innerHTML + "<img src=" + entrega[i].imagen.src + " width=100 height=50 />"+" ";
          }else{
            resultado.innerHTML = resultado.innerHTML + "<img src=" + entrega[i].imagen.src + " width=100 height=50 />"+"<br />";
          }
        }else{
          resultado.innerHTML = resultado.innerHTML + "<img src=" + entrega[i].imagen.src + " width=100 height=50 />"+"<br />";
        }


      }
      }
    }else{
    resultado.innerHTML = "No hay papeles, cabron";
  }
  //----------------------------------------------------------------------------------------------------

}
