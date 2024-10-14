// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodifyNft} from "../src/MoodifyNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodifyNft is Script {
    function run() external returns (MoodifyNft) {
        string memory happySvg = vm.readFile("./assets/moodNft/happy.svg");
        string memory sadSvg = vm.readFile("./assets/moodNft/sad.svg");

        vm.startBroadcast();
        MoodifyNft moodifyNft = new MoodifyNft(
            svgToImageUri(happySvg),
            svgToImageUri(sadSvg)
        );
        vm.stopBroadcast();

        return moodifyNft;
    }

    function svgToImageUri(
        string memory _svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(_svg)))
        );

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
