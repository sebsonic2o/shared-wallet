// SPDX-License-Identifier: Attribution CC BY 4.0
pragma solidity >=0.6.0 <0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    function isOwner(address _who) internal view returns(bool) {
        return owner() == _who;
    }

    mapping(address => uint) public allowance;

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner(msg.sender) || allowance[msg.sender] >= _amount, "Not allowed");
        _;
    }

    function setAllowance(address _to, uint _amount) public onlyOwner {
        if(!isOwner(_to)) {
            allowance[_to] = _amount;
        }
    }

    function reduceAllowance(uint _amount) internal ownerOrAllowed(_amount) {
        if(!isOwner(msg.sender)) {
            allowance[msg.sender] -= _amount;
        }
    }
}
