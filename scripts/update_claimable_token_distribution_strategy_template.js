require("dotenv").config();
const ClaimableTokenDistributionStrategyRenderer = artifacts.require('ClaimableTokenDistributionStrategyRenderer');
const ClaimableTokenDistributionStrategy = artifacts.require('ClaimableTokenDistributionStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.claimable-token-distribution",
            ClaimableTokenDistributionStrategy,
            ClaimableTokenDistributionStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            2 * 10 ** 18,
            (await getAccounts(web3))[0],
            'Claiamble Token Distribution',
            'Buyers can claim their tokens after the fundraising finishes.'
        );
        callback();
    } catch (e) {
        callback(e);
    }
};
