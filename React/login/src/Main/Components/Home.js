import React from "react";

function Home(props) {
    console.log(props)
    return(
        <>
            <h2>Home</h2>
            <p>{props.data}</p>    
        </>
    );
}

export{ Home };