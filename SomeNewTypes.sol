//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    //Array
    uint[10] public items; // create new array with 10 var or less and all of them are >=0

    function useArray() public {
        items[0] = 100;
        items[1] = 250;
        items[5] = 42; 
        // any other item is 0
    }

    uint[3][2] public obj; // wtf? it isn't [[],[]],[[],[]],[[],[]]; this is [[],[],[]],[[],[],[]]
    function checkObj() public {
        obj = [
            [1,2,3],
            [4,5,6]
        ];
    }

    string[] public strings; // dynamic len of array
    uint public len;

    function addString() public { //just testing
        strings.push("Hello,");
        strings.push(" ");
        strings.push("Mike");
        strings.push("!");
        len = strings.length; // So, may ve one day Solidity will create a mix of array and strings :)
    }

    function sampleMemory() public pure returns(uint[] memory){
        uint[] memory tempArray = new uint[](10);
        tempArray[0] = 1;
        return tempArray;
    }

    //Enum
    enum Status {Paid, Delivered, Received} // Data with status, Paid - 0, Delivered - 1, Received - 2
    Status public currentStatus; // create new var, default value = 0 - Paid

    function paid() public {
        currentStatus = Status.Paid;
    }

    function delivered() public {
        currentStatus = Status.Delivered;
    }

    function received() public {
        currentStatus = Status.Received;
    }

    //Bytes
    bytes32 public myVar = "test my var"; // min - 1 byte, max - 32 bytes; 32 * 8 = 256 - uint256
    bytes public myDynVar = "this is shorter"; // array with a dynamic length

    function lenDynVar() public view returns(uint) {
        return myDynVar.length;
    }

    function byteFromArray(uint8 index) public view returns(bytes1) {
        return myVar[index];
    }

    //Struct
    struct Payment {
        uint amount;
        uint timestamp;
        address addressFrom;
        string message;
        //Payment paymnet; - you can't create recursive structure
    }

    struct Balance {
        uint totalPayments;
        mapping(uint => Payment) payments;
    }

    mapping (address => Balance) public balances;

    function pay(string memory message) public payable {
        uint numberOfPayment = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++; // let's go :) client send us his payment

        Payment memory newPayment = Payment(
            msg.value, 
            block.timestamp,
            msg.sender,
            message
        );

        balances[msg.sender].payments[numberOfPayment] = newPayment;
    }

    function getPayment(address _addr, uint _paymentIndex) public view returns(Payment memory) {
        return balances[_addr].payments[_paymentIndex];
    }
}