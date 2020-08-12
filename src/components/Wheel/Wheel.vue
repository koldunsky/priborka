<template>
  <div class="scene">
    <div class="nameText">
      {{ name }}
    </div>
    <div class="wheelHolder" @scroll="onWheelHolderScroll" ref="wheelHolder">
      <div class="wheelInnerHolder" ref="wheelInnerHolder">
        <div
          v-for="(_, i) in new Array(vsegoPlastinok).fill('')"
          :key="i"
          class="wheelItem wheelItemPhantom"
          ref="wheelItemPhantom"
        >
          {{ getPartialValue(i) }}
        </div>
      </div>
      <div class="wheelDigitsHolder">
        <div
          v-for="(_, i) in new Array(vsegoPlastinok).fill('')"
          :key="i"
          class="wheelItem wheelItemDigits"
          :style="{
            transform: `rotateX(${getRotateX(i)}deg)`,
            opacity: getOpacity(i)
          }"
        >
          {{ getPartialValue(i) }}
        </div>
        <div
          :key="vsegoPlastinok + 1"
          class="wheelItem wheelItemDigits"
          :style="{
            transform: `rotateX(${getRotateX(vsegoPlastinok)}deg)`,
            opacity: getOpacity(vsegoPlastinok)
          }"
        >
          {{ getPartialValue(vsegoPlastinok) }}
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
      default: 15,
      type: Number
    },
    step: {
      default: 1,
      type: Number
    },
    initialValue: {
      type: Number
    },
    returnAbsolute: {
      default: false,
      type: Boolean
    }
  },

  data() {
    return {
      x: 0,
      y: 0,
      z: 0,
      deg: 0,
      amountOfPartials: 12,
      scrolled: 0,
      wheelHolderH: 130,
      wheelItemH: 30
    };
  },

  mounted() {
    const shouldBeScrolled = (this.initialValue - this.min) / this.minMaxDiff;

    if (!isNaN(shouldBeScrolled)) {
      const { wheelHolder } = this.$refs;
      console.info(shouldBeScrolled);
      console.dir(wheelHolder);
      wheelHolder.scrollTop =
        shouldBeScrolled * (wheelHolder.scrollHeight - this.wheelHolderH);
    }
  },

  computed: {
    partialHeight() {
      const additional = 0;
      return `calc(100% * 3.14 / ${this.amountOfPartials + additional})`;
    },
    vsegoPlastinok() {
      return this.minMaxDiff / this.step;
    },

    minMaxDiff() {
      return this.max - this.min;
    },

    absoluteValue() {
      const { min, minMaxDiff, scrolled } = this;
      return min + minMaxDiff * scrolled;
    }
  },

  methods: {
    getRotateX(i) {
      const diff = this.vsegoPlastinok;
      const { wheelItemH, wheelHolderH } = this;
      const roundLength = wheelHolderH * Math.PI;
      const contH = wheelItemH * diff;
      const amountOfDegrees = (contH / roundLength) * 360;
      const shiftForOne = amountOfDegrees / diff;
      const shiftForLast = shiftForOne * diff;
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
      this.scrolled = e.target.scrollTop / diff;
      this.$emit(
        "change",
        this.returnAbsolute ? this.absoluteValue : this.scrolled
      );
    },
    getPartialValue(i) {
      const { min, step } = this;
      return min + i * step;
    }
  }
};
</script>

<style src="./Wheel.scss" lang="scss" scoped />
