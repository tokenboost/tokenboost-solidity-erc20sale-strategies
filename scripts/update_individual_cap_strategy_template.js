require("dotenv").config();
const IndividualCapStrategyRenderer = artifacts.require('IndividualCapStrategyRenderer');
const IndividualCapStrategy = artifacts.require('IndividualCapStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.individual-cap",
            IndividualCapStrategy,
            IndividualCapStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            3 * 10 ** 18,
            (await getAccounts(web3))[0],
            'Individual Cap',
            'Each individual has his/her own cap.'
        );
        callback();
    } catch (e) {
        callback(e);
    }
};
