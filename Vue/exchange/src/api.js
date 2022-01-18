const url = 'https://api.coincap.io/v2'

async function getAssets() {
    try {
        const res = await fetch(`${url}/assets?limit=20`, {
            mode: "cors",
            method: "GET",
            headers: {
                Accept: "application/json",
            },
        });
        const res_json = await res.json();
        return res_json.data;
    } catch (e) {
        console.log(e);
        getAssets();
    }
}

async function getAsset(coin) {
    const res = await fetch(`${url}/assets/${coin}`);
    const res_json = await res.json();
    return res_json.data;
}

async function getAssetHistory(coin) {
    const now = new Date();
    const end = now.getTime();
    now.setDate(now.getDate() - 1);
    const start = now.getTime();

    const res = await fetch(
        `${url}/assets/${coin}/history?interval=h1&start=${start}&end=${end}`
    );
    const res_json = await res.json();
    return res_json.data;
}

const getMarkets = async (coin) => {
    let res = await fetch(`${url}/assets/${coin}/markets?limit=5`);
    res = await res.json();
    return res.data;
};

const getExchange = async (id) => {
    let res = await fetch(`${url}/exchanges/${id}`);
    res = await res.json();
    return res.data;
};


export default { getAssets, getAsset, getAssetHistory, getMarkets, getExchange };