// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Array {
    uint256[] public arr;

    function example() public {
        arr = [1, 2, 3, 4, 5];
    }

    function remove(uint256 _index) public {
        require(_index < arr.length, "indexOutOfBound");
        for (uint256 i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }
}
