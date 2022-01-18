const App = {
    data: function () {
        return ({
            myArray: [1, 2, 3],
        });
    },
    methods: {
        myFunction: function() {
            console.log(this.myArray)
        }
    },
};


const app = Vue.createApp(App);
app.mount("#app");