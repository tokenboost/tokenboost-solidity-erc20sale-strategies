require("dotenv").config();
const ManualStartFinishStrategyRenderer = artifacts.require('ManualStartFinishStrategyRenderer');
const ManualStartFinishStrategy = artifacts.require('ManualStartFinishStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.manual-start-finish",
            ManualStartFinishStrategy,
            ManualStartFinishStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            3 * 10 ** 18,
            (await getAccounts(web3))[0],
            'Manual Start/Finish',
            'You can manually start and finish the fundraising.'
        );
        callback();
    } catch (e) {
        callback(e);
    }
};
