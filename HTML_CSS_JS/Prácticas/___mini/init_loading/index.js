function awaitSeconds(seconds) {
    promise = new Promise((resolve, reject) => {
        setTimeout(() => {
            x = "Llegó por quien llorabas"
            resolve(x);
        }, seconds*1000);
    });
    return promise;
}

async function loadPyodideLibrary() {
    let pyodide = await loadPyodide({
        indexURL: "https://cdn.jsdelivr.net/pyodide/v0.18.0/full/",
    });
    await pyodide.loadPackage("scipy");
    await pyodide.runPython("from scipy.optimize import minimize, rosen, rosen_der");
    return pyodide;
}

function modifyScreen() {
    document.getElementById("screen2").removeAttribute("style");
    document.getElementById("screen1").remove();
}

async function main() {
    document.getElementById("screen2").style.display = "none";
    // r = await awaitSeconds(5);
    const pyodide = await loadPyodideLibrary();

    modifyScreen();

    

    button = document.getElementById("mybutton");
    button.addEventListener("click", function(ev) {
        console.log(ev);
        const answer = pyodide.runPython(`
            x0 = [1.3, 0.7, 0.8, 1.9, 1.2]
            res = minimize(rosen, x0, method='Nelder-Mead', tol=1e-6)
            str(list(res.x))
        `);
        console.log(answer);

        const p = document.createElement("p");
        p.textContent = answer;
        document.querySelector("#screen2").append(p);
    })
}

main();