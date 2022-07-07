// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyShop {
    address public owner; // address - специальный тип данных, прям как string но для блокчейна
    mapping (address => uint) public payments; //хранилище ключ-значение(адреса отправителей - unsign int >=0)

    constructor() { // фактически обычная функция, просто она вызывается как только контракт попадает в блокчейн
        owner = msg.sender; // назначили владельца контракта, в данном случае взяли message который появляется после развёртывания в блокчейне и выбрали у него свойство sender
    }

    function payForItem() public payable{ // можно вызывать извне и функция может брать деньги
        // функция уже автоматически принимает деньги и зачисляет на счёт контракта
        payments[msg.sender] = msg.value; // на ключ с адресом отправителя транзакции записываем цену транзакции
    }

    function withDrawAll() public {
        //owner.transfer(); просто так не сработает, потому что owner не может принимать деньги (not payable)
        address payable _to = payable(owner); // теперь на адрес того кто развернул контракт могут придти деньги
        address _thisContract = address(this); // this - это весь контракт MyShop и у него тоже есть адрес, положим во временную переменную
        _to.transfer(_thisContract.balance); //берём все деньги на балансе контракта
    }
}