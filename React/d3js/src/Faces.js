import React from "react";
import { Face } from "./Face.js"

function Faces() {
    const width = 160;
    const height = 160;

    const faces = [];
    for (let i = 0; i < 5; i++) {
        const SW = 4 + Math.random() * 10;
        faces.push({
            width: width,
            height: height,
            strokeWidth: SW,
            radius: width/2-SW/2,        
            eyeRadius: 8 + Math.random() * 6,
            innerRadiusMouth: 40 + Math.random() * 10,
            outerRadiusMouth: 50 + Math.random() * 10
        })
    }

    return(
        faces.map((face, index) => (
            <Face key={index} width={face.width} height={face.height} strokeWidth={face.strokeWidth} radius={face.radius} eyeRadius={face.eyeRadius} innerRadiusMouth={face.innerRadiusMouth} outerRadiusMouth={face.outerRadiusMouth}/>
        ))
    )
}

export { Faces };
