// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GachaMachine {
    address public owner;
    mapping(address => uint) public playerBalances;
    uint public gachaCost = 10;

    event PrizeClaimed(address indexed player, string prize);
    event Withdrawal(address indexed owner, uint amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier hasEnoughFunds() {
        if (playerBalances[msg.sender] < gachaCost) {
            revert("Insufficient funds to play the gacha");
        }
        _;
    }

    function deposit(uint256 amount) external payable {
        // Ensure that the deposit amount is greater than zero
        assert(amount > 0);

        playerBalances[msg.sender] += amount;
    }

    function playGacha() external hasEnoughFunds {
        // Deduct the gacha cost from the player's balance
        playerBalances[msg.sender] -= gachaCost;

        // Generate a random prize (for simplicity, let's use a string)
        string memory prize = generateRandomPrize();

        // Emit an event to indicate that a prize has been claimed
        emit PrizeClaimed(msg.sender, prize);
    }

    function generateRandomPrize() internal view returns (string memory) {
        uint randomValue = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % 3;

        if (randomValue == 0) {
            return "Common Prize";
        } else if (randomValue == 1) {
            return "Rare Prize";
        } else {
            return "Epic Prize";
        }
    }

    // Fallback function to accept ether sent to the contract
    receive() external payable {}
}
