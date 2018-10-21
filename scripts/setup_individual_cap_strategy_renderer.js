const setResource = require('./setResource');
const IndividualCapStrategyRenderer = artifacts.require("IndividualCapStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + IndividualCapStrategyRenderer.contractName);
    try {
        let renderer = await IndividualCapStrategyRenderer.deployed();
        await Promise.all([
            await setResource(renderer, "en", "individual_cap", "Individual Cap"),
            await setResource(renderer, "en", "individual_cap_short_desc", "The maximum amount of ETH to raise from one address."),
            await setResource(renderer, "en", "individual_cap_long_desc", "The maximum amount of ETH to raise from one address."),
            await setResource(renderer, "en", "my_cap", "My Cap"),
            await setResource(renderer, "en", "my_cap_short_desc", "The remaining amount of ETH you can pay to purchase tokens."),
            await setResource(renderer, "en", "my_cap_long_desc", "The remaining amount of ETH you can pay to purchase tokens."),
            await setResource(renderer, "en", "update", "Update"),
            await setResource(renderer, "en", "update_confirm", "Do you want to update?"),
            await setResource(renderer, "ko", "individual_cap", "개인 캡"),
            await setResource(renderer, "ko", "individual_cap_short_desc", "하나의 주소에서 참여할 수 있는 최대 ETH 금액."),
            await setResource(renderer, "ko", "individual_cap_long_desc", "하나의 주소에서 참여할 수 있는 최대 ETH 금액."),
            await setResource(renderer, "ko", "my_cap", "나의 캡"),
            await setResource(renderer, "ko", "my_cap_short_desc", "토큰 구입을 위해서 최대로 지불할 수 있는 남아있는 ETH 금액."),
            await setResource(renderer, "ko", "my_cap_long_desc", "토큰 구입을 위해서 최대로 지불할 수 있는 남아있는 ETH 금액."),
            await setResource(renderer, "ko", "update", "업데이트"),
            await setResource(renderer, "ko", "update_confirm", "업데이트하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
