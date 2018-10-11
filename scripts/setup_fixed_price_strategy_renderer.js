const FixedPriceStrategyRenderer = artifacts.require("FixedPriceStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + FixedPriceStrategyRenderer.contractName);
    try {
        let renderer = await FixedPriceStrategyRenderer.deployed();
        await Promise.all([
            await renderer.setResource("en", "token_price", "Token Price"),
            await renderer.setResource("en", "token_price_label", "Token Price (Number of tokens per 1 ETH)"),
            await renderer.setResource("en", "short_desc", "Number of tokens to be exchanged for 1 ETH."),
            await renderer.setResource("en", "long_desc", "Number of tokens to be exchanged for 1 ETH."),
            await renderer.setResource("en", "update", "Update"),
            await renderer.setResource("en", "update_confirm", "Do you want to update?"),
            await renderer.setResource("ko", "token_price", "토큰 가격"),
            await renderer.setResource("ko", "token_price_label", "토큰 가격 (1 ETH당 토큰 개수)"),
            await renderer.setResource("ko", "short_desc", "1 ETH당 교환해줄 토큰의 개수."),
            await renderer.setResource("ko", "long_desc", "1 ETH당 교환해줄 토큰의 개수."),
            await renderer.setResource("ko", "update", "업데이트"),
            await renderer.setResource("ko", "update_confirm", "업데이트하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
