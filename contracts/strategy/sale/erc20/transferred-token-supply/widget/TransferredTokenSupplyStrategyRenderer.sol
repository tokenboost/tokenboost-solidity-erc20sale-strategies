pragma solidity ^0.4.24;

import "zeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import "tokenboost-solidity/contracts/widget/Localizable.sol";
import "tokenboost-solidity/contracts/widget/Widgets.sol";
import "tokenboost-solidity/contracts/utils/StringUtils.sol";
import "../TransferredTokenSupplyStrategy.sol";

contract TransferredTokenSupplyStrategyRenderer is Localizable {
    using Widgets for Widgets.Widget;
    using Elements for Elements.Element;
    using strings for *;
    using UintUtils for uint;
    using AddressUtils for address;
    using StringUtils for string;

    string public constant TRANSFER = "transfer";
    string public constant TRANSFER_SHORT_DESC = "transfer_short_desc";
    string public constant TRANSFER_LONG_DESC = "transfer_long_desc";
    string public constant STRATEGY_ADDRESS = "strategy_address";
    string public constant AMOUNT = "amount";
    string public constant TRANSFER_CONFIRM = "update_confirm";
    string public constant UNSOLD_TOKENS = "unsold_tokens";
    string public constant WITHDRAW_UNSOLD_TOKENS = "withdraw_unsold_tokens";
    string public constant WITHDRAW_UNSOLD_TOKENS_SHORT_DESC = "unsold_tokens_short_desc";
    string public constant WITHDRAW_UNSOLD_TOKENS_LONG_DESC = "unsold_tokens_long_desc";
    string public constant WITHDRAW_UNSOLD_TOKENS_CONFIRM = "withdraw_unsold_tokens_confirm";

    function adminWidgets(string _locale, TransferredTokenSupplyStrategy _strategy) public view returns (string) {
        bool finished = _strategy.sale().finished();
        string memory json = "[";
        uint length = 0;
        string[] memory widgets = new string[](finished ? 2 : 1);
        widgets[0] = _transferWidget(_locale, _strategy);
        if (finished) {
            widgets[1] = _withdrawTokensWidget(_locale, _strategy);
        }
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

    function _transferWidget(string _locale, TransferredTokenSupplyStrategy _strategy) private view returns (string json) {
        Elements.Element[] memory elements = new Elements.Element[](3);
        DetailedERC20 erc20 = DetailedERC20(_strategy.sale().token());
        uint256 decimals = uint256(erc20.decimals());
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
            AMOUNT,
            "tokenEdit".toSlice().concat(decimals.toString().toSlice()),
            resources[_locale][AMOUNT],
            "0",
            Actions.empty(),
            Tables.empty()
        );
        elements[2] = Elements.Element(
            true,
            TRANSFER,
            "button",
            resources[_locale][TRANSFER],
            "null",
            Actions.Action(
                true,
                address(_strategy.sale().token()),
                "transfer(address,uint256)",
                '["address","amount"]',
                resources[_locale][TRANSFER_CONFIRM]
            ),
            Tables.empty()
        );
        Widgets.Widget memory widget = Widgets.Widget(
            resources[_locale][TRANSFER],
            resources[_locale][TRANSFER_SHORT_DESC],
            resources[_locale][TRANSFER_LONG_DESC],
            4,
            elements
        );
        return widget.toJson();
    }

    function _withdrawTokensWidget(string _locale, TransferredTokenSupplyStrategy _strategy) private view returns (string json) {
        Elements.Element[] memory elements = new Elements.Element[](2);
        uint256 unsoldTokens = _strategy.sale().token().balanceOf(address(this));
        DetailedERC20 erc20 = DetailedERC20(_strategy.sale().token());
        uint256 decimals = uint256(erc20.decimals());
        elements[0] = Elements.Element(
            true,
            UNSOLD_TOKENS,
            "token".toSlice().concat(decimals.toString().toSlice()),
            resources[_locale][UNSOLD_TOKENS],
            unsoldTokens.toString(),
            Actions.empty(),
            Tables.empty()
        );
        elements[1] = Elements.Element(
            true,
            WITHDRAW_UNSOLD_TOKENS,
            "button",
            resources[_locale][WITHDRAW_UNSOLD_TOKENS],
            "null",
            Actions.Action(
                true,
                _strategy,
                'withdrawTokens()',
                '[]',
                resources[_locale][WITHDRAW_UNSOLD_TOKENS_CONFIRM]
            ),
            Tables.empty()
        );
        Widgets.Widget memory widget = Widgets.Widget(
            resources[_locale][WITHDRAW_UNSOLD_TOKENS],
            resources[_locale][WITHDRAW_UNSOLD_TOKENS_SHORT_DESC],
            resources[_locale][WITHDRAW_UNSOLD_TOKENS_LONG_DESC],
            4,
            elements
        );
        return widget.toJson();
    }

    function userWidgets(string _locale, TransferredTokenSupplyStrategy _strategy) public view returns (string json) {
        return "[]";
    }

    function inputs(string _locale, TransferredTokenSupplyStrategy _strategy) public view returns (string) {
        return "[]";
    }
}
