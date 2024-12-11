

# **Infura: 连接链下与链上的桥梁**

`Infura` 是由 ConsenSys（小狐狸钱包母公司）开发的一项区块链基础设施服务，它帮助用户和开发者更便捷地与以太坊区块链交互。

## **概述**

Infura 为开发者提供了一个简化的方式，通过一个即时、可扩展的 `API` 来访问以太坊和 IPFS 网络。这样，开发者无需在本地部署和维护区块链节点，就可以轻松与区块链进行交互。

## **如何连接应用和区块链**

### **问题背景**

在以太坊上开发 DApp（去中心化应用）时，应用需要与区块链进行数据交互。早期，为了实现这种交互，开发者需要在本地搭建并维护以太坊节点，而这通常是一个复杂且耗时的过程。搭建节点可能需要几天的时间，并且会消耗大量的计算资源。

### **Infura 解决方案**

Infura 通过提供一个桥梁，简化了链下（应用）和链上（区块链）之间的交互。开发者通过 Infura 提供的 `API` 直接与以太坊和 IPFS 网络进行通信，而无需自行搭建节点。

## **创建 Infura API Key**

1. **打开 Infura 官网并注册**
   - 网址：[Infura 官网](https://infura.io)

   注册后，你将可以使用 Infura 提供的服务，创建一个 API Key 来与以太坊区块链进行交互。

2. **创建 API Key**
   - 注册后，进入 Infura 控制台（Dashboard），点击右上角的 **CREATE NEW KEY** 按钮。

   ![Create New Key](static/HJZxbzZoFohOhPxrxA5cpZKLngg.png)

3. **填写 API Key 信息**
   - 在弹出的窗口中，选择 **NETWORK**（网络类型），选择 **Web3 API (Formerly Ethereum)**，或者选择 **Ethereum**。
   - **NAME** 填写一个自定义名称（例如 `RCC`）。
   - 点击 **CREATE** 按钮，完成 API Key 的创建。

4. **查看 API Key**
   - 返回到控制台 Dashboard，你会看到已创建的 API Key（例如 `RCC`）。
   - 点击 **MANAGE KEY** 按钮查看 API Key 的详细信息。

5. **获取 RPC 节点链接**
   - 在 API Key 的详情页面，你会看到 **NETWORK ENDPOINT** 栏目，提供了以太坊主网/测试网的 RPC 节点链接，用于与区块链进行交互。
   - Infura 还允许你申请免费的 Layer 2 RPC 节点（如 `Polygon`，`Optimism`，和 `Arbitrum`），但需要绑定 `Visa` 卡。

## **如何使用 Infura API Key**

### **在 JavaScript 中使用 ethers.js 与 Infura 交互**

在前端开发中，你可以使用 `ethers.js` 库来与区块链进行交互，并通过 Infura 提供的 API Key 来创建 `JsonRpcProvider`，实现与以太坊网络的通信。

```javascript
const { ethers } = require("ethers");
// 填入你的 Infura API Key
const INFURA_ID = '' 
const provider = new ethers.providers.JsonRpcProvider(`https://mainnet.infura.io/v3/${INFURA_ID}`)
```

通过以上代码，你可以通过 Infura 提供的 RPC 节点与以太坊主网进行交互。

### **在 Metamask 中使用 Infura**

Metamask 是一个非常流行的以太坊钱包，它内置了 Infura 服务，使用户能够轻松连接到以太坊网络。

1. 打开 Metamask，进入 **Settings** 页面。
2. 选择 **Networks**，点击 **Add Network**。
3. 使用以下参数添加 `Optimism` Layer 2 网络：

```
网络名称 (Network Name): Optimism
RPC URL: 填入在 Infura 控制台申请的 Optimism RPC 链接
链 ID (Chain ID): 10
符号 (Chain Symbol): ETH
区块链浏览器 URL (Blockchain Explorer URL): https://optimistic.etherscan.io
```

通过这种方式，你可以轻松地将 Metamask 与 Optimism 网络连接起来，享受 Layer 2 网络带来的低费用和高性能。

## **总结**

通过 `Infura` 提供的服务，开发者可以简化与区块链的交互流程，无需自行搭建节点。只需创建 Infura 的 API Key，就可以快速连接到以太坊及 IPFS 网络。通过结合 `ethers.js` 和 Metamask 等工具，开发者能够轻松进行智能合约交互和链上数据查询。

---

这样整理后，希望能帮助你更清晰地理解 `Infura` 的功能和如何使用它。如果有任何疑问，可以随时问我！