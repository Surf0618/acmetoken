const AcmeToken = artifacts.require('../contracts/AcmeToken.sol')

const BigNumber = web3.BigNumber;
var publicSaleSupply = new BigNumber(500 * 10**18);
console.log(publicSaleSupply.toString())

contract("XCELTOKEN", function(accounts) {
    const founderAddress = accounts[1];
    const publicSaleBuyerAddr = accounts[2];
    const testAddress = accounts[3];

    it("creation: should create an initial balance of 25 bil for the public supply", function(done) {
        var ctr;
        AcmeToken.new(founderAddress, publicSaleBuyerAddr).then(function(result) {
            ctr = result;
            return ctr.publicSaleBuyerAddr.call();
    }).then(function (result) {
        assert.strictEqual(result, publicSaleBuyerAddr);
        return ctr.publicSaleSupply.call();
    }).then(function(result) {
        assert.isTrue(publicSaleSupply.eq(result));
        //any numner other than the actual number represeneted by publicSaleSupply
        assert.isFalse(new BigNumber(501 * 10**18).eq(result));
        done();
       }).catch(done);
    });

    it("public supply purchase: token buyer should be able to send 10 acme token to an address", function(done) {
        var ctr;
        AcmeToken.new(founderAddress, publicSaleBuyerAddr).then(function(result) {
        ctr = result;
        console.log('contract deployed for tokenbuyer test ' + result);
        //assumes first account in accounts as the owner that was used to deploy the contracts
        return ctr.paused();
    }).then (function (isPaused) {
        console.log('script paused: ' + isPaused);
         return ctr.balanceOf(testAddress);
      }).then (function (result) {
        var beforeBalanceOfTestAddress = result;
        console.log("balance for " + testAddress + " is : " + beforeBalanceOfTestAddress);
        assert.isTrue(beforeBalanceOfTestAddress.eq(new BigNumber(0)));
        //assume that your exchange app is accepting bitcoin for acme token sale
        return ctr.buyTokens(testAddress, (new BigNumber(10)).times(new BigNumber(10).pow(18)), 'BTC', '0x4ed593e3b0f41cecd0de314c8e701361d3ad850f6bf252af4da9ef3a39fc6988',{from: publicSaleBuyerAddr});
      }).then(function (result) {
        console.log(result);
        return ctr.balanceOf(testAddress);
      }).then(function (result) {
        assert.strictEqual(web3.fromWei(result, 'ether').toNumber(), 10);
        done();
      }).catch(done);

    });

  });
