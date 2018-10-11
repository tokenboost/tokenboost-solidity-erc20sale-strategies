pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/strategy/sale/erc20/ERC20SaleStrategy.sol";
import "tokenboost-solidity/contracts/widget/Renderable.sol";
import "./widget/SoftHardCapStrategyRenderer.sol";

contract SoftHardCapStrategy is ERC20SaleStrategy, Renderable {
    using SafeMath for uint;

    SoftHardCapStrategyRenderer public constant renderer = SoftHardCapStrategyRenderer(address(bytes20("__SoftHardCapStrateg")));

    uint public softCap;
    uint public hardCap;

    constructor(address _owner, ERC20Sale _sale) public ERC20SaleStrategy(_owner, _sale) {
    }

    function update(uint256 _softCap, uint256 _hardCap) public onlyOwner whenSaleNotActivated {
        softCap = _softCap;
        hardCap = _hardCap;
        activate();
    }

    function activate() public returns (bool) {
        require(softCap > 0);
        require(hardCap > 0);
        return super.activate();
    }

    function started() public view returns (bool) {
        return false;
    }

    function successful() public view returns (bool) {
        return sale.weiRaised() >= softCap;
    }

    function finished() public view returns (bool) {
        return sale.weiRaised() >= hardCap;
    }

    function purchasable(address _purchaser, uint256 _weiAmount) public view returns (bool) {
        uint256 raised = sale.weiRaised();
        return raised.add(_weiAmount) <= hardCap;
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
