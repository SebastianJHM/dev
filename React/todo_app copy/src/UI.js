import React from 'react';
import { TodoCounter } from './TodoCounter.js';
import { TodoSearch } from './TodoSearch.js';
import { TodoList } from './TodoList.js';
import { TodoItem } from './TodoItem.js';
import { CreateTodoButton } from './CreateTodoButton.js';
import { TodoContext } from './TodoContext.js'
import { Modal } from './Modal.js'
import { FormModal } from './FormModal.js'
import { Skeleton } from './Skeleton.js'

function UI() {
    const {todos, searchValue,searchedTodos, loadingService, errorService, openModal} = React.useContext(TodoContext);
    return(
        <>
            <TodoCounter />
            <TodoSearch />
            <TodoList>
                {loadingService && <Skeleton />}
                {(errorService === true) && <p style={{marginBottom: "20px"}}>Tenemos un error ... </p>}
                {(loadingService === false && todos.length === 0) && <p>Crea tu primer TODO</p>}
                {
                    searchValue.length > 1
                    ?
                    searchedTodos.map((todo) => (
                        <TodoItem text={todo.text} key={todo.id} id={todo.id} completed={todo.completed} />
                    ))
                    :
                    todos.map((todo) => (
                        <TodoItem text={todo.text} key={todo.id} id={todo.id} completed={todo.completed} />
                    ))
                }

            </TodoList>
            <CreateTodoButton />
            <Modal>
                <div className={`background-modal ${openModal ? "open-modal" : "close-modal"}`}>
                    <FormModal />
                </div>
            </Modal>
        </>       
    )
}

export { UI }