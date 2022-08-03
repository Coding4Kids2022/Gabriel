// SPDX-License-Identifier: MIT
// gabl22 @ github.com

// UncheckedCounter 0x01 03.08.2022

pragma solidity >=0.8.0 <0.9.0;

library UncheckedCounter {

    struct Counter {
        uint _value;
    }

    function current(Counter storage counter) internal view returns(uint) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        increment(counter, 1);
    }

    function increment(Counter storage counter, uint by) internal {
    unchecked {
        counter._value += by;
    }
    }

    function decrement(Counter storage counter) internal {
        decrement(counter, 1);
    }

    function decrement(Counter storage counter, uint by) internal {
    unchecked {
        counter._value -= by;
    }
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}