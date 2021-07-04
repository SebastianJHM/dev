function esta_circulo(x, y) {
    dist = Math.sqrt(x ** 2 + y ** 2);
    if (dist <= 1) {
        return true;
    }
    return false;
}

function estimar_pi(num_puntos) {
    var cont_circulos = 0;
    var dentro_circ = [];
    var fuera_circ = [];
    var x;
    var y;
    for (var i = 0; i < num_puntos; i++) {
        x = Math.random() * Math.sign(Math.random() - 0.5);
        y = Math.random() * Math.sign(Math.random() - 0.5);
        if (esta_circulo(x, y) == true) {
            cont_circulos += 1;
            dentro_circ.push([x, y]);
        } else {
            fuera_circ.push([x, y]);
        }
    }
    pi = (4 * cont_circulos) / num_puntos;
    return { 
        pi, 
        dentro_circ, 
        fuera_circ 
    };
}

function principal() {
    var response;
    response = estimar_pi(10000000);
    console.log(response.pi);
}

if (require.main === module) {
    principal();
}
