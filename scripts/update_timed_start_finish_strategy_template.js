require("dotenv").config();
const TimedStartFinishStrategyRenderer = artifacts.require('TimedStartFinishStrategyRenderer');
const TimedStartFinishStrategy = artifacts.require('TimedStartFinishStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.timed-start-finish",
            TimedStartFinishStrategy,
            TimedStartFinishStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            3 * 10 ** 18,
            (await getAccounts(web3))[0],
            'Timed Start/Finish',
            'You can set when to start and finish the fundraising.'
        );
        callback();
    } catch (e) {
        callback(e);
    }
};
