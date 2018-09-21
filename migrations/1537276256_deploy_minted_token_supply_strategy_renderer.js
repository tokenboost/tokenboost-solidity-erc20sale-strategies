const MintedTokenSupplyStrategyRenderer = artifacts.require("MintedTokenSupplyStrategyRenderer");

module.exports = function (deployer) {
    deployer.deploy(MintedTokenSupplyStrategyRenderer);
};
