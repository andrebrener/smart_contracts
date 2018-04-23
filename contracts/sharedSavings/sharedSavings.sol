pragma solidity ^0.4.19;

contract SharedSavings {
    uint256 public constant DURATION = 1 years;
    mapping(address => uint) public creations;
    mapping(address => uint) public balances;


    function deposit() public payable {
        if (creations[msg.sender] == 0) {
            creations[msg.sender] = block.timestamp;
        }
        balances[msg.sender] += msg.value;
        }

    function openTime(address owner) public view returns (uint256) {
        return creations[owner] + DURATION;
    }

    function getSavings() public returns (bool) {
        if (block.timestamp >= openTime(msg.sender)) {
        msg.sender.transfer(balances[msg.sender]);
        balances[msg.sender] = 0;
        return true;
        }
    }
}
