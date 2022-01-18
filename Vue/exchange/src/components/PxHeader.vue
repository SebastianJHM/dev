<template>
   <header>
        <nav class="nav">
            <IconLogo class="nav-logo"></IconLogo>
            <router-link v-bind:to="{ name: 'home'}">
                <span class="nav-title">Coin Exchange</span>
            </router-link>
            <div class="links">
                <router-link
                    v-for="link in links"
                    v-bind:key="link.title"
                    v-bind:to="link.to"
                >
                    {{ link.title }}
                </router-link>
            </div>
        </nav>
    </header> 
</template>

<script>
    import IconLogo from "@/components/__IconLogo.vue";

    export default {
        name: "PxHeader",
        props: {
            links: {
                type: Array,
                default: () => [],
            }
        },
        components: {
            IconLogo,
        },
    };
</script>

<style scoped>
    .nav {
        background-color: rgb(75, 187, 75);
        padding: 14px 10px;
        display: flex;
        align-items: center;
    }
    .nav-logo {
        margin-right: 10px;
    }
    .nav-title {
        font-size: 2rem;
        font-weight: bolder;
        color: white;
    }
    a {
        text-decoration: none;
    }
    .links {
        margin-left: 2rem;
    }
    .links > a {
        font-weight: bolder;
        font-size: 1.4rem;
        color: rgb(0, 112, 28);
        margin: 0 0.2rem;
    }
</style>


