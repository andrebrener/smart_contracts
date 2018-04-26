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
        address lastHighestBidder = highestBidder;

        // The offer value must be at least twice the previous one
        require(msg.value >= 2 * highestBid);
        // Set the value as the last bid
        highestBid = msg.value;
        // Set the sender as the last bidder
        highestBidder = msg.sender;
        // Transfer the new bid to the address that had the maximum
        lastHighestBidder.transfer(msg.value);
    }
}
