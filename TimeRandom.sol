// SPDX-License-Identifier: MIT
// gabl22 @ github.com

pragma solidity >=0.8.0 <0.9.0;

library TimeRandom {

    struct Random {
        uint _last;
    }

    function nextSeed(Random storage rnd) internal returns(uint) {
        rnd._last = nextViewSeed(rnd);
        return lastSeed(rnd);
    }

    function nextViewSeed(Random storage rnd) internal view returns(uint) {
        return uint(keccak256(abi.encodePacked(lastSeed(rnd) + block.timestamp + block.number)));
    }
    
    function nextPureSeed() internal view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp + block.number)));
    }

    function lastSeed(Random storage rnd) internal view returns(uint) {
        return rnd._last;
    }

    function random(uint seed, uint max) internal pure returns(uint) {
        return seed % max;
    }

    function random(uint seed, uint min, uint max) internal pure returns(uint) {
        return random(seed, max - min) + min;
    }
}
