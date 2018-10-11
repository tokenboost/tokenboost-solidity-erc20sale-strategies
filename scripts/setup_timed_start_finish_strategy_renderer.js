const TimedStartFinishStrategyRenderer = artifacts.require("TimedStartFinishStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + TimedStartFinishStrategyRenderer.contractName);
    try {
        let renderer = await TimedStartFinishStrategyRenderer.deployed();
        await Promise.all([
            await renderer.setResource("en", "started_at", "Started At"),
            await renderer.setResource("en", "started_at_short_desc", "The time the sale started."),
            await renderer.setResource("en", "started_at_long_desc", "The time the sale started."),
            await renderer.setResource("en", "finished_at", "Finished At"),
            await renderer.setResource("en", "finished_at_short_desc", "The time the sale finished."),
            await renderer.setResource("en", "finished_at_long_desc", "The time the sale finished."),
            await renderer.setResource("en", "update", "Update"),
            await renderer.setResource("en", "update_confirm", "Do you want to update?"),
            await renderer.setResource("ko", "started_at", "시작 시간"),
            await renderer.setResource("ko", "started_at_short_desc", "세일이 시작된 시간."),
            await renderer.setResource("ko", "started_at_long_desc", "세일이 시작된 시간."),
            await renderer.setResource("ko", "finished_at", "종료 시간"),
            await renderer.setResource("ko", "finished_at_short_desc", "세일이 종료된 시간."),
            await renderer.setResource("ko", "finished_at_long_desc", "세일이 종료된 시간."),
            await renderer.setResource("ko", "update", "업데이트"),
            await renderer.setResource("ko", "update_confirm", "업데이트 하시겠습니까?"),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};

