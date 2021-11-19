import React from "react";
import { Login } from "./Login/Login";
import { BrowserRouter, Routes, Route, Navigate, Link, Outlet } from "react-router-dom";
import { Main } from "./Main/Main";
import "./App.css";
import { Home } from "./Main/Components/Home";
import { About } from "./Main/Components/About";
import { Users } from "./Main/Components/Users";
import { Middle } from "./Main/Middle";

function App() {
    const [loggedIn, setLoggedIn] = React.useState(false);

    console.log(loggedIn);
    const x = "hola";
    return (
        <>
            <BrowserRouter>
                <Routes>
                    <Route path="/" element={<Navigate to="/app" />} />
                    <Route path="/*" element={<Navigate to="/app" />} />
                    <Route path="/app" element={loggedIn ? <Navigate to="/app/main" /> : <Navigate to="/app/login" />} />


                    <Route path="/app/login" element={<Login setLoggedIn={setLoggedIn} />} />
                    <Route path="/app/*" element={<Middle />} />
                </Routes>
            </BrowserRouter>
        </>

    );
}

export default App;
