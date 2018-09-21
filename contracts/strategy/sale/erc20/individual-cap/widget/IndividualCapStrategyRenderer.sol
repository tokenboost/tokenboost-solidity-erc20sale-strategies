pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/widget/Localizable.sol";
import "tokenboost-solidity/contracts/widget/Widgets.sol";
import "../IndividualCapStrategy.sol";

contract IndividualCapStrategyRenderer is Localizable {
    using Widgets for Widgets.Widget;
    using Elements for Elements.Element;
    using strings for *;
    using UintUtils for uint;
    using AddressUtils for address;

    string public constant INDIVIDUAL_CAP = "individual_cap";
    string public constant INDIVIDUAL_CAP_SHORT_DESC = "individual_cap_short_desc";
    string public constant INDIVIDUAL_CAP_LONG_DESC = "individual_cap_long_desc";
    string public constant MY_CAP = "my_cap";
    string public constant MY_CAP_SHORT_DESC = "my_cap_short_desc";
    string public constant MY_CAP_LONG_DESC = "my_cap_long_desc";
    string public constant UPDATE = "update";
    string public constant UPDATE_CONFIRM = "update_confirm";

    function adminWidgets(string _locale, IndividualCapStrategy _strategy) public view returns (string) {
        string memory json = "[";
        json = json.toSlice().concat(_capWidget(_locale, _strategy).toSlice());
        return json.toSlice().concat("]".toSlice());
    }

    function _capWidget(string _locale, IndividualCapStrategy _strategy) private view returns (string json) {
        Elements.Element[] memory elements = new Elements.Element[](1);
        elements[0] = Elements.Element(
            true,
            INDIVIDUAL_CAP,
            "eth",
            resources[_locale][INDIVIDUAL_CAP],
            _strategy.individualCap().toString(),
            Actions.empty(),
            Tables.empty()
        );
        Widgets.Widget memory widget = Widgets.Widget(
            resources[_locale][INDIVIDUAL_CAP],
            resources[_locale][INDIVIDUAL_CAP_SHORT_DESC],
            resources[_locale][INDIVIDUAL_CAP_LONG_DESC],
            4,
            elements
        );
        return widget.toJson();
    }

    function userWidgets(string _locale, IndividualCapStrategy _strategy) public view returns (string) {
        string memory json = "[";
        json = json.toSlice().concat(_myCapWidget(_locale, _strategy).toSlice());
        return json.toSlice().concat("]".toSlice());
    }

    function _myCapWidget(string _locale, IndividualCapStrategy _strategy) private view returns (string json) {
        Elements.Element[] memory elements = new Elements.Element[](1);
        uint256 myCap = _strategy.individualCap() - _strategy.sale().paymentOf(tx.origin);
        elements[0] = Elements.Element(
            true,
            MY_CAP,
            "eth",
            resources[_locale][MY_CAP],
            myCap.toString(),
            Actions.empty(),
            Tables.empty()
        );
        Widgets.Widget memory widget = Widgets.Widget(
            resources[_locale][MY_CAP],
            resources[_locale][MY_CAP_SHORT_DESC],
            resources[_locale][MY_CAP_LONG_DESC],
            4,
            elements
        );
        return widget.toJson();
    }

    function inputs(string _locale, IndividualCapStrategy _strategy) public view returns (string) {
        Elements.Element[] memory elements = new Elements.Element[](2);
        elements[0] = Elements.Element(
            true,
            INDIVIDUAL_CAP,
            "ethEdit",
            resources[_locale][INDIVIDUAL_CAP],
            _strategy.individualCap().toString(),
            Actions.empty(),
            Tables.empty()
        );
        elements[1] = Elements.Element(
            true,
            UPDATE,
            "button",
            resources[_locale][UPDATE],
            "null",
            Actions.Action(
                true,
                address(_strategy),
                "update(uint256)",
                '["individual_cap"]',
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
