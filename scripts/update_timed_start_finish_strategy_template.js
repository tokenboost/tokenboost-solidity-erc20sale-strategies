require("dotenv").config();
const TimedStartFinishStrategyRenderer = artifacts.require('TimedStartFinishStrategyRenderer');
const TimedStartFinishStrategy = artifacts.require('TimedStartFinishStrategy');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');
const updateTemplate = require('./updateTemplate.js');

module.exports = async function (callback) {
    try {
        let template = await updateTemplate(
            web3,
            "net.tokenboost.strategy.sale.erc20.timed-start-finish",
            TimedStartFinishStrategy,
            TimedStartFinishStrategyRenderer,
            ERC20SaleStrategyTemplate,
            ERC20SaleStrategyRegistry,
            3 * 10 ** 18,
            (await getAccounts(web3))[0],
        );
        await Promise.all([
            await template.setNameAndDescription(
                'en',
                'Timed Start/Finish',
                'You can set when to start and finish the sale.'
            ),
            await template.setNameAndDescription(
                'ko',
                '시간이 정해진 시작/종료',
                '세일을 시작할 시간과 종료할 시간을 미리 설정할 수 있습니다.'
            )
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
