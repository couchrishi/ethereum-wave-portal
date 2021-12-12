
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    
    /* Declaring a variable for capturing the total no. of waves */
    uint256 totalWaves;

    /* Declaring a seed to generate a random number later */
    uint256 private seed;

    /* Declaring an event for capturing every time there is a new waves from someone */
    event NewWave(address indexed from, uint256 timestamp, string message);

    /* Since we now intend to capture more than just the total no. of waves, we need a struct which can hold new attributes such as message, sender info etc. */
    struct Wave {
        address waver; // The address of who waved
        string message; // The message of the user sent
        uint256 timestamp; // The timestamp of when the user waved
    }

    /* Since we will have multiple users sending multiple waves & messages, we need an array of Struct */
    Wave[] waves;

    /** Creating a mapping to associate an address with a number, which is the no. of waves, from a user so that we can restrict spamming */
    mapping(address => uint256) public lastWavedAt;



    constructor() payable {
        console.log("You have been constructed");
        console.log("Yo yo, I am a contract and I am smart");

        /* Set the initial seed */
        seed = (block.timestamp + block.difficulty) %100;
    }

    /* The function now accepts 'message' as a parameter as well */

    function wave(string memory _message) public {

        /** Need to make sure the current timestamp is at least 15 mins lesser than the previous timestamp */
        require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
            "Wait 30s"
        );

        /** Update the  */
        lastWavedAt[msg.sender] = block.timestamp;
    
            
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);

        waves.push(Wave(msg.sender, _message, block.timestamp)); // Add the message and the corresponding details to the struct array

        seed = (block.timestamp + block.difficulty + seed) % 100; // Generating a new seed for the next user that sends a wave 

        if(seed < 50) {


            console.log("%s won", msg.sender);
            /* The same code to send the prize amount */
            uint256 prizeAmount = 0.001 ether;
            require(
                prizeAmount <= address(this).balance, "Trying to withdraw more money than the contract has."
            );

            (bool success,) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");

        }

        emit NewWave(msg.sender, block.timestamp, _message); // Emit a new wave event with the corresponding details so that the DOM element can capture it on the frontend later

    }

    /* A function to retrieve all the waves from the website by getting the struct array */
    function getAllWaves() public view returns(Wave[] memory) {
        return waves;

    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}

