// SPDX-License-Identifier: MIT
// gabl22 @ github.com

// NFT 0x03 01.08.2022
f
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFT is ERC721 {

    uint private nextTokenID;

    string private link_before;
    string private link_after;

    constructor(string memory _linkBefore, string memory _linkAfter, string memory name, string memory short) ERC721(name, short) {
        link_before = _linkBefore;
        link_after = _linkAfter;
    }

    function mint(address recipient) payable public returns(string memory) {
        _safeMint(recipient, nextTokenID);
        nextTokenID++;
        return Strings.toString(nextTokenID - 1);
    } 


    function tokenURI(uint tokenID) view public override returns(string memory) {
        require(tokenID < nextTokenID, "Token not existing");
        return string(abi.encodePacked(link_before, Strings.toString(tokenID), link_after));
    }
}
