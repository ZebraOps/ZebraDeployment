#!/bin/bash

echo "=== 分步部署 DevOps 套件 ==="

# 1. 首先拉取所有镜像（带重试机制）
echo "步骤 1: 拉取 Docker 镜像..."
images=(
  "registry.cn-shanghai.aliyuncs.com/numa-images/postgres:13"
  "registry.cn-shanghai.aliyuncs.com/numa-images/gitlab-ce:18.5.1-ce.0"
  "registry.cn-shanghai.aliyuncs.com/numa-images/jenkins:2.506-slim-jdk17"
  "registry.cn-shanghai.aliyuncs.com/numa-images/redis:8.4.0"
  "registry.cn-shanghai.aliyuncs.com/numa-images/harbor-core:v2.13.3"
  "registry.cn-shanghai.aliyuncs.com/numa-images/nginx:1.18.0"
)

for image in "${images[@]}"; do
  echo "拉取镜像: $image"
  retry_count=0
  max_retries=3

  while [ $retry_count -lt $max_retries ]; do
    docker pull $image
    if [ $? -eq 0 ]; then
      echo "✓ 成功拉取 $image"
      break
    else
      retry_count=$((retry_count+1))
      echo "✗ 拉取失败，第 $retry_count 次重试..."
      sleep 5
    fi
  done
done

echo "等待 10 秒..."
sleep 10

# 2. 先启动基础服务
echo "步骤 2: 启动基础服务..."
docker-compose up -d postgres redis

echo "等待数据库启动..."
sleep 20

# 3. 检查服务状态
echo "步骤 3: 检查服务状态..."
docker-compose ps

# 4. 逐步启动其他服务
echo "步骤 4: 启动 GitLab..."
docker-compose up -d gitlab

echo "等待 GitLab 启动..."
sleep 30

echo "步骤 5: 启动 Jenkins..."
docker-compose up -d jenkins

echo "等待 Jenkins 启动..."
sleep 20

echo "步骤 6: 启动 Harbor..."
docker-compose up -d harbor

echo "等待 Harbor 启动..."
sleep 15

# 5. 最终状态检查
echo "步骤 7: 最终状态检查..."
docker-compose ps

echo ""
echo "=== 部署完成 ==="
echo "访问地址:"
echo "GitLab: http://localhost:8082"
echo "Jenkins: http://localhost:8080"
echo "Harbor: http://localhost:8081"
echo "PostgreSQL: localhost:5432"
echo "Redis: localhost:6379"
echo ""
echo "默认凭据:"
echo "GitLab: 首次访问需要设置 root 密码"
echo "Jenkins: 首次访问需要解锁，查看日志: docker logs jenkins"
echo "PostgreSQL: postgres/postgres123"