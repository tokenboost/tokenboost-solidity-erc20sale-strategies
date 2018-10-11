require("dotenv").config();
const ClaimableTokenDistributionStrategyRenderer = artifacts.require('ClaimableTokenDistributionStrategyRenderer');
const ClaimableTokenDistributionStrategy = artifacts.require('ClaimableTokenDistributionStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        let template = await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.claimable-token-distribution",
            ClaimableTokenDistributionStrategy,
            ClaimableTokenDistributionStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            2 * 10 ** 18,
            (await getAccounts(web3))[0]
        );
        await Promise.all([
            await template.setNameAndDescription(
                'en',
                'Claimable Token Distribution',
                'Using strategy, tokens are not distributed at the payment but buyers can claim their tokens after your sale is successful. It prevents your tokens to be traded before the success of your sale.'
            ),
            await template.setNameAndDescription(
                'ko',
                '인출가능한 토큰 분배',
                '이 전략을 사용하면 토큰이 구매자에게 바로 지급되는 것이 아니라, 세일 성공 후에 구매자가 인출 가능합니다. 세일 성공 전에 토큰이 시장에서 거래되는 것을 막을 수 있습니다.'
            )
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
