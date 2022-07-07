// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

contract Demo {
    string public myStr = "Godbye, Mars."; // save in block-chain storage

    function sayHi() public {
        myStr = "Hello, world!";
    }

    function returnYourVal(string memory anyStr) public {
        myStr = anyStr;
    }

    function getBalance(address targetAddr) public view returns(uint) {
        return targetAddr.balance;
    }

    mapping (address => uint) public payments; // list with key and value, default value uint = 0

    function reciveFunds() public payable { // function get monies from client to contract balance
        payments[msg.sender] = msg.value; // value always >= 0, msg.sender = address of sender
    }

    address public myAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    function transferTo(uint amount) public {
        address payable _to = payable(myAddr);
        _to.transfer(amount);
    }
}