var options = {
    data: {
        labels: [1, 2, 3, 4, 5, 6, 7],
        datasets: [{
            type: 'line',
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            borderColor: 'pink',
            backgroundColor: 'pink'
        },
        {
            type: 'scatter',
            label: '# of Points',
            data: [{
                x: 2,
                y: 6
            }, {
                x: 4,
                y: 8
            }, {
                x: 5,
                y: 18
            }, {
                x: 6,
                y: 12
            }],
            pointRadius: 8,
            borderColor: 'blue',
            backgroundColor: 'blue'
        },
        {
            labels: [1, 2, 3, 4, 5, 6, 7],
            type: 'line',
            label: '# of Votes',
            data: [8, 1, 9, 9, 3],
            borderColor: 'red',
            backgroundColor: 'red',
            cubicInterpolationMode: 'monotone',
            tension: 0.4
        },
        {
            type: 'bar',
            label: '# of Points2',
            data: [null, 3, null, 18, null, 8, null],
            borderColor: 'lightblue',
            backgroundColor: 'lightblue',
            barPercentage: 2.2,

        },
        ]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    reverse: false
                }
            }]
        }
    }
}

var ctx = document.getElementById('chartJSContainer').getContext('2d');
new Chart(ctx, options);