const setResource = require('./setResource');
const VeriffKycStrategyAdminWidgetRenderer = artifacts.require("VeriffKycStrategyAdminWidgetRenderer");
const VeriffKycStrategyRenderer = artifacts.require("VeriffKycStrategyRenderer");

module.exports = async (callback) => {
    try {
        console.log("Setting Up " + VeriffKycStrategyAdminWidgetRenderer.contractName);
        let renderer = await VeriffKycStrategyAdminWidgetRenderer.deployed();
        await Promise.all([
            await setResource(renderer, "en", "blacklisted_countries", "Blacklisted Countries"),
            await setResource(renderer, "en", "blacklisted_countries_short_desc", "Citizens from blacklisted countries are not allowed to participate in the sale."),
            await setResource(renderer, "en", "whitelisted_countries", "Whitelisted Countries"),
            await setResource(renderer, "en", "whitelisted_countries_short_desc", "Only citizens from whitelisted countries are allowed to participate in the sale."),
            await setResource(renderer, "en", "country_name", "Country Name"),
            await setResource(renderer, "en", "country_code", "Country Code"),
            await setResource(renderer, "en", "add", "Add"),
            await setResource(renderer, "en", "add_confirm", "Do you want to add this country?"),
            await setResource(renderer, "en", "remove", "Remove"),
            await setResource(renderer, "en", "remove_confirm", "Do you want to remove this country?"),
            await setResource(renderer, "ko", "blacklisted_countries", "블랙리스트 국가"),
            await setResource(renderer, "ko", "blacklisted_countries_short_desc", "블랙리스트 국가의 시민들은 세일에 참여할 수 없습니다."),
            await setResource(renderer, "ko", "whitelisted_countries", "화이트리스트 국가"),
            await setResource(renderer, "ko", "whitelisted_countries_short_desc", "화이트리스트 국가의 시민들만 세일에 참여할 수 있습니다."),
            await setResource(renderer, "ko", "country_name", "국가명"),
            await setResource(renderer, "ko", "country_code", "국가코드"),
            await setResource(renderer, "ko", "add", "추가"),
            await setResource(renderer, "ko", "add_confirm", "이 국가를 추가하시겠습니까?"),
            await setResource(renderer, "ko", "remove", "제거"),
            await setResource(renderer, "ko", "remove_confirm", "이 국가를 제거하시겠습니까?"),
        ]);

        console.log("Setting Up " + VeriffKycStrategyRenderer.contractName);
        renderer = await VeriffKycStrategyRenderer.deployed();
        await Promise.all([
            await setResource(renderer, "en", "start_kyc", "Start KYC"),
            await setResource(renderer, "en", "start_kyc_short_desc", "You need to complete KYC process."),
            await setResource(renderer, "en", "start_kyc_long_desc", "You can complete KYC process with your passport or other documents."),
            await setResource(renderer, "en", "blacklisted", "Blacklisted"),
            await setResource(renderer, "en", "blacklisted_desc", "If 'blacklisted' is on, you can choose countries to be included in the blacklist.  Otherwise, you can choose countries to be included in the whitelist."),
            await setResource(renderer, "en", "update", "Update"),
            await setResource(renderer, "en", "update_confirm", "Do you want to update?"),
            await setResource(renderer, "ko", "start_kyc", "KYC 시작하기"),
            await setResource(renderer, "ko", "start_kyc_short_desc", "KYC 프로세스를 완료해야 합니다."),
            await setResource(renderer, "ko", "start_kyc_long_desc", "여권이나 기타 문서로 KYC 프로세르를 완료할 수 있습니다."),
            await setResource(renderer, "en", "blacklisted", "블랙리스트"),
            await setResource(renderer, "en", "blacklisted_desc", "만약 '블랙리스트'를 켠다면 블랙리스트에 추가할 국가를 선택할 수 있습니다. 그렇지 않다면 화이트리스트에 추가할 국가를 선택할 수 있습니다."),
            await setResource(renderer, "ko", "update", "업데이트"),
            await setResource(renderer, "ko", "update_confirm", "업데이트 하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
