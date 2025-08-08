/// ------------------------------
/// DAO Voting Contract
/// ------------------------------
contract DAO {
    struct Proposal {
        string description;
        uint voteCount;
        bool executed;
    }

    address public chairperson;
    mapping(address => bool) public voters;
    Proposal[] public proposals;

    constructor() {
        chairperson = msg.sender;
        voters[msg.sender] = true;
    }

    function addVoter(address voter) external {
        require(msg.sender == chairperson, "Not chairperson");
        voters[voter] = true;
    }

    function createProposal(string memory description) public {
        require(voters[msg.sender], "Not authorized");
        proposals.push(Proposal(description, 0, false));
    }

    function vote(uint proposalIndex) public {
        require(voters[msg.sender], "Not authorized");
        proposals[proposalIndex].voteCount++;
    }

    function executeProposal(uint proposalIndex) public {
        require(proposals[proposalIndex].voteCount > 2, "Not enough votes");
        proposals[proposalIndex].executed = true;
        // Simulate execution logic here
    }
}
