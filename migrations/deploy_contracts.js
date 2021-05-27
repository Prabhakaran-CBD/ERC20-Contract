var CryptoToken = artifacts.require('./CryptoToken.sol')
var CryptoTokenSale = artifacts.require('./CryptoTokenSale.sol')
var KycContract = artifacts.require('./KycContract.sol')
require('dotenv').config({ path: '../.env' })

module.exports = async (deployer) => {
  const accounts = await web3.eth.getAccounts()
  //Deploy all the below contracts;
  //MyToken contract creates the token for the owner (msg.sender)
  await deployer.deploy(CryptoToken, process.env.INITIAL_TOKEN) ///supplying the token to the contract owner (msg.sender)
  await deployer.deploy(KycContract)
  await deployer.deploy(
    CryptoTokenSale,
    1,
    accounts[0],
    CryptoToken.address, //Contract address
    KycContract.address,
  )
  //from Owner tokens should transfer to the crowdsale/sales team who is going to sale the token
  //here MyTokenSale is taking care of selling the token
  //so transfer the tokens to MyTokenSale contract

  let instance = await CryptoToken.deployed() //taking the deployed contract also inherites the ERC20
  await instance.transfer(CryptoTokenSale.address, process.env.INITIAL_TOKEN) //ERC20- transfer(address recipient, uint256 amount)
}
