<template>
    <main>
        <bounce-loader 
            v-if="isLoading"
            v-bind:color="'#68d391'" 
            v-bind:size="100"
        />
        <px-assets-table 
            v-if="!isLoading" 
            v-bind:assets="assets" 
        />
    </main>
</template>

<script>
    import PxAssetsTable from '../components/PxAssetsTable.vue'
    import api from "../api.js";

    export default {
        name: "Home",
        components: {
            PxAssetsTable
        },

        data: function () {
            return {
                assets: [],
                isLoading: true,
            };
        },

        // created is the vue hook
        created: async function () {
            const data = await api.getAssets();
            this.assets = data;
            this.isLoading = false;
            console.log(data);
        },
    }
</script>

<style scoped>
    main {
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 20px;
    }
</style>