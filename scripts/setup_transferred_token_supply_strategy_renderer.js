const setResource = require('./setResource');
const TransferredTokenSupplyStrategyRenderer = artifacts.require("TransferredTokenSupplyStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + TransferredTokenSupplyStrategyRenderer.contractName);
    try {
        let renderer = await TransferredTokenSupplyStrategyRenderer.deployed();
        await Promise.all([
            await setResource(renderer, "en", "transfer", "Transfer"),
            await setResource(renderer, "en", "transfer_short_desc", "To make the sale work, you need to transfer the maximum amount of tokens to sell to the strategy."),
            await setResource(renderer, "en", "transfer_long_desc", "If not all tokens are sold after the sale finishes, you can withdraw the remaining."),
            await setResource(renderer, "en", "transferred_tokens", "Transferred Tokens"),
            await setResource(renderer, "en", "transferred_tokens_short_desc", "The strategy has this amount of tokens."),
            await setResource(renderer, "en", "transferred_tokens_long_desc", "This amount of tokens is used for the sale."),
            await setResource(renderer, "en", "strategy_address", "Strategy Address"),
            await setResource(renderer, "en", "amount", "Amount"),
            await setResource(renderer, "en", "transfer_confirm", "Do you want to transfer?"),
            await setResource(renderer, "en", "unsold_tokens", "Unsold Tokens"),
            await setResource(renderer, "en", "withdraw_unsold_tokens", "Withdraw Unsold Tokens"),
            await setResource(renderer, "en", "withdraw_unsold_tokens_short_desc", "You can withdraw remaining tokens."),
            await setResource(renderer, "en", "withdraw_unsold_tokens_long_desc", "You can withdraw remaining tokens."),
            await setResource(renderer, "en", "withdraw_unsold_tokens_confirm", "Do you want to withdraw unsold tokens?"),
            await setResource(renderer, "ko", "transfer", "전송하기"),
            await setResource(renderer, "ko", "transfer_short_desc", "판매할 최대의 토큰 수량을 전략으로 전송해야 세일이 정상적으로 진행됩니다."),
            await setResource(renderer, "ko", "transfer_long_desc", "판매 종료 후 남은 토큰이 있으면 인출이 가능합니다."),
            await setResource(renderer, "ko", "transferred_tokens", "전송된 토큰"),
            await setResource(renderer, "ko", "transferred_tokens_short_desc", "전략이 가지고 있는 토큰의 수량."),
            await setResource(renderer, "ko", "transferred_tokens_long_desc", "이 수량만큼이 세일에 사용됩니다."),
            await setResource(renderer, "ko", "strategy_address", "전략 주소"),
            await setResource(renderer, "ko", "amount", "수량"),
            await setResource(renderer, "ko", "transfer_confirm", "전송하시겠습니까?"),
            await setResource(renderer, "ko", "unsold_tokens", "팔리지 않은 토큰"),
            await setResource(renderer, "ko", "withdraw_unsold_tokens", "팔리지 않은 토큰 인출"),
            await setResource(renderer, "ko", "withdraw_unsold_tokens_short_desc", "남은 토큰을 인출할 수 있습니다."),
            await setResource(renderer, "ko", "withdraw_unsold_tokens_long_desc", "남은 토큰을 인출할 수 있습니다."),
            await setResource(renderer, "ko", "withdraw_unsold_tokens_confirm", "남은 토큰을 인출하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
