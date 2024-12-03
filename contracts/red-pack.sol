pragma solidity ^0.8.23;

contract RedPack {
    // 发红发的主体
    address payable public owner;
    // 红包总额
    uint256 public totalAmount;
    // 红包数量
    uint256 public totalCount;
    // 红包是否平均
    bool average;
    // 红包是否领取
    mapping(address => bool) isGrabbed;

    constructor(uint256 count, bool isAverage) payable {
        require(msg.value > 0, "The amount must be greater than 0");

        owner = payable(msg.sender);
        totalAmount = msg.value;

        totalCount = count;
        average = isAverage;
    }

    // 获取余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // 领取红包
    function grab() public {
        require(totalCount > 0, "No red packets available");
        require(
            !isGrabbed[msg.sender],
            "You have already grabbed the red packet"
        );
        require(totalAmount > 0, "red packet is empty");

        isGrabbed[msg.sender] = true;

        if (totalCount == 1) {
            payable(msg.sender).transfer(totalAmount);
        } else {
            if (average) {
                uint256 amount = totalAmount / totalCount;
                totalAmount -= amount;
                payable(msg.sender).transfer(amount);
            } else {
                uint256 random = (uint256(
                    keccak256(
                        abi.encodePacked(
                            msg.sender,
                            owner,
                            totalCount,
                            totalAmount,
                            block.timestamp
                        )
                    )
                ) % 8) + 1;

                uint256 amount = (totalAmount * random) / 10;
                payable(msg.sender).transfer(amount);
                totalAmount -= amount;
            }
        }
        totalCount--;
    }
}
