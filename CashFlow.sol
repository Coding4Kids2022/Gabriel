// SPDX-License-Identifier: MIT
// gabl22 @ github.com

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
            payable(super.owner).transfer(msg.value);
        }
    }

    function charge() public payable {
        if(msg.sender != super.owner) {
            require(config.publicCharging, "Insufficient Permissions");
        }
    }

    function withdraw(uint amount) public onlyOwner {
        if(address(this).balance < amount) {
            withdrawAll();
        } else {
            payable(super.owner).transfer(amount);
        }
    }

    function withdrawAll() public onlyOwner {
        payable(super.owner).transfer(address(this).balance);
    }
}