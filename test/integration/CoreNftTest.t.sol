// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {CoreNft} from "../../src/CoreNft.sol";
import {DeployCoreNft} from "../../script/DeployCoreNft.s.sol";

contract CoreNftTest is Test {
    string private constant NFT_IPFS =
        "https://ipfs.io/ipfs/QmPX6RjAP33XSzfw9xfCcwrEFYZJu4qY3eZVKcesZW9bXP/?filename=dog-nft.json";

    DeployCoreNft private deployer;
    CoreNft private coreNft;

    address private USER = makeAddr("USER");

    function setUp() public {
        deployer = new DeployCoreNft();
        coreNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expected = "Dogo";
        string memory actual = coreNft.name();

        assert(
            keccak256(abi.encodePacked(expected)) ==
                keccak256(abi.encodePacked(actual))
        );
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        coreNft.mintNft(NFT_IPFS);

        assert(coreNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(NFT_IPFS)) ==
                keccak256(abi.encodePacked(coreNft.tokenURI(0)))
        );
    }
}
