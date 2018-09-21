require("dotenv").config();
const TransferredTokenSupplyStrategyRenderer = artifacts.require('TransferredTokenSupplyStrategyRenderer');
const TransferredTokenSupplyStrategy = artifacts.require('TransferredTokenSupplyStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.transferred-token-supply",
            TransferredTokenSupplyStrategy,
            TransferredTokenSupplyStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            2 * 10 ** 18,
            (await getAccounts(web3))[0],
            'Transferred Token Supply',
            'To supply tokens, you should transfer correct amount of tokens to this strategy.'
        );
        callback();
    } catch (e) {
        callback(e);
    }
};
