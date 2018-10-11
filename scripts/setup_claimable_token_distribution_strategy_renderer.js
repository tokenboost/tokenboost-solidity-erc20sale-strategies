const ClaimableTokenDistributionStrategyRenderer = artifacts.require("ClaimableTokenDistributionStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + ClaimableTokenDistributionStrategyRenderer.contractName);
    try {
        let renderer = await ClaimableTokenDistributionStrategyRenderer.deployed();
        await Promise.all([
            await renderer.setResource("en", "claimable_tokens", "Claimable Tokens"),
            await renderer.setResource("en", "claimable_tokens_short_desc", "The amount of tokens you can claim."),
            await renderer.setResource("en", "claimable_tokens_long_desc", "You can claim tokens you purchased for this sale."),
            await renderer.setResource("en", "address", "Address"),
            await renderer.setResource("en", "claim", "Claim"),
            await renderer.setResource("en", "claim_short_desc", "You can claim tokens that you purchased."),
            await renderer.setResource("en", "claim_long_desc", "You can claim tokens that you purchased."),
            await renderer.setResource("ko", "claimable_tokens", "인출가능한 토큰"),
            await renderer.setResource("ko", "claimable_tokens_short_desc", "인출가능한 토큰의 양."),
            await renderer.setResource("ko", "claimable_tokens_long_desc", "현재 세일에서 구입한 토큰을 인출할 수 있습니다."),
            await renderer.setResource("ko", "address", "주소"),
            await renderer.setResource("ko", "claim", "인출하기"),
            await renderer.setResource("ko", "claim_short_desc", "구입한 토큰을 인출할 수 있습니다."),
            await renderer.setResource("ko", "claim_long_desc", "구입한 토큰을 인출할 수 있습니다."),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
