<template>
  <ul>
    <li v-for="candidate in candidates" :key="candidate.id">
      {{ candidate.name }} - Votes: {{ candidate.voteCount }}
      <button @click="$emit('vote', candidate.id)">Vote</button>
    </li>
  </ul>
</template>

<script>
export default {
  props: {
    candidates: {
      type: Array,
      required: true,
    },
  },
};
</script>
