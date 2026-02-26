# Zebra Deployment

## 📖 简介

`ZebraDeploy` 是一个基于 Docker Compose 的一站式 DevOps 平台部署方案，整合了 API 网关、监控系统和 CI/CD 工具链。该项目旨在帮助开发者快速搭建一套完整的微服务基础设施环境。

### ✨ 主要功能模块

#### 1. API Gateway（API 网关）
- 使用 [Apache APISIX](https://apisix.apache.org/) 作为高性能 API 网关。
- 支持插件扩展，例如 `prometheus`、`zipkin`、`opentelemetry` 等。
- 提供统一的路由管理、流量控制、安全认证等功能。

#### 2. Monitoring（监控系统）
- 集成 [Prometheus](https://prometheus.io/) + [Grafana](https://grafana.com/) 实现指标采集与可视化。
- 使用 [Zipkin](https://zipkin.io/) 进行分布式链路追踪。
- 提供预定义的 Dashboard，方便查看网关性能、请求延迟等关键指标。

#### 3. DevOps Toolkit（DevOps 工具链）
- 包含 [GitLab](https://about.gitlab.com/)（代码仓库）、[Jenkins](https://www.jenkins.io/)（持续集成）、[Harbor](https://goharbor.io/)（镜像仓库）三大核心组件。
- 支持从代码提交到镜像构建再到应用部署的全流程自动化。

---

## 🚀 快速开始

### 准备工作

确保本地已安装以下依赖项：
```bash
# 检查 Docker 和 Docker Compose 是否安装
docker --version
docker-compose --version

# 如果未安装，请参考官方文档进行安装
```


建议系统配置：
- 内存：至少 8GB
- 磁盘：至少 50GB 可用空间
- CPU：至少 4 核

### 启动服务

#### 步骤一：启动网关服务

手动启动：
```bash
  docker-compose up -d
```


#### 步骤二：启动DevOps工具链

适用于调试或逐步验证每个服务的状态：
```bash
cd zebra-deployment/cicd
./deploy-step-by-step.sh
```


该脚本会依次拉取镜像、启动基础服务（如 PostgreSQL、Redis），然后逐步启动 GitLab、Jenkins、Harbor 等高级服务。

---

## 📢 Access address服务访问地址

| 组件名称 | 默认端口 | 访问地址 |
|----------|-----------|------------|
| APISIX Dashboard | 9000 | http://localhost:9000 |
| Prometheus | 9090 | http://localhost:9090 |
| Grafana | 3000 | http://localhost:3000 |
| Zipkin | 9411 | http://localhost:9411 |
| GitLab | 8082 | http://localhost:8082 |
| Jenkins | 8080 | http://localhost:8080 |
| Harbor | 8081 | http://localhost:8081 |

> 注：首次访问某些服务时可能需要初始化配置或设置管理员密码，请参考各服务的日志输出。

---

## 🔑 配置说明

### 1. 修改 Etcd 地址

在 `docker-compose.yml` 中找到 `etcd` 服务配置部分，修改 `ETCD_ADVERTISE_CLIENT_URLS` 为你机器的实际 IP 地址。

### 2. 数据库存储路径

所有持久化数据均挂载至宿主机目录（位于 `data/` 下），可根据需求调整路径。

### 3. 自定义插件配置

可在 `apisix_config/config.yaml` 中启用或禁用特定插件，例如：
```yaml
plugins:
  - real-ip
  - proxy-rewrite
  - prometheus
  - zipkin
```


### 4. 日志级别调整

在 `grafana_conf/config/grafana.ini` 中可修改日志级别：
```ini
[log]
level = info
```


---

## ⛓️‍💥 故障排查

### 查看服务状态
```bash
  docker-compose ps
```


### 查看服务日志
```bash
  docker-compose logs <service_name>
```


---

## 🤝 贡献指南

欢迎提交 Issue 或 Pull Request 来改进本项目！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

---

## ⚖️ 许可证

本项目遵循 MIT 协议开源，详情请参阅 [LICENSE](LICENSE) 文件。
