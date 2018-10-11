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

    string public constant STRATEGY_ADDRESS = "strategy_address";
    string public constant SET_MINTER = "set_minter";
    string public constant SET_MINTER_SHORT_DESC = "set_minter_short_desc";
    string public constant SET_MINTER_LONG_DESC = "set_minter_long_desc";
    string public constant SET_MINTER_CONFIRM = "set_minter_confirm";

    function adminWidgets(string _locale, MintedTokenSupplyStrategy _strategy) public view returns (string) {
        return string(abi.encodePacked("[", _setMinterWidget(_locale, _strategy), "]"));
    }

    function _setMinterWidget(string _locale, MintedTokenSupplyStrategy _strategy) private view returns (string json) {
        ERC20Token token = ERC20Token(_strategy.sale().token());
        if (token.hasRole(_strategy, token.ROLE_MINTER())) {
            return "";
        } else {
            Elements.Element[] memory elements = new Elements.Element[](2);
            elements[0] = Elements.Element(
                true,
                STRATEGY_ADDRESS,
                "address",
                resources[_locale][STRATEGY_ADDRESS],
                address(_strategy).toString().quoted(),
                Actions.empty(),
                Tables.empty()
            );
            elements[1] = Elements.Element(
                true,
                SET_MINTER,
                "button",
                resources[_locale][SET_MINTER],
                "null",
                Actions.Action(
                    true,
                    token,
                    "addMinter(address)",
                    '["strategy_address"]',
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
