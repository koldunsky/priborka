---
to: src/components/<%=h.changeCase.pascalCase(name)%>/<%=h.changeCase.pascalCase(name)%>.vue
---
<template>
  <div class="container">
     [[ <%= h.changeCase.pascalCase(name) %> ]]
  </div>
</template>

<script>
export default {
  props: {},

  data() {
    return {};
  }
};
</script>

<style src="./<%=h.changeCase.pascalCase(name)%>.scss" lang="scss" scoped />
