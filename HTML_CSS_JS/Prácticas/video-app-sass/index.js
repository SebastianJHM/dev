let peliculas = document.getElementsByClassName("main_peliculas_img")

for (let pelicula of peliculas) {
    pelicula.addEventListener("mouseover", opacar);
    pelicula.addEventListener("mouseout", normal);
}

function opacar(event) {
    for (let pelicula of peliculas) {
        pelicula.style.opacity = "0.3";
    }
    event.path[0].style.opacity = "1"
    event.path[0].style.transform = "scale(1.05)"
}

function normal(event) {
    console.log(event)
    for (let pelicula of peliculas) {
        pelicula.style.opacity = "1";
        pelicula.style.transform = "scale(1)";
    }
}

// Posicionar scroll en la mitad
const scroll_width = window.screen.width - 60;
const total_width = document.getElementById("scroll-peliculas").scrollWidth;
const percentage_free = 1 - (scroll_width/total_width)
const a = (percentage_free * total_width) / 2
document.getElementById("scroll-peliculas").scrollLeft = a;
