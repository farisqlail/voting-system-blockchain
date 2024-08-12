import Web3 from "web3";
import VotingABI from "~/abis/Voting.json";

const CONTRACT_ADDRESS = "0x88a0f64bf0d5916adaA722604bf9b94Ef609FA7e";

export const initweb3 = async () => {
    if(window.ethereum) {
        const web3 = new Web3(window.ethereum);
        await window.ethereum.request({ method: 'eth_requestAccounts' });
        const contract = new Web3.eth.Contract(VotingABI, CONTRACT_ADDRESS);
        return {web3, contract};
    } else {
        alert("MetaMask is not Installed");
        throw new Error("MetaMask not installed");
    }
};

export const loadCandidates = async () => {
    const candidatesCount = await contract.methods.candidatesCount().all();
    const candidates = [];
    for (let i = 1; i <= candidatesCount; i++){
        const candidate = await contract.methods.getCandidate(i).call();
        candidates.push({
            id: candidate[0],
            name: candidate[1],
            voteCOunt: candidate[2]
        });
    }
    
    return candidates;
}

export const voteCandidate = async (contract, web3, candidateId) => {
    const accounts = await web3.eth.getAccounts();
    await contract.methods.vote(candidateId).send({ from: accounts[0] });
}