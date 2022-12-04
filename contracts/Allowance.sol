// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
contract Allowance is Ownable {
    using SafeMath for uint;
    event AllowanceChanged(address indexed _forWho, address indexed _byWhom, uint _oldAmount, uint _newAmount);
    mapping(address => uint) public allowance;
    function addAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who,msg.sender,allowance[_who],_amount);
        allowance[_who] = allowance[_who].add(_amount); 
        // allowance[_who] = _amount;
    }
    function isOwner() internal view returns(bool) {
        return owner()== msg.sender;
    }
    modifier ownerOrWhoIsAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed!!!");
        _;
    }
    function reduceAllowance(address _who, uint _amount) internal ownerOrWhoIsAllowed(_amount) {
        emit AllowanceChanged(_who,msg.sender,allowance[_who],allowance[_who] - _amount);
        allowance[_who] = allowance[_who].sub(_amount); 
        // allowance[_who] -= _amount;
    }
    function renounceOwnership() public view override onlyOwner {
        revert("Can't renounceOwnership");
    }
}