pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract LegalPonzi is ReentrancyGuard {
    using Address for address payable;

    address public highestBidder;
    uint256 public highestBid;
    mapping(address => uint256) public pendingWithdrawals;

    function LegalPonzi() public {
        highestBidder = msg.sender;
    }

    function bid() public payable {
        address lastHighestBidder = highestBidder;

        // The offer value must be at least twice the previous one
        require(msg.value >= 2 * highestBid);
        // Set the value as the last bid
        highestBid = msg.value;
        // Set the sender as the last bidder
        highestBidder = msg.sender;
        // Add withdraw funds to previous max bidder
        pendingWithdrawals[lastHighestBidder] =
            pendingWithdrawals[highestBidder] +
            msg.value;
    }

    // Withdraw funds
    function withdraw() external nonReentrant {
        uint256 amount = pendingWithdrawals[msg.sender];
        payable(msg.sender).sendValue(amount);

        pendingWithdrawals[msg.sender] = 0;
    }
}
