// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Ownable{
    address internal owner;
    address private secureOwner;
    bool private allow = false;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not authorized");
        _;
    }

    modifier onlySecureOwner() {
        require(msg.sender == secureOwner, "not secureOwner");
        _;
    }

    modifier checkAllow() {
        require(allow, "not allow");
        _;
    }

    modifier resetAllow() {
        allow = false;
        _;
    }

    function setSecureOwner(address _secureOwner) internal onlyOwner {
        secureOwner = _secureOwner;
    }

    function allowDoing() external onlySecureOwner{
        allow = true;
    }

    function transferOwnership(address newOwner) public onlyOwner checkAllow resetAllow {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }

}