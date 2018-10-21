const setResource = require('./setResource');
const AllowedTokenSupplyStrategyRenderer = artifacts.require("AllowedTokenSupplyStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + AllowedTokenSupplyStrategyRenderer.contractName);
    try {
        let renderer = await AllowedTokenSupplyStrategyRenderer.deployed();
        await Promise.all([
            await setResource(renderer, "en", "allowed_tokens", "Allowed Tokens"),
            await setResource(renderer, "en", "allowed_tokens_short_desc", "The amount of tokens you allowed the strategy to transfer on behalf of you."),
            await setResource(renderer, "en", "allowed_tokens_long_desc", "Allowance is a feature of ERC20 standard. By approving an account with a specific amount, that account has ability to transfer tokens on behalf of you."),
            await setResource(renderer, "en", "approve", "Approve"),
            await setResource(renderer, "en", "approve_short_desc", "To make the sale work, you need to approve the strategy to supply tokens on behalf of you."),
            await setResource(renderer, "en", "approve_long_desc", "By clicking the approve button, you allow the strategy to supply tokens on behalf of you."),
            await setResource(renderer, "en", "address", "Address"),
            await setResource(renderer, "en", "amount", "Amount"),
            await setResource(renderer, "en", "approve_confirm", "Do you want to approve?"),
            await setResource(renderer, "ko", "allowed_tokens", "허용된 토큰"),
            await setResource(renderer, "ko", "allowed_tokens_short_desc", "전략이 세일 주인을 대신해서 보낼 수 있도록 승인한 토큰의 양."),
            await setResource(renderer, "ko", "allowed_tokens_long_desc", "허용된 토큰은 ERC20 표준의 한가지 기능입니다. 특정 계정에게 특정 수량의 토큰을 허용한다면, 그 계정은 토큰의 소유자를 대신해 해당 수량 만큼의 토큰을 전송할 수 있게 됩니다."),
            await setResource(renderer, "ko", "approve", "승인"),
            await setResource(renderer, "ko", "approve_short_desc", "세일이 이루어지기 위해서는 전략이 토큰을 공급할 수 있도록 승인해야 합니다."),
            await setResource(renderer, "ko", "approve_long_desc", "아래 승인 버튼을 누르면 전략이 토큰을 대신해서 공급할 수 있게 됩니다."),
            await setResource(renderer, "ko", "address", "주소"),
            await setResource(renderer, "ko", "amount", "수량"),
            await setResource(renderer, "ko", "approve_confirm", "승인하시겠습니까?"),
        ]);

        callback();
    } catch (e) {
        callback(e);
    }
};
