pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/strategy/sale/erc20/ERC20SaleStrategy.sol";
import "tokenboost-solidity/contracts/widget/Renderable.sol";
import "./widget/AllowedTokenSupplyStrategyRenderer.sol";

contract AllowedTokenSupplyStrategy is ERC20SaleStrategy, Renderable {
    AllowedTokenSupplyStrategyRenderer public constant renderer = AllowedTokenSupplyStrategyRenderer(address(bytes20("__AllowedTokenSupply")));

    constructor(address _owner, ERC20Sale _sale) public ERC20SaleStrategy(_owner, _sale) {
        activated = true;
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
        return sale.token().allowance(sale.owner(), address(this)) >= _weiAmount;
    }

    function tokenRate(address _purchaser, uint256 _weiAmount) public view returns (uint256) {
        return 0;
    }

    function supplyTokens(address _purchaser, uint256 _tokenAmount) public returns (bool) {
        require(sale.token().transferFrom(sale.owner(), _purchaser, _tokenAmount));
        return true;
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
