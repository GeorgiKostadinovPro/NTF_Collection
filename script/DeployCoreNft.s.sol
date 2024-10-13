// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {CoreNft} from "../src/CoreNft.sol";

contract DeployCoreNft is Script {
    function run() external returns (CoreNft) {
        vm.startBroadcast();
        CoreNft coreNft = new CoreNft();
        vm.stopBroadcast();

        return coreNft;
    }
}
