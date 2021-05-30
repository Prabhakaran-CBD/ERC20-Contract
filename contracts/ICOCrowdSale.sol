// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "../contracts/utils/SafeMath.sol";
import "./ERC20Interface.sol";
import "../contracts/utils/Address.sol";


//This contract allows to purchase tokens with ether... 
//take care of selling the token, receiving the amount, transfering token etc..
//but doing this before do check preValidationPurchase by knowing the customer (KYC)
contract ICOCrowdSale  {
    using SafeMath for uint256;
    using Address for address;
    
    // The token being sold
    ERC20Interface private _token;

    // Address where funds are collected
    address payable private _wallet;

    // How many token units a buyer gets per wei.
    // The rate is the conversion between wei and the smallest and indivisible token unit (TKNbites).
    uint256 private _rate;

    // Amount of wei raised
    uint256 private _weiRaised;

    //hardCap is set to 300 Ether and converted in Wei below
    //in real case this can be wirtten in function to get the cap even can increase or decrease
    uint private _hardCap = 300000000000000000000;
    
    /**
     *  rate Number of token units a buyer gets per wei
     *  1 wei will give you 1 unit, or 0.001 TOK.
     *  wallet Address where collected funds will be forwarded to
     *  token Address of the token being sold
     */
    constructor(
        uint256 rates,
        address payable walletAddress,
        ERC20Interface tokenAddress
    )  {
        require(rates > 0, "ICO: rate is 0");
        require(walletAddress != address(0), "ICO: wallet is the zero address");
        require(
            address(tokenAddress) != address(0),
            "ICO: token is the zero address"
        );

        _rate = rates;
        _wallet = walletAddress;
        _token = tokenAddress;
    }
    

     //this event used to emit to get to know purchaser, who got the tokens as beneficiary, 
     //how much paid for purchase
    event TokensPurchased(
        address indexed purchaser,
        address indexed beneficiary,
        uint256 value,
        uint256 amount
    );

    
    /*
      Note - Need enough gas to call the purchaseToken function 
      Sending ether and calling this function directly when purchasing tokens from a contract.
     */
    //Here receives ether/wei
    //it should be external and payable to receive the the ether.
    receive() external payable {
        purchaseTokens(msg.sender);
    }
    
    // beneficiary Recipient of the token purchase
    // this function called directly when purchaser send ether to purhcase token
    //this purhcaseToken process will invoked only if buying raised is not reached the hardCap
    function purchaseTokens(address beneficiary) public payable {
        require(_weiRaised < _hardCap, "Reached the Cap, no more sales avaiable" );

         uint256 weiAmount = msg.value;

        //call the preValidatePurchase to check the customer and proceed only if it is valid
        preValidatePurchase(beneficiary, weiAmount);
        
        // calculate token amount to be created
        uint256 tokens = weiAmount.mul(_rate);

         //raise the wei amount to check the cap value
        _weiRaised = _weiRaised.add(weiAmount);

        //call transfer token function to transfer the tokens to beneficiary
        transferTokens(beneficiary, tokens);

        emit TokensPurchased(msg.sender, beneficiary, weiAmount, tokens);
        //call this function to forward the received ETH to the wallet(token owner) address.
        forwardFunds();
        
    }

    //Validation of an incoming purchase. Use require statements to revert state when conditions are not met.
    //beneficiary Address performing the token purchase
    // weiAmount Value in wei involved in the purchase
   
    function preValidatePurchase(address beneficiary, uint256 weiAmount)
        internal
        view
        virtual
    {
        require(
            beneficiary != address(0),
            "ICO: beneficiary is the zero address"
        );
        require(weiAmount != 0, "ICO: weiAmount is 0 - Checking by Prabhakaran");
        this; // silence state mutability warning without generating bytecode as per solidity issues 2691
    }

    
      //-------------------------> Helper Function for ICO Contract <---------------------//
    
    //transfer the tokens to the buyer/token purchaser
    //this is safe trnasfer so do transfer only if the call came from token contract not from an EOA accounts
    //to do safe transder check EIP protocal - call the checkIsContract function
    //beneficiary - Address performing the token purchase
    //tokenAmount - Number of tokens to be emitted
   function transferTokens(address beneficiary, uint256 tokenAmount) internal {
        //call the transfer function from ERC20 interface   
       _token.transfer(beneficiary, tokenAmount);
    } 
     
    /*
     `checkisContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account - EOA
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract exist, but was destroyed
     */
    
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
    
    //return the token being sold.
    function token() public view returns (ERC20Interface) {
        return _token;
    }
    
    //forward the received ETH (received from the token buyer) is to the wallet(token owner) address.
    function forwardFunds() internal {
        _wallet.transfer(msg.value); //do transfer (address member function)
    }
    
    
    //this function returns total funds are collected
    function wallet() public view returns (address payable) {
        return _wallet;
    }
    
   //this function is used to raise the amount of wei collected
   //and using this value we can do hardCap or softCap decesion to continue the token sale
    function weiRaised() public view returns (uint256) {
        return _weiRaised;
    }

    //returns rate that used to get the number of token units a buyer gets per wei.
    function rate() public view returns (uint256) {
        return _rate;
    }
}

