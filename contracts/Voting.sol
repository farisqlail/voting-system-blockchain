// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // Struktur untuk kandidat
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Mapping dari ID kandidat ke kandidat
    mapping(uint => Candidate) public candidates;

    // Mapping untuk mencatat pemilih yang telah memberikan suara
    mapping(address => bool) public voters;

    // Jumlah total kandidat
    uint public candidatesCount;

    // Jumlah total suara
    uint public totalVotes;

    constructor() {
        addCandidate("Alice");
        addCandidate("Bob");
    }

    // Fungsi untuk menambahkan kandidat
    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Fungsi untuk memberikan suara
    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "Anda sudah memberikan suara.");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "ID kandidat tidak valid.");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
        totalVotes++;
    }

    // Fungsi untuk mendapatkan jumlah suara kandidat
    function getVotes(uint _candidateId) public view returns (uint) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "ID kandidat tidak valid.");
        return candidates[_candidateId].voteCount;
    }
}
