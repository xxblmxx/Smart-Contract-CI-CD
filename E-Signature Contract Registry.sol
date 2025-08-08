/// ------------------------------
/// 14. E-Signature Contract Registry
/// ------------------------------
contract SignatureRegistry {
    mapping(bytes32 => address) public documentSigner;

    function signDocument(string memory docHash) public {
        bytes32 hash = keccak256(abi.encodePacked(docHash));
        require(documentSigner[hash] == address(0), "Already signed");
        documentSigner[hash] = msg.sender;
    }

    function verifySignature(string memory docHash, address expectedSigner) public view returns (bool) {
        bytes32 hash = keccak256(abi.encodePacked(docHash));
        return documentSigner[hash] == expectedSigner;
    }
}
