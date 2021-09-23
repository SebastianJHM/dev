import React from "react";
import "./styles/TodoCounter.css"
import { TodoContext } from "./TodoContext";


const style_title = {
    fontSize: "30px",
    fontWeight: "700",
    marginBottom: "0px",
    textTransform: "uppercase"
}

function TodoCounter(props) {
    
    const {completedTodos, totalTodos} = React.useContext(TodoContext);

    return(
        <>
            <h1 style={style_title}>¿Qué pasa?</h1>
            <h2>Haz completado {completedTodos} de {totalTodos} tareas</h2>
        </>
    )
}

export { TodoCounter };