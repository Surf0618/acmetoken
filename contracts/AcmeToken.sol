pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/PausableToken.sol";

contract AcmeToken is PausableToken {
  string public name = "ACMETOKEN";
  string public symbol = "ACM";
  uint public decimals = 2;
  //1000 initial supply with 2 decimal places
  uint256 public INITIAL_SUPPLY =1000 * (10 ** decimals);


  function AcmeToken() public {
    totalSupply = INITIAL_SUPPLY;
  }

}
