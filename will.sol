// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


contract Will{
address owner;
uint fortune;
bool isDeceased;

constructor() payable {
owner = msg.sender;
fortune = msg.value;
isDeceased= false;
}

modifier onlyOwner{
    require(msg.sender == owner);
    _;
}

modifier mustBeDeceased{
    require(isDeceased == true);
    _;
}
 address payable [] familyWallets;
mapping(address => uint ) inheritance;

function setInheritance(address payable wallet, uint amount) public onlyOwner{
 require(amount <= fortune, "Amount exceeds the available fortune.");
  familyWallets.push(wallet);
  inheritance[wallet]= amount;
}
function payout() mustBeDeceased onlyOwner private {

for(uint i =0; i < familyWallets.length; i++){
    
    familyWallets[i].transfer(inheritance[familyWallets[i]]);
}
}

//ORACLE SIMULATED SWITCH
function desceased() public  onlyOwner{
    isDeceased = true;
    payout();
}
}