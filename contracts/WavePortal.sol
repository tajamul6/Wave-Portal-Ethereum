// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    uint256 private seed;
    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user wave
    }

    Wave[] waves;

    mapping(address=>uint256) public lastWavedAt;
    // address[] wavers;
    
    constructor() payable {
        console.log("Yo yo, whaddup");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public{
        require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp, "Wait 15minutes");
        lastWavedAt[msg.sender] = block.timestamp;
        
        
        totalWaves += 1;
        console.log("%s just waved! with message %s", msg.sender, _message);
        // wavers.push(msg.sender);
        waves.push(Wave(msg.sender, _message, block.timestamp));
        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);

        if(seed < 50){
            console.log ("%s won", msg.sender);
        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance, "Trying to withdraw more money than the contract has"
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract");
        }

        emit NewWave(msg.sender, block.timestamp, _message);


    }

    function getTotalWaves() public view returns(uint){
        console.log("There are a total of %d waves", totalWaves);
        return totalWaves;
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

}