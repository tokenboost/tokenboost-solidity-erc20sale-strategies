require("dotenv").config();
const CapStrategyRenderer = artifacts.require('CapStrategyRenderer');
const CapStrategy = artifacts.require('CapStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.cap",
            CapStrategy,
            CapStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            2 * 10 ** 18,
            (await getAccounts(web3))[0],
            'Single Cap',
            'When the cap is reached, your fundraising is finished.'
        );
        callback();
    } catch (e) {
        callback(e);
    }
};
