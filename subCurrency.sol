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
        require(receiver != address(0), "Invalid receiver address");
        balances[receiver] += amount;
    }

    error insufficientBalance(uint requested, uint available);

    function send(address receiver, uint amount) public  {
        uint senderBalance = balances[msg.sender];
        if(senderBalance < amount)
            revert insufficientBalance({
                requested: amount,
                available: senderBalance
            });
        
        balances[msg.sender] = senderBalance - amount;
        balances[receiver] += amount;
        
        emit Sent(msg.sender, receiver, amount);
    }

}