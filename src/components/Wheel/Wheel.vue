<template>
  <div class="scene">
    <button @click="increaseDeg">+</button>
    <button @click="decreaseDeg">-</button>
    <div class="wheelHolder">
      <div class="wheelInnerHolder">
        <div
          v-for="(part, i) in new Array(amountOfPartials).fill('')"
          :key="i"
          class="wheelPart"
          :style="{
            height: partialHeight,
            transform: `rotateX(${(360 / 12) * -i + deg}deg)`
          }"
        >
          {{ i }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    min: {
      type: Number,
      default: 0
    },
    max: {
      // required: true,
      type: Number
    }
  },

  data() {
    return {
      x: 0,
      y: 0,
      z: 0,
      deg: 0,
      amountOfPartials: 12
    };
  },

  computed: {
    partialHeight() {
      const additional = 0;
      return `calc(100% * 3.14 / ${this.amountOfPartials + additional})`;
    }
  },

  methods: {
    increaseDeg() {
      this.deg += 10;
    },
    decreaseDeg() {
      this.deg -= 10;
    }
  }
};
</script>

<style src="./Wheel.scss" lang="scss" scoped />
