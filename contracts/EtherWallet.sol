pragma solidity ^0.8.27;

contract EtherWallet {
    address payable public immutable owner;
    event Log(string funName, address from, uint256 value, bytes data);

    constructor() payable {
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }

    function withdraw1() external {
        require(msg.sender == owner, "only owner can call this function");
        // owner.transfer 相比 msg.sender 更加消耗  Gas
        // owner.transfer(address(this).balance);
        payable(msg.sender).transfer(100);
    }

    function withdraw2() external {
        require(msg.sender == owner, "only owner can call this function");
        bool success = payable(msg.sender).send(100);
    }

    function withdraw3() external{
        require(msg.sender == owner, "only owner can call this function");
        (bool success,) = payable(msg.sender).call{value: 100}("");
        require(success, "call failed");
    }
    
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
