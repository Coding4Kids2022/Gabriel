// SPDX-License-Identifier: MIT
// gabl22 @ github.com

pragma solidity >=0.8.0 <0.9.0;

contract Ownable {

    event OwnershipTransfer(address indexed oldOwner, address indexed newOwner);

    address private owner;

    modifier onlyOwner {
        require(msg.sender == owner, "Insufficient Permissions");
        _;
    }
    
    constructor() {
        owner = msg.sender;
        emit OwnershipTransfer(address(0), owner);
    }
    
    function deconstruct() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        address oldOwner = owner;
        owner = newOwner;
        emit OwnershipTransfer(oldOwner, owner);
    }

    //Thanks c:
    function donate() public payable {}
    
    function getOwner() public view returns(address) {
        return owner;
    }
}
