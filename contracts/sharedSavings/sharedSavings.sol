pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract SharedSavings is ReentrancyGuard {
    using Address for address payable;

    uint256 public constant DURATION = 1 years;
    mapping(address => uint256) public creations;
    mapping(address => uint256) public balances;

    function deposit() public payable {
        if (creations[msg.sender] == 0) {
            creations[msg.sender] = block.timestamp;
        }
        balances[msg.sender] += msg.value;
    }

    function openTime(address owner) public view returns (uint256) {
        return creations[owner] + DURATION;
    }

    function getSavings() public nonReentrant returns (bool) {
        if (block.timestamp >= openTime(msg.sender)) {
            payable(msg.sender).sendValue(balances[msg.sender]);
            balances[msg.sender] = 0;
            return true;
        }
    }
}
