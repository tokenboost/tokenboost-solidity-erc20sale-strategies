pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/strategy/sale/erc20/ERC20SaleStrategy.sol";
import "tokenboost-solidity/contracts/widget/Renderable.sol";
import "./widget/ClaimableTokenDistributionStrategyRenderer.sol";

contract ClaimableTokenDistributionStrategy is ERC20SaleStrategy, Renderable {
    using SafeMath for uint;

    ClaimableTokenDistributionStrategyRenderer public constant renderer = ClaimableTokenDistributionStrategyRenderer(address(bytes20("__ClaimableTokenDist")));

    mapping(address => uint256) claimableTokensOfPurchaser;
    address[] public purchasers;

    constructor(address _owner, ERC20Sale _sale) public ERC20SaleStrategy(_owner, _sale) {
        activated = true;
    }

    function claimableTokensOf(address _purchaser) public view returns (uint256) {
        return claimableTokensOfPurchaser[_purchaser];
    }

    function claimTokens() whenSaleActivated public {
        require(sale.finished());

        uint256 tokens = claimableTokensOfPurchaser[msg.sender];
        require(tokens > 0);

        claimableTokensOfPurchaser[msg.sender] = 0;
        sale.token().transfer(msg.sender, tokens);
    }

    function numberOfPurchasers() public view returns (uint256) {
        return purchasers.length;
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
        return false;
    }

    function tokenRate(address _purchaser, uint256 _weiAmount) public view returns (uint256) {
        return 0;
    }

    function supplyTokens(address _purchaser, uint256 _tokenAmount) public returns (bool) {
        return false;
    }

    function receivesTokens(address _purchaser, uint256 _tokenAmount) public returns (bool) {
        require(msg.sender == address(sale));

        bool exists = false;
        for (uint i = 0; i < purchasers.length; i++) {
            if (_purchaser == purchasers[i]) {
                exists = true;
                break;
            }
        }
        if (!exists) {
            purchasers.push(_purchaser);
        }
        claimableTokensOfPurchaser[_purchaser] = claimableTokensOfPurchaser[_purchaser].add(_tokenAmount);
        return true;
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
