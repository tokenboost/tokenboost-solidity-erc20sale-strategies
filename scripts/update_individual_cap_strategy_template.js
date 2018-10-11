require("dotenv").config();
const IndividualCapStrategyRenderer = artifacts.require('IndividualCapStrategyRenderer');
const IndividualCapStrategy = artifacts.require('IndividualCapStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        let template = await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.individual-cap",
            IndividualCapStrategy,
            IndividualCapStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            3 * 10 ** 18,
            (await getAccounts(web3))[0]
        );
        await Promise.all([
            await template.setNameAndDescription(
                'en',
                'Individual Cap',
                'This strategy sets the maximum amount of ETH to raise from one address(cap).'
            ),
            await template.setNameAndDescription(
                'ko',
                '개인별 캡',
                '이 전략은 1주소당 참여할 수 있는 최대 ETH 금액(캡)을 설정합니다.'
            )
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
