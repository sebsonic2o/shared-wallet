// SPDX-License-Identifier: Attribution CC BY 4.0
pragma solidity >=0.6.0 <0.7.0;

contract SharedWallet {
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(owner == msg.sender, "Not the owner");
        _;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
    }
    
    receive() external payable {
        
    }
}
