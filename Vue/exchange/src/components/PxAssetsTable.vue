<template>
    <table class="table">
        <thead>
            <tr>
                <th></th>
                <th>Ranking</th>
                <th>Nombre</th>
                <th>Precio</th>
                <th>Cap. de Mercado</th>
                <th>Variación 24hs</th>
                <th>
                    <input 
                        type="text"
                        v-model="filterCoin"
                    />
                </th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="ass in filteredAssets" v-bind:key="ass.id">
                <td>
                    <img
                        v-bind:src="`https://static.coincap.io/assets/icons/${ass.symbol.toLowerCase()}@2x.png`"
                        v-bind:alt="ass.name"
                        class="coin-icon"
                    />
                </td>
                <td class="bold">{{ ass.rank }}</td>
                <td class="bold">
                    <router-link
                        v-bind:to="{
                            name: 'coin-detail',
                            params: { id: ass.id },
                        }"
                    >
                        {{ ass.name }}
                    </router-link>
                </td>
                <td>{{ dollar(ass.priceUsd) }}</td>
                <td>{{ dollar(ass.marketCapUsd) }}</td>
                <td
                    v-bind:class="
                        ass.changePercent24Hr.includes('-')
                            ? 'c-red bold'
                            : 'c-green bold'
                    "
                >
                    {{ percent(ass.changePercent24Hr) }}
                </td>
                <td>
                    <px-button v-on:custom-click="goToCoin(ass.id)">
                        <template v-slot:button-content>
                            <span>Detalle</span>
                        </template>
                    </px-button>
                </td>
            </tr>
        </tbody>
    </table>
</template>

<script>
import { dollarFilter, percentFilter } from "@/filter.js";
import PxButton from "./PxButton.vue";

export default {
    components: { PxButton },
    name: "PxAssetsTable",

    data () {
        return({
            filterCoin: "",
        });
    },

    props: {
        assets: {
            type: Array,
            default: () => [],
        },
    },

    computed: {
        filteredAssets: function() {
     
            if (this.filterCoin === "") {
                return this.assets;
            }
          
            return this.assets.filter((ass) => (
                ass.name.toLowerCase().includes(this.filterCoin.toLowerCase())
            ));
        }
    },

    methods: {
        dollar: function (value) {
            return dollarFilter(value);
        },
        percent: function (value) {
            return percentFilter(value);
        },
        goToCoin: function (id_coin) {
            this.$router.push({ name: "coin-detail", params: { id: id_coin } });
        },
    },
};
</script>

<style scoped>
a {
    text-decoration: none;
    color: rgb(30, 128, 30);
}
.table {
    font-size: 1.4rem;
    border-collapse: collapse;
    width: fit-content;
}

.table thead tr {
    font-weight: bolder;
    border-bottom: 2px solid #7c7c7c;
}

.table tbody tr:not(:last-child) {
    border-bottom: 1px solid #7c7c7c;
}

.up::before {
    content: "👆";
}

.down::before {
    content: "👇";
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
.coin-icon {
    margin-top: 4px;
    height: 3rem;
}
.bold {
    font-weight: bolder;
}

.c-red {
    color: red;
}

.c-green {
    color: green;
}
</style>
