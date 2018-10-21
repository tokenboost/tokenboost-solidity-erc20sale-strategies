pragma solidity ^0.4.24;

import "oraclize-api/contracts/usingOraclize.sol";
import "tokenboost-solidity/contracts/strategy/sale/erc20/ERC20SaleStrategy.sol";
import "tokenboost-solidity/contracts/widget/Renderable.sol";
import "./widget/CoinbaseUSDPriceStrategyRenderer.sol";

contract CoinbaseUSDPriceStrategy is ERC20SaleStrategy, Renderable, usingOraclize {
    using SafeMath for uint;

    CoinbaseUSDPriceStrategyRenderer public constant renderer = CoinbaseUSDPriceStrategyRenderer(address(bytes20("__CoinbaseUSDPriceS")));

    event PriceCalculated(uint256 centsPerEth, uint256 centsPerToken, uint256 tokensPerEth);

    uint256 public tokensPerEth;
    uint256 public centsPerToken;

    constructor(address _owner, ERC20Sale _sale) public ERC20SaleStrategy(_owner, _sale) {
    }

    function update(uint256 _centsPerToken) public onlyOwner whenSaleNotActivated {
        centsPerToken = _centsPerToken;
        activate();
    }

    function activate() onlyOwner whenSaleNotActivated public returns (bool) {
        require(centsPerToken > 0);
        oraclize_query("URL", "json(https://api.coinbase.com/v2/prices/ETH-USD/spot).data.amount");
        return true;
    }

    function __callback(bytes32 _myid, string _result, bytes _proof) {
        require(msg.sender == oraclize_cbAddress());

        uint256 centsPerEth = parseInt(_result, 2);
        tokensPerEth = centsPerEth.div(centsPerToken);

        emit PriceCalculated(centsPerEth, centsPerToken, tokensPerEth);

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
