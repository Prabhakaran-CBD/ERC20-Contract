//SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
/*  Returns true if `account` is a contract.
     `checkisContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account - EOA
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract exist, but was destroyed
     */
library Address {
    
    function checkIsContract (address _callerAddress) public view returns(bool) {
        
         // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        //note there will not semicolon (;) at the end since there is curly brasis {}
        assembly { codehash := extcodehash(_callerAddress) }
        //check the calling account is EOA or contract 
        //if EOA then return false, if it is contract then return true
        return(codehash != accountHash && codehash != 0x0);
        
        
    }
 }
