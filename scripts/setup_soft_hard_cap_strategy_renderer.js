const setResource = require('./setResource');
const SoftHardCapStrategyRenderer = artifacts.require("SoftHardCapStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + SoftHardCapStrategyRenderer.contractName);
    try {
        let renderer = await SoftHardCapStrategyRenderer.deployed();
        await Promise.all([
            await setResource(renderer, "en", "soft_cap", "Soft Cap"),
            await setResource(renderer, "en", "soft_cap_short_desc", "Minimum amount of ETH to raise."),
            await setResource(renderer, "en", "soft_cap_long_desc", "If the soft cap is reached, your sale is successful."),
            await setResource(renderer, "en", "hard_cap", "Hard Cap"),
            await setResource(renderer, "en", "hard_cap_short_desc", "Maximum amount of ETH to raise."),
            await setResource(renderer, "en", "hard_cap_long_desc", "If the hard cap is reached, your sale finishes."),
            await setResource(renderer, "en", "soft_cap_left", "Soft Cap Left"),
            await setResource(renderer, "en", "soft_cap_left_short_desc", "Remaining minimum amount of ETH to raise."),
            await setResource(renderer, "en", "soft_cap_left_long_desc", "If the soft cap is reached, your sale is successful."),
            await setResource(renderer, "en", "hard_cap_left", "Hard Cap Left"),
            await setResource(renderer, "en", "hard_cap_left_short_desc", "Remaining maximum amount of ETH to raise."),
            await setResource(renderer, "en", "hard_cap_left_long_desc", "If the hard cap is reached, your sale finishes."),
            await setResource(renderer, "en", "update", "Update"),
            await setResource(renderer, "en", "update_confirm", "Do you want to update?"),
            await setResource(renderer, "ko", "soft_cap", "소프트 캡"),
            await setResource(renderer, "ko", "soft_cap_short_desc", "모금할 최소 ETH."),
            await setResource(renderer, "ko", "soft_cap_long_desc", "소프트 캡이 달성되면 세일은 성공합니다."),
            await setResource(renderer, "ko", "hard_cap", "하드 캡"),
            await setResource(renderer, "ko", "hard_cap_short_desc", "모금할 최대 ETH."),
            await setResource(renderer, "ko", "hard_cap_long_desc", "하드 캡이 달성되면 세일은 종료되고 더이상 토큰이 판매되지 않습니다."),
            await setResource(renderer, "ko", "soft_cap_left", "남은 소프트캡"),
            await setResource(renderer, "ko", "soft_cap_left_short_desc", "남은 최소 ETH."),
            await setResource(renderer, "ko", "soft_cap_left_long_desc", "소프트 캡이 달성되면 세일은 성공합니다."),
            await setResource(renderer, "ko", "hard_cap_left", "남은 하드캡"),
            await setResource(renderer, "ko", "hard_cap_left_short_desc", "남은 최대 ETH."),
            await setResource(renderer, "ko", "hard_cap_left_long_desc", "하드 캡이 달성되면 세일은 종료되고 더이상 토큰이 판매되지 않습니다."),
            await setResource(renderer, "ko", "update", "업데이트"),
            await setResource(renderer, "ko", "update_confirm", "업데이트 하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
