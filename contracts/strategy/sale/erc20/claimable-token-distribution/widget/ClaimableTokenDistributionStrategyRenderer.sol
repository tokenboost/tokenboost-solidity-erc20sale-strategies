pragma solidity ^0.4.24;

import "zeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import "tokenboost-solidity/contracts/widget/Localizable.sol";
import "tokenboost-solidity/contracts/widget/Widgets.sol";
import "../ClaimableTokenDistributionStrategy.sol";

contract ClaimableTokenDistributionStrategyRenderer is Localizable {
    using Widgets for Widgets.Widget;
    using Elements for Elements.Element;
    using strings for *;
    using UintUtils for uint;
    using AddressUtils for address;

    string public constant CLAIMABLE_TOKENS = "claimable_tokens";
    string public constant CLAIMABLE_TOKENS_SHORT_DESC = "claimable_short_desc";
    string public constant CLAIMABLE_TOKENS_LONG_DESC = "claimable_long_desc";
    string public constant ADDRESS = "address";
    string public constant CLAIM = "claim";
    string public constant CLAIM_SHORT_DESC = "claim_short_desc";
    string public constant CLAIM_LONG_DESC = "claim_long_desc";
    string public constant CLAIM_CONFIRM = "claim_confirm";

    function adminWidgets(string _locale, ClaimableTokenDistributionStrategy _strategy) public view returns (string) {
        return string(abi.encodePacked("[", _claimableTokensWidget(_locale, _strategy), "]"));
    }

    function _claimableTokensWidget(string _locale, ClaimableTokenDistributionStrategy _strategy) private view returns (string json) {
        Elements.Element[] memory elements = new Elements.Element[](1);
        elements[0] = Elements.Element(
            true,
            CLAIMABLE_TOKENS,
            "table",
            resources[_locale][CLAIMABLE_TOKENS],
            "null",
            Actions.empty(),
            Tables.Table(true, _columns(_locale, _strategy), _rows(_locale, _strategy))
        );
        Widgets.Widget memory widget = Widgets.Widget(
            resources[_locale][CLAIMABLE_TOKENS],
            resources[_locale][CLAIMABLE_TOKENS_SHORT_DESC],
            resources[_locale][CLAIMABLE_TOKENS_LONG_DESC],
            8,
            elements
        );
        return widget.toJson();
    }

    function _columns(string _locale, ClaimableTokenDistributionStrategy _strategy) private view returns (Tables.Column[]) {
        DetailedERC20 erc20 = DetailedERC20(_strategy.sale().token());
        uint256 decimals = uint256(erc20.decimals());
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
            CLAIMABLE_TOKENS,
            "token".toSlice().concat(decimals.toString().toSlice()),
            resources[_locale][CLAIMABLE_TOKENS],
            Actions.empty()
        );
        return columns;
    }

    function _rows(string _locale, ClaimableTokenDistributionStrategy _strategy) private view returns (string[]) {
        string[] memory rows = new string[](_strategy.numberOfPurchasers());
        for (uint i = 0; i < rows.length; i++) {
            address purchaser = _strategy.purchasers(i);
            string memory row = '{"address":"';
            row = row.toSlice().concat(purchaser.toString().toSlice());
            row = row.toSlice().concat('","claimable_tokens":'.toSlice());
            row = row.toSlice().concat(_strategy.claimableTokensOf(purchaser).toString().toSlice());
            row = row.toSlice().concat('}'.toSlice());
            rows[i] = row;
        }
        return rows;
    }

    function userWidgets(string _locale, ClaimableTokenDistributionStrategy _strategy) public view returns (string) {
        return string(abi.encodePacked("[", _claimWidget(_locale, _strategy), "]"));
    }

    function _claimWidget(string _locale, ClaimableTokenDistributionStrategy _strategy) private view returns (string json) {
        if (_strategy.sale().finished()) {
            Elements.Element[] memory elements = new Elements.Element[](2);
            DetailedERC20 erc20 = DetailedERC20(_strategy.sale().token());
            uint256 decimals = uint256(erc20.decimals());
            elements[0] = Elements.Element(
                true,
                CLAIMABLE_TOKENS,
                "token".toSlice().concat(decimals.toString().toSlice()),
                resources[_locale][CLAIMABLE_TOKENS],
                _strategy.claimableTokensOf(tx.origin).toString(),
                Actions.empty(),
                Tables.empty()
            );
            elements[1] = Elements.Element(
                true,
                CLAIM,
                "button",
                resources[_locale][CLAIM],
                "null",
                Actions.Action(
                    true,
                    address(_strategy),
                    "claimTokens()",
                    '[]',
                    resources[_locale][CLAIM_CONFIRM]
                ),
                Tables.empty()
            );
            Widgets.Widget memory widget = Widgets.Widget(
                resources[_locale][CLAIM],
                resources[_locale][CLAIM_SHORT_DESC],
                resources[_locale][CLAIM_LONG_DESC],
                4,
                elements
            );
            return widget.toJson();
        } else {
            return "";
        }
    }

    function inputs(string _locale, ClaimableTokenDistributionStrategy _strategy) public view returns (string) {
        return "[]";
    }
}
