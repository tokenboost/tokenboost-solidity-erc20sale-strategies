require("dotenv").config();
const AllowedTokenSupplyStrategyRenderer = artifacts.require('AllowedTokenSupplyStrategyRenderer');
const AllowedTokenSupplyStrategy = artifacts.require('AllowedTokenSupplyStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        let template = await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.allowed-token-supply",
            AllowedTokenSupplyStrategy,
            AllowedTokenSupplyStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            2 * 10 ** 18,
            (await getAccounts(web3))[0]
        );
        await Promise.all([
            await template.setNameAndDescription(
                'en',
                'Allowed Token Supply',
                'This strategy supplies tokens to the sale. Before your sale starts, you should "approve" this strategy to transfer your tokens on behalf of you.'
            ),
            await template.setNameAndDescription(
                'ko',
                '허용된(allowed) 토큰 공급',
                '이 전략은 세일에 토큰을 공급합니다. 세일이 시작되기 전에 이 전략이 토큰 주인을 대신해 토큰을 전송할 수 있도록 "승인"해야 합니다.'
            )
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
