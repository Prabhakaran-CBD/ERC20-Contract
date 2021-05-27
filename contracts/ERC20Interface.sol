//SPDX-License-Identifier: GIT
pragma solidity >=0.4.22 <0.9.0;

//Created on 03/17/2021 to have ERC20 Interface

interface ERC20Interface {
//this will going to have list of functions than can be implemented in ERC20 token Contract 
//Note in interface all  defined functions should be exteranl and virtual is implicity declared in interface so no need to speicfy them
//no constructor and state varaible can be defined in the interface
//for ERC20 token we need below standards functions to be implement in the token contract
//This function do initially supply to owner and it can fix total supply
function totalSupply() external view returns(uint _value) ;


//returns the balance token amount of the account holds
function balanceOf(address _tokenOwner) external view returns(uint _tokenValue);

//-Moves the amount of tokens from the function caller address (msg.sender) to the recipient address.
//how this can be done in this function..said below
//-basically subtracting the amount from sender(msg.sender) balance account  
//-and adding the amount to the recipient balance account
//-This function emits the Transfer event. 
function transfer(address _to, uint _tokenValue) external returns(bool);


//this function returns amount of token approved by the owner and that transferred to the spender account
//bascially it returns remaining number of tokens that spender spend
function allowance(address _tokenOwner, address _spender) external view returns(uint _remainingTokenValue);


//from the address of the sender ...to to the address of the receiver ... the amount of the token to be transferred
function transferFrom(address _from, address _to, uint _value) external returns(bool);

//basically setting amount of tokens that spender can spend/transfer and it approved by the owner 
// @notice `msg.sender` approves `_spender` to spend `_value` tokens
// @param _spender The address of the account able to transfer the tokens
// @param _value The amount of tokens to be approved for transfer
// @return Whether the approval was successful or not
//--ie mapping of mapping spender.. [msg.sender][spender] = amount
function approve(address _spender, uint _tokenValue) external returns(bool);

//events
 event Transfer(address indexed _from , address indexed _to, uint _value );
 event Approval(address indexed _tokenOwner, address indexed _spender, uint _tokens);

}