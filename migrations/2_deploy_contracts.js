var MyContract = artifacts.require('auction');

module.exports = function(deployer) {
    // deployment steps
    deployer.deploy(MyContract);
};
