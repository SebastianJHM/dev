<template>
    <main>
        <h1>Te has equivocado</h1>
        <router-link to="/">Volver ...</router-link>
    </main>
</template>

<script>

    export default {
        name: "NotFound",
        components: {

        },
    }
</script>

<style scoped>
    main {
        display: flex;
        flex-direction: column;
    }
    h1 {
        font-size: 1.8rem;
    }
</style>
