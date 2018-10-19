const FixedPriceStrategyRenderer = artifacts.require("FixedPriceStrategyRenderer");

module.exports = function (deployer) {
    deployer.deploy(FixedPriceStrategyRenderer);
};

