require("dotenv").config();
const VeriffKycStrategyRenderer = artifacts.require('VeriffKycStrategyRenderer');
const VeriffKycStrategy = artifacts.require('VeriffKycStrategy');
const VeriffKyc = artifacts.require('tokenboost-veriff-kyc/VeriffKyc');
const ERC20SaleStrategyTemplate = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyTemplate');
const ERC20SaleStrategyRegistry = artifacts.require('tokenboost-solidity-erc20sale/ERC20SaleStrategyRegistry');
const getAccounts = require('./getAccounts');

String.prototype.toHex = function () {
    let arr = [];
    let i = 0, l = this.length;
    for (; i < l; i++) {
        let hex = Number(this.charCodeAt(i)).toString(16);
        arr.push(hex);
    }
    return arr.join('');
};

module.exports = async function (callback) {
    try {
        const identifier = "net.tokenboost.strategy.sale.erc20.veriff-kyc";
        let bytecode = VeriffKycStrategy.bytecode;
        let renderer = await VeriffKycStrategyRenderer.deployed();
        bytecode = bytecode.replace(
            new RegExp(("__" + VeriffKycStrategyRenderer.contractName + "__________________").substr(0, 20).toHex(), "gi"),
            renderer.address.substr(2)
        );
        let kyc = await VeriffKyc.deployed();
        bytecode = bytecode.replace(
            new RegExp(("__" + VeriffKyc.contractName + "__________________").substr(0, 20).toHex(), "gi"),
            kyc.address.substr(2)
        );
        console.log("bytecode: " + bytecode);

        let bytecodeHash = web3.sha3(bytecode, {encoding: 'hex'});
        console.log("bytecodeHash: " + bytecodeHash);
        let template = await ERC20SaleStrategyTemplate.new(bytecodeHash, 10 * 10 ** 18, (await getAccounts(web3))[0]);
        await template.setNameAndDescription("en","KYC (veriff.me)", "You can select country to allow or reject. Users with identities of allowed countries are able to participate in the sale.");
        await template.setNameAndDescription("ko","KYC (veriff.me)", "허용/거부할 국가를 선택할 수 있습니다. 허용된 국가의 신분을 갖고있는 사용자만이 세일에 참여할 수 있습니다.");
        console.log(ERC20SaleStrategyTemplate.contractName + ": " + template.address);

        let registry = await ERC20SaleStrategyRegistry.deployed();
        let versions = await registry.versionsOf(identifier);
        let version = versions.length === 0 ? 1 : parseInt(versions[versions.length - 1]) + 1;
        await registry.register(identifier, version, template.address);
        callback();
    } catch (e) {
        callback(e);
    }
};
