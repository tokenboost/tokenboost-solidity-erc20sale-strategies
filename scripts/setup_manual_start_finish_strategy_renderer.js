const ManualStartFinishStrategyRenderer = artifacts.require("ManualStartFinishStrategyRenderer");

module.exports = async (callback) => {
    console.log("Setting Up " + ManualStartFinishStrategyRenderer.contractName);
    try {
        let renderer = await ManualStartFinishStrategyRenderer.deployed();
        await Promise.all([
            await renderer.setResource("en", "start", "Start"),
            await renderer.setResource("en", "start_short_desc", "You can start the sale now."),
            await renderer.setResource("en", "start_long_desc", "Your sale starts as soon as you click the 'Start' button."),
            await renderer.setResource("en", "started_at", "Started At"),
            await renderer.setResource("en", "started_at_short_desc", "The time the sale started."),
            await renderer.setResource("en", "started_at_long_desc", "The time the sale started."),
            await renderer.setResource("en", "finish", "Finish"),
            await renderer.setResource("en", "finish_short_desc", "You can finish the sale now."),
            await renderer.setResource("en", "finish_long_desc", "Your sale finishes as soon as you click the 'Finish' button."),
            await renderer.setResource("en", "finished_at", "Finished At"),
            await renderer.setResource("en", "finished_at_short_desc", "The time the sale finished."),
            await renderer.setResource("en", "finished_at_long_desc", "The time the sale finished."),
            await renderer.setResource("ko", "start", "시작하기"),
            await renderer.setResource("ko", "start_short_desc", "세일을 지금 시작할 수 있습니다."),
            await renderer.setResource("ko", "start_long_desc", "'시작하기' 버튼을 누르면 세일이 시작됩니다."),
            await renderer.setResource("ko", "started_at", "시작 시간"),
            await renderer.setResource("ko", "started_at_short_desc", "세일이 시작된 시간."),
            await renderer.setResource("ko", "started_at_long_desc", "세일이 시작된 시간."),
            await renderer.setResource("ko", "finish", "끝내기"),
            await renderer.setResource("ko", "finish_short_desc", "세일을 지금 종료할 수 있습니다."),
            await renderer.setResource("ko", "finish_long_desc", "'종료하기' 버튼을 누르면 세일이 종료됩니다."),
            await renderer.setResource("ko", "finished_at", "종료 시간"),
            await renderer.setResource("ko", "finished_at_short_desc", "세일이 종료된 시간."),
            await renderer.setResource("ko", "finished_at_long_desc", "세일이 종료된 시간."),
        ]);
        callback();
    } catch (e) {
        callback(e);
    }
};
