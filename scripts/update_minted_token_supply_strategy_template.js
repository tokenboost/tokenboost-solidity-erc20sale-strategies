require("dotenv").config();
const MintedTokenSupplyStrategy = artifacts.require('MintedTokenSupplyStrategy');
const MintedTokenSupplyStrategyRenderer = artifacts.require('MintedTokenSupplyStrategyRenderer');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.minted-token-supply",
            MintedTokenSupplyStrategy,
            MintedTokenSupplyStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            2 * 10 ** 18,
            (await getAccounts(web3))[0],
            'Minted Token Supply',
            'To supply tokens, tokens are minted every time when a buyer wants to buy.'
        );
        callback();
    } catch (e) {
        callback(e);
    }
};
