pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/strategy/sale/erc20/ERC20SaleStrategy.sol";
import "tokenboost-solidity/contracts/widget/Renderable.sol";
import "./widget/ManualStartFinishStrategyRenderer.sol";

contract ManualStartFinishStrategy is ERC20SaleStrategy, Renderable {
    ManualStartFinishStrategyRenderer public constant renderer = ManualStartFinishStrategyRenderer(address(bytes20("__ManualStartFinishS")));

    uint public startedAt;
    uint public finishedAt;

    constructor(address _owner, ERC20Sale _sale) public ERC20SaleStrategy(_owner, _sale) {
        activated = true;
    }

    function start() public onlyOwner whenSaleActivated {
        require(!sale.started());
        startedAt = now;
    }

    function finish() public onlyOwner whenSaleActivated {
        require(!sale.finished());
        require(sale.started());
        finishedAt = now;
    }

    function started() public view returns (bool) {
        return startedAt > 0;
    }

    function successful() public view returns (bool) {
        return true;
    }

    function finished() public view returns (bool) {
        return finishedAt > 0;
    }

    function purchasable(address _purchaser, uint256 _weiAmount) public view returns (bool) {
        return true;
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
