// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;
import "./Allowance.sol";
contract FundWallet is Allowance{
    event MoneySent(address indexed _to, uint _amount);
    event MoneyReceive(address indexed _from, uint _amount);
    function withdrawMoney(address payable _to, uint _amount) public ownerOrWhoIsAllowed(_amount) {
        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to,_amount);
        _to.transfer(_amount);
    }
    //transferOwnerShip la ham doi chu so huu de chuyen tu account khac.
    receive() external payable {
        emit MoneyReceive(msg.sender, msg.value);
    }
}