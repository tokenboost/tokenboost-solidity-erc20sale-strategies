const ClaimableTokenDistributionStrategyRenderer = artifacts.require("ClaimableTokenDistributionStrategyRenderer");

module.exports = function (deployer) {
    deployer.deploy(ClaimableTokenDistributionStrategyRenderer);
};
