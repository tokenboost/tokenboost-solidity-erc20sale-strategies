pragma solidity ^0.4.24;

import "tokenboost-solidity/contracts/strategy/sale/erc20/ERC20SaleStrategy.sol";
import "tokenboost-solidity/contracts/widget/Renderable.sol";
import "tokenboost-veriff-kyc/contracts/VeriffKyc.sol";
import "./widget/VeriffKycStrategyRenderer.sol";

contract VeriffKycStrategy is ERC20SaleStrategy, Renderable {
    VeriffKycStrategyRenderer public constant renderer = VeriffKycStrategyRenderer(address(bytes20("__VeriffKycStrategyR")));
    VeriffKyc public constant kyc = VeriffKyc(address(bytes20("__VeriffKyc_________")));

    bool public blacklisted = true;
    string countryCodes = "AFAXALDZASADAOAIAQAGARAMAWAUATAZBSBHBDBBBYBEBZBJBMBTBOBQBABWBVBRIOBNBGBFBIKHCMCACVKYCFTDCLCNCXCCCOKMCGCDCKCRCIHRCUCWCYCZDKDJDMDOECEGSVGQEREEETFKFOFJFIFRGFPFTFGAGMGEDEGHGIGRGLGDGPGUGTGGGNGWGYHTHMVAHNHKHUISINIDIRIQIEIMILITJMJPJEJOKZKEKIKPKRKWKGLALVLBLSLRLYLILTLUMOMKMGMWMYMVMLMTMHMQMRMUYTMXFMMDMCMNMEMSMAMZMMNANRNPNLNCNZNINENGNUNFMPNOOMPKPWPSPAPGPYPEPHPNPLPTPRQARERORURWBLSHKNLCMFPMVCWSSMSTSASNRSSCSLSGSXSKSISBSOZAGSSSESLKSDSRSJSZSECHSYTWTJTZTHTLTGTKTOTTTNTRTMTCTVUGUAAEGBUSUMUYUZVUVEVNVGVIWFEHYEZMZW";
    mapping(string => bool) allowed;
    mapping(string => bool) rejected;

    constructor(address _owner, ERC20Sale _sale) public ERC20SaleStrategy(_owner, _sale) {
        activated = true;
    }

    function numberOfCountryCodes() public view returns (uint) {
        return 249;
    }

    function countryCodeAt(uint _index) public view returns (string) {
        return _substring(countryCodes, _index * 2, _index * 2 + 2);
    }

    function _substring(string str, uint startIndex, uint endIndex) private view returns (string) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex-startIndex);
        for(uint i = startIndex; i < endIndex; i++) {
            result[i-startIndex] = strBytes[i];
        }
        return string(result);
    }

    function countryCodeAllowed(string _code) public view returns (bool) {
        return allowed[_code];
    }

    function countryCodeRejected(string _code) public view returns (bool) {
        return rejected[_code];
    }

    function update(bool _blacklisted) onlyOwner whenSaleNotActivated public {
        blacklisted = _blacklisted;
        activate();
    }

    function addAllowedCountryCode(string _code) onlyOwner public {
        allowed[_code] = true;
    }

    function removeAllowedCountryCode(string _code) onlyOwner public {
        allowed[_code] = false;
    }

    function addRejectedCountryCode(string _code) onlyOwner public {
        rejected[_code] = true;
    }

    function removeRejectedCountryCode(string _code) onlyOwner public {
        rejected[_code] = false;
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
        string memory code;
        uint i;
        if (blacklisted) {
            for (i = 0; i < numberOfCountryCodes(); i++) {
                code = countryCodeAt(i);
                if (!rejected[code] && kyc.countryVerified(_purchaser, code)) {
                    return true;
                }
            }
            return false;
        } else {
            for (i = 0; i < numberOfCountryCodes(); i++) {
                code = countryCodeAt(i);
                if (allowed[code] && kyc.countryVerified(_purchaser, code)) {
                    return true;
                }
            }
            return false;
        }
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
