new Chart(document.getElementById("myChart"), {
    type: 'bar',
    data: {
        labels: ["January", "February", "March", "April", "May", "June", "July"],
        datasets: [{
            label: "My First dataset",
            //new option, type will default to bar as that what is used to create the scale
            type: "line",
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [65, 59, 4, 81, 56, 55, 40],
            tension: 0.4,
            //fill: true
        }, {
            label: "My First dataset",
            //new option, type will default to bar as that what is used to create the scale
            type: "bar",
            fillColor: "rgba(220,20,220,0.2)",
            strokeColor: "rgba(220,20,220,1)",
            pointColor: "rgba(220,20,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [32, 25, 33, 88, 12, 92, 33]
        }]
    },
    options: {
      scales: {
        xAxes: [{
          display: true,
          stacked: true,
          scaleLabel: {
            display: true,
            labelString: 'Days'
          },
        }, {
          id: 'invoice-time',
          type: 'linear',
          display: false,
          stacked: false,
          scaleLabel: {
            display: false,
            labelString: 'Days'
          },
          ticks: {
            beginAtZero: true,
            stepSize: 1,
            suggestedMax: 125
          }
        }],
        yAxes: [{
          display: true,
          stacked: true,
          scaleLabel: {
            display: true,
            labelString: 'Dollar Amount'
          },
          ticks: {
            beginAtZero: true,
          }
        }, {
          id: 'invoice-amount',
          display: false,
          stacked: false,
          scaleLabel: {
            display: false,
            labelString: 'Dollar Amount'
          },
          ticks: {
            beginAtZero: true,
          }
        }]
      },
    }
  });