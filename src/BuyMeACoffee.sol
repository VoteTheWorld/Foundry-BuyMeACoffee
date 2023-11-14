//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

error BuyMeACoffee__callfunction();

contract BuyMeACoffee {
    address private immutable i_owner;
    uint256 private constant CoffeePrice = 0.01 ether;

    constructor() {
        i_owner = msg.sender;
    }

    function buy(uint256 _amount) public payable {
        require(msg.value == _amount * CoffeePrice, "Wrong amount");
        (bool callsuccess, ) = payable(i_owner).call{value: msg.value}("");
        require(callsuccess, "Transfer failed");
    }

    function reveive() external payable {
        revert BuyMeACoffee__callfunction();
    }

    function getOwner() public view returns (address) {
        return i_owner;
    }
}
