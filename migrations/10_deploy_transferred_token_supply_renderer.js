const TransferredTokenSupplyStrategyRenderer = artifacts.require("TransferredTokenSupplyStrategyRenderer");

module.exports = function (deployer) {
    deployer.deploy(TransferredTokenSupplyStrategyRenderer);
};
