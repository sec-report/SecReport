# SecReport
ChatGPT加持的，多人协同信息安全渗透测试报告`编写`/`导出`平台

[官方网站](https://sec-report.com)

* 标准化渗透测试流程
* 多人协同编辑
* 自定义导出模版
* ChatGPT生成漏洞简介及修复方案
* APP安全合规测试报告（仅在线版本）


#### TODO:
* ~~复测报告生成~~
* ~~多人协同的临时信息同步固钉窗口~~
* ~~整合社区单机版至[Docker Hub](https://hub.docker.com/r/secreport/sec-report)~~
* ~~提供报告模版demo~~
* ~~APP安全合规测试报告~~
* APP安全合规测试报告自定义模版
* 应急溯源处置报告，包括`access.log`等日志分析功能

> 报告模版demo已上传至template文件夹，欢迎社区通过pr提交优质报告模版。优质模版将在后续版本自动集成至官方模版库。

---

## 社区单机离线版安装

> 单机版仅供社区交流学习，禁止任何商业/OEM行为，商业版请联系邮箱[sec-report@outlook.com](mailto:sec-report@outlook.com)。

```shell
mkdir SecReport && cd SecReport
wget https://raw.githubusercontent.com/sec-report/SecReport/main/docker-compose.yml
wget https://raw.githubusercontent.com/sec-report/SecReport/main/run.sh
chmod +x run.sh
./run.sh

# 停止
./run stop

# 更新
./run update
```

Docker全部运行后访问 [http://127.0.0.1/](http://127.0.0.1/) 初始化管理员账号

## 其他作品

[SecAutoBan](https://github.com/sec-report/SecAutoBan)：安全设备告警IP全自动封禁平台，支持百万IP秒级分析处理。

## Star History

<a href="https://github.com/sec-report/SecReport/stargazers">
    <img width="500" alt="Star History Chart" src="https://api.star-history.com/svg?repos=sec-report/SecReport&type=Date">
</a> 
