import React from 'react';

function useLocalStorage(localStorageName, initialValue) {
    const [myItem, setMyItem] = React.useState(initialValue);
    const [loading, setLoading] = React.useState(true);
    const [error, setError] = React.useState(false);

    React.useEffect(function() {
        setTimeout(function() {
            try {
                const localStorageItem = localStorage.getItem(localStorageName);
                setMyItem(localStorageItem ? JSON.parse(localStorageItem) : initialValue);
                !localStorageItem && localStorage.setItem(localStorageName, JSON.stringify(initialValue));
                setLoading(false);
            } catch(e) {
                setError(true);
            }
        }, 3000)
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);
    
    
    function saveMyItem(newItem) {  
        setMyItem(newItem);
        localStorage.setItem(localStorageName, JSON.stringify(newItem));
    }

    return {myItem, saveMyItem, loading, error};
}


const TodoContext = React.createContext();

function TodoProvider(props) {
    const {myItem: todos, saveMyItem: saveTodos, loading: loadingService, error: errorService} = useLocalStorage("TODOS_V1", []);
    const [searchValue, setSearchValue] = React.useState("");
    const [openModal, setOpenModal] = React.useState(false);
    const completedTodos = todos.filter((todo) => (todo.completed === true)).length
    const totalTodos = todos.length;
    const searchedTodos = todos.filter((todo) => (todo.text.includes(searchValue)));
    function globalDeleteTodo(id) {
        const todosNotDeleted = todos.filter((todo) => (todo.id !== id));
        saveTodos(todosNotDeleted);
    }
    function globalChangeStateCompleteTodo(id) {
        const newTodos = [...todos];
        const i = newTodos.findIndex((todo) => (todo.id === id));
        newTodos[i].completed = !todos[i].completed;
        saveTodos(newTodos);
    }
    const values = { 
        todos,
        saveTodos,
        completedTodos, 
        totalTodos, 
        searchValue, 
        setSearchValue, 
        searchedTodos, 
        globalDeleteTodo, 
        globalChangeStateCompleteTodo, 
        loadingService, 
        errorService,
        openModal,
        setOpenModal,
    }
    
    return(
        <TodoContext.Provider value={values}>
            {props.children}
        </TodoContext.Provider>
    )
}

export { TodoContext, TodoProvider };