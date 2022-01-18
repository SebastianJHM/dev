Vue.component('my-component', {
    data: function () {
        return ({
            count: 0
        });
    },
    methods: {
        plassOne: function () {
            this.count++;
        }
    },
    template: `
        <div>
            <button v-on:click="plassOne">
                Me ha pulsado {{ count }} veces.
            </button>
        </div>
    `
});

Vue.component('element-component', {
    props: ["myAttribute"],
    data: function () {
        return ({
            receivedAttribute: `Componente ${this.myAttribute}`,
        });
    },
    methods: {
        reverseText: function () {
            this.receivedAttribute = this.receivedAttribute.split("").reverse().join("");
        },
    },
    template: `
        <div>
            <span 
                v-on:mouseover="reverseText"
                v-on:mouseout="reverseText"
            >
                {{ receivedAttribute }}
            </span>
        </div>
    `
});

Vue.component('slot-component', {
    template: `
        <div>
            <slot name="title-slot"></slot>
            <slot name="body-slot"></slot>
        </div>
    `
})


Vue.component('evento-hijo', {
    data: function () {
        return ({
            inputText: "hola",
        });
    },
    computed: {
        sizeInput: function () {
            const parameter1 = this.inputText.split("").reverse().join("");
            const parameter2 = this.inputText.length ** 2;
            const parameter3 = { k1: this.inputText.toUpperCase(), k2: this.inputText.split("") }
            this.$emit('evento-medida', parameter1, parameter2, parameter3)
            return this.inputText.length;
        }
    },
    template: `
        <div>
            <h2>Que pasa?</h2>
            <input type="text" v-model="inputText" />
            <p>lenght: {{sizeInput}}</p>
        </div>
    `
})


new Vue({
    el: "#app",
    data: function () {
        return ({
            title: "los componentes",
            elements: [1, 2, 3],
            rp1: null,
            rp2: null,
            rp3: null,
            rp4: null,
        });
    },
    methods: {
        metodoPadre: function (p1, p2, p3) {
            this.rp1 = p1;
            this.rp2 = p2;
            this.rp3 = p3.k1
            this.rp4 = String(p3.k2);
            console.log(p1, p2, p3);
        }
    }
});