// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;
    uint public candidatesCount;

    event VotedEvent (
        uint indexed candidatesId
    );
    

    constructor() {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidatesId) public {
        require(!voters[msg.sender], "You have already vote!");
        require(_candidatesId > 0 && _candidatesId <= candidatesCount, "Invalid candidate ID!");
        
        voters[msg.sender] = true;
        candidates[_candidatesId].voteCount++;

        emit VotedEvent(_candidatesId);
    }

    function getCandidate(uint _candidatesId) public view returns (uint, string memory, uint) {
        require(_candidatesId > 0 && _candidatesId <= candidatesCount, "Invalid candidate ID!");
        Candidate memory candidate = candidates[_candidatesId];
        return (candidate.id, candidate.name, candidate.voteCount);
    }
}