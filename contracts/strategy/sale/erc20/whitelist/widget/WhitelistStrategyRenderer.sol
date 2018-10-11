pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/widget/Localizable.sol";
import "tokenboost-solidity/contracts/widget/Widgets.sol";
import "../WhitelistStrategy.sol";

contract WhitelistStrategyRenderer is Localizable {
    using Widgets for Widgets.Widget;
    using Elements for Elements.Element;
    using strings for *;
    using UintUtils for uint;
    using AddressUtils for address;

    string public constant WHITELIST = "whitelist";
    string public constant WHITELIST_SHORT_DESC = "whitelist_short_desc";
    string public constant WHITELIST_LONG_DESC = "whitelist_long_desc";
    string public constant ADDRESS = "address";
    string public constant REMOVE = "remove";
    string public constant REMOVE_CONFIRM = "remove_confirm";
    string public constant ADD_TO_WHITELIST = "add_to_whitelist";
    string public constant ADD_TO_WHITELIST_SHORT_DESC = "add_to_whitelist_short_desc";
    string public constant ADD_TO_WHITELIST_LONG_DESC = "add_to_whitelist_long_desc";
    string public constant ADD = "add";
    string public constant ADD_CONFIRM = "add_confirm";

    function adminWidgets(string _locale, WhitelistStrategy _strategy) public view returns (string) {
        string memory json = "[";
        uint length = 0;
        string[2] memory widgets = [
        _whitelistWidget(_locale, _strategy),
        _addToWhitelistWidget(_locale, _strategy)
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

    function _whitelistWidget(string _locale, WhitelistStrategy _strategy) private view returns (string json) {
        Elements.Element[] memory elements = new Elements.Element[](1);
        elements[0] = Elements.Element(
            true,
            WHITELIST,
            "table",
            resources[_locale][WHITELIST],
            "null",
            Actions.empty(),
            Tables.Table(true, _columns(_locale, _strategy), _rows(_locale, _strategy))
        );
        Widgets.Widget memory widget = Widgets.Widget(
            resources[_locale][WHITELIST],
            resources[_locale][WHITELIST_SHORT_DESC],
            resources[_locale][WHITELIST_LONG_DESC],
            8,
            elements
        );
        return widget.toJson();
    }

    function _columns(string _locale, WhitelistStrategy _strategy) private view returns (Tables.Column[]) {
        Tables.Column[] memory columns = new Tables.Column[](2);
        columns[0] = Tables.Column(
            true,
            ADDRESS,
            "address",
            resources[_locale][ADDRESS],
            Actions.empty()
        );
        columns[1] = Tables.Column(
            true,
            REMOVE,
            "button",
            resources[_locale][REMOVE],
            Actions.Action(
                true,
                address(_strategy),
                "remove(address)",
                '["address"]',
                resources[_locale][REMOVE_CONFIRM]
            )
        );
        return columns;
    }

    function _rows(string _locale, WhitelistStrategy _strategy) private view returns (string[]) {
        string[] memory rows = new string[](_strategy.numberOfAddresses());
        for (uint i = 0; i < rows.length; i++) {
            address addr = _strategy.addresses(i);
            string memory row = '{"address":"';
            row = row.toSlice().concat(addr.toString().toSlice());
            row = row.toSlice().concat('"}'.toSlice());
            rows[i] = row;
        }
        return rows;
    }

    function _addToWhitelistWidget(string _locale, WhitelistStrategy _strategy) private view returns (string json) {
        Elements.Element[] memory elements = new Elements.Element[](2);
        elements[0] = Elements.Element(
            true,
            ADDRESS,
            "addressEdit",
            resources[_locale][ADDRESS],
            "null",
            Actions.empty(),
            Tables.empty()
        );
        elements[1] = Elements.Element(
            true,
            ADD,
            "button",
            resources[_locale][ADD],
            "null",
            Actions.Action(
                true,
                address(_strategy),
                "add(address)",
                '["address"]',
                resources[_locale][ADD_CONFIRM]
            ),
            Tables.empty()
        );
        Widgets.Widget memory widget = Widgets.Widget(
            resources[_locale][ADD_TO_WHITELIST],
            resources[_locale][ADD_TO_WHITELIST_SHORT_DESC],
            resources[_locale][ADD_TO_WHITELIST_LONG_DESC],
            4,
            elements
        );
        return widget.toJson();
    }

    function userWidgets(string _locale, WhitelistStrategy _strategy) public view returns (string json) {
        return "[]";
    }

    function inputs(string _locale, WhitelistStrategy _strategy) public view returns (string) {
        return "[]";
    }
}
