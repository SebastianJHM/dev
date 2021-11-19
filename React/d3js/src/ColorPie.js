import React from "react";
import { arc, pie } from 'd3';
import "./styles/ColorPie.css"

// function useWindowSize() {
//     const [size, setSize] = React.useState([0, 0]);
//     React.useLayoutEffect(() => {
//         function updateSize() {
//             setSize([window.innerWidth, window.innerHeight]);
//         }
//         window.addEventListener('resize', updateSize);
//         updateSize();
//         return () => window.removeEventListener('resize', updateSize);
//     }, []);
//     return size;
// }

function useWindowSize() {
    const [w, setW] = React.useState(0);
    const [h, setH] = React.useState(0);

    React.useLayoutEffect(() => {
        setW(window.innerWidth);
        setH(window.innerHeight);
        
        function updateSize() {
            setW(window.innerWidth);
            setH(window.innerHeight);
        }
        window.addEventListener('resize', updateSize);
        return(function() {
            window.removeEventListener('resize', updateSize);
        })
    }, []);
    return [w,h];
}


function ColorPie() {
    React.useEffect(() => {
        function convertToJson(input) {
            const data = input.split("\n");
            const keys = data[0].split(",");
            const values = data.slice(1,).map((value) => value.split(","));
            const json = values.map(v => Object.assign(...keys.map((k, i) => ({ [k]: v[i] }))))
            return (json)
        }
        async function importData() {
            const url = 'https://gist.githubusercontent.com/curran/b236990081a24761f7000567094914e0/raw/cssNamedColors.csv';
            const response = await fetch(url);
            const dataText = await response.text()
            setData(convertToJson(dataText));
        }
        importData();
        
    }, [])

    const [data, setData] = React.useState(null);
    const [widthScreen, heightScreen] = useWindowSize();

    const width = 0.5*widthScreen;
    const height = 300;
    const centerX = width / 2;
    const centerY = height / 2;

    const D3ARC = arc().innerRadius(0).outerRadius(width);
    // arc({
    //     innerRadius: 0,
    //     outerRadius: 100,
    //     startAngle: 0,
    //     endAngle: Math.PI / 2
    // }); // "M0,-100A100,100,0,0,1,100,0L0,0Z"

    
    const D3PIE = pie().value(1);
    // The class pie genarate a list of object that contain principally the startAngle and endAngle
    // The value(1) is because all the arcs will hace the same radius

    // const data = [8, 15, 2, 1];
    // const pie = pie();
    // pie(data)
    // [
    //     {"data":8,"index":1,"value":8,"startAngle":3.624914600295915,"endAngle":5.558202387120403,"padAngle":0},
    //     {"data":15,"index":0,"value":15,"startAngle":0,"endAngle":3.624914600295915,"padAngle":0},
    //     {"data":2,"index":2,"value":2,"startAngle":5.558202387120403,"endAngle":6.0415243338265245,"padAngle":0},
    //     {"data":1,"index":3,"value":1,"startAngle":6.0415243338265245,"endAngle":6.283185307179585,"padAngle":0}
    // ]



    if (!data) {
        return <pre>Loading...</pre>;
    }

    
    

    return (
        <div>
            <div>Window size: {widthScreen} x {heightScreen}</div>
            <svg width={width} height={height} viewBox={`0 0 ${width} ${height}`}>
                <g transform={`translate(${centerX},${centerY})`}>
                    {D3PIE(data).map((d, index) => (
                        <path key={index} fill={d.data['RGB hex value']} d={D3ARC(d)} />
                    ))}
                </g>
            </svg>

        </div>
    );
}

export { ColorPie };