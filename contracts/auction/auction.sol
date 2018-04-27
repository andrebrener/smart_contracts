pragma solidity ^0.4.19;

contract Auction {
    address public owner;
    address public highestBidder;
    uint public highestBid;
    uint public creation;
    uint256 public constant DURATION = 600; // 10 minutes

    function Auction() public {
        owner = msg.sender;
        creation = block.timestamp;
    }

    function finishTime() public view returns(uint256) {
        return creation + DURATION;
    }

    function bid() public payable {
        address lastHighestBidder = highestBidder;
        uint256 lastHighestBid = highestBid;

        // The bid value must be a % greater than the previous one
        // The action does not have to be finished
        require(msg.value > highestBid + 5 * highestBid / 100 && finishTime() >= block.timestamp);
        // Set the sender as the winner for the moment
        highestBidder = msg.sender;
        // Set the value as the winner for the moment
        highestBid = msg.value;
        // Make a refund of the last highest bid to the last highest bidder
        lastHighestBidder.transfer(lastHighestBid);
    }

    function recoverFunds() public returns(bool) {
        // Only the owner can recover the funds
        // The auction must be finished
        if (msg.sender == owner && block.timestamp >= finishTime()) {
            // Tranfer the maximum bid to the owner
            owner.transfer(address(this).balance);
            return true;
        }
    }
}
