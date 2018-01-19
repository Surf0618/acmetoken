# ERC20 token with the following functionality

1. ERC20 basic contract
2. Owner can pause unpause the contract


## Development env settings
### Install
1. Clone for for this repo
2. Under acmetoken do ***npm install zeppelin-solidity*** to install the solidity libraries

### Compile and deploy on local testnet  (truffle.js uses the default Ganace settings)
1. truffle compile    // this compiles solidity contracts under contracts/ folder  
2. truffle migrate --reset    // this deployes using the default n/w. Else specify using --network <name>

###Testing

## Running tests

## Manual tests using truffle console
1. Open truffle console using this command from the project directory
     ***truffle console***
2. In the console you can perfrom following test  
  -- var acme = AcmeToken.at(AcmeToken.address) --
  -- acme.paused() --  should show false
  -- acme.pause() -- should execute the pause call that you can verify in Ganache
  -- acme.paused() --  should show true as the state in the contract is now changed

## ToDo:
1. React app to play with certain features of the contract
  1.1 Display Pause state of the scripts
  1.2 Displau total supplay state of the scripts
  1.2 Toggle button to Pause /Unpause based on pause state ( note : this is a txn action so would need to use wallet like metamask )

##### Tested with following versions:
node v9.3.0
Truffle v4.0.4 (core: 4.0.4)
Solidity v0.4.18 (solc-js)
Ganache 1.0.1
