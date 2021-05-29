// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ERC20.sol";

/*
  Discripton - This contract used to create/minting the token and supply to the owner msg.sender
 */

//My token is inherting the ERC20 contract which has constructor with two arguments(name and symbol)
contract CryptoToken is ERC20 {
    //setting this constructor to pass initial supply while deploying this contract (MyToken)
    //and taking that initial supply and send to minting function(_mint from ERC20) below to create the token
    constructor(uint256 initialSupply)
        
        ERC20("Crypto Token", "CAPPU") //name and symbol
    {
        //mint function is called from inherited ERC20 contract
        //this mint function is used to add a initialSupply to the totalSupply of tokens
        //so totalSupply function will returns the amount of tokens in existence
        _mint(msg.sender, initialSupply);
     
    }
}
