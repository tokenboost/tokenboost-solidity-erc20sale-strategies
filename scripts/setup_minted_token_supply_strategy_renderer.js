const setResource = require('./setResource');
const MintedTokenSupplyStrategyRenderer = artifacts.require("MintedTokenSupplyStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + MintedTokenSupplyStrategyRenderer.contractName);
    try {
        let renderer = await MintedTokenSupplyStrategyRenderer.deployed();
        await Promise.all([
            await setResource(renderer, "en", "strategy_address", "Strategy Address"),
            await setResource(renderer, "en", "set_minter", "Set Minter"),
            await setResource(renderer, "en", "set_minter_short_desc", "You need to set the strategy as a minter of your token to supply tokens."),
            await setResource(renderer, "en", "set_minter_long_desc", "You need to set the strategy as a minter of your token to supply tokens."),
            await setResource(renderer, "en", "set_minter_confirm", "Do you want to set minter?"),
            await setResource(renderer, "ko", "strategy_address", "전략 주소"),
            await setResource(renderer, "ko", "set_minter", "토큰 발행자(minter) 설정"),
            await setResource(renderer, "ko", "set_minter_short_desc", "토큰을 공급하기 위해서는 이 전략을 발행자(minter)로 설정해야 합니다."),
            await setResource(renderer, "ko", "set_minter_long_desc", "토큰을 공급하기 위해서는 이 전략을 발행자(minter)로 설정해야 합니다."),
            await setResource(renderer, "ko", "set_minter_confirm", "발행자로 설정하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
