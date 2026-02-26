#!/bin/bash

echo "正在停止 DevOps 套件..."
docker-compose down

echo "清理未使用的资源..."
docker system prune -f