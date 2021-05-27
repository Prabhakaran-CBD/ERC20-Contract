//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {

    address private _owner;

    constructor()  {
        _owner = msg.sender;
    }

    function owner() public view returns (address) {
        return _owner;
    }

//only owner have access to call
    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }
}