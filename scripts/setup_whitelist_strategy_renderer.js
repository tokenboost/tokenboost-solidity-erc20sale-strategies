const WhitelistStrategyRenderer = artifacts.require("WhitelistStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + WhitelistStrategyRenderer.contractName);
    try {
        let renderer = await WhitelistStrategyRenderer.deployed();
        await Promise.all([
            await renderer.setResource("en", "whitelist", "Whitelist"),
            await renderer.setResource("en", "whitelist_short_desc", "Only whitelisted addresses can participate into the sale."),
            await renderer.setResource("en", "whitelist_long_desc", "Only whitelisted addresses can participate into the sale."),
            await renderer.setResource("en", "address", "Address"),
            await renderer.setResource("en", "remove", "Remove"),
            await renderer.setResource("en", "remove_confirm", "Do you want to remove?"),
            await renderer.setResource("en", "add_to_whitelist", "Add To Whitelist"),
            await renderer.setResource("en", "add_to_whitelist_short_desc", "You can add an address to the whitelist."),
            await renderer.setResource("en", "add_to_whitelist_long_desc", "You can add an address to the whitelist."),
            await renderer.setResource("en", "add", "Add"),
            await renderer.setResource("en", "add_confirm", "Do you want to add?"),
            await renderer.setResource("ko", "whitelist", "화이트리스트"),
            await renderer.setResource("ko", "whitelist_short_desc", "화이트리스트에 등록된 주소만 세일에 참여할 수 있습니다."),
            await renderer.setResource("ko", "whitelist_long_desc", "화이트리스트에 등록된 주소만 세일에 참여할 수 있습니다."),
            await renderer.setResource("ko", "address", "주소"),
            await renderer.setResource("ko", "remove", "제거"),
            await renderer.setResource("ko", "remove_confirm", "제거하시겠습니까?"),
            await renderer.setResource("ko", "add_to_whitelist", "화이트리스트에 추가하기"),
            await renderer.setResource("ko", "add_to_whitelist_short_desc", "화이트리스트에 주소를 추가할 수 있습니다."),
            await renderer.setResource("ko", "add_to_whitelist_long_desc", "화이트리스트에 주소를 추가할 수 있습니다."),
            await renderer.setResource("ko", "add", "추가하기"),
            await renderer.setResource("ko", "add_confirm", "추가하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
