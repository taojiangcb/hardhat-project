# AWS
## serverless
###  lambda、larmbda-edge、零时域名
1. 限制
    1. zip 代码不能大于 50M， 解压后不能大于 250 M
###  api gateway
### cloudWatch 监控
### cloudfront CDN
          1. aws waf 安全
### S3 存储 
### cloudPipleline 部署
### 解决的问题
1. 服务端免运维，
   1. 自动扩容，监控，日志，能力
2. 成本低：（调用次数 * 计算时长 * 内存使用）
### Lambad
 1. 代码放在 S3 上
 2. SAM 去创建应用并且 CI CD
    1. sam deploy
 3. cloudWatch 监控和 日志
### Trigger  
 1. API gateway
 2. Labmda@egde:cloudfront
### 函数入口
1.  
### 内网 VPC 请求
### 边缘部署
####  Edge
1. 多节点网络 （全球一个 13 个节点）
    1.  周期~
        1.  Viewer Request
           1.  301 重定向
           2.  代码不能大于 1 M
       1. origin request
          1. 服务，渲染页面，bff
       2. Origin Response
       3. Viewer Response
2. CloudFront Functions (200 多个节点)
       1. 10KB 代码限制~~
### Layers
    1.  管理公共依赖， 每个 Lamabda 最多可以拥有 5 个 Layer 没层不能大于 250 M，zip 不能大于 50MB

# 部署
- SAM 基于 cloudFormation 构建 资源 CIDI 资源分配
- CDK 通过 JS/TS/等语言完成 aws 资源的调度（eks,ec2,lambda,等等）
- Terraform : 复合云跨云平台（阿里云，aws，goole cloud,azure)
- SST: 基于 CDK 开发的。
- SSL: https://www.serverless.com 跨云，express koa 


   
# EC2 
# EKS