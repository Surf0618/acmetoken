pragma solidity ^0.4.18;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/AcmeToken.sol";

contract TestAcmeToken {


  //testing pause variable set and unset
  function testPauseUsingDeployedContract() public {
    AcmeToken acmeToken = AcmeToken(DeployedAddresses.AcmeToken());
    Assert.equal(acmeToken.paused(),false,"paused should be initialized to false");

    //acmeToken.pause();  // this doesn't work here

  }

  function testPauseUsingNewContract() public {
    AcmeToken acmeToken = new AcmeToken(DeployedAddresses.AcmeToken());
    Assert.equal(acmeToken.paused(),false,"paused should be initialized to false");
    acmeToken.pause();
    Assert.equal(acmeToken.paused(),true,"paused should be set to true");
    acmeToken.unpause();
    Assert.equal(acmeToken.paused(),false,"paused should be set back to false");
    Assert.equal(acmeToken.multisigAddress(),DeployedAddresses.AcmeToken(),"multisigaddress not same");
   }
}
