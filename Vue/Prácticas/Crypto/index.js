new Vue({
    el: "#app",
    data() {
        return {
            mensaje: "",
            clave: "",
            copiado: null,
        };
    },
    computed: {
        mensajeEncriptado: function() {
            if (!this.mensaje || !this.clave) {
                return "";
            }
            return CryptoJS.AES.encrypt(this.mensaje, this.clave).toString();
        },
    },
    methods: {
        copiarMensajeEncriptado: function() {
            navigator.clipboard.writeText(this.mensajeEncriptado);
            this.copiado = "Mensaje copiado";
            setInterval(() => {
                this.copiado = null;
            }, 5000);
        },
    }
})