# ERC20 token with the following functionality

1. ERC20 basic contract
2. Owner can pause unpause the contract


## Development env settings
### Install
1. Clone this repo. Nodejs and npm are assumed to be installed.
2. Install truffle `npm install -g truffle`
3. Download ganache (http://truffleframework.com/ganache/) personal ethereum blockchain and set permissions on it `chmod u+x ganache-1.1.0-beta.0-x86_64.AppImage` 
4. Under acmetoken do `npm install zeppelin-solidity` to install the solidity libraries

### Compile and deploy on local testnet  (truffle.js uses the default Ganache settings)
1. `truffle compile`    - this compiles solidity contracts under contracts/ folder  
2.  Run gananche `./ganache-1.1.0-beta.0-x86_64.AppImage`
3. `truffle migrate --reset`    - this deployes using the default n/w. Else specify using --network <name>

## Testing

### Running tests

#### Manual tests using truffle console
1. Run [ganache]
2. Open truffle console using this command from the project directory
     `truffle console`
3. In the console you can perfrom following test  
   - `var acme = AcmeToken.at(AcmeToken.address)`
   - `acme.paused()`  should show false
   - `acme.pause()`   should execute the pause call that you can verify in Ganache
   - `acme.paused()`  should show true as the state in the contract is now changed

## ToDo:
1. React app to play with certain features of the contract
   - Display Pause state of the scripts
   - Display total supplay state of the scripts
   - Toggle button to Pause /Unpause based on pause state ( note : this is a txn action so would need to use wallet like metamask )
2. Add tasks  

##### Tested with following versions:
1. node v9.3.0 , npm 5.6.0
2. Truffle v4.0.4 (core: 4.0.4)
3. Solidity v0.4.18 (solc-js)
4. Ganache 1.0.1
