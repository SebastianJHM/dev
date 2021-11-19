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

function Bar2() {

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
    const width = 700;
    const height = 300;
    const margin = { top: 10, right: 20, bottom: 20, left: 150 };
    const innerHeightBars = height - margin.top - margin.bottom;
    const innerWidthBars = width - margin.left - margin.right;

    console.log(data)
    if (!data) {
        return <pre>Loading...</pre>;
    }
    
    const yScale = scaleBand()
        .domain([...data.map(d => d.Country)])
        .range([0, innerHeightBars])
        .paddingInner(0.08)
        .paddingOuter(0)
        .align(0.5);

    const xScale = scaleLinear()
        .domain([0, Math.max(...data.map(d => d.Population))])
        .range([0, innerWidthBars]);

    console.log(yScale.domain());
    console.log(xScale.ticks());
    return (
        <>
            <div className="bar2-container">
                <svg width={width} height={height} viewBox={`0 0 ${width} ${height}`}>
                    <g transform={`translate(${margin.left},${margin.top})`}>
                        {xScale.ticks().map(t => (
                            <g key={t} transform={`translate(${xScale(t)},0)`}>
                                <line x1={0} y1={0} x2={0} y2={innerHeightBars} stroke="red"/>
                                <text x={0} y={innerHeightBars+3} dy=".71em" style={{ textAnchor: 'middle', fontSize: "12px", fontWeight: "bolder"}}>{t}</text>
                            </g>
                        ))}
                        {yScale.domain().map(d => (
                            <g key={d} transform={`translate(0,${yScale(d)+yScale.bandwidth()/2})`}>
                                <line x1={0} y1={0} x2={innerWidthBars} y2={0} stroke="blue"/>
                                <text x={-3} y={0} dy=".36em" style={{ textAnchor: 'end', fontSize: "12px", fontWeight: "bolder"}}>{d}</text>
                            </g>
                        ))}
                        {data.map((d) => (
                            <path key={d.Country} d={roundedRect(0, yScale(d.Country), xScale(d.Population), yScale.bandwidth(), 6, false, true, false, true)} />
                        ))}
                        
                    </g>
                </svg>
            </div>
        </>
    )
}

export { Bar2 };