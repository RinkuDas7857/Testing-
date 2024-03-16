pragma solidity ^0.8.0;

contract VulnerableContract {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public withdrawalLimit;
    
    constructor() {
        // Initialize balances and withdrawal limits for testing
        balances[msg.sender] = 100 ether;
        withdrawalLimit[msg.sender] = 10 ether;
    }
    
    function withdraw(uint256 _amount) external {
        require(_amount <= withdrawalLimit[msg.sender], "Exceeds withdrawal limit");
        require(_amount <= balances[msg.sender], "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        withdrawalLimit[msg.sender] -= _amount; // Update withdrawal limit
        
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "Transfer failed");
    }
    
    function setWithdrawalLimit(address _account, uint256 _limit) external {
        withdrawalLimit[_account] = _limit;
    }
}

