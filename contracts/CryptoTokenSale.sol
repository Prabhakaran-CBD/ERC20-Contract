// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ICOCrowdSale.sol";
import "./ERC20Interface.sol";
import "./KycContract.sol";

/*
Description : This contract is to send the token to crowdsale which was supplied from Mytoken contrat
and then crowdsale will take care of selling the token, receiving the amount, transfering token etc..
but doing this before doing preValidationPurchase, postValidationPurchase
*/
contract CryptoTokenSale is ICOCrowdSale {
    //constructor is in Crowdsale contract and expecting three arguments
    //so having own constractor here(MyCrowdsale) and receving value while deploying the MyCrowdsale Contract
    //and then passing those wale to the Crowdsale constructor
    //also while deploying this contract get the KYC contract address

    KycContract Kyc;

    constructor(
        uint256 rates, // rate in TKNbits
        address payable wallet, //the address where funds are collected.
        ERC20Interface token, //Token address
        KycContract _Kyc //KYC instance/address of the contract to play in this contract
    )  ICOCrowdSale(rates, wallet, token) {
        //need to get the instance of the smartcontract (Kyc) once deployed
        //think in remix once we deployed the main contract we will get the instance
        //then we use that instance to play with other contracts which used inside the main contract
        
        Kyc = _Kyc;
    }

    //get the address of the Kyc
    

    function preValidatePurchase(address beneficiary, uint256 weiAmount)
        internal
        view
        override
    {
        super.preValidatePurchase(beneficiary, weiAmount); //this will call the base function (from parent)
        //use the KycContract to validate that user(Beneficiary) able to buy the token
        require(
            Kyc.isKYCCompleted(beneficiary),
            "User is not Verified by KYC process and not able to buy the token"
        );
    }
    
}
