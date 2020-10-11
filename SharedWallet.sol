// SPDX-License-Identifier: Attribution CC BY 4.0
pragma solidity >=0.6.0 <0.7.0;

import "./Allowance.sol";

contract SharedWallet is Allowance {
    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(address(this).balance >= _amount, "Not enough money in contract");
        reduceAllowance(_amount);
        _to.transfer(_amount);
    }

    receive() external payable {
        
    }
}
