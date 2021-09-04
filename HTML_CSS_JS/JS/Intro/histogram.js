function generate_data(n, a, b) {
    x = []
    for (let i = 0; i < n; i++) {
        x.push(a + Math.random() * (b - a -1))
    }
    return x
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

function principal() {
    data  = generate_data(100, 10, 20);
    console.log(histogram(data, 5));
}

if (require.main === module) {
    principal();
}