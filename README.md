Blockchain:
---

The smart contracts are developed for the ethereum blockchain. Ethereum is a decentralized platform that runs smart contracts. Contracts can be deployed on the Ethereum Virtual Machine (EVM). Once deployed it can be accessed globally. These contracts are enforced and certified by parties that we call miners. Miners are multiple computers who add a transaction (Addition or modification of the state) to a public ledger that we call a block. Multiple blocks constitute a blockchain.
We pay these miners with something called Gas, which is the cost to run a contract. When you publish a smart contract, or execute a function of a smart contract, or transfer money to another account, you pay some ether that gets converted into gas.

Smart Contracts:
----

Smart contracts are self-executing contracts with the terms of the agreement between buyer and seller being directly written into lines of code. The code and the agreements contained therein exist across a distributed, decentralized blockchain network. Smart contracts permit trusted transactions and agreements to be carried out among disparate, anonymous parties without the need for a central authority, legal system, or external enforcement mechanism. They render transactions traceable, transparent, and irreversible.

Platforms:
--
High Level Languages for smart contract developing:

•	Solidity

Command Line Development Management Tools for creating a DAPP project:

•	Truffle

•	Embark

Browser based IDE to get instant feedback for solidity code:

•	ReMix
Wallet clients to connect a ethereum wallet

•	Metamask

•	MyEtherWallet

Compiler:
-
The contracts are written in solidity codes and these are to be compiled to get the Application Binary Interface (ABI) codes. ABI is the interface between two program modules, one of which is often at the level of machine code. The interface is the de facto method for encoding/decoding data into/out of the machine code. It defines how you can encode Solidity contract calls for the EVM and, backwards, how to read the data out of transactions. It also provides the Bytecode or the opcodes of the contract.
A command line tool such as truffle or online ide such as ReMix can be used to compile.

Network:
-
The smart contracts are deployed on the ethereum network on the EVM. But any transaction executed on this network requires ether to be spent, hence its not advicable for development.

Ethereum network is called 'mainnet’ and there exists multiple ‘testnet’ which are copies of ethereum network. Like ethereum, these networks have currency called ‘test ether’s which can be spent to execute a transaction on the network. Now the important difference is that you can get free ‘test ether’s here unlike real valued ether.
Some testnets are :

•	Ropsten – This is a global testnet with free test ether.

•	Rinkeby – Another global testnet with free ether.

There are few more, by using Testrpc we can add truffle development as well

Wallet:
-
Wallets are needed to deploy the smart contract and make the transaction.

•	It serves as client to Ethereum wallet. To make a transaction on network ether has to be spent and you can authorize these payments using this.

•	To communicate with a blockchain and to deploy, you need to either have a full node or a wallet client of the network. A wallet can facilitate the communication with the network.

Deployment:
-
To deploy a contract the following steps are to be taken:

•	Compile the code and get necessary bytecodes

•	Select a network to migrate or deploy.

•	Make a deployment with a wallet address as transaction sender

•	Authenticate the transaction form the wallet and pay the transaction cost.

Your contract will be deployed and will be assigned a public address which can be used to access it.

Install MetaMask:
-
1.	Go to https://metamask.io/ and install the browser plugin.
2.	Setup a password and open the wallet. Select the network as ‘Rinkeby Test Network’.
3.	Click on ‘CREATE ACCOUNT’ to create a new wallet account and click ‘Copy Address to clipboard’ to copy your public address for the wallet.
4.	Go to https://faucet.rinkeby.io/ to get free test ether to the address. Check your account on metamask and verify the balance.
5.	Repeat steps 3 and 4 to create more accounts.

Deploying contract:
-
1.	Go to http://remix.ethereum.org/ and upload your contract file 
2.	Compile the code. Make sure you’ve selected ‘.sol’ in the dropdown next to details. Ignore warnings.
3.	Go to the run tab. Make sure ‘Environment’ is set as ‘Injected Web3 ’ and shows ‘rinkeby’. Make sure ‘Account’ shows your wallet address in metamask. This is the account from which the contract will be deployed. ‘Gas limit’ and ‘Value’ needed to run on testnet but need enough gas on mainnet/livenet.
4.	Make sure ‘User’ is shown in the dropdown above ‘create’
(If any of the above steps fail, reload the browser)
5.	click ‘create’ and a popup will appear on metamask. Open metamask and Submit the transaction. Set a reasonable ‘Gas limit’ and ‘Gas Price’ according to network.
6.	Click on the transaction to go to https://rinkeby.etherscan.io/tx/ to know the status of transaction. If it is a success, your contract is deployed. In the ‘To’ section “[Contract 0x0000000000000000000000000000000000 Created]” will be shown. This is your contract address. Copy it. Click on it to know about the incoming transaction to the contract.
Now the contract is deployed on the rinkeby network. You can access it using a web app.

KYC Smart Contract:
-
Know Your Customer 
Ethereum Blockchain Smart Contract Solidity/Ganache/Remix IDE

The goal of this project was to design a smart contract to do a pre-validation process before allowing them to buy the tokens, once they approved then those customers will added into whitelisted customers list. A user would upload their basic information using a GUI form. A KYC admin layer would have to validate after verifying their identity. 

