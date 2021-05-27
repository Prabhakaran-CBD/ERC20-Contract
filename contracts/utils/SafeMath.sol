//SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

/**
Solidity throws overflow or underflow issue in arithmetic operation
example when do sub from uint number and that cause some negative value 
to fix this we this utils to restores by reverting the transaction.
Note : the new version of solidity provide unchecked block to use for overflow operation
but that cause some extra gas so it better to use this library


*/
library SafeMath {
    //for addtion
    function add(uint256 x, uint256 y) internal pure returns (uint256) {
        uint256 z = x + y;
        require(z >= x, "Addition overflow");

        return z;
    }

   //for subtraction 
    function sub(uint256 x, uint256 y, string memory errMsg) internal pure returns (uint256) {
        require(y <= x, errMsg);
        uint256 z = x - y;

        return z;
    }

    // for Multiplication
    function mul(uint256 x, uint256 y) internal pure returns (uint256) {
        //multiplying with zero is not valid so check it prior 
        if (x == 0 || y==0) {
            return 0;
        }

        uint256 z = x * y;
        require(z / x == y, "Multiplication overflow");

        return z;
    }

    //The divisor cannot be zero.
    function div(uint256 x, uint256 y, string memory errMsg) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(y > 0, errMsg);
        uint256 z = x / y;
        
        return z;
    }

    
}
