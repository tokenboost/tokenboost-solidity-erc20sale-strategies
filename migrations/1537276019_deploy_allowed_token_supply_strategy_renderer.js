const AllowedTokenSupplyStrategyRenderer = artifacts.require("AllowedTokenSupplyStrategyRenderer");

module.exports = function (deployer) {
    deployer.deploy(AllowedTokenSupplyStrategyRenderer);
};

