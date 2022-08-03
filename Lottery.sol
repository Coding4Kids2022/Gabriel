// SPDX-License-Identifier: MIT
// gabl22 @ github.com

pragma solidity >=0.8.0 <0.9.0;

import "./TimeRandom.sol";
import "./Ownable.sol";

contract Lottery is Ownable {

    function betOn(uint min, uint bet, uint max) external payable returns(bool) {
        require(min <= bet && bet <= max, "Number out of range");
        require(min != max, "Range can't be empty");
        if(TimeRandom.randomInt(min, max) == bet) {
            uint prize = (max - (min + 1)) * msg.value;
            address winner = tx.origin;
            if(balance() < prize) {
                prize = balance();
            }
            payable(winner).transfer(prize);
            return true;
        }
        return false;
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }
}
