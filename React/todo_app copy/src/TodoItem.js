import React from "react";
import { ReactComponent as DeleteIcon }  from "./assets/delete.svg";
import { ReactComponent as CheckedIcon }  from "./assets/checked.svg";
import { ReactComponent as GearIcon }  from "./assets/gear.svg";
import "./styles/TodoItem.css";
import { TodoContext } from "./TodoContext";

function TodoItem(props) {

    const {globalDeleteTodo, globalChangeStateCompleteTodo} = React.useContext(TodoContext);

    function changeStateCompleteTodo() {
        globalChangeStateCompleteTodo(props.id);
    }

    function deleteTodo() {
        globalDeleteTodo(props.id);
    }

    return(
        <>
            <li>
                <div className="todo-container">
                    <div className="s1">
                        {props.completed === true ? 
                            <CheckedIcon className="state-icon checked-icon" onClick={changeStateCompleteTodo} />  
                        :
                            <GearIcon className="state-icon gear-icon" onClick={changeStateCompleteTodo} />  
                        }
                        
                    </div>
                    <div className="s2">
                        <span className={`todo-title ${props.completed ? "todo-completed" : ""}`}>TODO {props.id}</span>
                        <DeleteIcon className="delete-icon" onClick={deleteTodo}/>
                        <p className="todo-text">{props.text}</p>
                    </div>
                </div>
            </li>
        </>
    )
}

export { TodoItem };