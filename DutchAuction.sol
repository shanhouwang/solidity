// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
import "@openzeppelin/contracts/utils/Strings.sol";

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _nftId
    ) external;
}

contract DutchAuction {
    // NFT 相关信息
    IERC721 public immutable nft;
    uint256 public immutable nftId;

    // 拍卖信息
    uint256 private constant DURATION = 7 days;
    address public immutable seller;
    uint256 public immutable startingPrice;
    uint256 public immutable startAt;
    uint256 public immutable expiresAt;
    uint256 public immutable discountRate;

    constructor(
        uint256 _startingPrice,
        uint256 _discountRate,
        address _nft,
        uint256 _nftId
    ) {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;
        require(
            _startingPrice >= discountRate * DURATION,
            "starting price < discout"
        );
        nft = IERC721(_nft);
        nftId = _nftId;
    }

    function buy() external payable {
        require(block.timestamp < expiresAt, "auction is expire");
        uint256 price = getPrice();
        require(msg.value >= price, "ETH < price");
        nft.transferFrom(seller, msg.sender, nftId);
        uint256 refund = msg.value - price;
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        }
    }

    // 查看当前价格
    function getPrice() public view returns (uint256) {
        uint256 timeElapsed = block.timestamp - startAt;
        uint256 discout = discountRate * timeElapsed;
        return startingPrice - discout;
    }
}
