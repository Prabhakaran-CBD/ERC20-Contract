// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "../contracts/utils/Ownable.sol";

contract KycContract is Ownable {
    mapping(address => bool) private allowed;

    //set the user completed the KYC and allowed to buy tokens
    function setKYCCompleted(address _user) public onlyOwner {
        allowed[_user] = true;
    }

    //revoke the allowed KYC for the cutomer/user
    function SetKYCRevoke(address _user) public onlyOwner {
        allowed[_user] = false;
    }

    //verifying/chekcing where the user is completed the KYC to buy the tokens
    function isKYCCompleted(address _user) public view returns (bool) {
        return allowed[_user];
    }
}
