pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/strategy/sale/erc20/ERC20SaleStrategy.sol";
import "tokenboost-solidity/contracts/widget/Renderable.sol";
import "./widget/IndividualCapStrategyRenderer.sol";

contract IndividualCapStrategy is ERC20SaleStrategy, Renderable {
    using SafeMath for uint;

    IndividualCapStrategyRenderer public constant renderer = IndividualCapStrategyRenderer(address(bytes20("__IndividualCapStrat")));

    uint256 public individualCap;

    constructor(address _owner, ERC20Sale _sale) public ERC20SaleStrategy(_owner, _sale) {
    }

    function update(uint256 _individualCap) public onlyOwner whenSaleNotActivated {
        individualCap = _individualCap;
        activate();
    }

    function activate() public returns (bool) {
        require(individualCap > 0);
        return super.activate();
    }

    function started() public view returns (bool) {
        return false;
    }

    function successful() public view returns (bool) {
        return false;
    }

    function finished() public view returns (bool) {
        return false;
    }

    function purchasable(address _purchaser, uint256 _weiAmount) public view returns (bool) {
        uint256 payment = sale.paymentOf(_purchaser);
        return payment.add(_weiAmount) <= individualCap;
    }

    function tokenRate(address _purchaser, uint256 _weiAmount) public view returns (uint256) {
        return 0;
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
