// Puntuación de los jugadores
let userScore = 0;
let cpuScore = 0;

// Selección de una opción mediante el click de la imagen
let rock_option = document.getElementById("rock-option");
let paper_option = document.getElementById("paper-option");
let scissor_option = document.getElementById("scissor-option");

// Actualización de los resultados
let user_text_result = document.getElementById("user-result-text");
let cpu_text_result = document.getElementById("machine-result-text");

// Elemnto de los modales
let modal = document.getElementById("modal");
let container_card_modal = document.getElementById("container-card-modal");
let button_modal = document.getElementById("button-modal");

function getCpuChoice() {
    const cpu_options = ["rock", "paper", "scissor"];
    const position = Math.floor(Math.random() * cpu_options.length);
    return cpu_options[position];
}

function win(user_choice, cpu_choice) {
    console.log("ganas");
    userScore++;
    user_text_result.innerHTML = userScore;
    container_card_modal.innerHTML = `<div class="card-modal">
                                        <h2 class="title-modal win">You win!</h2>
                                        <p class="selection-user">You choose ${user_choice}</p>
                                        <p class="selection-cpu">The cpu choose ${cpu_choice}</p>
                                        <button class="button-modal" id="button-modal" onclick="modal.style.display='none'">CLOSE</button>
                                    </div>`
    modal.style.display = "block";
}

function lose(user_choice, cpu_choice) {
    console.log("pierdes");
    cpuScore++;
    cpu_text_result.innerHTML = cpuScore;
    container_card_modal.innerHTML = `<div class="card-modal">
                                        <h2 class="title-modal lose">You lose!</h2>
                                        <p class="selection-user">You choose ${user_choice}</p>
                                        <p class="selection-cpu">The cpu choose ${cpu_choice}</p>
                                        <button class="button-modal" id="button-modal" onclick="modal.style.display='none'">CLOSE</button>
                                    </div>`
    modal.style.display = "block";
}

function draw(user_choice, cpu_choice) {
    console.log("empata");
    cpuScore += 0;
    userScore += 0;
    user_text_result.innerHTML = userScore;
    cpu_text_result.innerHTML = cpuScore;
    container_card_modal.innerHTML = `<div class="card-modal">
                                        <h2 class="title-modal draw">It's draw</h2>
                                        <p class="selection-user">You choose ${user_choice}</p>
                                        <p class="selection-cpu">The cpu choose ${cpu_choice}</p>
                                        <button class="button-modal" id="button-modal" onclick="modal.style.display='none'">CLOSE</button>
                                    </div>`
    modal.style.display = "block";
}

function play(user_choice) {
    cpu_choice = getCpuChoice()
    console.log(user_choice, cpu_choice);
    switch (user_choice + " " + cpu_choice) {
        case 'rock scissor':
        case 'paper rock':
        case 'scissor paper':
            win(user_choice, cpu_choice);
            break;
        case 'rock paper':
        case 'paper scissor':
        case 'scissor rock':
            lose(user_choice, cpu_choice);
            break;
        case 'rock rock':
        case 'paper paper':
        case 'scissor scissor':
            draw(user_choice, cpu_choice);
            break;
    }
}

function main() {
    rock_option.addEventListener('click', function (evento) {
        console.log(evento);
        play('rock');
    });

    paper_option.addEventListener('click', function (evento) {
        console.log(evento);
        play('paper');
    })

    scissor_option.addEventListener('click', function (evento) {
        console.log(evento);
        play('scissor');
    })
}

main();


window.addEventListener('click', clearModal);
function clearModal(evento) {
    console.log(evento);
    console.log(evento.target);
    if (evento.target.className == "container-card-modal") {
        modal.style.display = "none"
    }
}

button_reset = document.getElementById("reset-button");

button_reset.addEventListener('click', resetGame);
function resetGame(evento) {
    cpuScore = 0;
    userScore = 0;
    user_text_result.innerHTML = userScore;
    cpu_text_result.innerHTML = cpuScore;
}