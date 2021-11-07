pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract MonthlySalaries is Ownable, ReentrancyGuard {
    mapping(address => uint256) public salaries;
    mapping(address => uint256) public nextOpenDays;
    uint256 public constant MONTH = 2628000;

    function MonthlySalaries() public {
        // Hardcode my address. List employees with their salary
        salaries[0x580f917c58ff43d99ce9619f7cdf2c27a1005a1c] = 0.2 ether;
        // Hardcode my address. List employees with their first openDay
        nextOpenDays[0x580f917c58ff43d99ce9619f7cdf2c27a1005a1c] = 1522540800; // April 1st 2018
    }

    function deposit() public payable onlyOwner {
        // Only the owner can deposit
    }

    function updateSalary(address employee, uint256 updatedSalary)
        public
        onlyOwner
    {
        // Set the new salary in the employee mapping
        salaries[employee] = updatedSalary;
    }

    function updateOpenDay(uint256 openDay) public view returns (uint256) {
        return openDay + MONTH;
    }

    function pay() public nonReentrant returns (bool) {
        // Only pay if the next open day is in the past
        if (block.timestamp >= nextOpenDays[msg.sender]) {
            // Update the sender's next open to the next month
            nextOpenDays[msg.sender] = updateOpenDay(nextOpenDays[msg.sender]);
            // Transfer salary to the sender
            msg.sender.transfer(salaries[msg.sender]);
            return true;
        }
    }

    function recoverFunds() public onlyOwner nonReentrant {
        // Transfer the contract balance to the owner
        payable(owner()).sendValue(address(this).balance);
    }
}
