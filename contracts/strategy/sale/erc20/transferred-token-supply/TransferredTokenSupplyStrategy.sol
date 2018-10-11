pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/strategy/sale/erc20/ERC20SaleStrategy.sol";
import "tokenboost-solidity/contracts/widget/Renderable.sol";
import "./widget/TransferredTokenSupplyStrategyRenderer.sol";

contract TransferredTokenSupplyStrategy is ERC20SaleStrategy, Renderable {
    TransferredTokenSupplyStrategyRenderer public constant renderer = TransferredTokenSupplyStrategyRenderer(address(bytes20("__TransferredTokenSu")));

    constructor(address _owner, ERC20Sale _sale) public ERC20SaleStrategy(_owner, _sale) {
        activated = true;
    }

    function withdrawTokens() onlyOwner public returns (bool) {
        require(!sale.started() || sale.finished());

        ERC20 token = sale.token();
        return token.transfer(msg.sender, token.balanceOf(address(this)));
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
        return sale.token().balanceOf(address(this)) >= _weiAmount;
    }

    function tokenRate(address _purchaser, uint256 _weiAmount) public view returns (uint256) {
        return 0;
    }

    function supplyTokens(address _purchaser, uint256 _tokenAmount) public returns (bool) {
        require(sale.token().transfer(_purchaser, _tokenAmount));
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
