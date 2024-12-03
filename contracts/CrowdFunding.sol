pragma solidity ^0.8.27;

contract CrowdFunding {
    address public immutable beneficiary; // 受益人
    uint256 public immutable fundingGoal; // 筹资目标数量
    uint256 public fundingAmount; // 当前募集数量

    // 捐赠者捐赠的金额记录
    mapping(address => uint256) public funders; // 资助者
    // 捐赠者信息记录
    mapping(address => bool) private fundersInsered;
    // 捐赠者数组
    address[] public fundersKey; //length;

    // 不用自销毁方法，使用变量来控制
    bool public AVAILABLED = true;

    /**
     *
     * @param beneficiary_ 受益人
     * @param goal_        筹资目标数量
     */
    constructor(address beneficiary_, uint256 goal_) {
        beneficiary = beneficiary_;
        fundingGoal = goal_;
    }

    // 资助
    //      可用的时候才可以捐
    //      合约关闭之后，就不能在操作了
    function contribute() external payable {
        require(AVAILABLED, "CrowdFunding has been closed");

        // 检查捐赠金额是否会超过目标金额
        uint256 potentialFundingAmount = fundingAmount + msg.value;
        // 记录当前需要的退款金额
        uint refundAmount = 0;

        // 如果超出目标金额，则进行退款
        if (potentialFundingAmount > fundingGoal) {
            // 退款
            refundAmount = potentialFundingAmount - fundingGoal;
            funders[msg.sender] += (msg.value - refundAmount);
            fundingAmount += msg.value - refundAmount;
        } else {
            funders[msg.sender] += msg.value;
            fundingAmount += msg.value;
        }

        // 记录捐赠人
        if (!fundersInsered[msg.sender]) {
            fundersInsered[msg.sender] = true;
            fundersKey.push(msg.sender);
        }

        // 如果有退款，则进行退款
        if (refundAmount > 0) {
            payable(msg.sender).transfer(refundAmount);
        }
    }

    function close() external returns (bool) {
        // 还没有募集到足够的资金
        // 1 检查
        if (fundingAmount < fundingGoal) return false;
        uint256 amount = fundingAmount;

        // 2 修改
        fundingAmount = 0;
        AVAILABLED = false;

        // 3 转账
        payable(beneficiary).transfer(amount);
        return true;
    }

    function fundersLength() public view returns (uint256) {
        return fundersKey.length;
    }
}
