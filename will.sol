// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


contract Will{
address owner;
uint fortune;
bool deceased;

constructor() payable public {
owner = msg.sender;
fortune = msg.value;
deceased= false;
}

modifier onlyOwner{
    require(msg.sender == owner);
    _;
}

modifier isDeceased{
    require(deceased == true);
    _;
}
 address payable [] familyWallets;
mapping(address => uint ) inheritance;

function setInheritance(address payable wallet, uint amount) public {
  familyWallets.push(wallet);
  inheritance[wallet]= amount;
}
}