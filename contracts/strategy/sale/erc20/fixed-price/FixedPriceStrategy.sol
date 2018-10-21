pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/strategy/sale/erc20/ERC20SaleStrategy.sol";
import "tokenboost-solidity/contracts/widget/Renderable.sol";
import "./widget/FixedPriceStrategyRenderer.sol";

contract FixedPriceStrategy is ERC20SaleStrategy, Renderable {
    FixedPriceStrategyRenderer public constant renderer = FixedPriceStrategyRenderer(address(bytes20("__FixedPriceStrategy")));

    uint256 public tokensPerEth;

    constructor(address _owner, ERC20Sale _sale) public ERC20SaleStrategy(_owner, _sale) {
    }

    function update(uint256 _tokensPerEth) public onlyOwner whenSaleNotActivated {
        tokensPerEth = _tokensPerEth;
        activate();
    }

    function activate() public returns (bool) {
        require(tokensPerEth > 0);
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
        return true;
    }

    function tokenRate(address _purchaser, uint256 _weiAmount) public view returns (uint256) {
        return tokensPerEth;
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
