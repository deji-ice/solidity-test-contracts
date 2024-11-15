// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

contract SimpleStorage {
    // write all the code here
    uint storedData;
    string name = "John";
    bool switchOn = true;

    function set(uint x) public {
        storedData = x * 5;
    }

    function get() public view returns (uint){

        return storedData;
    }
}

contract NameStorage{
    string name;

    function set(string memory x) public{
        name = x;
    }
    function get() public view returns(string memory){
        return name;
    }
}