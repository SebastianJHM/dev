import './styles/Face.css';
import { arc } from 'd3';

function Face(props) {
    const mouthArc = arc()
        .innerRadius(props.innerRadiusMouth)
        .outerRadius(props.outerRadiusMouth)
        .startAngle(Math.PI / 2)
        .endAngle(3 * Math.PI / 2);

    return (
        <svg width={props.width} height={props.height}>
            <g transform={`translate(${props.width/2}, ${props.height/2})`}>
                <circle r={props.radius} strokeWidth={props.strokeWidth} className="background" />

                <circle r={props.eyeRadius} cx={-0.2*props.width} cy={-0.2*props.height}/>
                <circle r={props.eyeRadius} cx={0.2*props.width} cy={-0.2*props.height}/>

                <path d={mouthArc()}/>
            </g>
        </svg>
    );
}

export { Face };