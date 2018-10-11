pragma solidity ^0.4.24;

import "zeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import "tokenboost-solidity/contracts/widget/Localizable.sol";
import "tokenboost-solidity/contracts/widget/Widgets.sol";
import "../FixedPriceStrategy.sol";

contract FixedPriceStrategyRenderer is Localizable {
    using Widgets for Widgets.Widget;
    using Elements for Elements.Element;
    using UintUtils for uint;
    using strings for *;

    string public constant TOKEN_PRICE = "token_price";
    string public constant TOKEN_PRICE_LABEL = "token_price_label";
    string public constant SHORT_DESC = "short_desc";
    string public constant LONG_DESC = "long_desc";
    string public constant UPDATE = "update";
    string public constant UPDATE_CONFIRM = "update_confirm";

    function adminWidgets(string _locale, FixedPriceStrategy _strategy) public view returns (string json) {
        return string(abi.encodePacked("[", _tokenPriceWidget(_locale, _strategy, true), "]"));
    }

    function userWidgets(string _locale, FixedPriceStrategy _strategy) public view returns (string json) {
        return string(abi.encodePacked("[", _tokenPriceWidget(_locale, _strategy, false), "]"));
    }

    function _tokenPriceWidget(string _locale, FixedPriceStrategy _strategy, bool _admin) private view returns (string json) {
        if (_admin || _strategy.sale().activated()) {
            Elements.Element[] memory elements = new Elements.Element[](1);
            DetailedERC20 erc20 = DetailedERC20(_strategy.sale().token());
            string memory tokensPerEth = _strategy.tokensPerEth().toString().toSlice().concat(" ".toSlice()).toSlice().concat(erc20.symbol().toSlice());
            elements[0] = Elements.Element(
                true,
                TOKEN_PRICE,
                "text",
                '1 ETH = '.toSlice().concat(tokensPerEth.toSlice()),
                "null",
                Actions.empty(),
                Tables.empty()
            );
            Widgets.Widget memory widget = Widgets.Widget(
                resources[_locale][TOKEN_PRICE],
                resources[_locale][SHORT_DESC],
                resources[_locale][LONG_DESC],
                4,
                elements
            );
            return widget.toJson();
        } else {
            return "";
        }
    }

    function inputs(string _locale, FixedPriceStrategy _strategy) public view returns (string) {
        Elements.Element[] memory elements = new Elements.Element[](2);
        elements[0] = Elements.Element(
            true,
            TOKEN_PRICE,
            "numberEdit",
            resources[_locale][TOKEN_PRICE_LABEL],
            _strategy.tokensPerEth().toString(),
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
                '["token_price"]',
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
