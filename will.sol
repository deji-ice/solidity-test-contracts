// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// Contract that represents a will for distributing inheritance after the owner's death
contract Will {
    address owner; // The address of the contract owner (the person creating the will)
    uint fortune; // The total amount of ether (fortune) available for distribution
    bool isDeceased; // A flag to indicate whether the owner is deceased

    // Constructor that initializes the contract with the owner's address and the initial fortune
    constructor() payable {
        owner = msg.sender; // Set the owner to the address that deployed the contract
        fortune = msg.value; // Set the fortune to the amount of ether sent during deployment
        isDeceased = false; // Initially, the owner is not deceased
    }

    // Modifier to restrict function access to only the contract owner
    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can call this function.");
        _; // Placeholder for the modified function's body
    }

    // Modifier to ensure that certain functions can only be executed if the owner is deceased
    modifier mustBeDeceased {
        require(isDeceased == true, "The owner must be deceased.");
        _; // Placeholder for the modified function's body
    }

    address payable[] familyWallets; // Array to store addresses of family members' wallets
    mapping(address => uint) inheritance; // Mapping to associate each wallet with its inheritance amount

    // Function to set inheritance amounts for family members
    function setInheritance(address payable wallet, uint amount) public onlyOwner {
        require(amount <= fortune, "Amount exceeds the available fortune."); // Ensure amount does not exceed available fortune
        familyWallets.push(wallet); // Add the wallet address to the familyWallets array
        inheritance[wallet] = amount; // Set the inheritance amount for this wallet in the mapping
    }

    // Private function to distribute inheritance after owner's death
    function payout() mustBeDeceased onlyOwner private {
        for (uint i = 0; i < familyWallets.length; i++) { // Iterate through each family wallet
            familyWallets[i].transfer(inheritance[familyWallets[i]]); // Transfer the inheritance amount to each wallet
        }
    }

    // Function to simulate declaring the owner as deceased and trigger payout
    function desceased() public onlyOwner {
        isDeceased = true; // Set the deceased flag to true
        payout(); // Call payout function to distribute inheritance
    }
}
