const SoftHardCapStrategyRenderer = artifacts.require("SoftHardCapStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + SoftHardCapStrategyRenderer.contractName);
    try {
        let renderer = await SoftHardCapStrategyRenderer.deployed();
        await Promise.all([
            await renderer.setResource("en", "soft_cap", "Soft Cap"),
            await renderer.setResource("en", "soft_cap_short_desc", "Minimum amount of ETH to raise."),
            await renderer.setResource("en", "soft_cap_long_desc", "If the soft cap is reached, your sale is successful."),
            await renderer.setResource("en", "hard_cap", "Hard Cap"),
            await renderer.setResource("en", "hard_cap_short_desc", "Maximum amount of ETH to raise."),
            await renderer.setResource("en", "hard_cap_long_desc", "If the hard cap is reached, your sale finishes."),
            await renderer.setResource("en", "soft_cap_left", "Soft Cap Left"),
            await renderer.setResource("en", "soft_cap_left_short_desc", "Remaining minimum amount of ETH to raise."),
            await renderer.setResource("en", "soft_cap_left_long_desc", "If the soft cap is reached, your sale is successful."),
            await renderer.setResource("en", "hard_cap_left", "Hard Cap Left"),
            await renderer.setResource("en", "hard_cap_left_short_desc", "Remaining maximum amount of ETH to raise."),
            await renderer.setResource("en", "hard_cap_left_long_desc", "If the hard cap is reached, your sale finishes."),
            await renderer.setResource("en", "update", "Update"),
            await renderer.setResource("en", "update_confirm", "Do you want to update?"),
            await renderer.setResource("ko", "soft_cap", "소프트 캡"),
            await renderer.setResource("ko", "soft_cap_short_desc", "모금할 최소 ETH."),
            await renderer.setResource("ko", "soft_cap_long_desc", "소프트 캡이 달성되면 세일은 성공합니다. "),
            await renderer.setResource("ko", "hard_cap", "하드 캡"),
            await renderer.setResource("ko", "hard_cap_short_desc", "모금할 최대 ETH."),
            await renderer.setResource("ko", "hard_cap_long_desc", "하드 캡이 달성되면 세일은 종료되고 더이상 토큰이 판매되지 않습니다."),
            await renderer.setResource("ko", "update", "업데이트"),
            await renderer.setResource("ko", "update_confirm", "업데이트 하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
