let input_file = document.getElementById("input-file");
input_file.onchange = async function(ev) {
    // this.files es equivalente a input_file.files
    // console.log(this.files === input_file.files)
    // >>> true

    const myFile = this.files[0];
    process_file(myFile);
}

let input_drag_drop = document.getElementById("label-input-file");
input_drag_drop.ondrop = function(ev) {
    console.log('Fichero(s) arrastrados');

    // Evitar el comportamiendo por defecto (Evitar que el fichero se abra/ejecute)
    ev.preventDefault();

    console.log(ev.dataTransfer.files);

    if (ev.dataTransfer.files.length == 1) {
        if (ev.dataTransfer.files[0].type == "text/plain") {
            myFile = ev.dataTransfer.files[0];
            process_file(myFile);
        } else {
            document.getElementById("label-input-file").innerHTML = `
                <span style="font-weight: bolder;">👀</span>
                <span>El archivo tiene que ser un .txt</span>
            `;
        }
    } else {
        document.getElementById("label-input-file").innerHTML = `
            <span style="font-weight: bolder;">👀</span>
            <span>Arratre un solo archivo</span>
        `;
    }
    // Pasar el evento a removeDragData para limpiar
    removeDragData(ev);
}
input_drag_drop.ondragover = function(ev) {
    console.log('File(s) in drop zone');
    input_drag_drop.style.backgroundColor = "red";
    input_drag_drop.style.border = "dotted";
    // Prevent default behavior (Prevent file from being opened)
    ev.preventDefault();
}
function removeDragData(ev) {
    console.log('Removing drag data');
    input_drag_drop.removeAttribute("style");
    ev.dataTransfer.clearData();
}

async function process_file(file) {
    document.getElementById("label-input-file").innerHTML = `
        <span style="font-weight: bolder;">Archivo seleccionado: </span>
        <span>${file.name}</span>
    `;

    myArray = await fileTOarray(file);
    console.log("ARRAY:::=>", myArray);
    console.log(histogram(myArray, 10));
}


function fileTOarray(file) {
    const promise = new Promise((resolve, reject) => {
        let reader = new FileReader();
        reader.onload = function () {
            const lines = reader.result.split(/\r\n|\n/);
            const lines_number = lines.map(line => {
                if (!isNaN(Number(line))) {
                    return Number(line)
                } else { 
                    return Number(line.replace(",", "."))
                }

            });
            resolve(lines_number);
        };
        reader.onerror = reject;
        reader.readAsText(file);
    });
    return promise;
}

function histogram(data, num_bin) {
    const li = Math.min(...data);
    const ls = Math.max(...data);

    const range = (ls - li) / num_bin;

    const bin_edges = [li];
    for( let i = 0; i < num_bin; i++) {
        bin_edges.push(bin_edges[bin_edges.length-1] + range);
    }

    const frequencies = [];
    for( let i = 0; i < num_bin; i++) {
        f = data.filter((x) => {
            return x >= bin_edges[i] && x <= bin_edges[i+1]
        }).length
        frequencies.push(f);
    }
    
    return {
        "bin_edges": bin_edges,
        "frequencies": frequencies
    }
}