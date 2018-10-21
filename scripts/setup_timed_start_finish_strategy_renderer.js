const setResource = require('./setResource');
const TimedStartFinishStrategyRenderer = artifacts.require("TimedStartFinishStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + TimedStartFinishStrategyRenderer.contractName);
    try {
        let renderer = await TimedStartFinishStrategyRenderer.deployed();
        await Promise.all([
            await setResource(renderer, "en", "started_at", "Started At"),
            await setResource(renderer, "en", "started_at_short_desc", "The time the sale started."),
            await setResource(renderer, "en", "started_at_long_desc", "The time the sale started."),
            await setResource(renderer, "en", "finished_at", "Finished At"),
            await setResource(renderer, "en", "finished_at_short_desc", "The time the sale finished."),
            await setResource(renderer, "en", "finished_at_long_desc", "The time the sale finished."),
            await setResource(renderer, "en", "update", "Update"),
            await setResource(renderer, "en", "update_confirm", "Do you want to update?"),
            await setResource(renderer, "ko", "started_at", "시작 시간"),
            await setResource(renderer, "ko", "started_at_short_desc", "세일이 시작된 시간."),
            await setResource(renderer, "ko", "started_at_long_desc", "세일이 시작된 시간."),
            await setResource(renderer, "ko", "finished_at", "종료 시간"),
            await setResource(renderer, "ko", "finished_at_short_desc", "세일이 종료된 시간."),
            await setResource(renderer, "ko", "finished_at_long_desc", "세일이 종료된 시간."),
            await setResource(renderer, "ko", "update", "업데이트"),
            await setResource(renderer, "ko", "update_confirm", "업데이트 하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};

