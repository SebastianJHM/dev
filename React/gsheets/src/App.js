import './styles/App.css';
import { GoogleSpreadsheet } from "google-spreadsheet"
import React from "react"
import { Bar } from 'react-chartjs-2';

function App() {


    const [x, setX] = React.useState([]);
    const [y, setY] = React.useState([]);


    React.useEffect(function () {

        async function loadGoogleSpreadsheet() {
            const miDocumento = new GoogleSpreadsheet(process.env.REACT_APP_SHEET_ID);
            console.log(miDocumento);
            await miDocumento.useServiceAccountAuth({
                client_email: process.env.REACT_APP_GOOGLE_SERVICE_ACCOUNT_EMAIL,
                private_key: process.env.REACT_APP_GOOGLE_PRIVATE_KEY,
            });
            await miDocumento.loadInfo();
            console.log(miDocumento.title);
            console.log(miDocumento.rowCount);

            const miHoja = miDocumento.sheetsByIndex[0];

            const registros = await miHoja.getRows();
            console.log(registros);
            const x__ = registros.map((r) => r.x);
            const y__ = registros.map((r) => r.y);
            setX(x__);
            setY(y__);



            // await miHoja.loadCells('A:B')
            // console.log(miHoja.cellStats);
            // const a1 = miHoja.getCell(0, 0);
            // console.log(a1.value);
            // const b8 = miHoja.getCellByA1('B8');
            // console.log(b8.value)

        }

        loadGoogleSpreadsheet();
    }, []);

    const state = {
        labels: x,
        datasets: [
            {
                label: 'Rainfall',
                backgroundColor: 'rgba(75,192,192,1)',
                borderColor: 'rgba(0,0,0,1)',
                borderWidth: 2,
                data: y
            }
        ]
    }
    const options = { scales: { yAxes: [{ ticks: { beginAtZero: true, fontSize: 16 } }], xAxes: [{ ticks: { beginAtZero: true, fontSize: 16 } }] } }

    const [inputX, setInputX] = React.useState("");
    const [inputY, setInputY] = React.useState("");

    async function sendData(event) {
        event.preventDefault()
        const miDocumento = new GoogleSpreadsheet("1yL5ct8B7k8zxMuO7yRpml2kPpUhgWXjx4bD6lpNRv6w");
        await miDocumento.useServiceAccountAuth({
            client_email: process.env.REACT_APP_GOOGLE_SERVICE_ACCOUNT_EMAIL,
            private_key: process.env.REACT_APP_GOOGLE_PRIVATE_KEY,
        });
        await miDocumento.loadInfo();
        const miHoja = miDocumento.sheetsByIndex[0];
        await miHoja.addRow({ x: inputX, y: inputY });
        setInputX("");
        setInputY("");
    }
    async function reloadData() {
        const miDocumento = new GoogleSpreadsheet("1yL5ct8B7k8zxMuO7yRpml2kPpUhgWXjx4bD6lpNRv6w");
        await miDocumento.useServiceAccountAuth({
            client_email: process.env.REACT_APP_GOOGLE_SERVICE_ACCOUNT_EMAIL,
            private_key: process.env.REACT_APP_GOOGLE_PRIVATE_KEY,
        });
        await miDocumento.loadInfo();

        const miHoja = miDocumento.sheetsByIndex[0];

        const registros = await miHoja.getRows();
        const x__ = registros.map((r) => r.x);
        const y__ = registros.map((r) => r.y);
        setX(x__);
        setY(y__);
    }

    return (
        <>
            <div className="bar">
                <Bar data={state} options={options} />
            </div>

            <h3>Enviar datos</h3>
            <form onSubmit={sendData}>
                <input type="text" onInput={(event) => setInputX(event.target.value)} value={inputX} />
                <input type="text" onInput={(event) => setInputY(event.target.value)} value={inputY} />
                <button type="submit">Enviar</button>
            </form>
            <button onClick={reloadData}>Recargar</button>
        </>
    );
}

export default App;
