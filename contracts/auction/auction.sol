pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Auction is Ownable, ReentrancyGuard {
    using Address for address payable;

    address public highestBidder;
    uint256 public highestBid;
    uint256 public creation;
    uint256 public constant DURATION = 600; // 10 minutes
    bool public fundsRecovered = false;

    // Withdraw
    mapping(address => uint256) public pendingWithdrawals;

    function Auction() public {
        creation = block.timestamp;
    }

    function finishTime() public view returns (uint256) {
        return creation + DURATION;
    }

    function bid() public payable {
        address lastHighestBidder = highestBidder;
        uint256 lastHighestBid = highestBid;

        // The bid value must be a % greater than the previous one
        // The action does not have to be finished
        require(
            msg.value > highestBid + (5 * highestBid) / 100,
            "Not enough $"
        );
        require(finishTime() >= block.timestamp, "Auction finished");

        // Set the sender as the winner for the moment
        highestBidder = msg.sender;
        // Set the value as the winner for the moment
        highestBid = msg.value;

        // Add withdraw funds to previous max bidder
        pendingWithdrawals[maxBidder] = pendingWithdrawals[highestBidder] + highestBid;
    }

    // Withdraw funds
    function withdraw() external nonReentrant {
        uint256 amount = pendingWithdrawals[msg.sender];
        payable(msg.sender).sendValue(amount);

        pendingWithdrawals[msg.sender] = 0;
    }

    function recoverFunds() public onlyOwner) {
        require(!fundsRecovered, "Already recovered");
        // The auction must be finished
        if (block.timestamp >= finishTime(), "Auction not ended") {
            // Tranfer the maximum bid to the owner
            payable(owner()).sendValue(highestBid);
            fundsRecovered = true;
        }
    }
}
