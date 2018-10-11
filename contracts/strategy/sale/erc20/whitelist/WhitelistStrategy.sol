pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/strategy/sale/erc20/ERC20SaleStrategy.sol";
import "tokenboost-solidity/contracts/widget/Renderable.sol";
import "./widget/WhitelistStrategyRenderer.sol";

contract WhitelistStrategy is ERC20SaleStrategy, Renderable {
    WhitelistStrategyRenderer public constant renderer = WhitelistStrategyRenderer(address(bytes20("__WhitelistStrategyR")));

    mapping(address => bool) public whitelisted;
    address[] addrs;

    constructor(address _owner, ERC20Sale _sale) public ERC20SaleStrategy(_owner, _sale) {
        activated = true;
    }

    function numberOfAddresses() public view returns (uint) {
        uint number;
        for (uint i = 0; i < addrs.length; i++) {
            if (whitelisted[addrs[i]]) {
                number++;
            }
        }
        return number;
    }

    function addresses(uint index) public view returns (address) {
        uint j = 0;
        for (uint i = 0; i < addrs.length; i++) {
            address addr = addrs[i];
            if (whitelisted[addr]) {
                if (index == j) {
                    return addr;
                }
                j++;
            }
        }
        revert();
    }

    function add(address _address) public onlyOwner {
        whitelisted[_address] = true;

        bool exists = false;
        for (uint i = 0; i < addrs.length; i++) {
            if (addrs[i] == _address) {
                exists = true;
                break;
            }
        }

        if (!exists) {
            addrs.push(_address);
        }
    }

    function remove(address _address) public onlyOwner {
        whitelisted[_address] = false;
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
        return whitelisted[_purchaser];
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
