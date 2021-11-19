import React from "react";
import { scaleBand, scaleLinear } from 'd3';
import "./styles/App.css"

function roundedRect(x, y, w, h, r, tl, tr, bl, br) {
    let retval;
    retval = `M${x + r},${y}`;
    retval += `h${w - (2 * r)}`;
    (tr) ? retval += `a${r},${r} 0 0 1 ${r},${r}` : retval += `h${r}v${r}`;
    retval += `v${h - (2 * r)}`;
    (br) ? retval += `a${r},${r} 0 0 1 ${-r},${r}` : retval += `v${r}h${-r}`;
    retval += `h${(2 * r) - w}`;
    (bl) ? retval += `a${r},${r} 0 0 1 ${-r},${-r}` : retval += `h${-r}v${-r}`;
    retval += `v${((2 * r) - h)}`;
    (tl) ? retval += `a${r},${r} 0 0 1 ${r},${-r}` : retval += `v${-r}h${r}`;
    retval += 'z';
    return retval;
}

function Bar1() {

    React.useEffect(() => {
        function convertToJson(input) {
            const data = input.split("\n");
            const keys = data[0].split(",");
            const values = data.slice(1,).map((value) => value.split(","));
            const json = values.map(v => Object.assign(...keys.map((k, i) => ({ [k]: v[i] }))))
            return (json)
        }
        async function importData() {
            const url = 'https://gist.githubusercontent.com/curran/0ac4077c7fc6390f5dd33bf5c06cb5ff/raw/605c54080c7a93a417a3cea93fd52e7550e76500/UN_Population_2019.csv';
            const response = await fetch(url);
            const dataText = await response.text();
            const dataJSON = convertToJson(dataText).slice(0, 10);
            dataJSON.map(function (d) {
                return d.Population = d[2020];
            })
            setData(dataJSON);

        }
        importData();
    }, [])

    const [data, setData] = React.useState(null);
    const width = 500;
    const height = 300;

    console.log(data)
    if (!data) {
        return <pre>Loading...</pre>;
    }
    // scaleBand() y scaleLinear() son interpoladores, el primero es discreto, el segundo continuo
    // scaleBand() lo usamos para que ubique cada pais a una altura y scaleLinear() para que asigne un
    // ancho a cada valor.
    // sb = d3.scaleBand().domain(["one", "two", "three", "four"]).range([0, 100])
    // v	  sb(v)
    // one	  0
    // two	  25
    // three  50
    // four	   75
    
    const yScale = scaleBand()
        .domain([...data.map(d => d.Country)])
        .range([0, height])
        .paddingInner(0.08)
        .paddingOuter(0.3)
        .align(0.5);

    const xScale = scaleLinear()
        .domain([0, Math.max(...data.map(d => d.Population))])
        .range([0, width]);

    return (
        <div className="bar1-container">
            <svg width={width} height={height} viewBox={`0 0 ${width} ${height}`}>
                {data.map((d) => (
                    <path key={d.Country} d={roundedRect(0, yScale(d.Country), xScale(d.Population), yScale.bandwidth(), 8, false, true, false, true)} />
                    // <rect
                    //     key={d.Country}
                    //     x="0"
                    //     y={yScale(d.Country)}
                    //     width={xScale(d.Population)}
                    //     height={yScale.bandwidth()}
                    // />
                ))}
            </svg>
        </div>
    )
}

export { Bar1 };