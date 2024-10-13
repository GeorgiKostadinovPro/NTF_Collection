// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract CoreNft is ERC721 {
    uint256 private s_count;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721("Dogo", "DOG") {
        s_count = 0;
    }

    function mintNft(string memory _tokenUri) public {
        s_tokenIdToUri[s_count] = _tokenUri;
        _safeMint(msg.sender, s_count);
        s_count++;
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[_tokenId];
    }
}
