import { Navigate, Route, Routes } from "react-router";
import { Link } from "react-router-dom";
import { About } from "./Components/About";
import { Home } from "./Components/Home";
import { Users } from "./Components/Users";
import { Main } from "./Main";

function Middle() {
    const x = "hola";
    return (
        <Routes>
            <Route path="/*" element={<Navigate to="/app/main" />} />
            <Route path="/main/*" element={<Main />} >
                <Route path="*" element={<Navigate to="/app/main/home" />} />
                <Route path="home" element={<Home data={x} />} />
                <Route path="about" element={<About />} />
                <Route path="users" element={<Users />} />
            </Route>
        </Routes>
    );
}

export { Middle };