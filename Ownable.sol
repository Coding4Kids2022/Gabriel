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
    
    function withdrawAll() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
    
    function withdraw(uint amount) public onlyOwner{
        if(address(this).balance < amount) {
            withdrawAll();
        } else {
            payable(owner).transfer(amount);
        }
    }
    
    function transferOwnership(address newOwner) public onlyOwner {
        address oldOwner = owner;
        owner = newOwner;
        emit OwnershipTransfer(oldOwner, owner);
    }
    
    function donate() public payable {
        payable(owner).transfer(msg.value);
    }
    
    function charge() public payable onlyOwner() {}
    
    function getOwner() public view returns(address) {
        return owner;
    }
}
