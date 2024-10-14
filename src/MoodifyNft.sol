// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodifyNft is ERC721 {
    error MoodifyNft__NotOwnerOfNft();

    enum Mood {
        HAPPY,
        SAD
    }

    uint256 private s_count;
    string private s_happyImageUri;
    string private s_sadImageUri;

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory _happyImageUri,
        string memory _sadImageUri
    ) ERC721("Moodify NFT", "MNFT") {
        s_count = 0;
        s_happyImageUri = _happyImageUri;
        s_sadImageUri = _sadImageUri;
    }

    function mintNft() public {
        s_tokenIdToMood[s_count] = Mood.HAPPY;
        _safeMint(msg.sender, s_count);
        s_count++;
    }

    function switchMood(uint256 _tokenId) public {
        if (
            getApproved(_tokenId) != msg.sender &&
            ownerOf(_tokenId) != msg.sender
        ) {
            revert MoodifyNft__NotOwnerOfNft();
        }

        if (s_tokenIdToMood[_tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[_tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[_tokenId] = Mood.HAPPY;
        }
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        string memory imageUri;

        if (s_tokenIdToMood[_tokenId] == Mood.HAPPY) {
            imageUri = s_happyImageUri;
        } else {
            imageUri = s_sadImageUri;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                '", "description": "An NFT that shows the owners current mood.", "attributes": [{"trait_type": "mood", "value": 100}], "image": "',
                                imageUri,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }
}
