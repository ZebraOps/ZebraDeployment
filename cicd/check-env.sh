#!/bin/bash

echo "=== 检查环境 ==="

# 检查 Docker
echo "1. 检查 Docker..."
docker --version
if [ $? -eq 0 ]; then
  echo "✓ Docker 已安装"
else
  echo "✗ Docker 未安装"
  exit 1
fi

# 检查 Docker Compose
echo "2. 检查 Docker Compose..."
docker-compose --version
if [ $? -eq 0 ]; then
  echo "✓ Docker Compose 已安装"
else
  echo "✗ Docker Compose 未安装"
  exit 1
fi

# 检查磁盘空间
echo "3. 检查磁盘空间..."
df -h / | tail -1

# 检查内存
echo "4. 检查内存..."
free -h

# 检查网络连接
echo "5. 检查 Docker Hub 连接..."
timeout 10 docker pull hello-world
if [ $? -eq 0 ]; then
  echo "✓ 可以访问 Docker Hub"
else
  echo "⚠ Docker Hub 连接可能较慢，建议配置镜像加速器"
fi

echo ""
echo "=== 环境检查完成 ==="
echo "建议系统配置:"
echo "- 内存: 至少 8GB"
echo "- 磁盘: 至少 50GB 可用空间"
echo "- CPU: 至少 4 核"