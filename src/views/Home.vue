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
      <Cube v-bind="axises" :perspective="perspective" />
      <div class="row">
        <Wheel
          v-for="(_, name) in axises"
          :key="name"
          :name="`${name} axis`"
          :max="180"
          returnAbsolute
          :step="10"
          @change="handleAxisChange(name)($event)"
        />
        <Wheel
          name="Perspective"
          :min="500"
          :max="2500"
          :step="50"
          :initialValue="2000"
          returnAbsolute
          @change="handlePerspectiveChange"
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
      },
      perspective: 1000
    };
  },
  components: {
    Cube,
    Wheel,
    AccelorometerProvider
  },
  methods: {
    handleAxisChange(name) {
      return value => {
        this.axises = {
          ...this.axises,
          [name]: value
        };
      };
    },
    handlePerspectiveChange(persp) {
      console.info("persp", persp);
      this.perspective = persp;
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
