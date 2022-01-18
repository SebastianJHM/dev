new Vue({
    el: "#app",
    data() {
        return {
            title: "Hola Vue!",
            message1: "You loaded this page on" + new Date().toLocaleString(),
            todos: [
                { text: "Learn JavaScript" },
                { text: "Learn Vue" },
                { text: "Build something awesome" },
            ],
            counter: 0,
            date: new Date().toLocaleString(),
            inputText: "initial text",
            isActive: true,
            hasError: false,
            urlBitcoin: "https://cryptologos.cc/logos/bitcoin-btc-logo.png",
            counterLikes: 0,
            titlesLi: "",
            chart_width: 400,
            chart_height: 500,
            map: {},
            primosContador: [],
        };
    },

    // Las propiedades computadas son propiedades que dependen de otras
    // Se actualizan automáricamente cuando se actualizen las otras
    computed: {
        myProperty() {
            return `${this.title} -- ${this.counter} -- ${this.counterLikes}`;
        },
    },

    // Los watchers son métodos que se ejecutan cuando una propedad de data cambia de valor
    // Debe llevar necesariamente el mismo de nombre de la varriable
    // Cuando recibe dos parámetros, uno es el valor antiguo y el otro el actual
    // Cuando recibe un valor es el valor acutal de la propiedad
    // Cuando se revierte el titulo se dispara el console log
    // Cuando el valor actual de counter es primo, se agrega al atributo primos contador
    watch: {
        title(newValue, oldValue) {
            console.log(newValue, oldValue);
        },
        counter(currentCounter) {
            function isPrime(num) {
                for (let i = 2; i < num; i++) { if (num % i === 0) { return false; } }
                return num > 1;
            }
            if (isPrime(currentCounter)) {
                this.primosContador.push(currentCounter)
            }
        },
    },

    methods: {
        reverseMessage: function () {
            this.title = this.title.split("").reverse().join("");
            this.inputText = this.inputText.split("").reverse().join("");
        },
        changeClassName: function () {
            this.hasError = !this.hasError;
        },
        addLike: function () {
            this.counterLikes++;
        },
        removeLike: function () {
            this.counterLikes--;
        },
        myFunction: function (ev, index) {
            this.titlesLi = `es la etiqueta ${index}: ${ev.target.dataset.index
                .split("")
                .reverse()
                .join("")}`;
        },
        mouseOverDep: function (ev) {
            if (ev.target.dataset.label === "88") {
                document
                    .querySelectorAll('path[data-label="88"]')
                    .forEach(function (x) {
                        x.style.fill = "rgb(90, 90, 90)";
                    });
            } else {
                ev.target.style.fill = "rgb(90, 90, 90)";
            }
        },
        mouseOutDep: function (ev, depColor) {
            if (ev.target.dataset.label === "88") {
                document
                    .querySelectorAll('path[data-label="88"]')
                    .forEach(function (x) {
                        x.style.fill = depColor;
                    });
            } else {
                ev.target.style.fill = depColor;
            }
        },
    },
    async mounted() {
        // Contador y actualizador de fecha
        setInterval(() => {
            this.counter++;
            this.date = new Date().toLocaleString();
        }, 1000);

        const res = await fetch("./GeoJSONColombia.json");
        const mapJson = await res.json();

        const projection = d3.geo.mercator().scale(1500).scale(1500).center([-74, 4.5]).translate([this.chart_width * 0.4, this.chart_height * 0.5]);
        const projectionSanAndres = d3.geo.mercator().scale(19000).center([-81.7, 12.6]).translate([50, 30]);
        const projectionProvidencia = d3.geo.mercator().scale(19000).center([-81.3, 13.35]).translate([90, 52]);

        const path = d3.geo.path().projection(projection);
        const pathSanAndres = d3.geo.path().projection(projectionSanAndres);
        const pathProvidencia = d3.geo.path().projection(projectionProvidencia);

        const SanAndres = mapJson.features[mapJson.features.length - 2];
        const Providencia = mapJson.features[mapJson.features.length - 1];

        const colorScale = d3.scale
            .linear()
            .domain([0, 100])
            .clamp(true)
            .range(["yellow", "purple"]);

        const mapaColombia = [];
        mapJson.features.slice(0, -2).forEach(function (dep) {
            mapaColombia.push({
                d: path(dep),
                color: colorScale(Number(dep.properties.DPTO)),
                numDep: dep.properties.DPTO,
            });
        });
        mapaColombia.push({
            d: pathSanAndres(SanAndres),
            color: colorScale(Number(SanAndres.properties.DPTO)),
            numDep: SanAndres.properties.DPTO,
        });
        mapaColombia.push({
            d: pathProvidencia(Providencia),
            color: colorScale(Number(Providencia.properties.DPTO)),
            numDep: Providencia.properties.DPTO,
        });

        this.map = mapaColombia;

        const encrypted = CryptoJS.AES.encrypt("ey-908@naval-cartagena.iam.gserviceaccount.com", "1_OzZ2JUmpnFCLIajfW2GDBOwb_R7ghKkp75ncSkoCSo").toString();
        const decrypted = CryptoJS.AES.decrypt(encrypted, "1_OzZ2JUmpnFCLIajfW2GDBOwb_R7ghKkp75ncSkoCSo");
        
        console.log(encrypted.toString());
        console.log(decrypted);
        console.log(decrypted.toString(CryptoJS.enc.Utf8));
    },
});
