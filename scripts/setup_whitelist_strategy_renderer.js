const setResource = require('./setResource');
const WhitelistStrategyRenderer = artifacts.require("WhitelistStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + WhitelistStrategyRenderer.contractName);
    try {
        let renderer = await WhitelistStrategyRenderer.deployed();
        await Promise.all([
            await setResource(renderer, "en", "whitelist", "Whitelist"),
            await setResource(renderer, "en", "whitelist_short_desc", "Only whitelisted addresses can participate in the sale."),
            await setResource(renderer, "en", "whitelist_long_desc", "Only whitelisted addresses can participate in the sale."),
            await setResource(renderer, "en", "address", "Address"),
            await setResource(renderer, "en", "remove", "Remove"),
            await setResource(renderer, "en", "remove_confirm", "Do you want to remove?"),
            await setResource(renderer, "en", "add_to_whitelist", "Add To Whitelist"),
            await setResource(renderer, "en", "add_to_whitelist_short_desc", "You can add an address to the whitelist."),
            await setResource(renderer, "en", "add_to_whitelist_long_desc", "You can add an address to the whitelist."),
            await setResource(renderer, "en", "add", "Add"),
            await setResource(renderer, "en", "add_confirm", "Do you want to add?"),
            await setResource(renderer, "en", "whitelist_status", "Whitelist Status"),
            await setResource(renderer, "en", "whitelist_status_short_desc", "You need to be on the whitelist to participate in the sale."),
            await setResource(renderer, "en", "whitelist_status_long_desc", "You need to be on the whitelist to participate in the sale."),
            await setResource(renderer, "en", "whitelisted", "Whitelisted"),
            await setResource(renderer, "en", "not_whitelisted", "Not Whitelisted"),
            await setResource(renderer, "ko", "whitelist", "화이트리스트"),
            await setResource(renderer, "ko", "whitelist_short_desc", "화이트리스트에 등록된 주소만 세일에 참여할 수 있습니다."),
            await setResource(renderer, "ko", "whitelist_long_desc", "화이트리스트에 등록된 주소만 세일에 참여할 수 있습니다."),
            await setResource(renderer, "ko", "address", "주소"),
            await setResource(renderer, "ko", "remove", "제거"),
            await setResource(renderer, "ko", "remove_confirm", "제거하시겠습니까?"),
            await setResource(renderer, "ko", "add_to_whitelist", "화이트리스트에 추가하기"),
            await setResource(renderer, "ko", "add_to_whitelist_short_desc", "화이트리스트에 주소를 추가할 수 있습니다."),
            await setResource(renderer, "ko", "add_to_whitelist_long_desc", "화이트리스트에 주소를 추가할 수 있습니다."),
            await setResource(renderer, "ko", "add", "추가하기"),
            await setResource(renderer, "ko", "add_confirm", "추가하시겠습니까?"),
            await setResource(renderer, "ko", "whitelist_status", "화이트리스트 상태"),
            await setResource(renderer, "ko", "whitelist_status_short_desc", "화이트리스트에 등록되어 있어야 세일에 참여할 수 있습니다."),
            await setResource(renderer, "ko", "whitelist_status_long_desc", "화이트리스트에 등록되어 있어야 세일에 참여할 수 있습니다."),
            await setResource(renderer, "ko", "whitelisted", "화이트리스트에 등록됨"),
            await setResource(renderer, "ko", "not_whitelisted", "화이트리스트에 등록되지 않음"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
