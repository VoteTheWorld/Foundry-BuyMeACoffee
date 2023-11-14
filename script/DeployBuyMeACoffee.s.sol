//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BuyMeACoffee} from "../src/BuyMeACoffee.sol";

contract DeployBueMeACoffee is Script {
    function run() external returns (BuyMeACoffee) {
        vm.startBroadcast();
        BuyMeACoffee bmac = new BuyMeACoffee();
        vm.stopBroadcast();
        return bmac;
    }
}
