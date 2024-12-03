// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract Bank {
    // 状态变量
    address public immutable owner;

    // 事件
    event Deposit(address _ads,uint256 amount);
    event Withdraw(uint256 amount);

    // 接收到以太币时候触发
    receive() external payable {
        emit Deposit(msg.sender,msg.value);
    }

    // 构造函数
    constructor() {
        owner = msg.sender;
    }

    // 提现
    function withdraw() external {
        require(msg.sender == owner, "only owner can withdraw");
        emit Withdraw(address(this).balance);
        // 销毁合约
        selfdestruct(payable(owner));
    }

    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }

}