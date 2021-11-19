import React from "react";
import "./styles/CreateTodoButton.css"
import { TodoContext } from "./TodoContext.js";

function CreateTodoButton(props) {

    const {setOpenModal} = React.useContext(TodoContext);

    function openModalFunction() {
        console.log("Abrí el modal");
        setOpenModal(true);
    }
    
    return(
        <button className="button-add" onClick={openModalFunction}>Agregar Tarea</button>
    )
}

export { CreateTodoButton };