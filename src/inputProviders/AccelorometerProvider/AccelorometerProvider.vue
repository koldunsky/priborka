<template>
  <div class="container">
    <button @click="requestPermission">Launch!</button>
    <slot v-bind:x="x" v-bind:y="y" v-bind:z="z">
      <br />x:{{ x }} <br />y:{{ y }} <br />z:{{ z }}
    </slot>
  </div>
</template>

<script>
export default {
  props: {},

  data() {
    return {
      x: 0,
      y: 0,
      z: 0
    };
  },

  mounted() {
    console.info(process.env.NODE_ENV);
    if (process.env.NODE_ENV.includes("dev")) {
      window.addEventListener("deviceorientation", this.handleOrientation);
    }
  },

  methods: {
    handleOrientation(e) {
      console.info(e);
      const { alpha, beta, gamma } = e;
      this.x = Math.round(beta);
      this.y = Math.round(gamma);
      this.z = Math.round(alpha);
    },
    requestPermission() {
      console.info("requestPermission");
      if (
        typeof DeviceMotionEvent !== "undefined" &&
        typeof DeviceMotionEvent.requestPermission === "function"
      ) {
        console.info("requestPermission: in action");
        // (optional) Do something before API request prompt.
        DeviceMotionEvent.requestPermission()
          .then(response => {
            // (optional) Do something after API prompt dismissed.
            if (response === "granted") {
              window.addEventListener(
                "deviceorientation",
                this.handleOrientation
              );
            }
          })
          .catch(console.error);
      }
    }
  }
};
</script>

<style src="./AccelorometerProvider.scss" lang="scss" scoped />
