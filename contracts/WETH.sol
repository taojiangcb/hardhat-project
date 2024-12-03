pragma solidity ^0.8.27;

contract WETH {
    // there are defined the token name, symbol, and decimal places
    string public name = "Wrapped Ether"; // defined the name of the token
    string public symbol = "WETH"; // defined the symbol of the token
    uint8 public decimals = 18; // defined the decimal places of the token

    // this is approval and transfer events
    event Approval(address indexed src, address indexed delegateAds,uint256 amount);
    event Transfer(address indexed src, address indexed tods, uint256 amount);
    event Deposit(address indexed toAds, uint256 amount);
    event Withdraw(address indexed src, uint256 amount);

    // mapping the address to the balance of the token;
    mapping(address => uint256) public balanceOf;
    // mapping the address to the allowance of the token;
    mapping(address => mapping(address => uint256)) public allowance;

    // deposit the token to the contract 
    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount);
        balanceOf[msg.sender] -= amount;

        // transfer the token to the user;
        payable(msg.sender).transfer(amount);
        // emit the withdraw event recording the withdraw;
        emit Withdraw(msg.sender, amount);
    }

    // get the total supply of the token
    function totalSupply() public view returns (uint256) {
        return address(this).balance;
    }

    // approve the token to the spender
    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        address src = msg.sender;
        return transferFrom(src,to,amount);
    }

    function transferFrom(
        address src,
        address toAds,
        uint256 amount
    ) public returns (bool) {
        require(balanceOf[src] > amount);
        if(src != msg.sender) {
            require(allowance[src][msg.sender] >= amount);
            allowance[src][msg.sender] -= amount;
        }
        balanceOf[src] -= amount;
        balanceOf[toAds] += amount;
        emit Transfer(src,toAds,amount);
        return true;
    }

    fallback() external payable {
        deposit();
    }

    receive() external payable {
        deposit();
    }
}