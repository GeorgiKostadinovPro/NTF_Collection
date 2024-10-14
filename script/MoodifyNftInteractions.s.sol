// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodifyNft} from "../src/MoodifyNft.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract MintMoodifyNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodifyNft",
            block.chainid
        );

        mintNftOnChain(mostRecentlyDeployed);
    }

    function mintNftOnChain(address _contractAddress) public {
        vm.startBroadcast();
        MoodifyNft(_contractAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract SwitchMoodifyNft is Script {
    function run(uint256 _tokenId) external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodifyNft",
            block.chainid
        );

        switchMoodifyNft(mostRecentlyDeployed, _tokenId);
    }

    function switchMoodifyNft(
        address _contractAddress,
        uint256 _tokenId
    ) public {
        vm.startBroadcast();
        MoodifyNft(_contractAddress).switchMood(_tokenId);
        vm.stopBroadcast();
    }
}
