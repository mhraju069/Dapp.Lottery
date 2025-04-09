// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0 < 0.9.0;

contract Lottery {
    address public owner;
    address payable[] public players;

    constructor() {
        owner =  msg.sender;
    }

    receive() external payable {
        require(msg.value ==1 ether, 'Must be 1 Ether');
        players.push(payable (msg.sender));
     }
    function Balance() public view returns(uint) {
        require(msg.sender == owner,'Only owner can see balance');
        return address(this).balance;
    }
    function Winner() public{
        require(msg.sender == owner,'Only owner can pick winner');
        require(players.length>=3,'Participants must be more than 2');
        uint random = uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)))% players.length;
        address payable winner = players[random];
        winner.transfer(Balance());
        delete players;
    }

}
