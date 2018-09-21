require("dotenv").config();
const AllowedTokenSupplyStrategyRenderer = artifacts.require('AllowedTokenSupplyStrategyRenderer');
const AllowedTokenSupplyStrategy = artifacts.require('AllowedTokenSupplyStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.allowed-token-supply",
            AllowedTokenSupplyStrategy,
            AllowedTokenSupplyStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            2*10**18,
            (await getAccounts(web3))[0],
            'Allowed Token Supply',
            'To supply tokens, you should allow this strategy to transfer your tokens on behalf of you.'
        );
        callback();
    } catch (e) {
        callback(e);
    }
};
