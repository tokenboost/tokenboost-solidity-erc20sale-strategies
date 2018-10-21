pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/widget/Localizable.sol";
import "tokenboost-solidity/contracts/widget/Widgets.sol";
import "../TimedStartFinishStrategy.sol";

contract TimedStartFinishStrategyRenderer is Localizable {
    using Widgets for Widgets.Widget;
    using Elements for Elements.Element;
    using strings for *;
    using UintUtils for uint;

    string public constant STARTED_AT = "started_at";
    string public constant STARTED_AT_SHORT_DESC = "started_at_short_desc";
    string public constant STARTED_AT_LONG_DESC = "started_at_long_desc";
    string public constant FINISHED_AT = "finished_at";
    string public constant FINISHED_AT_SHORT_DESC = "finished_at_short_desc";
    string public constant FINISHED_AT_LONG_DESC = "finished_at_long_desc";
    string public constant UPDATE = "update";
    string public constant UPDATE_CONFIRM = "update_confirm";

    function adminWidgets(string _locale, TimedStartFinishStrategy _strategy) public view returns (string) {
        string memory json = "[";
        uint length = 0;
        string[2] memory widgets = [
        _startedAtWidget(_locale, _strategy),
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

    function _startedAtWidget(string _locale, TimedStartFinishStrategy _strategy) private view returns (string json) {
        if (_strategy.sale().started()) {
            Elements.Element[] memory elements = new Elements.Element[](1);
            elements[0] = Elements.Element(
                true,
                STARTED_AT,
                "timestamp",
                "",
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

    function _finishedAtWidget(string _locale, TimedStartFinishStrategy _strategy) private view returns (string json) {
        if (_strategy.sale().finished()) {
            Elements.Element[] memory elements = new Elements.Element[](1);
            elements[0] = Elements.Element(
                true,
                FINISHED_AT,
                "timestamp",
                "",
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

    function userWidgets(string _locale, TimedStartFinishStrategy _strategy) public view returns (string json) {
        return "[]";
    }

    function inputs(string _locale, TimedStartFinishStrategy _strategy) public view returns (string) {
        Elements.Element[] memory elements = new Elements.Element[](3);
        elements[0] = Elements.Element(
            true,
            STARTED_AT,
            "timestampEdit",
            resources[_locale][STARTED_AT],
            _strategy.startedAt().toString(),
            Actions.empty(),
            Tables.empty()
        );
        elements[1] = Elements.Element(
            true,
            FINISHED_AT,
            "timestampEdit",
            resources[_locale][FINISHED_AT],
            _strategy.finishedAt().toString(),
            Actions.empty(),
            Tables.empty()
        );
        elements[2] = Elements.Element(
            true,
            UPDATE,
            "button",
            resources[_locale][UPDATE],
            "null",
            Actions.Action(
                true,
                address(_strategy),
                "update(uint256,uint256)",
                '["started_at","finished_at"]',
                resources[_locale][UPDATE_CONFIRM]
            ),
            Tables.empty()
        );
        string memory json = "[";
        for (uint i = 0; i < elements.length; i++) {
            if (i > 0) {
                json = json.toSlice().concat(','.toSlice());
            }
            json = json.toSlice().concat(elements[i].toJson().toSlice());
        }
        return json.toSlice().concat(']'.toSlice());
    }
}
