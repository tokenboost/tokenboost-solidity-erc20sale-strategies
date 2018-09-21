pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/strategy/sale/erc20/ERC20SaleStrategy.sol";
import "tokenboost-solidity/contracts/widget/Renderable.sol";
import "./widget/CapStrategyRenderer.sol";

contract CapStrategy is ERC20SaleStrategy, Renderable {
    using SafeMath for uint;

    CapStrategyRenderer public constant renderer = CapStrategyRenderer(address(bytes20("__CapStrategyWidgetR")));

    uint256 public cap;

    constructor(address _owner, ERC20Sale _sale) public ERC20SaleStrategy(_owner, _sale) {
    }

    function update(uint256 _cap) public onlyOwner whenSaleNotActivated {
        cap = _cap;
        activate();
    }

    function activate() public returns (bool) {
        require(cap > 0);
        return super.activate();
    }

    function started() public view returns (bool) {
        return true;
    }

    function successful() public view returns (bool) {
        return sale.weiRaised() > cap;
    }

    function finished() public view returns (bool) {
        return sale.weiRaised() > cap;
    }

    function purchasable(address _purchaser, uint256 _weiAmount) public view returns (bool) {
        uint256 raised = sale.weiRaised();
        return raised.add(_weiAmount) <= cap;
    }

    function tokenRate(address _purchaser, uint256 _weiAmount) public view returns (uint256) {
        return 1;
    }

    function supplyTokens(address _purchaser, uint256 _tokenAmount) public returns (bool) {
        return false;
    }

    function receivesTokens(address _purchaser, uint256 _tokenAmount) public returns (bool) {
        return false;
    }

    function adminWidgets(string locale) public view returns (string json) {
        return renderer.adminWidgets(locale, this);
    }

    function userWidgets(string locale) public view returns (string json) {
        return renderer.userWidgets(locale, this);
    }

    function inputs(string locale) public view returns (string json) {
        return renderer.inputs(locale, this);
    }
}
