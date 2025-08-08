/// ------------------------------
/// 12. On-Chain Will / Inheritance Contract
/// ------------------------------
contract Will {
    address public owner;
    address public heir;
    uint public lastPing;
    uint public timeout = 30 days;

    constructor(address _heir) payable {
        owner = msg.sender;
        heir = _heir;
        lastPing = block.timestamp;
    }

    function ping() external {
        require(msg.sender == owner);
        lastPing = block.timestamp;
    }

    function claimInheritance() external {
        require(block.timestamp > lastPing + timeout, "Owner is still alive");
        require(msg.sender == heir, "Not heir");
        payable(heir).transfer(address(this).balance);
    }
}

/// ------------------------------
/// 13. Decentralized Payroll
/// ------------------------------
contract Payroll {
    address public admin;
    mapping(address => uint) public salaries;
    mapping(address => uint) public lastPaid;

    constructor() {
        admin = msg.sender;
    }

    function setSalary(address employee, uint salary) external {
        require(msg.sender == admin);
        salaries[employee] = salary;
    }

    function pay(address employee) external {
        require(block.timestamp > lastPaid[employee] + 30 days, "Already paid this month");
        lastPaid[employee] = block.timestamp;
        payable(employee).transfer(salaries[employee]);
    }

    receive() external payable {}
}
