<template>
  <div class="scene">
    <div class="nameText">
      {{ name }}
      {{ max }}
    </div>
    <div class="wheelHolder" @scroll="onWheelHolderScroll" ref="wheelHolder">
      <div class="wheelInnerHolder" ref="wheelInnerHolder">
        <div
          v-for="(_, i) in new Array(max).fill('')"
          :key="i"
          class="wheelItem wheelItemPhantom"
          ref="wheelItemPhantom"
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
            transform: `rotateX(${getRotateX(i)}deg)`,
            opacity: getOpacity(i)
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
    name: {
      type: String
    },
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
      const wheelHolderH = 130;
      const wheelItemH = 30;
      const roundLength = wheelHolderH * Math.PI;
      const contH = wheelItemH * this.max;
      const amountOfDegrees = (contH / roundLength) * 360;
      const shiftForOne = amountOfDegrees / this.max;
      const shiftForLast = shiftForOne * this.max;
      const degRaw = -1 * i * shiftForOne + this.scrolled * shiftForLast;

      if (degRaw > 90) {
        return 90;
      }

      if (degRaw < -90) {
        return -90;
      }
      return degRaw;
    },
    getOpacity(i) {
      return i + 1;
    },
    onWheelHolderScroll(e) {
      const diff =
        this.$refs.wheelInnerHolder.getBoundingClientRect().height -
        e.target.getBoundingClientRect().height;
      // console.info(this.name, this.scrolled);
      this.scrolled = e.target.scrollTop / diff;
      this.$emit("change", this.scrolled);
    }
  }
};
</script>

<style src="./Wheel.scss" lang="scss" scoped />
