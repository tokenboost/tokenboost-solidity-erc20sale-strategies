pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/strategy/sale/erc20/ERC20SaleStrategy.sol";
import "tokenboost-solidity/contracts/widget/Renderable.sol";
import "./widget/TimedStartFinishStrategyRenderer.sol";

contract TimedStartFinishStrategy is ERC20SaleStrategy, Renderable {
    TimedStartFinishStrategyRenderer public constant renderer = TimedStartFinishStrategyRenderer(address(bytes20("__TimedStartFinishSt")));

    uint public startedAt;
    uint public finishedAt;

    constructor(address _owner, ERC20Sale _sale) public ERC20SaleStrategy(_owner, _sale) {
    }

    function update(uint _startedAt, uint _finishedAt) onlyOwner whenSaleNotActivated public {
        startedAt = _startedAt;
        finishedAt = _finishedAt;
        activate();
    }

    function activate() public returns (bool) {
        require(startedAt > 0);
        require(finishedAt > 0);
        return super.activate();
    }

    function started() public view returns (bool) {
        return now >= startedAt;
    }

    function successful() public view returns (bool) {
        return false;
    }

    function finished() public view returns (bool) {
        return now >= finishedAt;
    }

    function purchasable(address _purchaser, uint256 _weiAmount) public view returns (bool) {
        return true;
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
