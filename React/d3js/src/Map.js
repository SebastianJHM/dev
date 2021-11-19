import React from "react";
import { geoMercator, geoPath, scaleLinear } from "d3";
import "./styles/Map.css"

function Map() {
    // https://bl.ocks.org/john-guerra/43c7656821069d00dcbc
    // Data
    // https://gist.githubusercontent.com/john-guerra/43c7656821069d00dcbc/raw/be6a6e239cd5b5b803c6e7c2ec405b793a9064dd/Colombia.geo.json


    const [selectedDep, setSelectedDep] = React.useState({ dep: "", value: -1 })
    const [colors, setColors] = React.useState([]);

    const chart_width = 400;
    const chart_height = 500;

    const projection = geoMercator().scale(1500).center([-74, 4.5]).translate([chart_width * 0.4, chart_height * 0.5]);
    const projectionSanAndres = geoMercator().scale(19000).center([-81.7, 12.6]).translate([50, 30]);
    const projectionProvidencia = geoMercator().scale(19000).center([-81.3, 13.35]).translate([90, 52 ]);
    
    const path_ = geoPath().projection(projection);
    const pathSanAndres = geoPath().projection(projectionSanAndres);
    const pathProvidencia = geoPath().projection(projectionProvidencia);
    const colorScale = scaleLinear().domain([0, 1]).clamp(true).range(['rgb(255, 255, 255)', 'green']);

    const DEPARTAMENTOS = [
        "AMAZONAS", "ANTIOQUIA", "ARAUCA", "ARCHIPIELAGO DE SAN ANDRES PROVIDENCIA Y SANTA CATALINA", "ATLANTICO",
        "SANTAFE DE BOGOTA D.C", "BOLIVAR", "BOYACA", "CALDAS", "CAQUETA", "CASANARE", "CAUCA", "CESAR", "CHOCO",
        "CORDOBA", "CUNDINAMARCA", "GUAINIA", "GUAVIARE", "HUILA", "LA GUAJIRA", "MAGDALENA", "META", "NARIÑO",
        "NORTE DE SANTANDER", "PUTUMAYO", "QUINDIO", "RISARALDA", "SANTANDER", "SUCRE", "TOLIMA", "VALLE DEL CAUCA",
        "VAUPES", "VICHADA"
    ]

    React.useEffect(() => {
        const c = [...Array(33).keys()].map((i) => Math.random());
        setColors(c);
    }, [])

    const data = require("./colombia-dep.json");
    const SanAndres = data.features[data.features.length - 2];
    const Providencia = data.features[data.features.length - 1];

    function mouseOverDep(e) {
        e.target.style.fill = "rgb(90, 90, 90)";
        if (e.target.attributes.dataindex.value === "32" ) {
            document.querySelectorAll('path[dataindex="32"]').forEach(function(x) {
                x.style.fill = "rgb(90, 90, 90)";    
            })
        }
    }

    function mouseOutDep(e) {
        e.target.style.fill = colorScale(colors[e.target.attributes.dataindex.value]);
        if (e.target.attributes.dataindex.value === "32" ) {
            document.querySelectorAll('path[dataindex="32"]').forEach(function(x) {
                x.style.fill = colorScale(colors[32]);    
            })
        }
    }

    return (
        <>
            <div className="map-container">
                <svg width={chart_width} height={chart_height} viewBox={`0 0 ${chart_width} ${chart_height}`}>
                    <g>
                        <g className="map-layer">
                            {data.features.slice(0,-2).map((x, i) => (
                                <path
                                    key={x.properties.NOMBRE_DPT}
                                    d={path_(x)}
                                    datadep={x.properties.NOMBRE_DPT}
                                    dataindex={i}
                                    vectorEffect="non-scaling-stroke"
                                    style={{ fill: colorScale(colors[i]) }}
                                    onMouseOver={mouseOverDep}
                                    onMouseOut={mouseOutDep}
                                />
                            ))}
                
                            <path
                                key={SanAndres.properties.NOMBRE_DPT}
                                d={pathSanAndres(SanAndres)}
                                datadep={SanAndres.properties.NOMBRE_DPT}
                                dataindex={32}
                                vectorEffect="non-scaling-stroke"
                                style={{ fill: colorScale(colors[32]) }}
                                onMouseOver={mouseOverDep}
                                onMouseOut={mouseOutDep}
                            />
               
                            <path
                                key={Providencia.properties.NOMBRE_DPT}
                                d={pathProvidencia(Providencia)}
                                datadep={Providencia.properties.NOMBRE_DPT}
                                dataindex={32}
                                vectorEffect="non-scaling-stroke"
                                style={{ fill: colorScale(colors[32]) }}
                                onMouseOver={mouseOverDep}
                                onMouseOut={mouseOutDep}
                            />
                      
                        </g>
                    </g>
                </svg>
            </div>
        </>
    )
}

export { Map };