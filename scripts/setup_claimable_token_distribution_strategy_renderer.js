const setResource = require('./setResource');
const ClaimableTokenDistributionStrategyRenderer = artifacts.require("ClaimableTokenDistributionStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + ClaimableTokenDistributionStrategyRenderer.contractName);
    try {
        let renderer = await ClaimableTokenDistributionStrategyRenderer.deployed();
        await Promise.all([
            await setResource(renderer, "en", "claimable_tokens", "Claimable Tokens"),
            await setResource(renderer, "en", "claimable_tokens_short_desc", "The amount of tokens you can claim."),
            await setResource(renderer, "en", "claimable_tokens_long_desc", "You can claim tokens you purchased for this sale."),
            await setResource(renderer, "en", "address", "Address"),
            await setResource(renderer, "en", "claim", "Claim"),
            await setResource(renderer, "en", "claim_short_desc", "You can claim tokens that you purchased."),
            await setResource(renderer, "en", "claim_long_desc", "You can claim tokens that you purchased."),
            await setResource(renderer, "ko", "claimable_tokens", "인출가능한 토큰"),
            await setResource(renderer, "ko", "claimable_tokens_short_desc", "인출가능한 토큰의 양."),
            await setResource(renderer, "ko", "claimable_tokens_long_desc", "현재 세일에서 구입한 토큰을 인출할 수 있습니다."),
            await setResource(renderer, "ko", "address", "주소"),
            await setResource(renderer, "ko", "claim", "인출하기"),
            await setResource(renderer, "ko", "claim_short_desc", "구입한 토큰을 인출할 수 있습니다."),
            await setResource(renderer, "ko", "claim_long_desc", "구입한 토큰을 인출할 수 있습니다."),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
