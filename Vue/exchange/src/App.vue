<template>
    <div id="app">
        <px-header v-bind:links="links" />
        <router-view class="router-container" />
    </div>
</template>

<script>
import PxHeader from "@/components/PxHeader.vue";

export default {
    name: "App",
    components: {
        PxHeader,
    },
    data() {
        return({
            links: [
                {
                    title: "BTC",
                    to: { name: "coin-detail", params: { id: "bitcoin" } },
                },
                {
                    title: "ETH",
                    to: { name: "coin-detail", params: { id: "ethereum" } },
                },
                {
                    title: "XRP",
                    to: { name: "coin-detail", params: { id: "xrp" } },
                },
            ],
        });
    },
};
</script>

<style>
@import url("https://fonts.googleapis.com/css2?family=Noto+Sans+Display:ital,wght@0,400;0,600;1,800&display=swap");
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: "Noto Sans Display", sans-serif;
}
html {
    font-size: 62.5%;
}
.router-container {
    display: flex;
}
</style>
