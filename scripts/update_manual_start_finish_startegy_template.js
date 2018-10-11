require("dotenv").config();
const ManualStartFinishStrategyRenderer = artifacts.require('ManualStartFinishStrategyRenderer');
const ManualStartFinishStrategy = artifacts.require('ManualStartFinishStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        let template = await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.manual-start-finish",
            ManualStartFinishStrategy,
            ManualStartFinishStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            3 * 10 ** 18,
            (await getAccounts(web3))[0]
        );
        await Promise.all([
            await template.setNameAndDescription(
                'en',
                'Manual Start/Finish',
                'You can manually start and finish the sale by clicking buttons on the dashboard.'
            ),
            await template.setNameAndDescription(
                'ko',
                '수동 시작/종료',
                '대시보드의 버튼을 눌러서 직접 세일을 시작하고 종료할 수 있습니다.'
            )
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
