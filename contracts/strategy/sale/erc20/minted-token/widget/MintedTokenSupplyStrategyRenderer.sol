pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/widget/Localizable.sol";
import "tokenboost-solidity/contracts/widget/Widgets.sol";
import "tokenboost-solidity/contracts/utils/StringUtils.sol";
import "tokenboost-solidity-erc20token/contracts/token/erc20/ERC20Token.sol";
import "../MintedTokenSupplyStrategy.sol";

contract MintedTokenSupplyStrategyRenderer is Localizable {
    using Widgets for Widgets.Widget;
    using Elements for Elements.Element;
    using strings for *;
    using AddressUtils for address;
    using StringUtils for string;

    string public constant SET_MINTER = "set_minter";
    string public constant SET_MINTER_SHORT_DESC = "set_minter_short_desc";
    string public constant SET_MINTER_LONG_DESC = "set_minter_long_desc";
    string public constant SET_MINTER_CONFIRM = "set_minter_confirm";

    function adminWidgets(string _locale, MintedTokenSupplyStrategy _strategy) public view returns (string) {
        string memory json = "[";
        uint length = 0;
        string[1] memory widgets = [
        _setMinterWidget(_locale, _strategy)
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

    function _setMinterWidget(string _locale, MintedTokenSupplyStrategy _strategy) private view returns (string json) {
        ERC20Token token = ERC20Token(_strategy.sale().token());
        if (token.hasRole(_strategy, token.ROLE_MINTER())) {
            return "";
        } else {
            Elements.Element[] memory elements = new Elements.Element[](1);
            elements[0] = Elements.Element(
                true,
                SET_MINTER,
                "button",
                resources[_locale][SET_MINTER],
                "null",
                Actions.Action(
                    true,
                    token,
                    "addMinter(address)",
                    address(_strategy).toString().quoted(),
                    resources[_locale][SET_MINTER_CONFIRM]
                ),
                Tables.empty()
            );
            Widgets.Widget memory widget = Widgets.Widget(
                resources[_locale][SET_MINTER],
                resources[_locale][SET_MINTER_SHORT_DESC],
                resources[_locale][SET_MINTER_LONG_DESC],
                4,
                elements
            );
            return widget.toJson();
        }
    }

    function userWidgets(string _locale, MintedTokenSupplyStrategy _strategy) public view returns (string json) {
        return "[]";
    }

    function inputs(string _locale, MintedTokenSupplyStrategy _strategy) public view returns (string) {
        return "[]";
    }
}
