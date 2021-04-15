class Billete{
  constructor(v,c){
    this.valor = v;
    this.cantidad = c;
  }
}


var caja = [];
caja.push(new Billete(50,3));
caja.push(new Billete(20,2));
caja.push(new Billete(10,2));


dinero = 0;
div = 0;
papeles = 0;
var resultado = document.getElementById("resultado");

b = document.getElementById("extraer");
b.addEventListener("click",entregarDinero);

function entregarDinero(){
  var t = document.getElementById("number");
  dinero = parseInt(t.value);
  var entrega = new Array();
  resultado.innerHTML = "";

  //-------------CALCULO DINERO TOTAL EN EL BANCO------------------------
  var dinero_total = 0;
  for(var i in caja){
    dinero_total = dinero_total + caja[i].valor*caja[i].cantidad;
  }
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
        entrega.push(new Billete(caja[i].valor,papeles));
        dinero = dinero - (caja[i].valor*papeles);
      }
    }
    if (dinero > 0){
      resultado.innerHTML = "No hay forma de entregarte esa cantidad.";
    }else{
      //.innerHTML es la forma correcta de imprimir.
      //En el .html hay una linea <p> con un id, luego ese id se registro en JS en var resultado
      //hay que agregarle .innerHTML para que almacene lo que hay
      for(var e of entrega){
        resultado.innerHTML = resultado.innerHTML + e.cantidad + " billetes de " + e.valor + "<br />"
      }
    }
  }else{
    resultado.innerHTML = "No hay papeles, cabron";
  }
  //----------------------------------------------------------------------------------------------------

}
