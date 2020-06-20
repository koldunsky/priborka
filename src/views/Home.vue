<template>
  <div class="home">
    <Cube />
    <Wheel />
  </div>
</template>

<script>
// @ is an alias to /src
import Cube from "@/components/Cube/Cube";
import Wheel from "@/components/Wheel/Wheel";

export default {
  name: "Home",
  components: {
    Cube,
    Wheel
  }
};
</script>
