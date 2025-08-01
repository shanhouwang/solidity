// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Structs {
    struct Car {
        string model;
        uint256 year;
        address owner;
    }

    Car[] public cars;

    function test() external {
        Car memory t = Car("", 1989, msg.sender);
    }
}
