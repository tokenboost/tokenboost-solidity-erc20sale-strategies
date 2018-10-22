const VeriffKycStrategyAdminWidgetRenderer = artifacts.require("VeriffKycStrategyAdminWidgetRenderer");
const VeriffKycStrategyRenderer = artifacts.require("VeriffKycStrategyRenderer");

module.exports = function (deployer) {
    return deployer.then(async () => {
        await deployer.deploy(VeriffKycStrategyAdminWidgetRenderer);
        await deployer.deploy(VeriffKycStrategyRenderer, VeriffKycStrategyAdminWidgetRenderer.address);
    });
};

