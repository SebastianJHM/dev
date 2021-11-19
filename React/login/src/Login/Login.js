import React from "react";
import { useNavigate } from "react-router-dom";
import "./Login.css"

function Login(props) {

    const [contrasenaIngresada, setContrasenaIngresada] = React.useState("");
    const [contrasenaIncorrecta, setContrasenaIncorrecta] = React.useState(false);
    const navigate = useNavigate();
    
    async function digestMessage(message) {
        const msgUint8 = new TextEncoder().encode(message);                           // encode as (utf-8) Uint8Array
        const hashBuffer = await crypto.subtle.digest('SHA-256', msgUint8);           // hash the message
        const hashArray = Array.from(new Uint8Array(hashBuffer));                     // convert buffer to byte array
        const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join(''); // convert bytes to hex string
        return hashHex;
    }

    async function verificarContrasenna() {
        const digestBuffer = await digestMessage(contrasenaIngresada);
        const c = "2d711642b726b04401627ca9fbac32f5c8530fb1903cc4db02258717921a4881";
        if (digestBuffer === c) {
            props.setLoggedIn(true);    
            navigate('/main');
        } else {
            setContrasenaIncorrecta(true);
        }
    }

    function ingresar(ev) {
        setContrasenaIngresada(ev.target.value)
    }

    return(
        <>
            <div className="login-page">
                <div className="login-card">
                    <h1>Credenciales</h1>
                    <input className="input-login" type="password" value={contrasenaIngresada} onInput={ingresar} />
                    <button className="button-login" onClick={verificarContrasenna}>Entrar</button>
                </div>
                {contrasenaIncorrecta && <div className="contrasena-incorrecta">Contrasena incorrecta</div>}
                
            </div>
        </>
    );
}

export { Login };