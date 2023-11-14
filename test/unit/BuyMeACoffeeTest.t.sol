//SPDX-License_Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BuyMeACoffee} from "../../src/BuyMeACoffee.sol";
import {DeployBueMeACoffee} from "../../script/DeployBuyMeACoffee.s.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract BuyMeACoffeeTest is StdCheats, Test {
    uint256 public constant COFFEE_AMOUNT = 1;
    uint256 public constant COFFEE_PRICE = 0.01 ether;
    uint256 public constant Money = 1 ether;
    address USER = address(1);
    BuyMeACoffee bmac;

    function setUp() external {
        DeployBueMeACoffee deployBmac = new DeployBueMeACoffee();
        bmac = deployBmac.run();
        vm.deal(USER, Money);
    }

    function testNotCallFunctionRevert() public {
        vm.expectRevert();
        address(bmac).call{value: COFFEE_PRICE}("");
    }

    function testBuyCoffeeSuccess() public {
        uint256 balanceBeforeA = address(USER).balance;
        uint256 balanceBeforeB = address(bmac.getOwner()).balance;
        vm.startPrank(USER);
        bmac.buy{value: COFFEE_PRICE}(COFFEE_AMOUNT);
        vm.stopPrank();
        uint256 balanceAfterA = address(USER).balance;
        uint256 balanceAfterB = address(bmac.getOwner()).balance;

        assertEq(balanceBeforeA - COFFEE_PRICE, balanceAfterA);
        assertEq(balanceBeforeB + COFFEE_PRICE, balanceAfterB);
    }
}
