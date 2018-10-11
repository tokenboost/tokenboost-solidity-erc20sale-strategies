require("dotenv").config();
const SoftHardCapStrategyRenderer = artifacts.require('SoftHardCapStrategyRenderer');
const SoftHardCapStrategy = artifacts.require('SoftHardCapStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        let template = await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.soft-hard-cap",
            SoftHardCapStrategy,
            SoftHardCapStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            3 * 10 ** 18,
            (await getAccounts(web3))[0]
        );
        await Promise.all([
            await template.setNameAndDescription(
                'en',
                'Soft/Hard Cap',
                'The soft cap is the minimum amount of ETH to raise and the hard cap is the maximum amount of ETH to raise. If the soft cap is reached, your sale is successful. Then if the hard cap is reached, your sale finishes.'
            ),
            await template.setNameAndDescription(
                'ko',
                '소프트/하드 캡',
                '소프트 캡은 모금할 최소 ETH이고 하드 캡은 모금할 최대 ETH입니다. 소프트 캡이 달성되면 세일은 성공합니다. 그 후 하드 캡이 달성되면 세일은 종료되고 더이상 토큰이 판매되지 않습니다.'
            )
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
