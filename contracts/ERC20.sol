//SPDX-License-Identifier: GIT
pragma solidity >=0.4.22 <0.9.0;

import "./ERC20Interface.sol";
import "../contracts/utils/SafeMath.sol";


//this contract is used to create the token using ERC20 standard interface
contract ERC20 is ERC20Interface {
    
    //using SafeMath library for uint to avoid overflow error
    using SafeMath for uint;
    
    string public _tokenName;
    string public _tokenSymbol;
    uint8 public _decimals;
    
    //this variable holds the total amount of token for the contracts to supply
    uint public _totalSupply;
    //this address is deploy the contract and who creates the token
    //and owner who is going to have inital token supply and he allowes and approves to spenders
    address public _tokenOwner;
    
    //event -- -This event is emitted when the amount of tokens (value) is sent from the 'from-address' to the 'to-address'.
   
    
    //any EOA can hold number of crypto tokens.. so need to map all those address and its respective tokens thru mapping variable
    mapping(address => uint) public balances;
    
    
    //in the below mapping structure explains that
    //mapping(owner) allowed/approved (spender) to spend maimum no of tokens
    //so mapping(owner)(spender) = 100;
    //so its more on two dimentional mapping looks like two dimentional array
    mapping(address => mapping(address => uint)) public allowed;
    
    
    //constructor to set the token name and symbol while this ERC20 token called
    //Sets the values for {name} and {symbol}, initializes {decimals} with
    //All three of these values are immutable: they can only be set once during construction
    constructor(string memory _name, string memory _symbol) {
        
        _tokenOwner = msg.sender;
        _tokenName = _name;
        _tokenSymbol = _symbol;
        _decimals = 18;
        
    }
    
    modifier onlyAdmin {
        require(_tokenOwner == msg.sender, "Only admin have rights");
        _;
    }
    
    //this mint function is used to minting token and be called from other contract
    //will supply the token and creator of the token
    function _mint(address _tokenSupplier, uint _initialSupply) public {
            
        require(_initialSupply > 1000, "InitialSupply should meet the minium supply value" );
        _tokenOwner = _tokenSupplier;
        _totalSupply = _initialSupply;
        
        //who is owning the crypto tokens at the begning and how could someone transfer the tokens to others
        //so it needs intial token supply should supplied to the owner/founder 
        balances[_tokenOwner] += _totalSupply;

    }
    
    //----------------------> implement the functions inherited from the ERC20 interface <------------------------//
    //-> First Pahse in implementing the ERC20 standards <-//
    //includes below functions 
    /*
     totalSupply()
     balanceOf()
     transfer()
    */
    
    //external interface function is overide with public visibility
    function totalSupply() public view override returns(uint _value) {
    //return total token supply     
        return _totalSupply;
    } 
   
   //-Returns the amount of tokens owned by an address (account).
   //bascially how much token that account has hold get them and returns it
   
    function balanceOf(address _tokenOwnedAccount) public view override returns(uint _value) {
        //return the balance token amount of the account
        return balances[_tokenOwnedAccount];
    }
    
    //--------------------->Transfer Token Process<----------------//
    //-Moves the amount of tokens from the function caller address (msg.sender) to the recipient address.
	//-basically subtracting the amount from sender balance account  
    //-and adding the amount to the recipient balance account
    //-here using mapping variable to use the balances.
    
    /*
      @notice send `_value` token to `_to` from `msg.sender`
      @param _to The address of the recipient
      @param _value The amount of token to be transferred
      @return Whether the transfer was successful or not
      This function emits the Transfer event. 
    */
    
    function transfer(address _toRecipient, uint _tokenValue) public override returns(bool) {
        require(balances[msg.sender] >= _tokenValue && _tokenValue > 0, "Token value is zero or higher than the balance amount of token" );
        //Note here transfer means not doing account.transfer call rather moving the token around
        balances[msg.sender] -= _tokenValue; //taken the token value from the owner/token supplier
        balances[_toRecipient] += _tokenValue; //add the token to the recipient
    
        //emit the transfer event to get the log event 
        emit Transfer(msg.sender, _toRecipient, _tokenValue);
    
        return true;
    }
    
    
    //---------------------------> second Phase-------------<-//
    //Functions involved
    /*
    approve()
    transferFrom()
    allowance() - geter function (view function)
    */
    
    //this function permit token owner to approve another account (spender account) to spend up to the maximum no. of tokens 
    //bascially token owner giving tokens that the spender can spend maximum spend
    function approve(address _spender, uint _token) public override returns(bool) {
        require (_token > 0, "Token value is zero and can not be approve");
        require (balances[msg.sender] >= _token, "Not enough balance to approve tokens");
        
        allowed[msg.sender][_spender]= _token;
        emit Approval(msg.sender, _spender, _token);
        return true;
    }
    
    //this function called by spender and transfer the allowed tokens(after no. of tokens allowed from the above approve function) 
    //from the owners account to his acccount by using transferFrom() function
    function transferFrom(address _tokenOwnerAccount, address _spenderAccount, uint _token) public override returns(bool) {
        
        //so there are three steps involved while doing the transfer from the token owner account to spender account
        /*when transfer do 
            1.deduct the token from the token owner's account
            2.add those token to spender's account
            3.deduct the transfer tokens from the allowed no. of tokens
        */
        
        //1.deduct the token from the token owner's account
        //balances[_tokenOwnerAccount] -= _token;
        balances[_tokenOwnerAccount] =  balances[_tokenOwnerAccount].sub(_token,"ERC20: burn amount exceeds balance");
        //2.add those token to spender's account
        balances[_spenderAccount] += _token;
        //3.deduct the transfer tokens from the allowed no. of tokens
        allowed[_tokenOwnerAccount][_spenderAccount] -= _token;
        return true;
    }
    
    //this function is used to see how much tokens that the spender is allowed to spend or remaining token that spender has after he spent
    //getter function and it returns the token value that spender has
    function allowance(address _fromOwner, address _toSpender) public view override returns(uint) {
        return allowed[_fromOwner][_toSpender];
        
    } 
    
    //---------------------------> Other useful functions for ERC20 Token development <-----------------------------//
    /*
       //-Destroys `amount` tokens from `account` and reducing the total supply ..this is opposite action of the mint function..
      1.function burn(address account, uint256 amount) internal virtual {}
      
      //Atomically increases the allowance granted to `spender` by the owner/caller.
      //Emits an {Approval} event indicating the updated allowance.
      2.function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {}
      
      /Atomically decreases the allowance granted to `spender` by the owner/caller. 
      //Emits an {Approval} event indicating the updated allowance.
      3.function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {}
      
      
      */
      //this function will reduce the tokens from total supply and reduce the no.of tokens from the account that hold
      function burn(address _burnAccount, uint _tokenValue) public returns(bool){
          
          balances[_burnAccount] -= balances[_burnAccount].sub(_tokenValue, "Burn amount exceeds balance");
          _totalSupply -= _totalSupply.sub(_tokenValue, "Burn successfully");
          return true;
      }
      
      //this function used to increase the allowance granted to spender by the token owner
      function increaseAllowance(address _spender, uint _tokenValueIncrease) public {
        allowed[msg.sender][_spender] += _tokenValueIncrease;
      }
      
      //this function used to decrease the allowance granted to spender by the owner
      function decreaseAllowance(address _spender, uint _tokenValueDecrease) public {
          allowed[msg.sender][_spender] = allowed[msg.sender][_spender].sub(_tokenValueDecrease, "allownace decreased");
      }
    
}