import './styles/App.css';
import React from 'react';
import { Faces } from "./Faces.js"
import { ColorPie } from "./ColorPie.js"
import { Bar1 } from "./Bar1.js"
import { Bar2 } from "./Bar2.js"
import { Map } from "./Map.js"
function App() {
    return (
        <>
            <h1>LEARNING D3.js</h1>

            <h2>Caras</h2>
            <Faces />

            <h2>Pastel de colores</h2>
            <ColorPie />

            <h2>Bar Chart</h2>
            <Bar1 />

            <h2>Bar Chart: Axis</h2>
            <Bar2 />

            <h2>Mapa</h2>
            <Map />

        </>
    );
}

export default App;
