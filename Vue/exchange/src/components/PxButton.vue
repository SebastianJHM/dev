<template>
    <button
        v-on:click="buttonClick"
        class="button"
    >
        <slot name="button-content"></slot>
    </button>
</template>

<script>
export default {
    name: "PxButton",

    methods: {
        buttonClick() {
            this.$emit("custom-click");
        },
    },
};
</script>

<style scoped>

.button {
    background-color: rgb(75, 187, 75);
    border-radius: 5px;
    border: none;
    color: white;
    padding: 0px 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    width: 100%;
    font-weight: bolder;
}

</style>
