require("dotenv").config();
const WhitelistStrategyRenderer = artifacts.require('WhitelistStrategyRenderer');
const WhitelistStrategy = artifacts.require('WhitelistStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.whitelist",
            WhitelistStrategy,
            WhitelistStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            3 * 10 ** 18,
            (await getAccounts(web3))[0],
            'Whitelist',
            'Only whitelisted addresses can participate into the sale.'
        );
        callback();
    } catch (e) {
        callback(e);
    }
};
