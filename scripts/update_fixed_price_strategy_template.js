require("dotenv").config();
const FixedPriceStrategyRenderer = artifacts.require('FixedPriceStrategyRenderer');
const FixedPriceStrategy = artifacts.require('FixedPriceStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        let template = await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.fixed-price",
            FixedPriceStrategy,
            FixedPriceStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            2 * 10 ** 18,
            (await getAccounts(web3))[0]
        );
        await Promise.all([
            await template.setNameAndDescription(
                'en',
                'Fixed Price',
                'This strategy sets the number of . When the cap is reached, your sale is finished.'
            ),
            await template.setNameAndDescription(
                'ko',
                '고정 가격',
                '이 전략은 1 ETH당 제공해줄 토큰의 개수를 설정합니다.'
            )
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
