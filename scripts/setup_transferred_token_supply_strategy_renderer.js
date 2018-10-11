const TransferredTokenSupplyStrategyRenderer = artifacts.require("TransferredTokenSupplyStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + TransferredTokenSupplyStrategyRenderer.contractName);
    try {
        let renderer = await TransferredTokenSupplyStrategyRenderer.deployed();
        await Promise.all([
            await renderer.setResource("en", "transfer", "Transfer"),
            await renderer.setResource("en", "transfer_short_desc", "To make the sale work, you need to transfer the maximum amount of tokens to sell to the strategy."),
            await renderer.setResource("en", "transfer_long_desc", "If not all tokens are sold after the sale finishes, you can withdraw the remaining."),
            await renderer.setResource("en", "strategy_address", "Strategy Address"),
            await renderer.setResource("en", "amount", "Amount"),
            await renderer.setResource("en", "transfer_confirm", "Do you want to transfer?"),
            await renderer.setResource("en", "unsold_tokens", "Unsold Tokens"),
            await renderer.setResource("en", "withdraw_unsold_tokens", "Withdraw Unsold Tokens"),
            await renderer.setResource("en", "withdraw_unsold_tokens_short_desc", "You can withdraw remaining tokens."),
            await renderer.setResource("en", "withdraw_unsold_tokens_long_desc", "You can withdraw remaining tokens."),
            await renderer.setResource("en", "withdraw_unsold_tokens_confirm", "Do you want to withdraw unsold tokens?"),
            await renderer.setResource("ko", "transfer", "전송하기"),
            await renderer.setResource("ko", "transfer_short_desc", "판매할 최대의 토큰 수량을 전략으로 전송해야 세일이 정상적으로 진행됩니다."),
            await renderer.setResource("ko", "transfer_long_desc", "판매 종료 후 남은 토큰이 있으면 인출이 가능합니다."),
            await renderer.setResource("ko", "strategy_address", "전략 주소"),
            await renderer.setResource("ko", "amount", "수량"),
            await renderer.setResource("ko", "transfer_confirm", "전송하시겠습니까?"),
            await renderer.setResource("ko", "unsold_tokens", "팔리지 않은 토큰"),
            await renderer.setResource("ko", "withdraw_unsold_tokens", "팔리지 않은 토큰 인출"),
            await renderer.setResource("ko", "withdraw_unsold_tokens_short_desc", "남은 토큰을 인출할 수 있습니다."),
            await renderer.setResource("ko", "withdraw_unsold_tokens_long_desc", "남은 토큰을 인출할 수 있습니다."),
            await renderer.setResource("ko", "withdraw_unsold_tokens_confirm", "남은 토큰을 인출하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
