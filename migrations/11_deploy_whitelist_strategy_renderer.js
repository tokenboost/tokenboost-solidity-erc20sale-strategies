const WhitelistStrategyRenderer = artifacts.require("WhitelistStrategyRenderer");

module.exports = function (deployer) {
    deployer.deploy(WhitelistStrategyRenderer);
};
