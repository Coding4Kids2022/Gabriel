// SPDX-License-Identifier: MIT
// gabl22 @ github.com

// CashFlow 0x01 03.08.2022

pragma solidity >=0.8.0 <0.9.0;

import "./Ownable.sol";

contract CashFlow is Ownable {

    struct Config {
        bool publicDonations;
        bool publicCharging;
    }

    modifier cashFlow {
        require(!deactivated, "Contract deactivated");
        _;
    }

    Config private config;
    bool private deactivated;

    constructor(Config memory _config) {
        config = _config;
    }

    function deactivate() public onlyOwner {
        require(!deactivated, "Already deactivated.");
        deactivated = true;
    }

    function activate() public onlyOwner {
        require(deactivated, "Already activated");
        deactivated = false;
    }

    function donate() public payable {
        require(config.publicDonations, "Insufficient Permissions");
        if (config.publicDonations) {
            payable(super.getOwner()).transfer(msg.value);
        }
    }

    function charge() public payable {
        if(msg.sender != super.getOwner()) {
            require(config.publicCharging, "Error: Unable to charge contract");
        }
    }

    function withdraw(uint amount) public onlyOwner {
        if(address(this).balance < amount) {
            withdrawAll();
        } else {
            payable(super.getOwner()).transfer(amount);
        }
    }

    function withdrawAll() public onlyOwner {
        payable(super.getOwner()).transfer(address(this).balance);
    }
}