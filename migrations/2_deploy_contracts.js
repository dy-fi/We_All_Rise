var Rise = artifacts.require("./Rise.sol");
var RiseOwnership = artifacts.require("./riseownership.sol");
var RiseHelper = artifacts.require("./risehelper.sol");

module.exports = function(deployer) {
    deployer.deploy(Rise);
    deployer.deploy(RiseOwnership);
    deployer.deploy(RiseHelper)
};