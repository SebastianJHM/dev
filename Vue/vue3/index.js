const App = {
    data: function () {
        return {
            homeDistsCharts: staticCharts,
            indexChart: Math.floor(Math.random() * (8 - 0 + 1) + 0)
        };
    },
    methods: {},
};

const Chart = {
    props: {
        minData: {
            type: Number,
            default: 0,
        },
        maxData: {
            type: Number,
            default: 0,
        },
        bH: {
            type: Array,
            default: function () {
                return [];
            },
        },
        dist: {
            type: String,
            default: "",
        },
        params: {
            type: Array,
            default: function () {
                return [];
            },
        },
        dotsCurvePdf: {
            type: Array,
            default: function () {
                return [];
            },
        },
        lineCurvePdf: {
            type: Array,
            default: function () {
                return [];
            },
        },
    },
    data: function () {
        return {
            chartWidth: 500,
            chartHeight: 300,
            xLines: 30,
            yLines: 20,
            barsSeparation: 3,
            marginBarsX: 1.5,
            percentageScreenPdf: 0.98,
            dotsTheoricalPdf: 100,
        };
    },
    computed: {
        // Desplazamientos de la cuadriculas respecto al origen del contenedor.
        // Los desplazamientos de los elementos dentro de la cuadrícula son respecto
        // al origen de la cuadricula
        translateGrid() {
            const tx = this.marginLeftGrid;
            const ty = this.marginTopGrid;
            return `translate(${tx}, ${ty})`;
        },
        // Ancho de la cuadricula
        gridWidth() {
            return 0.94 * this.chartWidth;
        },
        // Alto de la cuadrica
        gridHeight() {
            return 0.9 * this.chartHeight;
        },
        // Margen superior de la cudricula. Este margen mas el alto de la
        // cuadricula deben ser inferiores deben ser inferiores al alto del
        // gráfico para dejar espacio para las etiquetas del eje X
        marginTopGrid() {
            return 0.05 * this.chartHeight;
        },
        // Margen izquierdo. Este margen debe dejar espacios para las
        // etiquetas del eje Y
        marginLeftGrid() {
            return 0.03 * this.chartWidth;
        },

        // Margen izquierdo y derecho del eje X. Es un porcentaje del
        // ancho de la cuadricula
        marginAxisX() {
            return 0 * this.gridWidth;
        },
        // Espacio entre las líneas de del eje x. Se decuentan los margenes laterales
        spaceWidthX() {
            return (this.gridWidth - 2 * this.marginAxisX) / (this.xLines - 1);
        },
        // Desplazamientos de las líneas del eje X, las líneas de la
        // tienen debajo los valores de las etiquetas
        translateGridX() {
            return [...Array(this.xLines)].map((_, i) => {
                const tx = this.marginAxisX + i * this.spaceWidthX;
                const ty = 0;
                return `translate(${tx}, ${ty})`;
            });
        },

        // Margen superior del eje Y. Es un porcentaje del alto de la cuadricula
        marginAxisY() {
            return 0 * this.gridHeight;
        },
        // Espacio entre las líneas de del eje Y. Se decuentan el margen superior
        spaceHeightY() {
            return (this.gridHeight - this.marginAxisY) / (this.yLines - 1);
        },
        // Etiquetas del eje Y
        labelY() {
            const maxLabelY = this.maxRelFreqHist / this.percentageScreenPdf;
            return [...Array(this.yLines)].map((_, i) => {
                return 0 + (i * maxLabelY) / (this.yLines - 1);
            });
        },
        // Desplazamientos de las líneas del eje Y, las líneas de la
        // tienen al lado izquierod los valores de las etiquetas
        translateGridY() {
            return [...Array(this.yLines)].map((_, i) => {
                const tx = 0;
                const ty =
                    this.marginAxisY +
                    (this.yLines - i - 1) * this.spaceHeightY;
                return `translate(${tx}, ${ty})`;
            });
        },

        // Número de categorías del histograma
        numCategories() {
            return this.barsHeight.length;
        },
        // Ancho de cada barra (px)
        barsWidth() {
            return (
                (this.gridWidth -
                    2 * this.marginAxisX -
                    2 * this.marginBarsX -
                    (this.numCategories - 1) * this.barsSeparation) /
                this.numCategories
            );
        },
        // Altura máxima de referencia para las barras. Es un porcentaje de
        // del alto de la cuadricula menos el margen superior del eje Y
        globalBarsHeight() {
            return (
                (this.gridHeight - this.marginAxisY) * this.percentageScreenPdf
            );
        },
        // Altura de cada barra (px)
        barsHeight() {
            return this.bH.map(
                (h) => this.globalBarsHeight * (h / Math.max(...this.bH))
            );
        },
        // Desplazamiento de cada barra en el eje X y en el eje Y
        translateBars() {
            return this.barsHeight.map((_, i) => {
                const tx =
                    this.marginAxisX +
                    this.marginBarsX +
                    i * this.barsWidth +
                    i * this.barsSeparation;
                const ty = this.gridHeight - this.barsHeight[i];
                return `translate(${tx}, ${ty})`;
            });
        },

        // Ancho de la curva
        pdfWidth() {
            return this.gridWidth - 2 * this.marginAxisX - 2 * this.marginBarsX;
        },
        // Alto de la curva
        pdfHeight() {
            return (
                this.percentageScreenPdf * (this.gridHeight - this.marginAxisY)
            );
        },
        // Desplazamiento de la curva
        translateCurve() {
            const tx = this.marginAxisX + this.marginBarsX;
            const ty =
                this.marginAxisY +
                (1 - this.percentageScreenPdf) *
                    (this.gridHeight - this.marginAxisY);
            return `translate(${tx}, ${ty})`;
        },
    },
    mounted() {
        // console.log({
        //     minData: this.minData,
        //     maxData: this.maxData,
        //     dist: this.dist,
        //     params: this.params,
        //     bH: this.bH,
        //     lineCurvePdf: this.lineCurvePdf,
        //     dotsCurvePdf: this.dotsCurvePdf,
        // });
    },
    template: `
        <div
            class="chart-container"
            :style="{
                width: chartWidth + 'px',
                height: chartHeight + 'px',
            }"
        >
            <svg id="chart" height="100%" width="100%">
                <g :transform="translateGrid">
                    <Border :grid-width="gridWidth" :grid-height="gridHeight" />
                    <AxisX
                        :x-lines="xLines"
                        :translate-grid-x="translateGridX"
                        :grid-height="gridHeight"
                    />
                    <AxisY
                        :y-lines="yLines"
                        :translate-grid-y="translateGridY"
                        :grid-width="gridWidth"
                    />
                    <Bars
                        :translate-bars="translateBars"
                        :bars-width="barsWidth"
                        :global-bars-height="globalBarsHeight"
                        :bars-height="barsHeight"
                    />
                    <CurvePdf
                        :dots-curve-pdf="dotsCurvePdf"
                        :translate-curve="translateCurve"
                        :line-curve-pdf="lineCurvePdf"
                    />
                </g>
            </svg>
        </div>
    `,
};

