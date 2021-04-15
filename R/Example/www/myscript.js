var i;
elementslist = document.getElementsByClassName("header");
for( i=0; i < elementslist.length; i++ ) {
    elementslist[i].addEventListener('click', seleccionar);
}
function seleccionar(evento){
    alert("He presionado el div que dice: " + evento.path[0].innerHTML);
    console.log(evento);
    console.log(evento.path[0].innerHTML)
}