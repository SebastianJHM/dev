Vue.component("modal-container", {
    methods: {
        closeModal: function() {
            this.$emit("close-modal", false)
        }
    },
    template: `
        <div class="background-modal">
            <div class="card-modal">
                <slot name="title-modal"></slot>
                <slot name="body-modal"></slot>
                <button class="button-close-modal" v-on:click="closeModal">Cerrar</button>
            </div>
        </div>
    `
});

new Vue({
    el: "#app",
    data: function() {
        return({
            stateOpenModal: false,
        });
    },
    methods: {
        appOpenModal: function() {
            this.stateOpenModal = true;
        },
        appCloseModal: function(s) {
            this.stateOpenModal = s;
        }
    },
});