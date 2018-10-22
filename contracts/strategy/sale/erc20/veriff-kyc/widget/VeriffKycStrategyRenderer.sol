pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/widget/Localizable.sol";
import "tokenboost-solidity/contracts/widget/Widgets.sol";
import "../VeriffKycStrategy.sol";
import "./VeriffKycStrategyAdminWidgetRenderer.sol";
import "tokenboost-solidity/contracts/utils/StringUtils.sol";

contract VeriffKycStrategyRenderer is Localizable {
    using Widgets for Widgets.Widget;
    using Elements for Elements.Element;
    using StringUtils for string;
    using strings for *;

    string public constant START_KYC = "start_kyc";
    string public constant START_KYC_SHORT_DESC = "start_kyc_short_desc";
    string public constant START_KYC_LONG_DESC = "start_kyc_long_desc";
    string public constant BLACKLISTED = "blacklisted";
    string public constant BLACKLISTED_DESC = "blacklisted_desc";
    string public constant UPDATE = "update";
    string public constant UPDATE_CONFIRM = "update_desc";

    VeriffKycStrategyAdminWidgetRenderer adminWidgetRenderer;

    constructor(VeriffKycStrategyAdminWidgetRenderer _adminWidgetRenderer) public {
        adminWidgetRenderer = _adminWidgetRenderer;
    }

    function adminWidgets(string _locale, VeriffKycStrategy _strategy) public view returns (string) {
        return adminWidgetRenderer.render(_locale, _strategy);
    }

    function userWidgets(string _locale, VeriffKycStrategy _strategy) public view returns (string) {
        return string(abi.encodePacked("[", _processKycWidget(_locale, _strategy), "]"));
    }

    function _processKycWidget(string _locale, VeriffKycStrategy _strategy) private view returns (string json) {
        Elements.Element[] memory elements = new Elements.Element[](1);
        elements[0] = Elements.Element(
            true,
            START_KYC,
            "veriff-kyc-button",
            resources[_locale][START_KYC],
            "null",
            Actions.empty(),
            Tables.empty()
        );
        Widgets.Widget memory widget = Widgets.Widget(
            resources[_locale][START_KYC],
            resources[_locale][START_KYC_SHORT_DESC],
            resources[_locale][START_KYC_LONG_DESC],
            4,
            elements
        );
        return widget.toJson();
    }

    function inputs(string _locale, VeriffKycStrategy _strategy) public view returns (string) {
        Elements.Element[] memory elements = new Elements.Element[](3);
        elements[0] = Elements.Element(
            true,
            BLACKLISTED_DESC,
            "text",
            "",
            resources[_locale][BLACKLISTED_DESC].quoted(),
            Actions.empty(),
            Tables.empty()
        );
        elements[1] = Elements.Element(
            true,
            BLACKLISTED,
            "switch",
            resources[_locale][BLACKLISTED],
            _strategy.blacklisted() ? "true" : "false",
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
                "update(bool)",
                '["blacklisted"]',
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
