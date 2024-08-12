<template>
  <div>
    <h1>Voting System</h1>
    <div v-if="!accountConnected">
      <button @click="connectWallet">Connect Wallet</button>
    </div>
    <div v-else>
      <h2>Candidates</h2>
      <CandidateList :candidates="candidates" @vote="vote" />
    </div>
  </div>
</template>

<script>
import CandidateList from "~/components/CandidateList.vue";
import { initWeb3, loadCandidates, voteCandidate } from "~/utils/web3";

export default {
  components: { CandidateList },
  data() {
    return {
      web3: null,
      contract: null,
      candidates: [],
      accountConnected: false, // Perbaiki nama variabel dari accountsConnected menjadi accountConnected
    };
  },
  methods: {
    async connectWallet() {
      const { web3, contract } = await initWeb3();
      this.web3 = web3;
      this.contract = contract;
      this.accountConnected = true; // Sesuaikan dengan nama variabel yang benar
      this.loadCandidates();
    },
    async loadCandidates() {
      this.candidates = await loadCandidates(this.contract);
    },
    async vote(candidateId) { // Sesuaikan dengan nama metode yang benar
      await voteCandidate(this.contract, this.web3, candidateId);
      this.loadCandidates();
    },
  },
};
</script>
