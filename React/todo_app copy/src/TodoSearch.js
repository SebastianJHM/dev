import React from "react";
import "./styles/TodoSearch.css"
import { TodoContext } from "./TodoContext";


function TodoSearch() {
    
    const {searchValue, setSearchValue} = React.useContext(TodoContext);

    function searchTodo(event) {
        console.log(event.target.value);
        setSearchValue(event.target.value);
    }

    return(
        <>
            <input className="search" placeholder="Buscar tarea ..." value={searchValue} type="text" onInput={searchTodo} />
        </>
    )
}

export { TodoSearch };