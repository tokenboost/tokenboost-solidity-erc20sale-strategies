const setResource = require('./setResource');
const CapStrategyRenderer = artifacts.require("CapStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + CapStrategyRenderer.contractName);
    try {
        let renderer = await CapStrategyRenderer.deployed();
        await Promise.all([
            await setResource(renderer, "en", "cap", "Cap"),
            await setResource(renderer, "en", "cap_short_desc", "Maximum amount of ETH to raise."),
            await setResource(renderer, "en", "cap_long_desc", "When the cap is reached, your sale is finished."),
            await setResource(renderer, "en", "cap_left", "Cap Left"),
            await setResource(renderer, "en", "cap_left_short_desc", "Remaining amount of ETH to raise."),
            await setResource(renderer, "en", "cap_left_long_desc", "When the cap is reached, your sale is finished."),
            await setResource(renderer, "en", "update", "Update"),
            await setResource(renderer, "en", "update_confirm", "Do you want to update?"),
            await setResource(renderer, "ko", "cap", "캡"),
            await setResource(renderer, "ko", "cap_short_desc", "모금할 최대 ETH 금액."),
            await setResource(renderer, "ko", "cap_long_desc", "캡이 달성되면 세일은 종료됩니다."),
            await setResource(renderer, "ko", "cap_left", "남은 캡"),
            await setResource(renderer, "ko", "cap_left_short_desc", "모금할 남은 ETH 금액."),
            await setResource(renderer, "ko", "cap_left_long_desc", "캡이 달성되면 세일은 종료됩니다."),
            await setResource(renderer, "ko", "update", "업데이트"),
            await setResource(renderer, "ko", "update_confirm", "업데이트하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
