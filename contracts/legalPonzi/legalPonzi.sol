pragma solidity ^0.4.19;

contract LegalPonzi {
    address public owner;
    address public highestBidder;
    uint public highestBid;


    function LegalPonzi() public {
        owner = msg.sender;
        highestBidder = msg.sender;
    }

    function bid() public payable {
        // The offer value must be at least twice the previous one
        require(msg.value >= 2 * highestBid);
        // Transfer a % of the new bid to the address that had the maximum
        highestBidder.transfer(90 * msg.value / 100);
        // Transfer a fee to the owner
        owner.transfer(10 * msg.value / 100);
        // Set the value as the last bid
        highestBid = msg.value;
        // Set the sender as the last bidder
        highestBidder = msg.sender;
    }
}
