import React from 'react';
import './styles/App.css';
import { TodoProvider } from './TodoContext.js'
import { UI } from './UI.js'

// const defaultTodos = [
//     { id:"1", text: "Up on melancholy hill there's a plastic tree are you here with me? just looking out on the day of another dream", completed: false},
//     { id:"2", text: "Well you can't get what you want but you can get me so let's set out to sea, love because you are my medicine when you're close to me when you're close to me", completed: true},
//     { id:"3", text: "So call in the submarines around the world we'll go does anybody know, love if we're looking out on the day of another dream?", completed: false},
//     { id:"4", text: "Up on melancholy hill sits a manatee just looking out for the day When you're close to me when you're close to me when you're close to me", completed: true},
// ]
// localStorage.setItem("TODOS_V1", JSON.stringify(defaultTodos));


function App(props) {

    // // Como queremos que los todos además de guardarse en el estado de la aplicación
    // // se guarde en el localStorage no es suficiente usar la function setTodos que retorna
    // // React.useState, sino que debemos definir nuestro propio hook que debe comenzar por la palabra
    // // "use" pero la diferencia será que la función saveTodos también guardará en localStorage
    // // const [todos, setTodos] = React.useState(defaultTodos);
    // const {myItem: todos, saveMyItem: saveTodos, loading: loadingService, error: errorService} = useLocalStorage("TODOS_V1", []);

    // const [searchValue, setSearchValue] = React.useState("");

    // // Componente TodoCounter
    // const completedTodos = todos.filter((todo) => (todo.completed === true)).length
    // const totalTodos = todos.length;

    // // Componente TodoSeaqrch
    // const searchedTodos = todos.filter((todo) => (todo.text.includes(searchValue)));
    
    // // Componente TodoItem
    // function globalDeleteTodo(id) {
    //     const todosNotDeleted = todos.filter((todo) => (todo.id !== id));
    //     saveTodos(todosNotDeleted);
    // }

    // function globalChangeStateCompleteTodo(id) {
    //     const newTodos = [...todos];
    //     const i = newTodos.findIndex((todo) => (todo.id === id));
    //     newTodos[i].completed = !todos[i].completed;
    //     saveTodos(newTodos);
    // }

    // // REACT USE EFFECT
    // // El use effect es una función que se ejecuta justo antes del renderizado de la aplicación
    // // El segundo parámetro le dice al use Effect que se ejecute solo cuando el valor de una lista de variables
    // // Si se le pasa un [], solo se ejecutará una vez al comienzo
    // // console.log("1. Antes del use effect");
    // // React.useEffect(() => {
    // //     console.log("2. Durante el use effect")
    // // },[completedTodos])
    // // console.log("3. Después del use effect ");

    // // const [loading, setLoading] = React.useState(true);
    // // React.useEffect(function() {
    // //     setTimeout(function(){
    // //         setLoading(false);
    // //     }, 2000)
    // // })
    
    return (
        <div id="myApp">
            <TodoProvider>
                <UI />
            </TodoProvider>
        </div>
    );
}

export default App;