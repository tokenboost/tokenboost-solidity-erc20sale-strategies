require("dotenv").config();
const MintedTokenSupplyStrategy = artifacts.require('MintedTokenSupplyStrategy');
const MintedTokenSupplyStrategyRenderer = artifacts.require('MintedTokenSupplyStrategyRenderer');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        let template = await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.minted-token-supply",
            MintedTokenSupplyStrategy,
            MintedTokenSupplyStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            2 * 10 ** 18,
            (await getAccounts(web3))[0]
        );
        await Promise.all([
            await template.setNameAndDescription(
                'en',
                'Minted Token Supply',
                "This strategy supplies tokens to the sale. Tokens are minted every time when a buyer wants to buy. Your token contract should implement 'mint(address,uint256)' function."
            ),
            await template.setNameAndDescription(
                'ko',
                '발행(mint)되는 토큰 공급',
                "이 전략은 세일에 토큰을 공급합니다. 구매자가 구매를 원할 때마다 새로운 토큰이 발행됩니다. 토큰 계약은 'mint(address,uint256)' 함수를 구현하고 있어야 합니다."
            )
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
