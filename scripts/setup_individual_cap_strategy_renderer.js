const IndividualCapStrategyRenderer = artifacts.require("IndividualCapStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + IndividualCapStrategyRenderer.contractName);
    try {
        let renderer = await IndividualCapStrategyRenderer.deployed();
        await Promise.all([
            await renderer.setResource("en", "individual_cap", "Individual Cap"),
            await renderer.setResource("en", "individual_cap_short_desc", "The maximum amount of ETH to raise from one address."),
            await renderer.setResource("en", "individual_cap_long_desc", "The maximum amount of ETH to raise from one address."),
            await renderer.setResource("en", "my_cap", "My Cap"),
            await renderer.setResource("en", "my_cap_short_desc", "The remaining amount of ETH you can pay to purchase tokens."),
            await renderer.setResource("en", "my_cap_long_desc", "The remaining amount of ETH you can pay to purchase tokens."),
            await renderer.setResource("en", "update", "Update"),
            await renderer.setResource("en", "update_confirm", "Do you want to update?"),
            await renderer.setResource("ko", "individual_cap", "개인 캡"),
            await renderer.setResource("ko", "individual_cap_short_desc", "하나의 주소에서 참여할 수 있는 최대 ETH 금액."),
            await renderer.setResource("ko", "individual_cap_long_desc", "하나의 주소에서 참여할 수 있는 최대 ETH 금액."),
            await renderer.setResource("ko", "my_cap", "나의 캡"),
            await renderer.setResource("ko", "my_cap_short_desc", "토큰 구입을 위해서 최대로 지불할 수 있는 남아있는 ETH 금액."),
            await renderer.setResource("ko", "my_cap_long_desc", "토큰 구입을 위해서 최대로 지불할 수 있는 남아있는 ETH 금액."),
            await renderer.setResource("ko", "update", "업데이트"),
            await renderer.setResource("ko", "update_confirm", "업데이트하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
