pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/widget/Localizable.sol";
import "tokenboost-solidity/contracts/widget/Widgets.sol";
import "../ManualStartFinishStrategy.sol";

contract ManualStartFinishStrategyRenderer is Localizable {
    using Widgets for Widgets.Widget;
    using strings for *;
    using UintUtils for uint;

    string public constant START = "start";
    string public constant START_SHORT_DESC = "start_short_desc";
    string public constant START_LONG_DESC = "start_long_desc";
    string public constant START_CONFIRM = "start_confirm";
    string public constant STARTED_AT = "started_at";
    string public constant STARTED_AT_SHORT_DESC = "started_at_short_desc";
    string public constant STARTED_AT_LONG_DESC = "started_at_long_desc";
    string public constant FINISH = "finish";
    string public constant FINISH_SHORT_DESC = "finish_short_desc";
    string public constant FINISH_LONG_DESC = "finish_long_desc";
    string public constant FINISH_CONFIRM = "finish_confirm";
    string public constant FINISHED_AT = "finished_at";
    string public constant FINISHED_AT_SHORT_DESC = "finished_at_short_desc";
    string public constant FINISHED_AT_LONG_DESC = "finished_at_long_desc";

    function adminWidgets(string _locale, ManualStartFinishStrategy _strategy) public view returns (string) {
        string memory json = "[";
        uint length = 0;
        string[4] memory widgets = [
        _startButtonWidget(_locale, _strategy),
        _startedAtWidget(_locale, _strategy),
        _finishButtonWidget(_locale, _strategy),
        _finishedAtWidget(_locale, _strategy)
        ];
        for (uint i = 0; i < widgets.length; i++) {
            string memory widget = widgets[i];
            if (bytes(widget).length > 0) {
                if (length > 0) {
                    json = json.toSlice().concat(",".toSlice());
                }
                json = json.toSlice().concat(widget.toSlice());
                length++;
            }
        }
        return json.toSlice().concat("]".toSlice());
    }

    function _startButtonWidget(string _locale, ManualStartFinishStrategy _strategy) private view returns (string json) {
        if (_strategy.sale().activated() && !_strategy.sale().started()) {
            Elements.Element[] memory elements = new Elements.Element[](1);
            elements[0] = Elements.Element(
                true,
                START,
                "button",
                resources[_locale][START],
                "null",
                Actions.Action(
                    true,
                    address(_strategy),
                    "start()",
                    "[]",
                    resources[_locale][START_CONFIRM]
                ),
                Tables.empty()
            );
            Widgets.Widget memory widget = Widgets.Widget(
                resources[_locale][START],
                resources[_locale][START_SHORT_DESC],
                resources[_locale][START_LONG_DESC],
                4,
                elements
            );
            return widget.toJson();
        } else {
            return "";
        }
    }

    function _startedAtWidget(string _locale, ManualStartFinishStrategy _strategy) private view returns (string json) {
        if (_strategy.sale().activated() && _strategy.sale().started()) {
            Elements.Element[] memory elements = new Elements.Element[](1);
            elements[0] = Elements.Element(
                true,
                STARTED_AT,
                "timestamp",
                "null",
                _strategy.startedAt().toString(),
                Actions.empty(),
                Tables.empty()
            );
            Widgets.Widget memory widget = Widgets.Widget(
                resources[_locale][STARTED_AT],
                resources[_locale][STARTED_AT_SHORT_DESC],
                resources[_locale][STARTED_AT_LONG_DESC],
                4,
                elements
            );
            return widget.toJson();
        } else {
            return "";
        }
    }

    function _finishButtonWidget(string _locale, ManualStartFinishStrategy _strategy) private view returns (string json) {
        if (_strategy.sale().activated() && _strategy.sale().started() && !_strategy.sale().finished()) {
            Elements.Element[] memory elements = new Elements.Element[](1);
            elements[0] = Elements.Element(
                true,
                FINISH,
                "button",
                resources[_locale][FINISH],
                "null",
                Actions.Action(
                    true,
                    address(_strategy),
                    "finish()",
                    "[]",
                    resources[_locale][FINISH_CONFIRM]
                ),
                Tables.empty()
            );
            Widgets.Widget memory widget = Widgets.Widget(
                resources[_locale][FINISH],
                resources[_locale][FINISH_SHORT_DESC],
                resources[_locale][FINISH_LONG_DESC],
                4,
                elements
            );
            return widget.toJson();
        } else {
            return "";
        }
    }

    function _finishedAtWidget(string _locale, ManualStartFinishStrategy _strategy) private view returns (string json) {
        if (_strategy.sale().activated() && _strategy.sale().finished()) {
            Elements.Element[] memory elements = new Elements.Element[](1);
            elements[0] = Elements.Element(
                true,
                FINISHED_AT,
                "timestamp",
                "null",
                _strategy.finishedAt().toString(),
                Actions.empty(),
                Tables.empty()
            );
            Widgets.Widget memory widget = Widgets.Widget(
                resources[_locale][FINISHED_AT],
                resources[_locale][FINISHED_AT_SHORT_DESC],
                resources[_locale][FINISHED_AT_LONG_DESC],
                4,
                elements
            );
            return widget.toJson();
        } else {
            return "";
        }
    }

    function userWidgets(string _locale, ManualStartFinishStrategy _strategy) public view returns (string json) {
        return "[]";
    }

    function inputs(string _locale, ManualStartFinishStrategy _strategy) public view returns (string json) {
        return "[]";
    }
}
