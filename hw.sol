// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract HW {
    string public my = "Hello world";
    address public addressMy;

    constructor(uint256 _u) {
        u = _u;
        addressMy = msg.sender;
    }

    bool public b = true;
    uint256 public u = 1; // 取值范围 0 到 2**256 - 1
    int256 public i = 1; // -2**256 到 2**256 -1

    // 拿到最小值
    int256 public minInt = type(int256).min;
    int256 public minMax = type(int256).max;

    function addFunction(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }
}
