<template>
  <div class="home">
    <section>
      Accelorometer powered cube
      <AccelorometerProvider>
        <template v-slot:default="slotProps">
          <Cube v-bind="slotProps" />
        </template>
      </AccelorometerProvider>
    </section>
    <section>
      <Cube v-bind="axises" />
      <div class="row">
        <Wheel
          v-for="(_, name) in axises"
          :key="name"
          :name="`${name} axis`"
          :max="180"
          @change="handleAxisChange(name)($event)"
        />
      </div>
    </section>
  </div>
</template>

<script>
// @ is an alias to /src
import Cube from "@/components/Cube/Cube";
import Wheel from "@/components/Wheel/Wheel";
import AccelorometerProvider from "../inputProviders/AccelorometerProvider/AccelorometerProvider";

export default {
  data() {
    return {
      axises: {
        x: 0,
        y: 0,
        z: 0
      }
    };
  },
  components: {
    Cube,
    Wheel,
    AccelorometerProvider
  },
  methods: {
    handleFirstWheel(data) {
      this.firstWheel = data;
    },
    handleAxisChange(name) {
      return value => {
        this.axises = {
          ...this.axises,
          [name]: 360 * value
        };
      };
    }
  }
};
</script>

<style lang="scss">
.home {
  display: flex;
  flex-direction: row;
}

.row {
  display: flex;
  flex-direction: row;
}

section {
  /*box-shadow: 0 0 5px rgba(#6500ff, .2) inset;*/
  padding: 20px;
  margin: 10px;
}
</style>
