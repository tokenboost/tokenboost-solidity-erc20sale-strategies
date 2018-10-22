pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/widget/Localizable.sol";
import "tokenboost-solidity/contracts/widget/Widgets.sol";
import "../VeriffKycStrategy.sol";

contract VeriffKycStrategyAdminWidgetRenderer is Localizable {
    using Widgets for Widgets.Widget;
    using Elements for Elements.Element;
    using strings for *;

    string public constant BLACKLISTED_COUNTRIES = "blacklisted_countries";
    string public constant BLACKLISTED_COUNTRIES_SHORT_DESC = "blacklisted_countries_short_desc";
    string public constant BLACKLISTED_COUNTRIES_LONG_DESC = "blacklisted_countries_long_desc";
    string public constant WHITELISTED_COUNTRIES = "whitelisted_countries";
    string public constant WHITELISTED_COUNTRIES_SHORT_DESC = "whitelisted_countries_short_desc";
    string public constant WHITELISTED_COUNTRIES_LONG_DESC = "whitelisted_countries_long_desc";
    string public constant COUNTRY_NAME = "country_name";
    string public constant COUNTRY_CODE = "country_code";
    string public constant ADD = "add";
    string public constant ADD_CONFIRM = "add_confirm";
    string public constant REMOVE = "remove";
    string public constant REMOVE_CONFIRM = "remove_confirm";

    function render(string _locale, VeriffKycStrategy _strategy) public view returns (string) {
        bool blacklisted = _strategy.blacklisted();
        return string(abi.encodePacked("[", _tableWidget(_locale, _strategy, blacklisted, true),
            ",", _tableWidget(_locale, _strategy, blacklisted, false), "]"));
    }

    function _tableWidget(string _locale, VeriffKycStrategy _strategy, bool _blacklist, bool _added) private view returns (string json) {
        Elements.Element[] memory elements = new Elements.Element[](1);
        elements[0] = Elements.Element(
            true,
            _blacklist ? BLACKLISTED_COUNTRIES : WHITELISTED_COUNTRIES,
            "table",
            "",
            "null",
            Actions.empty(),
            Tables.Table(
                true,
                _columns(_locale, _strategy, _blacklist, _added),
                _rows(_locale, _strategy, _blacklist, _added)
            )
        );
        Widgets.Widget memory widget = Widgets.Widget(
            resources[_locale][_blacklist ? BLACKLISTED_COUNTRIES : WHITELISTED_COUNTRIES],
            resources[_locale][_blacklist ? BLACKLISTED_COUNTRIES_SHORT_DESC : WHITELISTED_COUNTRIES_SHORT_DESC],
            resources[_locale][_blacklist ? BLACKLISTED_COUNTRIES_LONG_DESC : WHITELISTED_COUNTRIES_LONG_DESC],
            6,
            elements
        );
        return widget.toJson();
    }

    function _columns(string _locale, VeriffKycStrategy _strategy, bool _blacklist, bool _added) private view returns (Tables.Column[]) {
        Tables.Column[] memory columns = new Tables.Column[](3);
        columns[0] = Tables.Column(
            true,
            COUNTRY_NAME,
            "text",
            resources[_locale][COUNTRY_NAME],
            Actions.empty()
        );
        columns[1] = Tables.Column(
            true,
            COUNTRY_CODE,
            "text",
            resources[_locale][COUNTRY_CODE],
            Actions.empty()
        );
        columns[2] = Tables.Column(
            true,
            _added ? REMOVE : ADD,
            "button",
            resources[_locale][_added ? REMOVE : ADD],
            Actions.Action(
                true,
                address(_strategy),
                string(abi.encodePacked((_added ? "remove" : "add"), (_blacklist ? "Reject" : "Allow"), "edCountryCode(string)")),
                '["country_code"]',
                resources[_locale][_added ? REMOVE_CONFIRM : ADD_CONFIRM]
            )
        );
        return columns;
    }

    function _rows(string _locale, VeriffKycStrategy _strategy, bool _blacklisted, bool _added) private view returns (string[]) {
        uint i;
        string memory code;
        uint number = 0;
        for (i = 0; i < _strategy.numberOfCountryCodes(); i++) {
            code = _strategy.countryCodeAt(i);
            if (_codeIncluded(_strategy, _blacklisted, _added, code)) {
                number++;
            }
        }
        string[] memory rows = new string[](number);
        uint count = 0;
        for (i = 0; i < _strategy.numberOfCountryCodes(); i++) {
            code = _strategy.countryCodeAt(i);
            if (_codeIncluded(_strategy, _blacklisted, _added, code)) {
                string memory row = '{"country_code":"';
                row = row.toSlice().concat(code.toSlice());
                row = row.toSlice().concat('","country_name":"'.toSlice());
                row = row.toSlice().concat(resources[_locale][code].toSlice());
                row = row.toSlice().concat('"}'.toSlice());
                rows[count++] = row;
            }
        }
        return rows;
    }

    function _codeIncluded(VeriffKycStrategy _strategy, bool _blacklisted, bool _added, string _code) private view returns (bool) {
        bool included;
        if (_blacklisted) {
            included = _strategy.countryCodeRejected(_code);
        } else {
            included = _strategy.countryCodeAllowed(_code);
        }
        if (!_added) {
            included = !included;
        }
        return included;
    }
}