const Border = {
    props: {
        gridWidth: {
            type: Number,
            default: 0,
        },
        gridHeight: {
            type: Number,
            default: 0,
        },
    },
    template: `
        <rect x="0" y="0" :width="gridWidth" :height="gridHeight" class="border-grid" />
    `,
};

const AxisX = {
    props: {
        xLines: {
            type: Number,
            default: 0,
        },
        translateGridX: {
            type: Array,
            default: function () {
                return [];
            },
        },
        gridHeight: {
            type: Number,
            default: 0,
        },
    },
    template: `
        <g 
            v-for="(_, i) in xLines"
            :key="i" 
            :transform="translateGridX[i]"
        >
            <line x1="0" y1="0" x2="0" :y2="gridHeight" class="xy-axis-line" />
        </g>
    `,
};

const AxisY = {
    props: {
        yLines: {
            type: Number,
            default: 0,
        },
        translateGridY: {
            type: Array,
            default: function () {
                return [];
            },
        },
        gridWidth: {
            type: Number,
            default: 0,
        },
    },
    template: `
    <g
        v-for="(_, i) in yLines"
        :key="i"
        :transform="translateGridY[i]"
    >
        <line x1="0" y1="0" :x2="gridWidth" y2="0" class="xy-axis-line" />
    </g>
    `,
};

