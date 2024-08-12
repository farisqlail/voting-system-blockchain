const Voting = artifacts.require("Voting");

contract("Voting", (accounts) => {
    let votingInstance;

    before(async () => {
        votingInstance = await Voting.deployed();
    })

    it("should initialize with no two candidates", async () => {
        const candidatesCount = await votingInstance.candidatesCount();
        assert.equal(candidatesCount, 2, "There should be two candidates initially");
    });

    it("should allow a voter to cast a vote", async () => {
        await votingInstance.vote(1, {from: accounts[0] });
        const candidate = await votingInstance.candidates(1);
        assert.equal(candidate.voteCount, 1, "The candidate's vote count should increase");
        const hasVoted = await votingInstance.voter(accounts[0]);
        assert.equal(hasVoted, true, "The voter should be marked as voted");
    });

    it("Should not allow double voting", async () => {
        try {
            await votingInstance.vote(1, { from: accounts[0] });
            assert.fail("Expected error not received");
        } catch (error) {
            assert(error.message.indexOf("revert") >= 0, "Expected revert error, got: " + error.message);
        }
    })
})