<template>
  <div class="scene">
    <div class="wheelHolder" @scroll="onWheelHolderScroll" ref="wheelHolder">
      <div class="wheelInnerHolder" ref="wheelInnerHolder">
        <div
          v-for="(_, i) in new Array(max).fill('')"
          :key="i"
          class="wheelItem wheelItemPhantom"
          :ref="`wheelItemPhantom_${i}`"
        >
          {{ i }}
        </div>
      </div>
      <div class="wheelDigitsHolder">
        <div
          v-for="(_, i) in new Array(max).fill('')"
          :key="i"
          class="wheelItem wheelItemDigits"
          :style="{
            transform: `rotateX(${getRotateX(i)}deg)`
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
      default: 15,
      type: Number
    }
  },

  data() {
    return {
      x: 0,
      y: 0,
      z: 0,
      deg: 0,
      amountOfPartials: 12,
      scrolled: 0
    };
  },

  computed: {
    partialHeight() {
      const additional = 0;
      return `calc(100% * 3.14 / ${this.amountOfPartials + additional})`;
    }
  },

  methods: {
    getRotateX(i) {
      console.info(this);
      const wheelHolderH = 130;
      const wheelItemH = 40;
      const deg = (wheelHolderH * Math.PI) / 4 / wheelItemH;
      const degRaw = -1 * i * (90 / deg) + this.scrolled * 5;
      if (degRaw > 90) {
        return 90;
      }

      if (degRaw < -90) {
        return -90;
      }
      return degRaw;
    },
    onWheelHolderScroll(e) {
      console.log(e);
      const diff =
        this.$refs.wheelInnerHolder.clientHeight - e.target.clientHeight;
      console.info(e.target.scrollTop / diff);
      this.scrolled = (e.target.scrollTop / diff) * 100;
    }
  }
};
</script>

<style src="./Wheel.scss" lang="scss" scoped />
