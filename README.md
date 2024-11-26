# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test // 单元测试
REPORT_GAS=true npx hardhat test
npx hardhat node // 启动本地节点
npx hardhat ignition deploy ./ignition/modules/Lock.ts // 部署合约
```

1. 编译合约
```shell
npx hardhat compile 
```
编译成功后会⽣成artifacts文件夹

2. 部署合约
   - 启动本地网络：npx hardhat node
   - 部署合约到本地网络 npx hardhat ignition deploy ./ignition/modules/Lock.js --network localhost   
  
3. 编写测试用例
   1. 使用 mocha 框架编写测试用例
   2. 运行测试 npx hardhat test 