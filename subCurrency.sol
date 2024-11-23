// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


contract Coin {
    address public minter;
    mapping (address => uint) public balances;

    constructor(){
        minter = msg.sender;

    }
     event Sent(address from, address to, uint amount);
  
     modifier onlyMinter{
     require(minter == msg.sender);
     _;
     }

    function mint(address receiver, uint amount) onlyMinter public{
        balances[receiver] += amount;
    }

    error insufficientBalance(uint requested, uint available);

    function send(address receiver, uint amount)payable public  {
        if(balances[msg.sender] < amount)
            revert insufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }

}