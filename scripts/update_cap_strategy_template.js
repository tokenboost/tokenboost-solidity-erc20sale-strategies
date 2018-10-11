require("dotenv").config();
const CapStrategyRenderer = artifacts.require('CapStrategyRenderer');
const CapStrategy = artifacts.require('CapStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        let template = await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.cap",
            CapStrategy,
            CapStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            2 * 10 ** 18,
            (await getAccounts(web3))[0]
        );
        await Promise.all([
            await template.setNameAndDescription(
                'en',
                'Single Cap',
                'This strategy sets the maximum amount of ETH to raise(cap). When the cap is reached, your sale is finished.'
            ),
            await template.setNameAndDescription(
                'ko',
                '단일 캡',
                '이 전략은 세일에서 모금할 최대 ETH 금액(캡)을 설정합니다. 해당 캡이 달성되면 세일은 종료됩니다.'
            )
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
