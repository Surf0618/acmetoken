var AcmeToken = artifacts.require("AcmeToken");

module.exports = function(deployer) {
  deployer.deploy(AcmeToken);
};
