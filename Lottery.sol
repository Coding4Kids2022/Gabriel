// SPDX-License-Identifier: MIT
// gabl22 @ github.com

// Lottery 0x01 03.08.2022

pragma solidity >=0.8.0 <0.9.0;

import "./TimeRandom.sol";
import "./Ownable.sol";

contract Lottery is Ownable {

    using TimeRandom for TimeRandom.Random;

    TimeRandom.Random private generator = TimeRandom.Random({
        _last: 557940830126698960967415390
    });

   function betOn(uint min, uint bet, uint max) external payable returns(uint) {
        require(min <= bet && bet <= max, "Error: Number out of range");
        require(min != max, "Error: Range can't be empty");
        if(TimeRandom.random(generator.nextSeed(), min, max) == bet) {
            uint _payout = prize(msg.value, min, max);
            address winner = tx.origin;
            if(balance() < _payout) {
                _payout = balance();
            }
            payable(winner).transfer(_payout);
            return _payout;
        }
        return 0;
    }

    function prize(uint amountBet, uint min, uint max) public pure returns(uint) {
        uint range = max - min + 1;
        return (range * range - range - 1) * amountBet / (range - 1);
    }
    
    function balance() public view returns(uint) {
        return address(this).balance;
    }
}