const Bars = {
    props: {
        translateBars: {
            type: Array,
            default: function () {
                return [];
            },
        },
        barsWidth: {
            type: Number,
            default: 0,
        },
        globalBarsHeight: {
            type: Number,
            default: 0,
        },
        barsHeight: {
            type: Array,
            default: function () {
                return [];
            },
        },
    },
    methods: {
        roundedRect: function (
            x,
            y,
            w,
            h,
            r = 4,
            tl = true,
            tr = true,
            bl = false,
            br = false
        ) {
            let retval;
            retval = `M${x + r},${y}`;
            retval += `h${w - 2 * r}`;
            tr
                ? (retval += `a${r},${r} 0 0 1 ${r},${r}`)
                : (retval += `h${r}v${r}`);
            retval += `v${h - 2 * r}`;
            br
                ? (retval += `a${r},${r} 0 0 1 ${-r},${r}`)
                : (retval += `v${r}h${-r}`);
            retval += `h${2 * r - w}`;
            bl
                ? (retval += `a${r},${r} 0 0 1 ${-r},${-r}`)
                : (retval += `h${-r}v${-r}`);
            retval += `v${2 * r - h}`;
            tl
                ? (retval += `a${r},${r} 0 0 1 ${r},${-r}`)
                : (retval += `v${-r}h${r}`);
            retval += "z";
            return retval;
        },
    },
    template: `
        <g 
            v-for="(_, i) in barsHeight"
            :key="i"
            :transform="translateBars[i]"
        >
            <!-- <rect x="0" y="0" :width="barsWidth" :height="barsHeight[i]" class="rect-bars" /> -->
            <path :d="roundedRect(0, 0, barsWidth, barsHeight[i])" class="bars" />
        </g>
    `,
};

const CurvePdf = {
    data() {
        return({
            indexAnimation: 0,
            colors: ["red", "purple", "blue", "green", "yellow", "orange"],
        });
    },
    props: {
        dotsCurvePdf: {
            type: Array,
            default: function () {
                return [];
            },
        },
        translateCurve: {
            type: String,
            default: "",
        },
        lineCurvePdf: {
            type: Array,
            default: function () {
                return [];
            },
        },
    },
    computed: {
        selectedColor() {
            return this.colors[this.indexAnimation];
        }
    },
    beforeCreate() {
        // Contador y actualizador de fecha
        setInterval(() => {
            this.indexAnimation = (this.indexAnimation + 1) % this.colors.length;
            // console.log(this.indexAnimation);
        }, 2000);
    },
    template: `
        <g
            v-for="(d, i) in dotsCurvePdf"
            :key="i"
            :transform="translateCurve"
        >
            <circle :cx="d.x" :cy="d.y" r="1.5" :class="['pdf-circle', 'color-circle-' + selectedColor]" />
        </g>

        <g
            v-for="(l, i) in lineCurvePdf"
            :key="i"
            :transform="translateCurve"
        >
            <line :x1="l.x1" :y1="l.y1" :x2="l.x2" :y2="l.y2" :class="['pdf-line', 'color-line-' + selectedColor]" /> 
        </g>
    `,
};

const app = Vue.createApp(App);
const myComponent = app.component("chart", Chart);
myComponent.component("Border", Border);
myComponent.component("AxisX", AxisX);
myComponent.component("AxisY", AxisY);
myComponent.component("Bars", Bars);
myComponent.component("CurvePdf", CurvePdf);

app.mount("#app");
