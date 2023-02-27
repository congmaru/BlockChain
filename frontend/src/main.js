import { createApp, configureCompat } from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import HNav from "./components/common/HNav.vue";
import HBreadcrumb from "./components/common/HBreadcrumb.vue";

configureCompat({
  MODE: 3
})

const app = createApp(App);

app.use(store);
app.use(router);
app.mount("#app");

app.config.globalProperties.$filters = {
  truncate(text, length, clamp) {
    if (text) {
      clamp = clamp || "...";
      return text.length > length ? text.slice(0, length) + clamp : text;
    }
  }
}

app.component("HNav", HNav)
  .component("HBreadcrumb", HBreadcrumb);
