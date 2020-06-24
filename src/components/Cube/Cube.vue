<template>
  <div class="container">
    <div class="scene" :style="{ width: `${size}px`, height: `${size}px` }">
      <button @click="requestPermission">Launch!</button>
      <div
        class="cube"
        :style="{
          transform: `rotateX(${x}deg) rotateY(${-y}deg) rotateZ(${z}deg)`
        }"
      >
        <div
          v-for="side in ['front', 'back', 'right', 'left', 'top', 'bottom']"
          :key="side"
          :class="`cube__face cube__face--${side}`"
        >
          {{ side }}
        </div>
      </div>
    </div>
    <div>
      <p>x:{{ x }}</p>
      <p>y:{{ y }}</p>
      <p>z:{{ z }}</p>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    size: {
      default: 300
    }
  },

  data() {
    return {
      x: 0,
      y: 0,
      z: 0
    };
  },

  methods: {
    handleOrientation(e) {
      console.info(e);
      const { alpha, beta, gamma } = e;
      this.x = beta;
      this.y = gamma;
      this.z = alpha;
    },
    requestPermission() {
      if (
        typeof DeviceMotionEvent !== "undefined" &&
        typeof DeviceMotionEvent.requestPermission === "function"
      ) {
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

<style src="./Cube.scss" lang="scss" scoped />
