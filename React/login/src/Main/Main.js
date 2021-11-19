import React from "react";
import { Link, Outlet } from "react-router-dom";

function Main() {
    return (
        <>
            <div>
                <nav>
                    <Link to="/app/main/home">Home</Link>
                    <Link to="/app/main/about">About</Link>
                    <Link to="/app/main/users">Users</Link>
                </nav>
                
                <Outlet />  

            </div>
        </>
    );
}

export { Main };