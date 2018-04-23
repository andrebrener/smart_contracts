contract MonthlySalaries {
    mapping(address => uint) public salaries;
    mapping(address => uint) public nextOpenDays;
    address public owner;
    uint256 public constant MONTH = 2628000;

    function MonthlySalaries() public {
        owner = msg.sender;
        // Hardcode my address. List employees with their salary
        salaries[0x580f917c58ff43d99ce9619f7cdf2c27a1005a1c] = 0.2 ether;
        // Hardcode my address. List employees with their first openDay
        nextOpenDays[0x580f917c58ff43d99ce9619f7cdf2c27a1005a1c] = 1522540800;  // April 1st 2018
    }

    function deposit() public payable {
        // Only the owner can deposit
        require(msg.sender == owner);
        }

    function updateSalary(address employee, uint256 updatedSalary) public {
        // Only the owner can update
        require(msg.sender == owner);
        // Set the new salary in the employee mapping
        salaries[employee] = updatedSalary;
        }

    function updateOpenDay(uint256 openDay) public view returns(uint256) {
        return openDay + MONTH;
    }

    function pay() public returns (bool) {
        // Only pay if the next open day is in the past
        if (block.timestamp >= nextOpenDays[msg.sender]) {
            // Transfer salary to the sender
            msg.sender.transfer(salaries[msg.sender]);
            // Update the sender's next open to the next month
            nextOpenDays[msg.sender] = updateOpenDay(nextOpenDays[msg.sender]);
            return true;
        }
    }

    function recoverFunds() public returns(bool) {
        // Only the owner can ask for the extra funds
        if (msg.sender == owner) {
            // Transfer the contract balance to the owner
            owner.transfer(address(this).balance);
            return true;
        }
    }
}
