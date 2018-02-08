const AcmeToken = artifacts.require('../contracts/AcmeToken.sol')

contract('AcmeToken', function () {

  it("should start AcmeToken paused as false", function() {
      var acmeToken = new AcmeToken(AcmeToken.address);

      acmeToken.paused().then(function(isPaused){
        assert.equal(isPaused, false, "paused should be initialized to false");
      });

  });

  it("should start AcmeToken paused as false, then true, then false again", function() {
    var acmeToken;

    return AcmeToken.deployed().then(function(instance) {
      acmeToken = instance;
      return acmeToken.paused();
    }).then(function(isPaused) {
      assert.equal(isPaused, false, "paused should be initialized to false");
      return acmeToken.pause();
    }).then(function(result) {
      return acmeToken.paused();
    }).then(function(isPaused){
      assert.equal(isPaused, true, "paused should be set to true");
      return acmeToken.unpause();
    }).then(function(result){
      return acmeToken.paused();
    }).then(function(isPaused) {
      assert.equal(isPaused,false,"paused should be set back to false");            
    });
  });

});
