<template>
  <div class="scene" :style="{ width: `${size}px`, height: `${size}px` }">
    {{ x }},{{ y }},{{ z }}
    <div
      class="cube"
      :style="{
        transform: `rotateX(${x}deg) rotateY(${y}deg) rotateZ(${z}deg)`
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
    }
  },

  beforeMount() {
    window.addEventListener("deviceorientation", this.handleOrientation);
  }
};
</script>

<style src="./Cube.scss" lang="scss" scoped />
