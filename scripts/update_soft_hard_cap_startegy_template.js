require("dotenv").config();
const SoftHardCapStrategyRenderer = artifacts.require('SoftHardCapStrategyRenderer');
const SoftHardCapStrategy = artifacts.require('SoftHardCapStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.soft-hard-cap",
            SoftHardCapStrategy,
            SoftHardCapStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            3 * 10 ** 18,
            (await getAccounts(web3))[0],
            'Soft/Hard Cap',
            'If the soft cap is reached, your fundraising is successful. Then if the hard cap is reached, your fundraising is finished.'
        );
        callback();
    } catch (e) {
        callback(e);
    }
};
