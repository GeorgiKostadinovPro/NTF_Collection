// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {CoreNft} from "../src/CoreNft.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract MintCoreNft is Script {
    string private constant NFT_IPFS =
        "https://ipfs.io/ipfs/QmPX6RjAP33XSzfw9xfCcwrEFYZJu4qY3eZVKcesZW9bXP/?filename=dog-nft.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "CoreNft",
            block.chainid
        );

        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address _contractAddress) public {
        vm.startBroadcast();
        CoreNft(_contractAddress).mintNft(NFT_IPFS);
        vm.stopBroadcast();
    }
}
