<template>
    <div class="c1">
        <template v-if="asset.id">
            <div class="c2">
                <div class="c2_e1">
                    <img
                        v-bind:src="`https://static.coincap.io/assets/icons/${asset.symbol.toLowerCase()}@2x.png`"
                        v-bind:alt="asset.name"
                        class=""
                    />
                    <h1 class="">
                        {{ asset.name }}
                        <span class="">{{ asset.symbol }}</span>
                    </h1>
                </div>

                <div class="">
                    <ul>
                        <li class="">
                            <b class="text-gray-600 mr-10 uppercase">Ranking</b>
                            <span>#{{ asset.rank }}</span>
                        </li>
                        <li class="">
                            <b class="">Precio actual</b>
                            <span>{{ dollar(asset.priceUsd) }}</span>
                        </li>
                        <li class="">
                            <b class="">Precio más bajo</b>
                            <span>{{ dollar(min) }}</span>
                        </li>
                        <li class="">
                            <b class="">Precio más alto</b>
                            <span>{{ dollar(max) }}</span>
                        </li>
                        <li class="">
                            <b class="">Precio Promedio</b>
                            <span>{{ dollar(avg) }}</span>
                        </li>
                        <li class="">
                            <b class="">Variación 24hs</b>
                            <span>{{ percent(asset.changePercent24Hr) }}</span>
                        </li>
                    </ul>
                </div>

                <div class="c2_e3">
                    <button class="button" v-on:click="toggleConverter">
                        {{
                            fromUsd
                                ? `USD a ${asset.symbol}`
                                : `${asset.symbol} a USD`
                        }}
                    </button>

                    <input
                        v-model="convertValue"
                        id="convertValue"
                        type="number"
                        class="c2_input"
                        v-bind:placeholder="`Valor en ${
                            fromUsd ? 'USD' : asset.symbol
                        }`"
                    />

                    <span class="conversor-text"
                        >Conversión: {{ convertResult }}
                        {{ fromUsd ? asset.symbol : "USD" }}</span
                    >
                </div>
            </div>
        </template>

        <div class="c3">
            <line-chart
                class=""
                :colors="['orange']"
                :min="min"
                :max="max"
                :data="chartData"
            />
        </div>

        <table class="table">
            <thead>
                <tr>
                    <th>Exchange Id</th>
                    <th>Price</th>
                    <th>B/S</th>
                    <th>Link</th>
                </tr>
            </thead>
            <tbody>
                <tr
                    v-for="m in markets"
                    :key="`${m.exchangeId}-${m.priceUsd}`"
                    class="border-b"
                >
                    <td>
                        <b>{{ m.exchangeId }}</b>
                    </td>
                    <td>{{ dollar(m.priceUsd) }}</td>
                    <td>{{ m.baseSymbol }} / {{ m.quoteSymbol }}</td>
                    <td>
                        <px-button
                            v-if="!m.url"
                            v-on:custom-click="getWebSite(m)"
                        >
                            <template v-slot:button-content>
                                <span>Link</span>
                            </template>
                        </px-button>
                        <a v-else class="" target="_blanck">
                            {{ m.url }}
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
import api from "@/api.js";
import { dollarFilter, percentFilter } from "@/filter.js";
import PxButton from "../components/PxButton.vue";

export default {
    name: "CoinDetail",
    components: { PxButton },
    data() {
        return {
            asset: {},
            history: [],
            markets: [],
            fromUsd: true,
            convertValue: null,
        };
    },

    computed: {
        convertResult() {
            if (!this.convertValue) {
                return 0;
            }

            const result = this.fromUsd
                ? this.convertValue / this.asset.priceUsd
                : this.convertValue * this.asset.priceUsd;

            return result.toFixed(4);
        },

        min() {
            return Math.min(
                ...this.history.map((h) => parseFloat(h.priceUsd).toFixed(2))
            );
        },

        max() {
            return Math.max(
                ...this.history.map((h) => parseFloat(h.priceUsd).toFixed(2))
            );
        },

        avg() {
            return (
                this.history.reduce((a, b) => a + parseFloat(b.priceUsd), 0) /
                this.history.length
            );
        },

        chartData() {
            const data = this.history.map((h) => {
                return [h.date, parseFloat(h.priceUsd).toFixed(2)];
            });
            console.log(data);
            return data;
        },
    },

    watch: {
        $route() {
            this.getCoin();
        },
    },

    created() {
        this.getCoin();
    },

    methods: {
        toggleConverter() {
            this.fromUsd = !this.fromUsd;
        },

        getCoin() {
            const id = this.$route.params.id;

            Promise.all([
                api.getAsset(id),
                api.getAssetHistory(id),
                api.getMarkets(id),
            ]).then(([asset, history, markets]) => {
                console.log({ asset, history, markets });
                this.asset = asset;
                this.history = history;
                this.markets = markets;
            });
        },

        async getWebSite(exchange) {
            console.log(exchange);
            const res = await api.getExchange(exchange.exchangeId);
            // Si quisieramos agrgar una propiedad al objeto exchange
            // en este caso url, no basta con (★), se debe usar la propiedad:
            // this.$set(objeto, atributo, valor)
            // ★ exchange.url = res.url;
            // En vue 3 se puede hacer con (★)
            this.$set(exchange, "url", res.exchangeUrl);
        },

        dollar: function (value) {
            return dollarFilter(value);
        },

        percent: function (value) {
            return percentFilter(value);
        },
    },
};
</script>

<style scoped>
.c1 {
    display: flex;
    flex-direction: column;
}

.c2 {
    display: flex;
    justify-content: space-around;
    align-items: center;
    margin-top: 5rem;
}

.c3 {
    padding: 30px;
    background-color: rgb(230, 230, 230);
    border-radius: 10px;
    width: 90%;
    margin: 10px auto;
}

.c2_e1 {
    display: flex;
    flex-direction: column;
    align-items: center;
}

h1 {
    font-size: 4rem;
    margin-top: 10px;
}

h1 > span {
    font-weight: bolder;
    color: white;
    background-color: rgb(41, 41, 41);
    border-radius: 6px;
    padding: 0px 10px;
}

ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

li {
    font-size: 1.8rem;
}

li > b {
    text-transform: uppercase;
    font-weight: bolder;
    color: rgb(87, 87, 87);
}

li > span {
    float: right;
    margin-left: 20px;
    font-weight: bolder;
}

.c2_e3 {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.button {
    background-color: rgb(75, 187, 75);
    border-radius: 5px;
    border: none;
    color: white;
    padding: 10px 0;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    width: 100%;
    font-weight: bolder;
}

.c2_input {
    padding: 10px;
    border-radius: 5px;
    border: 2px solid rgb(59, 59, 59);
    width: 100%;
}

.c2_input:focus {
    outline: none;
}

.table {
    font-size: 1.4rem;
    border-collapse: collapse;
    width: fit-content;
    margin: 10px auto;
}

.table thead tr {
    font-weight: bolder;
    border-bottom: 2px solid #7c7c7c;
}

.table tbody tr:not(:last-child) {
    border-bottom: 1px solid #7c7c7c;
}

thead {
    background-color: rgb(204, 204, 204);
}

td {
    padding: 2px 10px;
    text-align: center;
}

th {
    padding: 4px 10px;
    font-size: 1.4rem;
}
.conversor-text {
    margin-top: 1rem;
    font-weight: bolder;
    font-size: 1.4rem;
}
</style>
