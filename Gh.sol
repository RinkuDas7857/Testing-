function callExternal(address _externalContract, uint256 _amount) external {
    _externalContract.call.value(_amount)(""); // No return value check
}
