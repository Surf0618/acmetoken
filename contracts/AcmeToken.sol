pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC20/PausableToken.sol";

contract AcmeToken is PausableToken {
  string public name = "ACMETOKEN";
  string public symbol = "ACM";
  uint public decimals = 18;
  //1000 initial supply with 2 decimal places
  uint256 public INITIAL_SUPPLY =1000 * (10 ** decimals);
  address public multisigAddress;

  //address that is used to buy from public sale allocation
  //Since public sale can happen for a while this provides flexibility to support
  //different token (like BTC, ETH) to purchse AcmeToken and exchange rate can be handled
  //outside of the purcahse call.
  address public publicSaleBuyerAddr;
  // public sale supply`
  uint256 public publicSaleSupply;

  event TokensBought(address _to, uint256 _totalAmount, bytes4 _currency, bytes32 _txHash);

  // Token Buyer has special rights
  modifier onlyPublicSaleBuyerAddr() {
      require(msg.sender == publicSaleBuyerAddr);
      _;
  }

  function AcmeToken(address _multisigAddress, address _publicSaleBuyerAddr) public {
    totalSupply_ = INITIAL_SUPPLY;
    multisigAddress = _multisigAddress;
    publicSaleBuyerAddr = _publicSaleBuyerAddr;
    publicSaleSupply = 500 * (10 ** decimals);

    //mint all tokens
    balances[msg.sender] = totalSupply_;
    Transfer(address(0x0), msg.sender, totalSupply_);

    //Allow  token buyer to transfer public sale allocation
    approve(publicSaleBuyerAddr, 0);
    approve(publicSaleBuyerAddr, publicSaleSupply);

  }

  // Not supporting a payable function
  //This provides flexibiltiy to handle exchange rate fluctuations when buying using other TokensBought
  // which can be handled on a separate exchange app that will call this function for final token transer
  function buyTokens(address _to, uint256 _totalAmount, bytes4 _currency, bytes32 _txHash)
  external
  onlyPublicSaleBuyerAddr
  returns(bool) {
      require(_totalAmount > 0 && publicSaleSupply >= _totalAmount);

      if(transferFrom(owner,_to, _totalAmount)) {
          publicSaleSupply =  publicSaleSupply.sub(_totalAmount);          
          TokensBought(_to, _totalAmount, _currency, _txHash);
          return true;
      }
      revert();
  }

}
