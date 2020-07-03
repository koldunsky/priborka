<template>
  <div class="container">
    <div
      class="scene"
      :style="{
        width: `${size}px`,
        height: `${size}px`,
        perspective: `${perspective}px`
      }"
    >
      <div
        class="cube"
        :style="{
          transform: `rotateX(${x}deg) rotateY(${-y}deg) rotateZ(${z}deg)`
        }"
      >
        <div
          v-for="(side, name) in sides"
          :key="name"
          :class="`cube__face cube__face--${name}`"
          :style="getStyles(name, side)"
        >
          {{ name }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
const mapping = {
  bottom: ({ x, y, z }) => ({
    x,
    y: y * -1,
    z
  })
};
export default {
  props: {
    perspective: {
      default: 1000,
      type: Number
    },
    x: {
      type: Number
    },
    y: {
      type: Number
    },
    z: {
      type: Number
    },
    size: {
      default: 300
    }
  },

  methods: {
    getStyles(name, coords) {
      const zzz = mapping[name] ? mapping[name](coords) : coords;
      return `
        rotateX(${zzz.x + this.x}deg)
        rotateY(${zzz.y + this.y}deg)
        rotateZ(${zzz.z + this.z}deg)
        translateZ(100px)
      `;
    }
  },

  data() {
    return {
      sides: {
        front: {
          x: 0,
          y: 0,
          z: 0
        },
        back: {
          x: 0,
          y: 180,
          z: 0
        },
        right: {
          x: 0,
          y: 90,
          z: 0
        },
        left: {
          x: 0,
          y: 270,
          z: 0
        },
        top: {
          x: 90,
          y: 0,
          z: 0
        },
        bottom: {
          x: -90,
          y: 0,
          z: 0
        }
      }
    };
  }
};
</script>

<style src="./Cube.scss" lang="scss" scoped />
