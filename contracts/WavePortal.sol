// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    address[] wavers;
    constructor() {
        console.log("Yo yo, whaddup");
    }

    function wave() public{
        totalWaves += 1;
        console.log("%s just waved!", msg.sender);
        wavers.push(msg.sender);
    }

    function getTotalWaves() public view returns(uint){
        console.log("There are a total of %d waves", totalWaves);
        return totalWaves;
    }

    function getWavers() public view{
        for(uint i = 0; i < wavers.length; i++){
            console.log("Waver no. %d : ", i+1);
            console.log(wavers[i]);
        }
    }
}