import React from "react";
import { TodoContext } from "./TodoContext";
import "./styles/FormModal.css"

function FormModal() {
    const [newTodoText, setNewTodoText] = React.useState("");
    const {openModal, setOpenModal, todos, saveTodos} = React.useContext(TodoContext)

    function cancelNewTodo() {
        setOpenModal(false);
    }

    function addNewTodo(event) {
        event.preventDefault();
        const newId = String(Math.max(...todos.map(todo => Number(todo.id))) + 1);
        const newTodo = {id: newId, text: newTodoText, completed: false};
        const newTodos = [...todos];
        newTodos.push(newTodo);
        saveTodos(newTodos);
        setNewTodoText("");
        setOpenModal(false);
    }

    function inputNewTodo(event) {
        console.log(event.target.value);
        setNewTodoText(event.target.value);
    }

    return(
        <div className={`modal-container ${openModal ? "a-open-modal" : ""}`}>
            <form onSubmit={addNewTodo}>
                <h3><span>Agregar nueva tarea</span></h3>
                <textarea className="new-todo-input" placeholder="Mi siguiente tarea es ..." value={newTodoText} onInput={inputNewTodo}></textarea>
                <div className="buttons-container">
                    <button className="new-todo-button" type="submit">Agregar</button>
                    <button className="new-todo-button" type="button" onClick={cancelNewTodo}>Cancelar</button>
                </div>
            </form>
        </div>
    )
}

export { FormModal }