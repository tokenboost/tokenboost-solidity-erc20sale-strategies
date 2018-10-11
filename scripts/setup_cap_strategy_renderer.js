const CapStrategyRenderer = artifacts.require("CapStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + CapStrategyRenderer.contractName);
    try {
        let renderer = await CapStrategyRenderer.deployed();
        await Promise.all([
            await renderer.setResource("en", "cap", "Cap"),
            await renderer.setResource("en", "cap_short_desc", "Maximum amount of ETH to raise."),
            await renderer.setResource("en", "cap_long_desc", "When the cap is reached, your sale is finished."),
            await renderer.setResource("en", "cap_left", "Cap Left"),
            await renderer.setResource("en", "cap_left_short_desc", "Remaining amount of ETH to raise."),
            await renderer.setResource("en", "cap_left_long_desc", "When the cap is reached, your sale is finished."),
            await renderer.setResource("en", "update", "Update"),
            await renderer.setResource("en", "update_confirm", "Do you want to update?"),
            await renderer.setResource("ko", "cap", "캡"),
            await renderer.setResource("ko", "cap_short_desc", "모금할 최대 ETH 금액."),
            await renderer.setResource("ko", "cap_long_desc", "캡이 달성되면 세일은 종료됩니다."),
            await renderer.setResource("ko", "cap_left", "남은 캡"),
            await renderer.setResource("ko", "cap_left_short_desc", "모금할 남은 ETH 금액."),
            await renderer.setResource("ko", "cap_left_long_desc", "캡이 달성되면 세일은 종료됩니다."),
            await renderer.setResource("ko", "update", "업데이트"),
            await renderer.setResource("ko", "update_confirm", "업데이트하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
