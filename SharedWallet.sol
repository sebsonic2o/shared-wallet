// SPDX-License-Identifier: Attribution CC BY 4.0
pragma solidity >=0.6.0 <0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }

    mapping(address => uint) public allowance;

    function addAllowance(address _to, uint _amount) public onlyOwner {
        if(_to != owner()) {
            allowance[_to] += _amount;
        }
    }

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "Not allowed");
        _;
    }

    function reduceAllowance(uint _amount) public ownerOrAllowed(_amount) {
        if(!isOwner()) {
            allowance[msg.sender] -= _amount;
        }
    }

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(address(this).balance >= _amount, "Contract doesn't have enough funds");
        reduceAllowance(_amount);
        _to.transfer(_amount);
    }

    receive() external payable {
        
    }
}
