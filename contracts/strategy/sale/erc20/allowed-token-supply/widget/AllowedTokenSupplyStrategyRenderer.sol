pragma solidity ^0.4.24;

import "zeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import "tokenboost-solidity/contracts/widget/Localizable.sol";
import "tokenboost-solidity/contracts/widget/Widgets.sol";
import "tokenboost-solidity/contracts/utils/StringUtils.sol";
import "../AllowedTokenSupplyStrategy.sol";

contract AllowedTokenSupplyStrategyRenderer is Localizable {
    using Widgets for Widgets.Widget;
    using Elements for Elements.Element;
    using strings for *;
    using UintUtils for uint;
    using AddressUtils for address;
    using StringUtils for string;

    string public constant ALLOWED_TOKENS = "allowed_tokens";
    string public constant ALLOWED_TOKENS_SHORT_DESC = "allowed_tokens_short_desc";
    string public constant ALLOWED_TOKENS_LONG_DESC = "allowed_tokens_long_desc";
    string public constant APPROVE = "approve";
    string public constant APPROVE_SHORT_DESC = "approve_short_desc";
    string public constant APPROVE_LONG_DESC = "approve_long_desc";
    string public constant ADDRESS = "address";
    string public constant AMOUNT = "amount";
    string public constant APPROVE_CONFIRM = "approve_confirm";

    function adminWidgets(string _locale, AllowedTokenSupplyStrategy _strategy) public view returns (string) {
        string memory json = "[";
        uint length = 0;
        string[2] memory widgets = [
        _allowedTokensWidget(_locale, _strategy),
        _approveWidget(_locale, _strategy)
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

    function _allowedTokensWidget(string _locale, AllowedTokenSupplyStrategy _strategy) private view returns (string json) {
        Elements.Element[] memory elements = new Elements.Element[](1);
        uint256 allowedTokens = _strategy.sale().token().allowance(_strategy.sale().owner(), address(this));
        DetailedERC20 erc20 = DetailedERC20(_strategy.sale().token());
        uint256 decimals = uint256(erc20.decimals());
        elements[0] = Elements.Element(
            true,
            ALLOWED_TOKENS,
            "token".toSlice().concat(decimals.toString().toSlice()),
            resources[_locale][ALLOWED_TOKENS],
            allowedTokens.toString(),
            Actions.empty(),
            Tables.empty()
        );
        Widgets.Widget memory widget = Widgets.Widget(
            resources[_locale][ALLOWED_TOKENS],
            resources[_locale][ALLOWED_TOKENS_SHORT_DESC],
            resources[_locale][ALLOWED_TOKENS_LONG_DESC],
            4,
            elements
        );
        return widget.toJson();
    }

    function _approveWidget(string _locale, AllowedTokenSupplyStrategy _strategy) private view returns (string json) {
        Elements.Element[] memory elements = new Elements.Element[](3);
        DetailedERC20 erc20 = DetailedERC20(_strategy.sale().token());
        uint256 decimals = uint256(erc20.decimals());
        elements[0] = Elements.Element(
            true,
            ADDRESS,
            "address",
            resources[_locale][ADDRESS],
            address(_strategy).toString().quoted(),
            Actions.empty(),
            Tables.empty()
        );
        elements[1] = Elements.Element(
            true,
            AMOUNT,
            "tokenEdit".toSlice().concat(decimals.toString().toSlice()),
            resources[_locale][AMOUNT],
            "0",
            Actions.empty(),
            Tables.empty()
        );
        elements[2] = Elements.Element(
            true,
            APPROVE,
            "button",
            resources[_locale][APPROVE],
            "null",
            Actions.Action(
                true,
                address(_strategy.sale().token()),
                "approve(address,uint256)",
                '["address","amount"]',
                resources[_locale][APPROVE_CONFIRM]
            ),
            Tables.empty()
        );
        Widgets.Widget memory widget = Widgets.Widget(
            resources[_locale][APPROVE],
            resources[_locale][APPROVE_SHORT_DESC],
            resources[_locale][APPROVE_LONG_DESC],
            4,
            elements
        );
        return widget.toJson();
    }

    function userWidgets(string _locale, AllowedTokenSupplyStrategy _strategy) public view returns (string json) {
        return "[]";
    }

    function inputs(string _locale, AllowedTokenSupplyStrategy _strategy) public view returns (string) {
        return "[]";
    }
}
