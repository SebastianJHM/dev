optionList = document.getElementsByClassName("option-choose");
for (option of optionList) {
    option.addEventListener("click", seleccionar);
}

function seleccionar(evento) {
    console.log(evento);

    initIconList = document.getElementsByClassName("init-icon");
    for (var ii of initIconList) {
        ii.style.setProperty('display', 'none');
    }

    for (var p of evento.path) {
        if (p.localName == "div") {
            if (p.className.startsWith("option-choose")) {
                tag_class = p.className
                object_user = tag_class.split(" ")[1].substring(2,);
                // console.log(object)
                break;
            }
        }
    }
    
    class_icon_user = "container-icon c-" + object_user + " sup";

    userSelections = document.getElementsByClassName("container-icon");
    // console.log(userSelections);
    for(var j=0;j<3;j++) {
        if (userSelections[j].className != class_icon_user ) {
            // console.log(userSelections[j]);
            // userSelections[j].style.display = "none";
            userSelections[j].style.setProperty('display', 'none');
        } else {
            // console.log(userSelections[j]);
            // userSelections[j].style.display = "initial";
            userSelections[j].style.setProperty('display', 'initial');
        }
    }

    jugar(object_user);
};

function jugar(object_user) {
    const machine_options = ["rock", "papper", "scissor"];
    const position = Math.floor(Math.random() * machine_options.length);
    var selected_option_machine = machine_options[position];
    
    class_icon_machine = "container-icon-M c-" + selected_option_machine + " supM";

    userSelectionsM = document.getElementsByClassName("container-icon-M");
    console.log(userSelectionsM);
    for(var j=0;j<3;j++) {
        if (userSelectionsM[j].className != class_icon_machine) {
            // console.log(userSelections[j]);
            // userSelections[j].style.display = "none";
            userSelectionsM[j].style.setProperty('display', 'none');
        } else {
            // console.log(userSelections[j]);
            // userSelections[j].style.display = "initial";
            userSelectionsM[j].style.setProperty('display', 'initial');
        }
    }
    
    setTimeout(function () {
        if (object_user == selected_option_machine) {
            alert("Empate");
        }
        if ((object_user == "rock" && selected_option_machine == "scissor") ||
            (object_user == "scissor" && selected_option_machine == "papper") ||
            (object_user == "papper" && selected_option_machine == "rock")){
            alert("Gana el usuario");
        } else {
            alert("Gana la máquina");
        }
    }, 300);
};
            