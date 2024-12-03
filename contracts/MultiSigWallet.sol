// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MutiSigWallet {
    // mutiltisig owners
    address[] public owners;
    // 确认数
    uint256 public required;
    
    mapping(address => bool) public isOwner;

    // 交易转账
    struct Transaction {
        address to; // 接收者地址
        uint256 value; // 转账金额
        bytes data; // 附带数据
        bool executed; // 是否已经被执行
    }

    Transaction[] public transactions;
    // the owner agreement of maps
    // txId => owner => bool
    mapping(uint256 => mapping(address => bool)) public approved;

    // 事件
    event Deposit(address indexed sender, uint256 amount);
    event Submit(uint256 indexed txId);
    event Approve(address indexed owner, uint256 indexed txId);
    event Revoke(address indexed owner, uint256 indexed txId);
    event Execute(uint256 indexed txId);

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier txExists(uint256 _txId) {
        require(_txId < transactions.length, "tx does not exist");
        _;
    }

    modifier notApproved(uint256 _txId) {
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    modifier notExecuted(uint256 _txId) {
        require(!transactions[_txId].executed, "tx already executed");
        _;
    }

    /**
     * pass in the owners and required number of owners of the wallet
     * @param _owners array of owners
     * @param _required number of required owners
     */
    constructor(address[] memory _owners, uint256 _required) {
        require(_owners.length > 0, "owners required");
        require(
            _required > 0 && _required <= _owners.length,
            "invalid required number of owners"
        );

        for (uint256 index = 0; index < owners.length; index++) {
            address owner = _owners[index];
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner is not unique");
            isOwner[owner] = true;
            owners.push(owner);
        }

        required = _required;
    }

    // get balance
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    /**
     * submit a transaction to the contract
     * @param _to address of the recipient
     */
    function submit(
        address _to,
        uint256 _value,
        bytes memory _data
    ) external onlyOwner returns (uint256) {
        transactions.push(
            Transaction({to: _to, value: _value, data: _data, executed: false})
        );
        emit Submit(transactions.length - 1);
        return transactions.length - 1;
    }

    // approve a transaction
    function approv(uint256 _txId)
        external
        onlyOwner
        txExists(_txId)
        notApproved(_txId)
        notExecuted(_txId)
    {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    /**
     * execute a transaction
     * @param _txId transaction id
     */
    function executed(uint256 _txId)
        external
        onlyOwner
        txExists(_txId)
        notExecuted(_txId)
    {
        require(
            getApprovalCount(_txId) >= required,
            "approval count < required"
        );
        Transaction storage transaction = transactions[_txId];
        transaction.executed = true;

        (bool success, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(success, "tx failed");
        emit Execute(_txId);
    }

    // get the approval count of approved owners
    function getApprovalCount(uint256 _txId)
        public
        view
        returns (uint256 count)
    {
        for (uint256 index = 0; index < owners.length; index++) {
            if (approved[_txId][owners[index]]) {
                count++;
            }
        }
    }

    /** 撤回 */
    function revoke(uint256 _txId)
        external
        onlyOwner
        txExists(_txId)
        notExecuted(_txId)
    {
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }
}
